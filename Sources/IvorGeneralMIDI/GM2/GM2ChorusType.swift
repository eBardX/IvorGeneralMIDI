// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

/// A General MIDI 2 (GM2) chorus type: one of the 6 chorus designs that the
/// chorus type parameter selects.
///
/// Selecting a chorus type also sets the other chorus parameters to the
/// type’s defaults, such as ``defaultFeedback``. A GM2 device starts with
/// ``chorus3``.
///
/// ``allCases`` lists the chorus types in value order, from ``chorus1`` (0)
/// to ``flanger`` (5).
public enum GM2ChorusType {

    /// Chorus 1 (value 0).
    case chorus1

    /// Chorus 2 (value 1).
    case chorus2

    /// Chorus 3 (value 2).
    case chorus3

    /// Chorus 4 (value 3).
    case chorus4

    /// FB Chorus, a chorus with heavy feedback (value 4).
    case fbChorus

    /// Flanger (value 5).
    case flanger

    // MARK: Public Initializers

    /// Creates a `GM2ChorusType` instance from the provided chorus type
    /// parameter value, or `nil` if no chorus type has that value.
    ///
    /// - Parameter value:  The value (0–5).
    public init?(value: MIDIData1Value) {
        guard let type = Self.allCases.first(where: { $0.value == value })
        else { return nil }

        self = type
    }
}

// MARK: -

extension GM2ChorusType {

    // MARK: Public Instance Properties

    /// The feedback that selecting this chorus type sets.
    ///
    /// See ``GM2ChorusParameter/feedback(_:)`` for how the value relates to
    /// the feedback in percent.
    public var defaultFeedback: MIDIData1Value {
        MIDIData1Value(clamping: defaults.feedback)
    }

    /// The modulation depth that selecting this chorus type sets.
    ///
    /// See ``GM2ChorusParameter/modDepth(_:)`` for how the value relates to
    /// the depth in milliseconds.
    public var defaultModDepth: MIDIData1Value {
        MIDIData1Value(clamping: defaults.modDepth)
    }

    /// The modulation rate that selecting this chorus type sets.
    ///
    /// See ``GM2ChorusParameter/modRate(_:)`` for how the value relates to
    /// the rate in hertz.
    public var defaultModRate: MIDIData1Value {
        MIDIData1Value(clamping: defaults.modRate)
    }

    /// The send level to the reverb that selecting this chorus type sets,
    /// which is 0 for every chorus type.
    public var defaultSendToReverb: MIDIData1Value {
        MIDIData1Value(clamping: 0)
    }

    /// The name of this chorus type, as the General MIDI 2 specification
    /// gives it, such as “FB Chorus”.
    public var name: String {
        switch self {
        case .chorus1:
            "Chorus 1"

        case .chorus2:
            "Chorus 2"

        case .chorus3:
            "Chorus 3"

        case .chorus4:
            "Chorus 4"

        case .fbChorus:
            "FB Chorus"

        case .flanger:
            "Flanger"
        }
    }

    /// The chorus type parameter value that selects this chorus type.
    public var value: MIDIData1Value {
        switch self {
        case .chorus1:
            MIDIData1Value(clamping: 0)

        case .chorus2:
            MIDIData1Value(clamping: 1)

        case .chorus3:
            MIDIData1Value(clamping: 2)

        case .chorus4:
            MIDIData1Value(clamping: 3)

        case .fbChorus:
            MIDIData1Value(clamping: 4)

        case .flanger:
            MIDIData1Value(clamping: 5)
        }
    }

    // MARK: Private Instance Properties

    // The default feedback, mod rate, and mod depth values, from the chorus
    // type table of the General MIDI 2 specification.
    private var defaults: (feedback: UInt, modRate: UInt, modDepth: UInt) {
        switch self {
        case .chorus1:
            (0, 3, 5)       // 0%, 0.4 Hz, 1.9 ms

        case .chorus2:
            (5, 9, 19)      // 4%, 1.1 Hz, 6.3 ms

        case .chorus3:
            (8, 3, 19)      // 6%, 0.4 Hz, 6.3 ms

        case .chorus4:
            (16, 9, 16)     // 12%, 1.1 Hz, 5.3 ms

        case .fbChorus:
            (64, 2, 24)     // 49%, 0.2 Hz, 7.8 ms

        case .flanger:
            (112, 1, 5)     // 86%, 0.1 Hz, 1.9 ms
        }
    }
}

// MARK: - CaseIterable

extension GM2ChorusType: CaseIterable {

    // MARK: Public Type Properties

    /// Every chorus type, in value order.
    public static let allCases: [Self] = [.chorus1,
                                          .chorus2,
                                          .chorus3,
                                          .chorus4,
                                          .fbChorus,
                                          .flanger]
}

// MARK: - Equatable

extension GM2ChorusType: Equatable {
}

// MARK: - Hashable

extension GM2ChorusType: Hashable {
}

// MARK: - Sendable

extension GM2ChorusType: Sendable {
}
