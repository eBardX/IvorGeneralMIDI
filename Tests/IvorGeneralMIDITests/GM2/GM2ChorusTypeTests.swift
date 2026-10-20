// © 2026 John Gary Pusey (see LICENSE.md)

import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM2ChorusTypeTests {
}

// MARK: -

extension GM2ChorusTypeTests {
    @Test
    func allCases() {
        #expect(GM2ChorusType.allCases.count == 6)
        #expect(Set(GM2ChorusType.allCases).count == 6)
        #expect(GM2ChorusType.allCases.first == .chorus1)
        #expect(GM2ChorusType.allCases.last == .flanger)
    }

    @Test
    func defaultFeedback() {
        #expect(GM2ChorusType.allCases.map(\.defaultFeedback.uintValue) == [0, 5, 8, 16, 64, 112])
    }

    @Test
    func defaultModDepth() {
        #expect(GM2ChorusType.allCases.map(\.defaultModDepth.uintValue) == [5, 19, 19, 16, 24, 5])
    }

    @Test
    func defaultModRate() {
        #expect(GM2ChorusType.allCases.map(\.defaultModRate.uintValue) == [3, 9, 3, 9, 2, 1])
    }

    @Test
    func defaultSendToReverb() {
        #expect(GM2ChorusType.allCases.allSatisfy { $0.defaultSendToReverb.uintValue == 0 })
    }

    @Test
    func init_value() {
        #expect(GM2ChorusType(value: 0) == .chorus1)
        #expect(GM2ChorusType(value: 2) == .chorus3)
        #expect(GM2ChorusType(value: 5) == .flanger)
    }

    @Test
    func init_value_roundTrip() {
        for type in GM2ChorusType.allCases {
            #expect(GM2ChorusType(value: type.value) == type)
        }
    }

    @Test
    func init_value_unassigned() {
        #expect(GM2ChorusType(value: 6) == nil)
        #expect(GM2ChorusType(value: 127) == nil)
    }

    @Test
    func name() {
        #expect(GM2ChorusType.allCases.map(\.name) == ["Chorus 1",
                                                       "Chorus 2",
                                                       "Chorus 3",
                                                       "Chorus 4",
                                                       "FB Chorus",
                                                       "Flanger"])
    }

    @Test
    func value() {
        #expect(GM2ChorusType.allCases.map(\.value.uintValue) == [0, 1, 2, 3, 4, 5])
    }
}
