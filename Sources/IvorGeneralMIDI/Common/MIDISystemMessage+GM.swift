// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

extension MIDISystemMessage {

    // MARK: Public Type Properties

    /// The universal non-real-time system exclusive message that turns
    /// General MIDI 1 on in all devices (`F0 7E 7F 09 01 F7`).
    public static let gm1SystemOn: Self = .systemExclusive([0x7e, 0x7f, 0x09, 0x01, 0xf7])

    /// The universal non-real-time system exclusive message that turns
    /// General MIDI 2 on in all devices (`F0 7E 7F 09 03 F7`).
    public static let gm2SystemOn: Self = .systemExclusive([0x7e, 0x7f, 0x09, 0x03, 0xf7])

    /// The universal non-real-time system exclusive message that turns
    /// General MIDI off in all devices (`F0 7E 7F 09 02 F7`).
    public static let gmSystemOff: Self = .systemExclusive([0x7e, 0x7f, 0x09, 0x02, 0xf7])

    // MARK: Public Type Methods

    /// Returns the universal real-time system exclusive message that assigns
    /// channel pressure on the provided channel to the provided destinations
    /// in all devices (`F0 7F 7F 09 01 0n pp rr … F7`).
    ///
    /// The message replaces any earlier channel pressure destinations on the
    /// channel.
    ///
    /// - Parameter channel:        The channel whose channel pressure to
    ///                             assign.
    /// - Parameter destinations:   The destinations and their ranges.
    ///
    /// - Returns:  The controller destination setting message.
    public static func channelPressureDestinationSetting(channel: MIDIChannel,
                                                         _ destinations: GM2ControllerDestination...) -> Self {
        .systemExclusive([0x7f, 0x7f, 0x09, 0x01, _byte(channel)] + destinations.flatMap(\.bytes) + [0xf7])
    }

    /// Returns the universal real-time system exclusive message that assigns
    /// the provided controller on the provided channel to the provided
    /// destinations in all devices (`F0 7F 7F 09 03 0n cc pp rr … F7`), or
    /// `nil` if the controller cannot be assigned.
    ///
    /// The message replaces any earlier destinations of a controller on the
    /// channel. Only one controller per channel, plus channel pressure, can
    /// have destinations at a time.
    ///
    /// - Parameter controller:     The controller to assign. Only controllers
    ///                             1–31 and 64–95 can be assigned.
    /// - Parameter channel:        The channel whose controller to assign.
    /// - Parameter destinations:   The destinations and their ranges.
    ///
    /// - Returns:  The controller destination setting message, or `nil`.
    public static func controlChangeDestinationSetting(controller: MIDIController,
                                                       channel: MIDIChannel,
                                                       _ destinations: GM2ControllerDestination...) -> Self? {
        guard (0x01...0x1f).contains(controller.uintValue) || (0x40...0x5f).contains(controller.uintValue)
        else { return nil }

        return .systemExclusive([0x7f, 0x7f, 0x09, 0x03, _byte(channel), UInt8(truncatingIfNeeded: controller.uintValue)]
                                + destinations.flatMap(\.bytes)
                                + [0xf7])
    }

    /// Returns the universal real-time system exclusive message that sets the
    /// provided General MIDI 2 chorus parameters in all devices
    /// (`F0 7F 7F 04 05 01 01 01 01 02 pp vv … F7`).
    ///
    /// This is a global parameter control message addressed to the chorus
    /// (slot 0102). Send it at the start of a song or during a break in the
    /// sound, since a device may not change effects smoothly.
    ///
    /// - Parameter parameters: The parameters to set, in the order to set
    ///                         them. Put ``GM2ChorusParameter/type(_:)``
    ///                         first, since selecting a chorus type resets the
    ///                         other parameters.
    ///
    /// - Returns:  The global parameter control message.
    public static func gm2Chorus(_ parameters: GM2ChorusParameter...) -> Self {
        _makeGlobalParameterControl(slotLSB: 0x02,
                                    pairs: parameters.flatMap(\.bytes))
    }

    /// Returns the universal real-time system exclusive message that sets the
    /// provided General MIDI 2 reverb parameters in all devices
    /// (`F0 7F 7F 04 05 01 01 01 01 01 pp vv … F7`).
    ///
    /// This is a global parameter control message addressed to the reverb
    /// (slot 0101). Send it at the start of a song or during a break in the
    /// sound, since a device may not change effects smoothly.
    ///
    /// - Parameter parameters: The parameters to set, in the order to set
    ///                         them. Put ``GM2ReverbParameter/type(_:)``
    ///                         first, since selecting a reverb type resets the
    ///                         reverb time.
    ///
    /// - Returns:  The global parameter control message.
    public static func gm2Reverb(_ parameters: GM2ReverbParameter...) -> Self {
        _makeGlobalParameterControl(slotLSB: 0x01,
                                    pairs: parameters.flatMap(\.bytes))
    }

    /// Returns the universal real-time system exclusive message that adjusts
    /// the provided controllers for one note of the drum set on the provided
    /// channel in all devices (`F0 7F 7F 0A 01 0n kk nn vv … F7`).
    ///
    /// - Parameter channel:        The rhythm channel of the drum set.
    /// - Parameter note:           The note whose sound to adjust.
    /// - Parameter controllers:    The controllers and their values.
    ///
    /// - Returns:  The key-based instrument control message.
    public static func keyBasedInstrumentControl(channel: MIDIChannel,
                                                 note: MIDIData1Value,
                                                 _ controllers: GM2KeyBasedController...) -> Self {
        .systemExclusive([0x7f, 0x7f, 0x0a, 0x01, _byte(channel), _byte(note)] + controllers.flatMap(\.bytes) + [0xf7])
    }

    // MARK: Private Type Methods

    private static func _byte(_ channel: MIDIChannel) -> UInt8 {
        UInt8(truncatingIfNeeded: channel.uintValue - 1)
    }

    private static func _byte(_ value: MIDIData1Value) -> UInt8 {
        UInt8(truncatingIfNeeded: value.uintValue)
    }

    // Builds a General MIDI 2 global parameter control message: all devices,
    // a slot path of length 1 (slot MSB 1 is reserved for General MIDI 2),
    // and one-byte parameter IDs and values.
    private static func _makeGlobalParameterControl(slotLSB: UInt8,
                                                    pairs: [UInt8]) -> Self {
        .systemExclusive([0x7f, 0x7f, 0x04, 0x05, 0x01, 0x01, 0x01, 0x01, slotLSB] + pairs + [0xf7])
    }
}
