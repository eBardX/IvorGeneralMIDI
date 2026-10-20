// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

/// A General MIDI 2 (GM2) reverb parameter and its value, which
/// `MIDISystemMessage.gm2Reverb(_:)` sets.
public enum GM2ReverbParameter {

    /// The reverb time (parameter 1).
    ///
    /// The value is `ln(rt) / 0.025 + 40`, where `rt` is the time in seconds
    /// (0.36–9.0) for the low-frequency part of the sound to decay by 60 dB.
    case time(MIDIData1Value)

    /// The reverb type (parameter 0).
    ///
    /// Selecting a reverb type also sets the reverb time to the type’s
    /// ``GM2ReverbType/defaultTime``.
    case type(GM2ReverbType)
}

// MARK: -

extension GM2ReverbParameter {

    // MARK: Internal Instance Properties

    // The parameter ID and value bytes of this parameter.
    internal var bytes: [UInt8] {
        switch self {
        case let .time(value):
            [0x01, UInt8(truncatingIfNeeded: value.uintValue)]

        case let .type(type):
            [0x00, UInt8(truncatingIfNeeded: type.value.uintValue)]
        }
    }
}

// MARK: - Equatable

extension GM2ReverbParameter: Equatable {
}

// MARK: - Hashable

extension GM2ReverbParameter: Hashable {
}

// MARK: - Sendable

extension GM2ReverbParameter: Sendable {
}
