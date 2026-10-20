// © 2026 John Gary Pusey (see LICENSE.md)

import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM2ReverbTypeTests {
}

// MARK: -

extension GM2ReverbTypeTests {
    @Test
    func allCases() {
        #expect(GM2ReverbType.allCases.count == 6)
        #expect(Set(GM2ReverbType.allCases).count == 6)
        #expect(GM2ReverbType.allCases.first == .smallRoom)
        #expect(GM2ReverbType.allCases.last == .plate)
    }

    @Test
    func defaultTime() {
        #expect(GM2ReverbType.allCases.map(\.defaultTime.uintValue) == [44, 50, 56, 64, 64, 50])
    }

    @Test
    func init_value() {
        #expect(GM2ReverbType(value: 0) == .smallRoom)
        #expect(GM2ReverbType(value: 4) == .largeHall)
        #expect(GM2ReverbType(value: 8) == .plate)
    }

    @Test
    func init_value_roundTrip() {
        for type in GM2ReverbType.allCases {
            #expect(GM2ReverbType(value: type.value) == type)
        }
    }

    @Test
    func init_value_unassigned() {
        #expect(GM2ReverbType(value: 5) == nil)
        #expect(GM2ReverbType(value: 7) == nil)
        #expect(GM2ReverbType(value: 9) == nil)
        #expect(GM2ReverbType(value: 127) == nil)
    }

    @Test
    func name() {
        #expect(GM2ReverbType.allCases.map(\.name) == ["Small Room",
                                                       "Medium Room",
                                                       "Large Room",
                                                       "Medium Hall",
                                                       "Large Hall",
                                                       "Plate"])
    }

    @Test
    func value() {
        #expect(GM2ReverbType.allCases.map(\.value.uintValue) == [0, 1, 2, 3, 4, 8])
    }
}
