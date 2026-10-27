// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

internal import XestiTools

/// A General MIDI 2 (GM2) drum set: one of the 9 percussion kits that a
/// bank select and program change select on a rhythm channel.
///
/// Each drum set is identified by its program, with the bank MSB set to
/// ``bankMSB`` (120) and the bank LSB set to ``bankLSB`` (0).
///
/// The ``standard`` set plays the ``GM2PercussionSound`` key map. Every other
/// set plays that key map too, but replaces some of its sounds with its own,
/// and the ``sfx`` set replaces nearly all of them. ``sounds`` and
/// ``sound(for:)`` give the sound that each note plays in a set.
///
/// ``allCases`` lists the drum sets in program order, from ``standard``
/// (program 1) to ``sfx`` (program 57).
public enum GM2DrumSet {

    /// Analog Set (program 26).
    case analog

    /// Brush Set (program 41).
    case brush

    /// Electronic Set (program 25).
    case electronic

    /// Jazz Set (program 33).
    case jazz

    /// Orchestra Set (program 49).
    case orchestra

    /// Power Set (program 17).
    case power

    /// Room Set (program 9).
    case room

    /// SFX Set (program 57).
    case sfx

    /// Standard Set (program 1).
    case standard

    // MARK: Public Initializers

    /// Creates a `GM2DrumSet` instance from the provided drum set name, or
    /// `nil` if no drum set has that name.
    ///
    /// Matching ignores case, leading and trailing whitespace, and the
    /// amount of whitespace between words.
    ///
    /// - Parameter name:   The drum set name, such as “Jazz Set”.
    public init?(name: String) {
        guard let drumSet = Self.drumSetsByName[name.normalizedName]
        else { return nil }

        self = drumSet
    }

    /// Creates a `GM2DrumSet` instance from the provided program, or `nil`
    /// if no drum set has that program.
    ///
    /// - Parameter program:    The program. Only programs 1, 9, 17, 25, 26,
    ///                         33, 41, 49, and 57 select drum sets.
    public init?(program: MIDIProgram) {
        guard let drumSet = Self.drumSetsByProgram[program.uintValue]
        else { return nil }

        self = drumSet
    }
}

// MARK: -

extension GM2DrumSet {

    // MARK: Public Type Properties

    /// The bank select LSB that selects the General MIDI 2 drum sets (0).
    public static let bankLSB: MIDIData1Value = 0

    /// The bank select MSB that selects the General MIDI 2 drum sets (120).
    public static let bankMSB: MIDIData1Value = 120

    // MARK: Public Instance Properties

    /// The name of this drum set, as the General MIDI 2 specification gives
    /// it, such as “Jazz Set”.
    public var name: String {
        entry.name
    }

    /// The patch that selects this drum set: ``program`` in bank
    /// ``bankMSB``:``bankLSB``.
    public var patch: MIDIPatch {
        MIDIPatch(program: program,
                  bank: MIDIBank(msb: Self.bankMSB,
                                 lsb: Self.bankLSB))
    }

    /// The program that selects this drum set.
    public var program: MIDIProgram {
        entry.program
    }

    /// The sounds of this drum set, one for each note that sounds, in note
    /// order.
    public var sounds: [GM2DrumSetSound] {
        Self.soundsByNote[self, default: [:]].values.sorted { $0.note.uintValue < $1.note.uintValue }
    }

    // MARK: Public Instance Methods

    /// Returns the channel messages that select this drum set on the
    /// provided channel: a bank select MSB of ``bankMSB``, a bank select LSB
    /// of ``bankLSB``, and a program change to ``program``, in that order.
    ///
    /// - Parameter channel:    The rhythm channel on which to select this
    ///                         drum set. Defaults to channel 10, the
    ///                         percussion channel of General MIDI 1.
    ///
    /// - Returns:  The bank select and program change messages.
    public func selectionMessages(channel: MIDIChannel = GM1PercussionSound.channel) -> [MIDIChannelMessage] {
        patch.selectionMessages(on: channel,
                                after: nil)
    }

