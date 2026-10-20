// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM2ChorusParameterTests {
}

// MARK: -

extension GM2ChorusParameterTests {
    @Test
    func bytes_feedback() {
        #expect(GM2ChorusParameter.feedback(8).bytes == [0x03, 0x08])
    }

    @Test
    func bytes_modDepth() {
        #expect(GM2ChorusParameter.modDepth(19).bytes == [0x02, 0x13])
    }

    @Test
    func bytes_modRate() {
        #expect(GM2ChorusParameter.modRate(3).bytes == [0x01, 0x03])
    }

    @Test
    func bytes_sendToReverb() {
        #expect(GM2ChorusParameter.sendToReverb(127).bytes == [0x04, 0x7f])
    }

    @Test
    func bytes_type() {
        #expect(GM2ChorusParameter.type(.chorus1).bytes == [0x00, 0x00])
        #expect(GM2ChorusParameter.type(.flanger).bytes == [0x00, 0x05])
    }

    @Test
    func equality() {
        #expect(GM2ChorusParameter.modRate(3) == GM2ChorusParameter.modRate(MIDIData1Value(clamping: 3)))
        #expect(GM2ChorusParameter.modRate(3) != .modDepth(3))
    }

    @Test
    func hashable() {
        let parameters: Set<GM2ChorusParameter> = [.modRate(3), .modRate(3), .modDepth(3)]

        #expect(parameters.count == 2)
    }
}
