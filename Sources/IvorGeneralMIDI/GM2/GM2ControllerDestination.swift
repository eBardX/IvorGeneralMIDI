// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

/// A General MIDI 2 (GM2) controller destination and its range: a sound
/// parameter that a controller destination setting message assigns to
/// channel pressure or a control change, and how strongly it responds.
///
/// A channel’s controller destination setting replaces any earlier one for
/// the same control source, and rhythm channels should ignore it.
public enum GM2ControllerDestination {

    /// Amplitude control (destination 02).
    ///
    /// The range is 0–127 for 0–(127/64) × 100 percent. The default is 64
    /// (100 percent).
    case amplitudeControl(MIDIData1Value)

    /// Filter cutoff control (destination 01).
    ///
    /// The range is 0–127 for −9600 to +9450 cents, in steps of 150 cents.
    /// The default is 64 (0 cents).
    case filterCutoffControl(MIDIData1Value)

    /// LFO amplitude depth, or tremolo (destination 05).
    ///
    /// The range is 0–127 for 0–100 percent. The default is 0.
    case lfoAmplitudeDepth(MIDIData1Value)

    /// LFO filter depth (destination 04).
    ///
    /// The range is 0–127 for 0–2400 cents. The default is 0.
    case lfoFilterDepth(MIDIData1Value)

    /// LFO pitch depth, or vibrato (destination 03).
    ///
    /// The range is 0–127 for 0–600 cents. The default is 0.
    case lfoPitchDepth(MIDIData1Value)

    /// Pitch control (destination 00).
    ///
    /// The range is 40–88 for −24 to +24 semitones. The default is 64
    /// (0 semitones).
    case pitchControl(MIDIData1Value)
}

// MARK: -

extension GM2ControllerDestination {

    // MARK: Internal Instance Properties

    // The destination and range bytes of this destination.
    internal var bytes: [UInt8] {
        switch self {
        case let .amplitudeControl(range):
            [0x02, UInt8(truncatingIfNeeded: range.uintValue)]

        case let .filterCutoffControl(range):
            [0x01, UInt8(truncatingIfNeeded: range.uintValue)]

        case let .lfoAmplitudeDepth(range):
            [0x05, UInt8(truncatingIfNeeded: range.uintValue)]

        case let .lfoFilterDepth(range):
            [0x04, UInt8(truncatingIfNeeded: range.uintValue)]

        case let .lfoPitchDepth(range):
            [0x03, UInt8(truncatingIfNeeded: range.uintValue)]

        case let .pitchControl(range):
            [0x00, UInt8(truncatingIfNeeded: range.uintValue)]
        }
    }
}

// MARK: - Equatable

extension GM2ControllerDestination: Equatable {
}

// MARK: - Hashable

extension GM2ControllerDestination: Hashable {
}

// MARK: - Sendable

extension GM2ControllerDestination: Sendable {
}
