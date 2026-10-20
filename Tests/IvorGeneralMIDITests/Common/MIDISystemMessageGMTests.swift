// © 2026 John Gary Pusey (see LICENSE.md)

import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct MIDISystemMessageGMTests {
}

// MARK: -

extension MIDISystemMessageGMTests {
    @Test
    func channelPressureDestinationSetting() {
        // The example in CA-022 and General MIDI 2 section 4.6.1.
        let message = MIDISystemMessage.channelPressureDestinationSetting(channel: 7,
                                                                          .pitchControl(0x42),
                                                                          .filterCutoffControl(0x60),
                                                                          .lfoAmplitudeDepth(0x20))

        #expect(message.dataBytes == [0x7f, 0x7f, 0x09, 0x01, 0x06] + [0x00, 0x42, 0x01, 0x60, 0x05, 0x20] + [0xf7])
    }

    @Test
    func channelPressureDestinationSetting_parsesFromBytes() {
        let message = MIDISystemMessage.channelPressureDestinationSetting(channel: 1, .amplitudeControl(64))

        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: message.dataBytes ?? []) == message)
    }

    @Test
    func controlChangeDestinationSetting() {
        // The example in General MIDI 2 section 4.6.2: General Purpose
        // Controller 1 on channel 7.
        let message = MIDISystemMessage.controlChangeDestinationSetting(controller: .generalPurposeController1MSB,
                                                                        channel: 7,
                                                                        .pitchControl(0x42),
                                                                        .filterCutoffControl(0x60),
                                                                        .lfoAmplitudeDepth(0x20))

        #expect(message?.dataBytes == [0x7f, 0x7f, 0x09, 0x03, 0x06, 0x10] + [0x00, 0x42, 0x01, 0x60, 0x05, 0x20] + [0xf7])
    }

    @Test
    func controlChangeDestinationSetting_assignableControllers() {
        for number in UInt(0)...127 {
            guard let controller = MIDIController(uintValue: number)
            else { continue }

            let message = MIDISystemMessage.controlChangeDestinationSetting(controller: controller,
                                                                            channel: 1,
                                                                            .lfoPitchDepth(10))

            #expect((message != nil) == ((1...31).contains(number) || (64...95).contains(number)))
        }
    }

    @Test
    func gm1SystemOn() {
        #expect(MIDISystemMessage.gm1SystemOn.statusByte == 0xf0)
        #expect(MIDISystemMessage.gm1SystemOn.dataBytes == [0x7e, 0x7f, 0x09, 0x01, 0xf7])
    }

    @Test
    func gm1SystemOn_parsesFromBytes() {
        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: [0x7e, 0x7f, 0x09, 0x01, 0xf7]) == .gm1SystemOn)
    }

    @Test
    func gm2Chorus() {
        let message = MIDISystemMessage.gm2Chorus(.type(.chorus3), .feedback(8))

        #expect(message.statusByte == 0xf0)
        #expect(message.dataBytes == [0x7f, 0x7f, 0x04, 0x05, 0x01, 0x01, 0x01, 0x01, 0x02] + [0x00, 0x02] + [0x03, 0x08] + [0xf7])
    }

    @Test
    func gm2Chorus_parsesFromBytes() {
        let message = MIDISystemMessage.gm2Chorus(.modRate(9), .modDepth(19), .sendToReverb(0))

        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: message.dataBytes ?? []) == message)
    }

    @Test
    func gm2Reverb() {
        let message = MIDISystemMessage.gm2Reverb(.type(.largeHall), .time(64))

        #expect(message.statusByte == 0xf0)
        #expect(message.dataBytes == [0x7f, 0x7f, 0x04, 0x05, 0x01, 0x01, 0x01, 0x01, 0x01] + [0x00, 0x04] + [0x01, 0x40] + [0xf7])
    }

    @Test
    func gm2Reverb_parsesFromBytes() {
        let message = MIDISystemMessage.gm2Reverb(.type(.plate))

        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: message.dataBytes ?? []) == message)
    }

    @Test
    func gm2SystemOn() {
        #expect(MIDISystemMessage.gm2SystemOn.statusByte == 0xf0)
        #expect(MIDISystemMessage.gm2SystemOn.dataBytes == [0x7e, 0x7f, 0x09, 0x03, 0xf7])
    }

    @Test
    func gm2SystemOn_parsesFromBytes() {
        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: [0x7e, 0x7f, 0x09, 0x03, 0xf7]) == .gm2SystemOn)
    }

    @Test
    func gmSystemOff() {
        #expect(MIDISystemMessage.gmSystemOff.statusByte == 0xf0)
        #expect(MIDISystemMessage.gmSystemOff.dataBytes == [0x7e, 0x7f, 0x09, 0x02, 0xf7])
    }

    @Test
    func gmSystemOff_parsesFromBytes() {
        #expect(MIDISystemMessage(statusByte: 0xf0,
                                  dataBytes: [0x7e, 0x7f, 0x09, 0x02, 0xf7]) == .gmSystemOff)
    }

    @Test
    func keyBasedInstrumentControl() {
        let message = MIDISystemMessage.keyBasedInstrumentControl(channel: 10,
                                                                  note: 38,
                                                                  .volume(0x50),
                                                                  .pan(0x00),
                                                                  .reverbSendLevel(0x7f),
                                                                  .chorusSendLevel(0x10))

        #expect(message.dataBytes == [0x7f, 0x7f, 0x0a, 0x01, 0x09, 0x26] + [0x07, 0x50, 0x0a, 0x00, 0x5b, 0x7f, 0x5d, 0x10] + [0xf7])
    }

    @Test
    func messagesAreDistinct() {
        #expect(Set([MIDISystemMessage.gm1SystemOn, .gm2SystemOn, .gmSystemOff]).count == 3)
    }
}
