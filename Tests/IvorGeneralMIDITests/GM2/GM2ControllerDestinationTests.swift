// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM2ControllerDestinationTests {
}

// MARK: -

extension GM2ControllerDestinationTests {
    @Test
    func bytes_amplitudeControl() {
        #expect(GM2ControllerDestination.amplitudeControl(64).bytes == [0x02, 0x40])
    }

    @Test
    func bytes_filterCutoffControl() {
        #expect(GM2ControllerDestination.filterCutoffControl(0x60).bytes == [0x01, 0x60])
    }

    @Test
    func bytes_lfoAmplitudeDepth() {
        #expect(GM2ControllerDestination.lfoAmplitudeDepth(0x20).bytes == [0x05, 0x20])
    }

    @Test
    func bytes_lfoFilterDepth() {
        #expect(GM2ControllerDestination.lfoFilterDepth(127).bytes == [0x04, 0x7f])
    }

    @Test
    func bytes_lfoPitchDepth() {
        #expect(GM2ControllerDestination.lfoPitchDepth(0).bytes == [0x03, 0x00])
    }

    @Test
    func bytes_pitchControl() {
        #expect(GM2ControllerDestination.pitchControl(0x42).bytes == [0x00, 0x42])
    }

    @Test
    func equality() {
        #expect(GM2ControllerDestination.pitchControl(64) == .pitchControl(MIDIData1Value(clamping: 64)))
        #expect(GM2ControllerDestination.pitchControl(64) != .amplitudeControl(64))
    }

    @Test
    func hashable() {
        let parameters: Set<GM2ControllerDestination> = [.pitchControl(64), .pitchControl(64), .amplitudeControl(64)]

        #expect(parameters.count == 2)
    }
}
