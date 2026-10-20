// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import Testing

struct StringGeneralMIDITests {
}

// MARK: -

extension StringGeneralMIDITests {
    @Test
    func normalizedName() {
        #expect("Acoustic Grand Piano".normalizedName == "acoustic grand piano")
        #expect("  closed   HI-HAT ".normalizedName == "closed hi-hat")
        #expect("\tElectric\nGuitar".normalizedName == "electric guitar")
        #expect("".normalizedName.isEmpty)
        #expect("   ".normalizedName.isEmpty)
    }
}
