// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

/// A General MIDI 2 (GM2) reverb type: one of the 6 reverb designs that the
/// reverb type parameter selects.
///
/// The names describe example designs rather than define effect algorithms.
/// Selecting a reverb type also sets the reverb time to the type’s
/// ``defaultTime``. A GM2 device starts with ``largeHall``.
///
/// ``allCases`` lists the reverb types in value order, from ``smallRoom``
/// (0) to ``plate`` (8).
public enum GM2ReverbType {

    /// A large size concert hall suitable for a full orchestra (value 4).
    case largeHall

    /// A large size room suitable for live performances (value 2).
    case largeRoom

    /// A medium size concert hall (value 3).
    case mediumHall

    /// A medium size room with a length of about 10 m (value 1).
    case mediumRoom

    /// A plate reverb simulation (value 8).
    case plate

    /// A small size room with a length of about 5 m (value 0).
    case smallRoom

    // MARK: Public Initializers

    /// Creates a `GM2ReverbType` instance from the provided reverb type
    /// parameter value, or `nil` if no reverb type has that value.
    ///
    /// - Parameter value:  The value (0–4 or 8).
    public init?(value: MIDIData1Value) {
        guard let type = Self.allCases.first(where: { $0.value == value })
        else { return nil }

        self = type
    }
}

// MARK: -

extension GM2ReverbType {

    // MARK: Public Instance Properties

    /// The reverb time that selecting this reverb type sets.
    ///
    /// See ``GM2ReverbParameter/time(_:)`` for how the value relates to the
    /// time in seconds.
    public var defaultTime: MIDIData1Value {
        switch self {
        case .largeHall:
            MIDIData1Value(clamping: 64)    // 1.8 s

        case .largeRoom:
            MIDIData1Value(clamping: 56)    // 1.5 s

        case .mediumHall:
            MIDIData1Value(clamping: 64)    // 1.8 s

        case .mediumRoom:
            MIDIData1Value(clamping: 50)    // 1.3 s

        case .plate:
            MIDIData1Value(clamping: 50)    // 1.3 s

        case .smallRoom:
            MIDIData1Value(clamping: 44)    // 1.1 s
        }
    }

    /// The name of this reverb type, as the General MIDI 2 specification
    /// gives it, such as “Large Hall”.
    public var name: String {
        switch self {
        case .largeHall:
            "Large Hall"

        case .largeRoom:
            "Large Room"

        case .mediumHall:
            "Medium Hall"

        case .mediumRoom:
            "Medium Room"

        case .plate:
            "Plate"

        case .smallRoom:
            "Small Room"
        }
    }

    /// The reverb type parameter value that selects this reverb type.
    public var value: MIDIData1Value {
        switch self {
        case .largeHall:
            MIDIData1Value(clamping: 4)

        case .largeRoom:
            MIDIData1Value(clamping: 2)

        case .mediumHall:
            MIDIData1Value(clamping: 3)

        case .mediumRoom:
            MIDIData1Value(clamping: 1)

        case .plate:
            MIDIData1Value(clamping: 8)

        case .smallRoom:
            MIDIData1Value(clamping: 0)
        }
    }
}

// MARK: - CaseIterable

extension GM2ReverbType: CaseIterable {

    // MARK: Public Type Properties

    /// Every reverb type, in value order.
    public static let allCases: [Self] = [.smallRoom,
                                          .mediumRoom,
                                          .largeRoom,
                                          .mediumHall,
                                          .largeHall,
                                          .plate]
}

// MARK: - Equatable

extension GM2ReverbType: Equatable {
}

// MARK: - Hashable

extension GM2ReverbType: Hashable {
}

// MARK: - Sendable

extension GM2ReverbType: Sendable {
}
