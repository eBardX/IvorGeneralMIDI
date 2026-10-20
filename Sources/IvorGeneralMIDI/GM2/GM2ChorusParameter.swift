// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

/// A General MIDI 2 (GM2) chorus parameter and its value, which
/// `MIDISystemMessage.gm2Chorus(_:)` sets.
public enum GM2ChorusParameter {

    /// The amount of feedback from the chorus output (parameter 3).
    ///
    /// The value is the feedback in percent divided by 0.763.
    case feedback(MIDIData1Value)

    /// The modulation depth (parameter 2).
    ///
    /// The value is `md * 3.2 - 1`, where `md` is the peak-to-peak swing of
    /// the modulation in milliseconds.
    case modDepth(MIDIData1Value)

    /// The modulation rate (parameter 1).
    ///
    /// The value is the modulation frequency in hertz divided by 0.122.
    case modRate(MIDIData1Value)

    /// The send level from the chorus to the reverb (parameter 4).
    ///
    /// The value is the send level in percent divided by 0.787.
    case sendToReverb(MIDIData1Value)

    /// The chorus type (parameter 0).
    ///
    /// Selecting a chorus type also sets the other chorus parameters to the
    /// type’s defaults, such as ``GM2ChorusType/defaultFeedback``.
    case type(GM2ChorusType)
}

// MARK: -

extension GM2ChorusParameter {

    // MARK: Internal Instance Properties

    // The parameter ID and value bytes of this parameter.
    internal var bytes: [UInt8] {
        switch self {
        case let .feedback(value):
            [0x03, UInt8(truncatingIfNeeded: value.uintValue)]

        case let .modDepth(value):
            [0x02, UInt8(truncatingIfNeeded: value.uintValue)]

        case let .modRate(value):
            [0x01, UInt8(truncatingIfNeeded: value.uintValue)]

        case let .sendToReverb(value):
            [0x04, UInt8(truncatingIfNeeded: value.uintValue)]

        case let .type(type):
            [0x00, UInt8(truncatingIfNeeded: type.value.uintValue)]
        }
    }
}

// MARK: - Equatable

extension GM2ChorusParameter: Equatable {
}

// MARK: - Hashable

extension GM2ChorusParameter: Hashable {
}

// MARK: - Sendable

extension GM2ChorusParameter: Sendable {
}
