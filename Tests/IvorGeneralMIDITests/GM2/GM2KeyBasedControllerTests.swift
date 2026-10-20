// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM2KeyBasedControllerTests {
}

// MARK: -

extension GM2KeyBasedControllerTests {
    @Test
    func bytes_chorusSendLevel() {
        #expect(GM2KeyBasedController.chorusSendLevel(0x10).bytes == [0x5d, 0x10])
    }

    @Test
    func bytes_pan() {
        #expect(GM2KeyBasedController.pan(64).bytes == [0x0a, 0x40])
    }

    @Test
    func bytes_reverbSendLevel() {
        #expect(GM2KeyBasedController.reverbSendLevel(127).bytes == [0x5b, 0x7f])
    }

    @Test
    func bytes_volume() {
        #expect(GM2KeyBasedController.volume(64).bytes == [0x07, 0x40])
    }

    @Test
    func equality() {
        #expect(GM2KeyBasedController.pan(64) == .pan(MIDIData1Value(clamping: 64)))
        #expect(GM2KeyBasedController.pan(64) != .volume(64))
    }

    @Test
    func hashable() {
        let parameters: Set<GM2KeyBasedController> = [.pan(64), .pan(64), .volume(64)]

        #expect(parameters.count == 2)
    }
}
