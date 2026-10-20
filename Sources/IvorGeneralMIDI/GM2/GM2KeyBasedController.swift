// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

/// A General MIDI 2 (GM2) key-based instrument controller and its value: a
/// setting that a key-based instrument control message adjusts for one note
/// of a drum set.
///
/// Selecting a drum set restores the preset setting of every note, and
/// melody channels should ignore these messages.
public enum GM2KeyBasedController {

    /// The chorus send level (controller 93), from 0 to the maximum (127).
    ///
    /// The value is absolute: it replaces the note’s preset level.
    case chorusSendLevel(MIDIData1Value)

    /// The pan (controller 10), from hard left (0) through center (64) to
    /// hard right (127).
    ///
    /// The value is absolute: it replaces the note’s preset pan, such as
    /// ``GM2DrumSetSound/pan``.
    case pan(MIDIData1Value)

    /// The reverb send level (controller 91), from 0 to the maximum (127).
    ///
    /// The value is absolute: it replaces the note’s preset level.
    case reverbSendLevel(MIDIData1Value)

    /// The volume (controller 7), from 0 through the preset volume (64) to
    /// (127/64) × 100 percent of it (127).
    ///
    /// The value is relative to the note’s preset volume.
    case volume(MIDIData1Value)
}

// MARK: -

extension GM2KeyBasedController {

    // MARK: Internal Instance Properties

    // The controller number and value bytes of this controller.
    internal var bytes: [UInt8] {
        switch self {
        case let .chorusSendLevel(value):
            [0x5d, UInt8(truncatingIfNeeded: value.uintValue)]

        case let .pan(value):
            [0x0a, UInt8(truncatingIfNeeded: value.uintValue)]

        case let .reverbSendLevel(value):
            [0x5b, UInt8(truncatingIfNeeded: value.uintValue)]

        case let .volume(value):
            [0x07, UInt8(truncatingIfNeeded: value.uintValue)]
        }
    }
}

// MARK: - Equatable

extension GM2KeyBasedController: Equatable {
}

// MARK: - Hashable

extension GM2KeyBasedController: Hashable {
}

// MARK: - Sendable

extension GM2KeyBasedController: Sendable {
}
