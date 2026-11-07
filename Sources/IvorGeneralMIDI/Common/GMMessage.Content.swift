// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

extension GMMessage {

    /// The content of a General MIDI message.
    public enum Content {

        /// An assignment of channel pressure on a channel to the provided
        /// destinations (`F0 7F id 09 01 0n pp rr … F7`).
        ///
        /// The message replaces any earlier channel pressure destinations on
        /// the channel.
        case channelPressureDestinations(MIDIChannel, [GM2ControllerDestination])

        /// An assignment of a controller on a channel to the provided
        /// destinations (`F0 7F id 09 03 0n cc pp rr … F7`).
        ///
        /// Only controllers 1–31 and 64–95 can be assigned. The message replaces
        /// any earlier destinations of a controller on the channel. Only one
        /// controller per channel, plus channel pressure, can have destinations
        /// at a time.
        case controlChangeDestinations(MIDIController, MIDIChannel, [GM2ControllerDestination])

        /// The message that turns General MIDI 1 on (`F0 7E id 09 01 F7`).
        case gm1SystemOn

        /// The General MIDI 2 chorus parameters to set, in the order to set them
        /// (`F0 7F id 04 05 01 01 01 01 02 pp vv … F7`).
        ///
        /// This is a global parameter control message addressed to the chorus
        /// (slot 0102). Send it at the start of a song or during a break in the
        /// sound, since a device may not change effects smoothly. Put
        /// ``GM2ChorusParameter/type(_:)`` first, since selecting a chorus type
        /// resets the other parameters.
        case gm2Chorus([GM2ChorusParameter])

        /// The General MIDI 2 reverb parameters to set, in the order to set them
        /// (`F0 7F id 04 05 01 01 01 01 01 pp vv … F7`).
        ///
        /// This is a global parameter control message addressed to the reverb
        /// (slot 0101). Send it at the start of a song or during a break in the
        /// sound, since a device may not change effects smoothly. Put
        /// ``GM2ReverbParameter/type(_:)`` first, since selecting a reverb type
        /// resets the reverb time.
        case gm2Reverb([GM2ReverbParameter])

        /// The message that turns General MIDI 2 on (`F0 7E id 09 03 F7`).
        case gm2SystemOn

        /// The message that turns General MIDI off (`F0 7E id 09 02 F7`).
        case gmSystemOff

        /// An adjustment of the provided controllers for one note of the drum set
        /// on a rhythm channel (`F0 7F id 0A 01 0n kk nn vv … F7`).
        case keyBasedInstrumentControl(MIDIChannel, note: MIDIData1Value, [GM2KeyBasedController])
    }
}

// MARK: - Equatable

extension GMMessage.Content: Equatable {
}

// MARK: - Hashable

extension GMMessage.Content: Hashable {
}

// MARK: - Sendable

extension GMMessage.Content: Sendable {
}
