// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI
public import XestiTools

/// A General MIDI system exclusive message.
///
/// This covers the messages that turn General MIDI on and off, and the General
/// MIDI 2 messages for effects and controllers. `MIDISysExRepresentable`
/// provides the conversions to and from a `MIDISystemMessage`:
///
/// ```swift
/// let message = GMMessage(content: .gm2SystemOn)
///
/// message.systemMessage   // F0 7E 7F 09 03 F7
/// ```
public struct GMMessage {

    // MARK: Public Initializers

    /// Creates a `GMMessage` instance with the provided content and device ID.
    ///
    /// - Parameter content:    The content of the message.
    /// - Parameter deviceID:   The ID of the target device. Defaults to all
    ///                         devices (127).
    public init(content: Content,
                deviceID: MIDIData1Value = 0x7f) {
        self.content = content
        self.deviceID = deviceID
    }

    // MARK: Public Instance Properties

    /// The content of this message.
    public let content: Content

    /// The ID of the target device, where 127 means all devices.
    public let deviceID: MIDIData1Value
}

// MARK: -

extension GMMessage {

    // MARK: Private Type Properties

    // A General MIDI 2 global parameter control message: a slot path of length
    // 1 (slot MSB 1 is reserved for General MIDI 2), and one-byte parameter IDs
    // and values. The slot LSB follows.
    private static let globalParameterHeader: [UInt8] = [0x05, 0x01, 0x01, 0x01, 0x01]

    // MARK: Private Type Methods

    private static func _byte(_ value: MIDIData1Value) -> UInt8 {
        UInt8(truncatingIfNeeded: value.uintValue)
    }

    private static func _channel(_ byte: UInt8) -> MIDIChannel? {
        byte <= 0x0f ? MIDIChannel(uintValue: UInt(byte) + 1) : nil
    }

    private static func _channelByte(_ channel: MIDIChannel) -> UInt8 {
        UInt8(truncatingIfNeeded: channel.uintValue - 1)
    }

    private static func _decodeControllerDestination(_ payload: [UInt8]) -> Content? {
        guard payload.count >= 2,
              let channel = _channel(payload[1])
        else { return nil }

        switch payload[0] {
        case 0x01:
            return _pairs(payload.dropFirst(2)) { GM2ControllerDestination(bytes: $0) }
                .map { .channelPressureDestinations(channel, $0) }

        case 0x03:
            guard payload.count >= 3,
                  let controller = MIDIController(uintValue: UInt(payload[2])),
                  _isAssignable(controller)
            else { return nil }

            return _pairs(payload.dropFirst(3)) { GM2ControllerDestination(bytes: $0) }
                .map { .controlChangeDestinations(controller, channel, $0) }

        default:
            return nil
        }
    }

    private static func _decodeDeviceControl(_ payload: [UInt8]) -> Content? {
        guard payload.count > globalParameterHeader.count,
              payload.starts(with: globalParameterHeader)
        else { return nil }

        let pairs = payload.dropFirst(globalParameterHeader.count + 1)

        switch payload[globalParameterHeader.count] {
        case 0x01:
            return _pairs(pairs) { GM2ReverbParameter(bytes: $0) }.map { .gm2Reverb($0) }

        case 0x02:
            return _pairs(pairs) { GM2ChorusParameter(bytes: $0) }.map { .gm2Chorus($0) }

        default:
            return nil
        }
    }

    private static func _decodeGeneralMIDI(_ payload: [UInt8]) -> Content? {
        switch payload {
        case [0x01]:
            .gm1SystemOn

        case [0x02]:
            .gmSystemOff

        case [0x03]:
            .gm2SystemOn

        default:
            nil
        }
    }

    private static func _decodeKeyBasedInstrumentControl(_ payload: [UInt8]) -> Content? {
        guard payload.count >= 3,
              payload[0] == 0x01,
              let channel = _channel(payload[1]),
              let note = MIDIData1Value(uintValue: UInt(payload[2]))
        else { return nil }

        return _pairs(payload.dropFirst(3)) { GM2KeyBasedController(bytes: $0) }
            .map { .keyBasedInstrumentControl(channel, note: note, $0) }
    }

