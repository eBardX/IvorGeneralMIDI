// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

/// A General MIDI 2 (GM2) percussion sound: one of the 61 sounds of the
/// percussion key map, which notes 27–87 play on a rhythm channel.
///
/// This is the key map of the Standard Set (``GM2DrumSet/standard``). The
/// other drum sets replace some of its sounds; see ``GM2DrumSet/sounds``.
///
/// General MIDI 2 keeps the 47 ``GM1PercussionSound`` sounds on notes 35–81
/// and adds 8 sounds below them and 6 above. Names follow the General MIDI 2
/// specification, which spells a few of the General MIDI 1 sounds
/// differently, such as “High Bongo” rather than “Hi Bongo”.
///
/// ``allCases`` lists the sounds in note order, from ``highQ`` (note 27) to
/// ``openSurdo`` (note 87).
public enum GM2PercussionSound {

    /// Acoustic Bass Drum (note 35).
    case acousticBassDrum

    /// Acoustic Snare (note 38).
    case acousticSnare

    /// Bass Drum 1 (note 36).
    case bassDrum1

    /// Bell Tree (note 84).
    case bellTree

    /// Cabasa (note 69).
    case cabasa

    /// Castanets (note 85).
    case castanets

    /// Chinese Cymbal (note 52).
    case chineseCymbal

    /// Claves (note 75).
    case claves

    /// Closed Hi-hat (note 42).
    case closedHiHat

    /// Cowbell (note 56).
    case cowbell

    /// Crash Cymbal 1 (note 49).
    case crashCymbal1

    /// Crash Cymbal 2 (note 57).
    case crashCymbal2

    /// Electric Snare (note 40).
    case electricSnare

    /// Hand Clap (note 39).
    case handClap

    /// High Agogo (note 67).
    case highAgogo

    /// High Bongo (note 60).
    case highBongo

    /// High Floor Tom (note 43).
    case highFloorTom

    /// High Mid Tom (note 48).
    case highMidTom

    /// High Q (note 27).
    case highQ

    /// High Timbale (note 65).
    case highTimbale

    /// High Tom (note 50).
    case highTom

    /// Hi Wood Block (note 76).
    case hiWoodBlock

    /// Jingle Bell (note 83).
    case jingleBell

    /// Long Guiro (note 74).
    case longGuiro

    /// Long Whistle (note 72).
    case longWhistle

    /// Low Agogo (note 68).
    case lowAgogo

    /// Low Bongo (note 61).
    case lowBongo

    /// Low Conga (note 64).
    case lowConga

    /// Low Floor Tom (note 41).
    case lowFloorTom

    /// Low-Mid Tom (note 47).
    case lowMidTom

    /// Low Timbale (note 66).
    case lowTimbale

    /// Low Tom (note 45).
    case lowTom

    /// Low Wood Block (note 77).
    case lowWoodBlock

    /// Maracas (note 70).
    case maracas

    /// Metronome Bell (note 34).
    case metronomeBell

    /// Metronome Click (note 33).
    case metronomeClick

    /// Mute Cuica (note 78).
    case muteCuica

    /// Mute Hi Conga (note 62).
    case muteHiConga

    /// Mute Surdo (note 86).
    case muteSurdo

    /// Mute Triangle (note 80).
    case muteTriangle

    /// Open Cuica (note 79).
    case openCuica

    /// Open Hi Conga (note 63).
    case openHiConga

    /// Open Hi-hat (note 46).
    case openHiHat

    /// Open Surdo (note 87).
    case openSurdo

    /// Open Triangle (note 81).
    case openTriangle

    /// Pedal Hi-hat (note 44).
    case pedalHiHat

    /// Ride Bell (note 53).
    case rideBell

    /// Ride Cymbal 1 (note 51).
    case rideCymbal1

    /// Ride Cymbal 2 (note 59).
    case rideCymbal2

    /// Scratch Pull (note 30).
    case scratchPull

    /// Scratch Push (note 29).
    case scratchPush

