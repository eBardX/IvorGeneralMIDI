// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM2ReverbParameterTests {
}

// MARK: -

extension GM2ReverbParameterTests {
    @Test
    func bytes_time() {
        #expect(GM2ReverbParameter.time(64).bytes == [0x01, 0x40])
    }

    @Test
    func bytes_type() {
        #expect(GM2ReverbParameter.type(.smallRoom).bytes == [0x00, 0x00])
        #expect(GM2ReverbParameter.type(.plate).bytes == [0x00, 0x08])
    }

    @Test
    func equality() {
        #expect(GM2ReverbParameter.type(.plate) == GM2ReverbParameter.type(GM2ReverbType.plate))
        #expect(GM2ReverbParameter.type(.plate) != .type(.largeHall))
        #expect(GM2ReverbParameter.time(44) != .time(50))
    }

    @Test
    func hashable() {
        let parameters: Set<GM2ReverbParameter> = [.time(44), .time(44), .time(50)]

        #expect(parameters.count == 2)
    }

    @Test
    func init_bytes() {
        #expect(GM2ReverbParameter(bytes: [0x00, 0x08]) == .type(.plate))
        #expect(GM2ReverbParameter(bytes: [0x01, 0x40]) == .time(64))
    }

    @Test(arguments: [[], [0x01], [0x01, 0x02, 0x03], [0x02, 0x00], [0x00, 0x7f], [0x01, 0x80]] as [[UInt8]])
    func init_bytes_invalid(bytes: [UInt8]) {
        #expect(GM2ReverbParameter(bytes: bytes) == nil)
    }
}
