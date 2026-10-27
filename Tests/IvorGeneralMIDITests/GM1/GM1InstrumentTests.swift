// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM1InstrumentTests {
}

// MARK: -

extension GM1InstrumentTests {
    @Test
    func allCases() {
        #expect(GM1Instrument.allCases.count == 128)
        #expect(Set(GM1Instrument.allCases).count == 128)
        #expect(GM1Instrument.allCases.first == .acousticGrandPiano)
        #expect(GM1Instrument.allCases.last == .gunshot)
    }

    @Test
    func family() {
        #expect(GM1Instrument(program: 1).family == .piano)
        #expect(GM1Instrument(program: 8).family == .piano)
        #expect(GM1Instrument(program: 9).family == .chromaticPercussion)
        #expect(GM1Instrument(program: 25).family == .guitar)
        #expect(GM1Instrument(program: 32).family == .guitar)
        #expect(GM1Instrument(program: 41).family == .strings)
        #expect(GM1Instrument(program: 72).family == .reed)
        #expect(GM1Instrument(program: 120).family == .percussive)
        #expect(GM1Instrument(program: 121).family == .soundEffects)
        #expect(GM1Instrument(program: 128).family == .soundEffects)
    }

    @Test
    func family_matchesProgramOrder() {
        for instrument in GM1Instrument.allCases {
            let index = Int(instrument.program.uintValue - 1) / 8

            #expect(GM1InstrumentFamily.allCases[index] == instrument.family)
        }
    }

    @Test
    func init_name() {
        #expect(GM1Instrument(name: "Violin") == .violin)
        #expect(GM1Instrument(name: "acoustic grand piano") == .acousticGrandPiano)
        #expect(GM1Instrument(name: "\tElectric  Guitar (jazz)\n") == .electricGuitarJazz)
        #expect(GM1Instrument(name: "Jazz Guitar") == nil)
        #expect(GM1Instrument(name: "") == nil)
    }

    @Test
    func init_name_roundTrip() {
        for instrument in GM1Instrument.allCases {
            #expect(GM1Instrument(name: instrument.name) == instrument)
        }
    }

    @Test
    func init_program() {
        #expect(GM1Instrument(program: 1) == .acousticGrandPiano)
        #expect(GM1Instrument(program: 27) == .electricGuitarJazz)
        #expect(GM1Instrument(program: 128) == .gunshot)
    }

    @Test
    func init_program_roundTrip() {
        for instrument in GM1Instrument.allCases {
            #expect(GM1Instrument(program: instrument.program) == instrument)
        }
    }

    @Test
    func name() {
        #expect(GM1Instrument.acousticGrandPiano.name == "Acoustic Grand Piano")
        #expect(GM1Instrument.glockenspiel.name == "Glockenspiel")
        #expect(GM1Instrument.acousticGuitarNylon.name == "Acoustic Guitar (nylon)")
        #expect(GM1Instrument.violin.name == "Violin")
        #expect(GM1Instrument.clarinet.name == "Clarinet")
        #expect(GM1Instrument.lead1Square.name == "Lead 1 (square)")
        #expect(GM1Instrument.bagPipe.name == "Bag pipe")
        #expect(GM1Instrument.gunshot.name == "Gunshot")
    }

    @Test
    func patch_hasNoBank() {
        #expect(GM1Instrument.churchOrgan.patch == MIDIPatch(program: 20))
    }

    @Test
    func program() {
        #expect(GM1Instrument.acousticGrandPiano.program == 1)
        #expect(GM1Instrument.glockenspiel.program == 10)
        #expect(GM1Instrument.acousticGuitarNylon.program == 25)
        #expect(GM1Instrument.violin.program == 41)
        #expect(GM1Instrument.clarinet.program == 72)
        #expect(GM1Instrument.lead1Square.program == 81)
        #expect(GM1Instrument.bagPipe.program == 110)
        #expect(GM1Instrument.gunshot.program == 128)
    }

    @Test
    func program_inProgramOrder() {
        #expect(GM1Instrument.allCases.map(\.program.uintValue) == Array(1...128))
    }
}