    /// Returns the sound that the provided note plays in this drum set, or
    /// `nil` if the note does not sound.
    ///
    /// - Parameter note:   The note number (0–127). Only notes 27–88 can
    ///                     sound, and not all of them sound in every set.
    ///
    /// - Returns:  The sound that the note plays, or `nil`.
    public func sound(for note: MIDIData1Value) -> GM2DrumSetSound? {
        Self.soundsByNote[self]?[note.uintValue]
    }

    // MARK: Private Type Properties

    private static let drumSetsByName: [String: Self] = {
        var map: [String: Self] = [:]

        for entry in catalog {
            map[entry.name.normalizedName] = entry.drumSet
        }

        return map
    }()

    private static let drumSetsByProgram: [UInt: Self] = {
        var map: [UInt: Self] = [:]

        for entry in catalog {
            map[entry.program] = entry.drumSet
        }

        return map
    }()

    private static let entries: [Self: (program: MIDIProgram, name: String)] = {
        var map: [Self: (program: MIDIProgram, name: String)] = [:]

        for entry in catalog {
            map[entry.drumSet] = (MIDIProgram(clamping: entry.program), entry.name)
        }

        return map
    }()

    // Sounds keyed by drum set, then by note.
    private static let soundsByNote: [Self: [UInt: GM2DrumSetSound]] = {
        var map: [Self: [UInt: GM2DrumSetSound]] = [:]

        for drumSet in allCases {
            map[drumSet] = _makeSounds(for: drumSet)
        }

        return map
    }()

    // MARK: Private Type Methods

    // Starts from the Standard Set key map, removes the drum set’s silent
    // notes, then applies the drum set’s own sounds.
    private static func _makeSounds(for drumSet: Self) -> [UInt: GM2DrumSetSound] {
        let groups = exclusiveGroups[drumSet] ?? [:]
        let noteOffRange = noteOffNotes[drumSet]
        let silent = Set(silentNotes[drumSet] ?? [])
        var sounds: [UInt: GM2DrumSetSound] = [:]

        for sound in GM2PercussionSound.allCases where !silent.contains(sound.note.uintValue) {
            sounds[sound.note.uintValue] = GM2DrumSetSound(drumSet: drumSet,
                                                           exclusiveGroup: sound.exclusiveGroup,
                                                           name: sound.name,
                                                           note: sound.note,
                                                           pan: sound.pan,
                                                           respondsToNoteOff: noteOffRange?.contains(sound.note.uintValue) ?? false,
                                                           standardSound: sound)
        }

        for entry in keyMaps[drumSet] ?? [] {
            sounds[entry.note] = GM2DrumSetSound(drumSet: drumSet,
                                                 exclusiveGroup: groups[entry.note],
                                                 name: entry.name,
                                                 note: MIDIData1Value(clamping: entry.note),
                                                 pan: MIDIData1Value(clamping: entry.pan),
                                                 respondsToNoteOff: noteOffRange?.contains(entry.note) ?? false,
                                                 standardSound: nil)
        }

        return sounds
    }

    // MARK: Private Instance Properties

    private var entry: (program: MIDIProgram, name: String) {
        guard let entry = Self.entries[self]
        else { fatalError("GM2DrumSet catalog has no entry for \(self)") }

        return entry
    }
}

// MARK: - CaseIterable

extension GM2DrumSet: CaseIterable {

    // MARK: Public Type Properties

    /// Every drum set, in program order.
    public static let allCases: [Self] = catalog.map(\.drumSet)
}

// MARK: - Equatable

extension GM2DrumSet: Equatable {
}

// MARK: - Hashable

extension GM2DrumSet: Hashable {
}

// MARK: - Sendable

extension GM2DrumSet: Sendable {
}
