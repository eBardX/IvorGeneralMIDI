// © 2026 John Gary Pusey (see LICENSE.md)

import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GMMessageContentTests {
}

// MARK: -

extension GMMessageContentTests {
    @Test
    func equality() {
        #expect(GMMessage.Content.gm2Reverb([.time(1)]) == .gm2Reverb([.time(1)]))
    }

    @Test
    func hashable_everyCaseIsDistinct() {
        let contents: [GMMessage.Content] = [.channelPressureDestinations(1, []),
                                             .controlChangeDestinations(.generalPurposeController1MSB, 1, []),
                                             .gm1SystemOn,
                                             .gm2Chorus([]),
                                             .gm2Reverb([]),
                                             .gm2SystemOn,
                                             .gmSystemOff,
                                             .keyBasedInstrumentControl(1, note: 1, [])]

        #expect(Set(contents).count == contents.count)
    }

    @Test
    func inequality() {
        #expect(GMMessage.Content.channelPressureDestinations(1, []) != .channelPressureDestinations(2, []))
        #expect(GMMessage.Content.keyBasedInstrumentControl(1, note: 1, []) != .keyBasedInstrumentControl(1, note: 2, []))
    }
}
