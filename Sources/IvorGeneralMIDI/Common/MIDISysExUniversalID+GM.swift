// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

internal import XestiTools

extension MIDISysExUniversalID {

    // MARK: Public Type Properties

    /// The ID of the real-time General MIDI 2 controller destination setting
    /// messages (0x7F 0x09).
    public static let controllerDestination = Self(realTime: true,
                                                   subID: 0x09)

    /// The ID of the real-time General MIDI 2 key-based instrument control
    /// messages (0x7F 0x0A).
    public static let keyBasedInstrumentControl = Self(realTime: true,
                                                       subID: 0x0a)
}
