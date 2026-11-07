// © 2026 John Gary Pusey (see LICENSE.md)

import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GMMessageTests {
    private let reverbHeader: [UInt8] = [0x05, 0x01, 0x01, 0x01, 0x01, 0x01]
}

// MARK: -

extension GMMessageTests {
    @Test
    func channelPressureDestinations() {
        // The example in CA-022 and General MIDI 2 section 4.6.1.
        let message = GMMessage(content: .channelPressureDestinations(7,
                                                                      [.pitchControl(0x42),
                                                                       .filterCutoffControl(0x60),
                                                                       .lfoAmplitudeDepth(0x20)]))

        #expect(message.systemMessage?.dataBytes
                == [0x7f, 0x7f, 0x09, 0x01, 0x06] + [0x00, 0x42, 0x01, 0x60, 0x05, 0x20] + [0xf7])
    }

    @Test
    func channelPressureDestinations_parsesFromBytes() {
        let message = GMMessage(content: .channelPressureDestinations(1, [.amplitudeControl(64)])).systemMessage

        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: message?.dataBytes ?? []) == message)
    }

    @Test
    func controlChangeDestinations() {
        // The example in General MIDI 2 section 4.6.2: General Purpose
        // Controller 1 on channel 7.
        let message = GMMessage(content: .controlChangeDestinations(.generalPurposeController1MSB,
                                                                    7,
                                                                    [.pitchControl(0x42),
                                                                     .filterCutoffControl(0x60),
                                                                     .lfoAmplitudeDepth(0x20)]))

        #expect(message.systemMessage?.dataBytes
                == [0x7f, 0x7f, 0x09, 0x03, 0x06, 0x10] + [0x00, 0x42, 0x01, 0x60, 0x05, 0x20] + [0xf7])
    }

    @Test
    func controlChangeDestinations_assignableControllers() {
        for number in UInt(0)...127 {
            guard let controller = MIDIController(uintValue: number)
            else { continue }

            let message = GMMessage(content: .controlChangeDestinations(controller, 1, [.lfoPitchDepth(10)]))

            #expect((message.envelope != nil) == ((1...31).contains(number) || (64...95).contains(number)))
        }
    }

    @Test
    func deviceID() {
        #expect(GMMessage(content: .gm1SystemOn).deviceID == 0x7f)
        #expect(GMMessage(content: .gm1SystemOn, deviceID: 0x10).systemMessage?.dataBytes
                == [0x7e, 0x10, 0x09, 0x01, 0xf7])
    }

    @Test
    func envelope() {
        #expect(GMMessage(content: .gm2SystemOn).envelope == .universal(.generalMIDI, deviceID: 127, payload: [0x03]))
        #expect(GMMessage(content: .channelPressureDestinations(2, [])).envelope
                == .universal(.controllerDestination, deviceID: 127, payload: [0x01, 0x01]))
        #expect(GMMessage(content: .keyBasedInstrumentControl(10, note: 36, [.pan(0)])).envelope
                == .universal(.keyBasedInstrumentControl, deviceID: 127, payload: [0x01, 0x09, 0x24, 0x0a, 0x00]))
    }

    @Test
    func gm1SystemOn() {
        #expect(GMMessage(content: .gm1SystemOn).systemMessage?.statusByte == 0xf0)
        #expect(GMMessage(content: .gm1SystemOn).systemMessage?.dataBytes == [0x7e, 0x7f, 0x09, 0x01, 0xf7])
    }

    @Test
    func gm1SystemOn_parsesFromBytes() {
        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: [0x7e, 0x7f, 0x09, 0x01, 0xf7]) == GMMessage(content: .gm1SystemOn).systemMessage)
    }

    @Test
    func gm2Chorus() {
        let message = GMMessage(content: .gm2Chorus([.type(.chorus3), .feedback(8)])).systemMessage

        #expect(message?.statusByte == 0xf0)
        #expect(message?.dataBytes == [0x7f, 0x7f, 0x04, 0x05, 0x01, 0x01, 0x01, 0x01, 0x02] + [0x00, 0x02] + [0x03, 0x08] + [0xf7])
    }

    @Test
    func gm2Chorus_parsesFromBytes() {
        let message = GMMessage(content: .gm2Chorus([.modRate(9), .modDepth(19), .sendToReverb(0)])).systemMessage

        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: message?.dataBytes ?? []) == message)
    }

    @Test
    func gm2Reverb() {
        let message = GMMessage(content: .gm2Reverb([.type(.largeHall), .time(64)])).systemMessage

        #expect(message?.statusByte == 0xf0)
        #expect(message?.dataBytes == [0x7f, 0x7f, 0x04, 0x05, 0x01, 0x01, 0x01, 0x01, 0x01] + [0x00, 0x04] + [0x01, 0x40] + [0xf7])
    }

    @Test
    func gm2Reverb_parsesFromBytes() {
        let message = GMMessage(content: .gm2Reverb([.type(.plate)])).systemMessage

        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: message?.dataBytes ?? []) == message)
    }

    @Test
    func gm2SystemOn() {
        #expect(GMMessage(content: .gm2SystemOn).systemMessage?.statusByte == 0xf0)
        #expect(GMMessage(content: .gm2SystemOn).systemMessage?.dataBytes == [0x7e, 0x7f, 0x09, 0x03, 0xf7])
    }

    @Test
    func gm2SystemOn_parsesFromBytes() {
        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: [0x7e, 0x7f, 0x09, 0x03, 0xf7]) == GMMessage(content: .gm2SystemOn).systemMessage)
    }

    @Test
    func gmSystemOff() {
        #expect(GMMessage(content: .gmSystemOff).systemMessage?.statusByte == 0xf0)
        #expect(GMMessage(content: .gmSystemOff).systemMessage?.dataBytes == [0x7e, 0x7f, 0x09, 0x02, 0xf7])
    }

    @Test
    func gmSystemOff_parsesFromBytes() {
        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: [0x7e, 0x7f, 0x09, 0x02, 0xf7]) == GMMessage(content: .gmSystemOff).systemMessage)
    }

    @Test
    func hashable() {
        let message = GMMessage(content: .gm1SystemOn)
        let other = GMMessage(content: .gm1SystemOn, deviceID: 0x10)

        #expect(Set([message, message, other]).count == 2)
    }

    @Test
    func init_envelope_channelAbove16() {
        #expect(GMMessage(MIDISysExEnvelope.universal(.controllerDestination, deviceID: 127, payload: [0x01, 0x10])) == nil)
        #expect(GMMessage(MIDISysExEnvelope.universal(.keyBasedInstrumentControl, deviceID: 127, payload: [0x01, 0x10, 0x24])) == nil)
    }

    @Test
    func init_envelope_controllerBoundaries() {
        for controller in [0x01, 0x1f, 0x40, 0x5f] as [UInt8] {
            #expect(GMMessage(MIDISysExEnvelope.universal(.controllerDestination, deviceID: 127, payload: [0x03, 0x00, controller])) != nil)
        }

        for controller in [0x00, 0x20, 0x3f, 0x60] as [UInt8] {
            #expect(GMMessage(MIDISysExEnvelope.universal(.controllerDestination, deviceID: 127, payload: [0x03, 0x00, controller])) == nil)
        }
    }

    @Test(arguments: [[], [0x01], [0x03, 0x00]] as [[UInt8]])
    func init_envelope_controllerDestination_tooShort(payload: [UInt8]) {
        #expect(GMMessage(MIDISysExEnvelope.universal(.controllerDestination, deviceID: 127, payload: payload)) == nil)
    }

    @Test
    func init_envelope_controllerDestination_unknownForm() {
        #expect(GMMessage(MIDISysExEnvelope.universal(.controllerDestination, deviceID: 127, payload: [0x02, 0x00])) == nil)
    }

    @Test
    func init_envelope_dataByteAbove7F() {
        #expect(GMMessage(MIDISysExEnvelope.universal(.generalMIDI, deviceID: 127, payload: [0x81])) == nil)
        #expect(GMMessage(MIDISysExEnvelope.universal(.deviceControl, deviceID: 127, payload: reverbHeader + [0x01, 0x80])) == nil)
    }

    @Test
    func init_envelope_deviceControl_headerOnly() {
        #expect(GMMessage(MIDISysExEnvelope.universal(.deviceControl, deviceID: 127, payload: [0x05, 0x01, 0x01, 0x01, 0x01])) == nil)
    }

    @Test
    func init_envelope_deviceControl_wrongHeader() {
        let payload: [UInt8] = [0x05, 0x01, 0x01, 0x02, 0x01, 0x01, 0x00, 0x40]

        #expect(GMMessage(MIDISysExEnvelope.universal(.deviceControl, deviceID: 127, payload: payload)) == nil)
    }

    @Test
    func init_envelope_generalMIDI_invalid() {
        #expect(GMMessage(MIDISysExEnvelope.universal(.generalMIDI, deviceID: 127, payload: [])) == nil)
        #expect(GMMessage(MIDISysExEnvelope.universal(.generalMIDI, deviceID: 127, payload: [0x04])) == nil)
        #expect(GMMessage(MIDISysExEnvelope.universal(.generalMIDI, deviceID: 127, payload: [0x01, 0x00])) == nil)
    }

    @Test(arguments: [[], [0x01], [0x01, 0x09]] as [[UInt8]])
    func init_envelope_keyBasedInstrumentControl_tooShort(payload: [UInt8]) {
        #expect(GMMessage(MIDISysExEnvelope.universal(.keyBasedInstrumentControl, deviceID: 127, payload: payload)) == nil)
    }

    @Test
    func init_envelope_keyBasedInstrumentControl_unknownForm() {
        #expect(GMMessage(MIDISysExEnvelope.universal(.keyBasedInstrumentControl, deviceID: 127, payload: [0x02, 0x09, 0x24])) == nil)
    }

    @Test
    func init_envelope_otherOwners() {
        #expect(GMMessage(MIDISysExEnvelope.manufacturer(.yamaha, payload: [0x01])) == nil)
        #expect(GMMessage(MIDISysExEnvelope.nonCommercial(payload: [0x01])) == nil)
        #expect(GMMessage(MIDISysExEnvelope.universal(.tuning, deviceID: 127, payload: [0x01])) == nil)
    }

    @Test
    func init_envelope_unassignableController() {
        #expect(GMMessage(MIDISysExEnvelope.universal(.controllerDestination,
                                                      deviceID: 127,
                                                      payload: [0x03, 0x00, 0x20, 0x00, 0x40])) == nil)
    }

    @Test
    func init_envelope_unknownPairs() {
        #expect(GMMessage(MIDISysExEnvelope.universal(.controllerDestination,
                                                      deviceID: 127,
                                                      payload: [0x01, 0x00, 0x06, 0x40])) == nil)
        #expect(GMMessage(MIDISysExEnvelope.universal(.keyBasedInstrumentControl,
                                                      deviceID: 127,
                                                      payload: [0x01, 0x09, 0x24, 0x08, 0x40])) == nil)
        #expect(GMMessage(MIDISysExEnvelope.universal(.deviceControl,
                                                      deviceID: 127,
                                                      payload: reverbHeader + [0x02, 0x40])) == nil)
    }

    @Test
    func init_envelope_unknownSlot() {
        let payload: [UInt8] = [0x05, 0x01, 0x01, 0x01, 0x01, 0x03, 0x00, 0x00]

        #expect(GMMessage(MIDISysExEnvelope.universal(.deviceControl, deviceID: 127, payload: payload)) == nil)
    }

    @Test
    func init_envelope_unknownType() {
        #expect(GMMessage(MIDISysExEnvelope.universal(.deviceControl, deviceID: 127, payload: reverbHeader + [0x00, 0x7f])) == nil)
    }

    @Test
    func init_envelope_unpairedByte() {
        #expect(GMMessage(MIDISysExEnvelope.universal(.deviceControl, deviceID: 127, payload: reverbHeader + [0x01])) == nil)
        #expect(GMMessage(MIDISysExEnvelope.universal(.controllerDestination, deviceID: 127, payload: [0x01, 0x00, 0x00])) == nil)
    }

    @Test
    func init_message_masterVolumeIsNotGM() throws {
        let volume = try #require(MIDIDeviceControlMessage(content: .masterVolume(100)).systemMessage)
        let reverb = try #require(GMMessage(content: .gm2Reverb([.time(64)])).systemMessage)

        #expect(GMMessage(volume) == nil)
        #expect(MIDIDeviceControlMessage(reverb) == nil)
    }

    @Test
    func init_message_wrongHeader() {
        #expect(GMMessage(MIDISystemMessage.systemExclusive([0x7f, 0x7f, 0x09, 0x01, 0xf7])) == nil)    // Real-time GM1 On
        #expect(GMMessage(MIDISystemMessage.systemExclusive([0x7e, 0x7f, 0x0a, 0x01, 0x09, 0x24, 0xf7])) == nil)
    }

    @Test
    func keyBasedInstrumentControl() {
        let message = GMMessage(content: .keyBasedInstrumentControl(10,
                                                                    note: 38,
                                                                    [.volume(0x50),
                                                                     .pan(0x00),
                                                                     .reverbSendLevel(0x7f),
                                                                     .chorusSendLevel(0x10)]))

        #expect(message.systemMessage?.dataBytes
                == [0x7f, 0x7f, 0x0a, 0x01, 0x09, 0x26] + [0x07, 0x50, 0x0a, 0x00, 0x5b, 0x7f, 0x5d, 0x10] + [0xf7])
    }

    @Test
    func messagesAreDistinct() {
        #expect(Set([GMMessage(content: .gm1SystemOn).systemMessage,
                     GMMessage(content: .gm2SystemOn).systemMessage,
                     GMMessage(content: .gmSystemOff).systemMessage]).count == 3)
    }

    @Test(arguments: [.channelPressureDestinations(16, [.pitchControl(0x42), .lfoFilterDepth(1)]),
                      .channelPressureDestinations(1, []),
                      .controlChangeDestinations(.generalPurposeController1MSB, 7, [.amplitudeControl(64)]),
                      .gm1SystemOn,
                      .gm2Chorus([.type(.flanger), .feedback(8), .modDepth(1), .modRate(2), .sendToReverb(3)]),
                      .gm2Chorus([]),
                      .gm2Reverb([.type(.plate), .time(64)]),
                      .gm2Reverb([]),
                      .gm2SystemOn,
                      .gmSystemOff,
                      .keyBasedInstrumentControl(10, note: 36, [.volume(1), .pan(2), .reverbSendLevel(3), .chorusSendLevel(4)]),
                      .keyBasedInstrumentControl(16, note: 127, [])] as [GMMessage.Content])
    func roundTrip(content: GMMessage.Content) throws {
        let original = GMMessage(content: content, deviceID: 0x10)
        let message = try #require(original.systemMessage)

        #expect(GMMessage(message) == original)
    }
}