    /// Shaker (note 82).
    case shaker

    /// Short Guiro (note 73).
    case shortGuiro

    /// Short Whistle (note 71).
    case shortWhistle

    /// Side Stick (note 37).
    case sideStick

    /// Slap (note 28).
    case slap

    /// Splash Cymbal (note 55).
    case splashCymbal

    /// Square Click (note 32).
    case squareClick

    /// Sticks (note 31).
    case sticks

    /// Tambourine (note 54).
    case tambourine

    /// Vibra-slap (note 58).
    case vibraSlap

    // MARK: Public Initializers

    /// Creates a `GM2PercussionSound` instance from the provided sound name,
    /// or `nil` if no sound has that name.
    ///
    /// Matching ignores case, leading and trailing whitespace, and the
    /// amount of whitespace between words.
    ///
    /// - Parameter name:   The sound name, such as “Metronome Click”.
    public init?(name: String) {
        guard let sound = Self.soundsByName[name.normalizedName]
        else { return nil }

        self = sound
    }

    /// Creates a `GM2PercussionSound` instance from the provided note, or
    /// `nil` if the percussion key map assigns no sound to it.
    ///
    /// - Parameter note:   The note number (0–127). Only notes 27–87 have
    ///                     sounds assigned.
    public init?(note: MIDIData1Value) {
        guard let sound = Self.soundsByNote[note.uintValue]
        else { return nil }

        self = sound
    }
}

// MARK: -

extension GM2PercussionSound {

    // MARK: Public Instance Properties

    /// The exclusive group of this sound, or `nil` if it has none.
    ///
    /// Sounds in the same exclusive group cut each other off, such as the
    /// closed, pedal, and open hi-hats (group 1).
    public var exclusiveGroup: UInt? {
        Self.exclusiveGroups[self]
    }

    /// The General MIDI 1 percussion sound on the same note as this sound,
    /// or `nil` if this sound is one that General MIDI 2 adds.
    public var gm1PercussionSound: GM1PercussionSound? {
        GM1PercussionSound(note: note)
    }

    /// The name of this sound, as the General MIDI 2 specification gives it,
    /// such as “Metronome Click”.
    public var name: String {
        entry.name
    }

    /// The note that plays this sound on a rhythm channel (27–87).
    public var note: MIDIData1Value {
        MIDIData1Value(clamping: entry.note)
    }

    /// The preset pan of this sound, from hard left (0) through center (64)
    /// to hard right (127).
    public var pan: MIDIData1Value {
        guard let pan = Self.pans[self]
        else { fatalError("GM2PercussionSound catalog has no pan for \(self)") }

        return MIDIData1Value(clamping: pan)
    }

    // MARK: Private Type Properties

    private static let entries: [Self: (note: UInt, name: String)] = {
        var map: [Self: (note: UInt, name: String)] = [:]

        for entry in catalog {
            map[entry.sound] = (entry.note, entry.name)
        }

        return map
    }()

    private static let soundsByName: [String: Self] = {
        var map: [String: Self] = [:]

        for entry in catalog {
            map[entry.name.normalizedName] = entry.sound
        }

        return map
    }()

    private static let soundsByNote: [UInt: Self] = {
        var map: [UInt: Self] = [:]

        for entry in catalog {
            map[entry.note] = entry.sound
        }

        return map
    }()

    // MARK: Private Instance Properties

    private var entry: (note: UInt, name: String) {
        guard let entry = Self.entries[self]
        else { fatalError("GM2PercussionSound catalog has no entry for \(self)") }

        return entry
    }
}

// MARK: - CaseIterable

extension GM2PercussionSound: CaseIterable {

    // MARK: Public Type Properties

    /// Every sound, in note order.
    public static let allCases: [Self] = catalog.map(\.sound)
}

// MARK: - Equatable

extension GM2PercussionSound: Equatable {
}

// MARK: - Hashable

extension GM2PercussionSound: Hashable {
}

// MARK: - Sendable

extension GM2PercussionSound: Sendable {
}
