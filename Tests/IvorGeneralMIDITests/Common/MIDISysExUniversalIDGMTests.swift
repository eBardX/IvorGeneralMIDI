// © 2026 John Gary Pusey (see LICENSE.md)

import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct MIDISysExUniversalIDGMTests {
}

// MARK: -

extension MIDISysExUniversalIDGMTests {
    @Test
    func constants() {
        #expect(MIDISysExUniversalID.controllerDestination == MIDISysExUniversalID(realTime: true, subID: 0x09))
        #expect(MIDISysExUniversalID.keyBasedInstrumentControl == MIDISysExUniversalID(realTime: true, subID: 0x0a))
    }

    @Test
    func controllerDestination_isNotGeneralMIDI() {
        #expect(MIDISysExUniversalID.controllerDestination != .generalMIDI)
    }
}
