// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM1InstrumentFamilyTests {
}

// MARK: -

extension GM1InstrumentFamilyTests {
    @Test
    func allCases() {
        #expect(GM1InstrumentFamily.allCases.count == 16)
        #expect(Set(GM1InstrumentFamily.allCases).count == 16)
        #expect(GM1InstrumentFamily.allCases.first == .piano)
        #expect(GM1InstrumentFamily.allCases.last == .soundEffects)
    }

    @Test
    func instruments() {
        #expect(GM1InstrumentFamily.piano.instruments.map(\.program) == [1, 2, 3, 4, 5, 6, 7, 8])
        #expect(GM1InstrumentFamily.soundEffects.instruments.map(\.program) == [121, 122, 123, 124, 125, 126, 127, 128])
        #expect(GM1InstrumentFamily.guitar.instruments.first == .acousticGuitarNylon)
    }

    @Test
    func instruments_inProgramOrder() {
        let instruments = GM1InstrumentFamily.allCases.flatMap(\.instruments)

        #expect(instruments == GM1Instrument.allCases)
    }

    @Test
    func name() {
        #expect(GM1InstrumentFamily.piano.name == "Piano")
        #expect(GM1InstrumentFamily.chromaticPercussion.name == "Chromatic Percussion")
        #expect(GM1InstrumentFamily.synthLead.name == "Synth Lead")
        #expect(GM1InstrumentFamily.soundEffects.name == "Sound Effects")
        #expect(Set(GM1InstrumentFamily.allCases.map(\.name)).count == 16)
    }
}
