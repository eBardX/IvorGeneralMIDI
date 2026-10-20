// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

internal import XestiTools

/// A General MIDI (GM1) percussion sound: one of the 47 sounds of the
/// percussion key map, which notes 35–81 play on ``channel``.
///
/// ``allCases`` lists the sounds in note order, from ``acousticBassDrum``
/// (note 35) to ``openTriangle`` (note 81).
public enum GM1PercussionSound {

    /// Acoustic Bass Drum (note 35).
    case acousticBassDrum

    /// Acoustic Snare (note 38).
    case acousticSnare

    /// Bass Drum 1 (note 36).
    case bassDrum1

    /// Cabasa (note 69).
    case cabasa

    /// Chinese Cymbal (note 52).
    case chineseCymbal

    /// Claves (note 75).
    case claves

    /// Closed Hi Hat (note 42).
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

    /// Hi Bongo (note 60).
    case hiBongo

    /// High Agogo (note 67).
    case highAgogo

    /// High Floor Tom (note 43).
    case highFloorTom

    /// High Timbale (note 65).
    case highTimbale

    /// High Tom (note 50).
    case highTom

    /// Hi Mid Tom (note 48).
    case hiMidTom

    /// Hi Wood Block (note 76).
    case hiWoodBlock

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

    /// Mute Cuica (note 78).
    case muteCuica

    /// Mute Hi Conga (note 62).
    case muteHiConga

    /// Mute Triangle (note 80).
    case muteTriangle

    /// Open Cuica (note 79).
    case openCuica

    /// Open Hi Conga (note 63).
    case openHiConga

    /// Open Hi-Hat (note 46).
    case openHiHat

    /// Open Triangle (note 81).
    case openTriangle

    /// Pedal Hi-Hat (note 44).
    case pedalHiHat

    /// Ride Bell (note 53).
    case rideBell

    /// Ride Cymbal 1 (note 51).
    case rideCymbal1

    /// Ride Cymbal 2 (note 59).
    case rideCymbal2

    /// Short Guiro (note 73).
    case shortGuiro

    /// Short Whistle (note 71).
    case shortWhistle

    /// Side Stick (note 37).
    case sideStick

    /// Splash Cymbal (note 55).
    case splashCymbal

    /// Tambourine (note 54).
    case tambourine

    /// Vibraslap (note 58).
    case vibraslap

    // MARK: Public Initializers

    /// Creates a `GM1PercussionSound` instance from the provided sound name,
    /// or `nil` if no sound has that name.
    ///
    /// Matching ignores case, leading and trailing whitespace, and the
    /// amount of whitespace between words.
    ///
    /// - Parameter name:   The sound name, such as “Acoustic Snare”.
    public init?(name: String) {
        guard let sound = Self.soundsByName[name.normalizedName]
        else { return nil }

        self = sound
    }

    /// Creates a `GM1PercussionSound` instance from the provided note, or
    /// `nil` if the percussion key map assigns no sound to it.
    ///
    /// - Parameter note:   The note number (0–127). Only notes 35–81 have
    ///                     sounds assigned.
    public init?(note: MIDIData1Value) {
        guard let sound = Self.soundsByNote[note.uintValue]
        else { return nil }

        self = sound
    }
}

// MARK: -

extension GM1PercussionSound {

    // MARK: Public Type Properties

    /// The channel that plays the percussion key map (10).
    public static let channel: MIDIChannel = 10

    // MARK: Public Instance Properties

    /// The name of this sound, as the General MIDI specification gives it,
    /// such as “Acoustic Snare”.
    public var name: String {
        entry.name
    }

    /// The note that plays this sound on ``channel`` (35–81).
    public var note: MIDIData1Value {
        MIDIData1Value(clamping: entry.note)
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
        else { fatalError("GM1PercussionSound catalog has no entry for \(self)") }

        return entry
    }
}

// MARK: - CaseIterable

extension GM1PercussionSound: CaseIterable {

    // MARK: Public Type Properties

    /// Every sound, in note order.
    public static let allCases: [Self] = catalog.map(\.sound)
}

// MARK: - Equatable

extension GM1PercussionSound: Equatable {
}

// MARK: - Hashable

extension GM1PercussionSound: Hashable {
}

// MARK: - Sendable

extension GM1PercussionSound: Sendable {
}