    private static func _isAssignable(_ controller: MIDIController) -> Bool {
        (0x01...0x1f).contains(controller.uintValue) || (0x40...0x5f).contains(controller.uintValue)
    }

    // Returns nil for an odd number of bytes, or for a pair that make rejects.
    private static func _pairs<T>(_ bytes: ArraySlice<UInt8>,
                                  _ make: ([UInt8]) -> T?) -> [T]? {
        let bytes = Array(bytes)

        guard bytes.count.isMultiple(of: 2)
        else { return nil }

        let values = stride(from: 0, to: bytes.count, by: 2).compactMap { make(Array(bytes[$0..<($0 + 2)])) }

        return values.count == bytes.count / 2 ? values : nil
    }

    // MARK: Private Instance Methods

    private func _envelope(_ id: MIDISysExUniversalID,
                           _ payload: [UInt8]) -> MIDISysExEnvelope {
        .universal(id,
                   deviceID: deviceID,
                   payload: payload)
    }
}

// MARK: - Equatable

extension GMMessage: Equatable {
}

// MARK: - Hashable

extension GMMessage: Hashable {
}

// MARK: - MIDISysExRepresentable

extension GMMessage: MIDISysExRepresentable {

    // MARK: Public Initializers

    /// Creates a `GMMessage` instance by decoding an envelope, or `nil` if it
    /// does not hold a valid General MIDI message.
    ///
    /// A message is invalid if its payload has a byte above 0x7F, or if it
    /// holds a parameter, destination, or controller that General MIDI doesn’t
    /// define.
    ///
    /// - Parameter envelope:   The envelope to decode.
    public init?(_ envelope: MIDISysExEnvelope) {
        guard envelope.hasValidPayload,
              case let .universal(id, deviceID, payload) = envelope
        else { return nil }

        let content: Content? = switch id {
        case .controllerDestination:
            Self._decodeControllerDestination(payload)

        case .deviceControl:
            Self._decodeDeviceControl(payload)

        case .generalMIDI:
            Self._decodeGeneralMIDI(payload)

        case .keyBasedInstrumentControl:
            Self._decodeKeyBasedInstrumentControl(payload)

        default:
            nil
        }

        guard let content
        else { return nil }

        self.init(content: content,
                  deviceID: deviceID)
    }

    // MARK: Public Instance Properties

    /// The envelope that encodes this message, or `nil` if it can’t be
    /// encoded.
    ///
    /// A ``Content/controlChangeDestinations(_:_:_:)`` message can’t be encoded
    /// unless its controller is in the assignable ranges, 1–31 and 64–95.
    public var envelope: MIDISysExEnvelope? {
        switch content {
        case let .channelPressureDestinations(channel, destinations):
            _envelope(.controllerDestination,
                      [0x01, Self._channelByte(channel)] + destinations.flatMap(\.bytes))

        case let .controlChangeDestinations(controller, channel, destinations):
            Self._isAssignable(controller)
                ? _envelope(.controllerDestination,
                            [0x03, Self._channelByte(channel), UInt8(truncatingIfNeeded: controller.uintValue)]
                                + destinations.flatMap(\.bytes))
                : nil

        case .gm1SystemOn:
            _envelope(.generalMIDI, [0x01])

        case let .gm2Chorus(parameters):
            _envelope(.deviceControl, Self.globalParameterHeader + [0x02] + parameters.flatMap(\.bytes))

        case let .gm2Reverb(parameters):
            _envelope(.deviceControl, Self.globalParameterHeader + [0x01] + parameters.flatMap(\.bytes))

        case .gm2SystemOn:
            _envelope(.generalMIDI, [0x03])

        case .gmSystemOff:
            _envelope(.generalMIDI, [0x02])

        case let .keyBasedInstrumentControl(channel, note, controllers):
            _envelope(.keyBasedInstrumentControl,
                      [0x01, Self._channelByte(channel), Self._byte(note)] + controllers.flatMap(\.bytes))
        }
    }
}

// MARK: - Sendable

extension GMMessage: Sendable {
}
