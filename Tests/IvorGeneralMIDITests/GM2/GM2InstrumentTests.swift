// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM2InstrumentTests {
}

// MARK: -

extension GM2InstrumentTests {
    @Test
    func allCases() {
        #expect(GM2Instrument.allCases.count == 256)
        #expect(Set(GM2Instrument.allCases).count == 256)
        #expect(GM2Instrument.allCases.first == .acousticGrandPiano)
        #expect(GM2Instrument.allCases.last == .explosion)
    }

    @Test
    func bankLSB() {
        #expect(GM2Instrument.acousticGrandPiano.bankLSB == 0)
        #expect(GM2Instrument.acousticGrandPianoDark.bankLSB == 2)
        #expect(GM2Instrument.epPhase.bankLSB == 4)
        #expect(GM2Instrument.burstNoise.bankLSB == 9)
    }

    @Test
    func bankMSB() {
        #expect(GM2Instrument.bankMSB.uintValue == 0x79)
    }

    @Test
    func family() {
        #expect(GM2Instrument.acousticGrandPianoWide.family == .piano)
        #expect(GM2Instrument.ukulele.family == .guitar)
        #expect(GM2Instrument.lead2cDoubleSawtooth.family == .synthLead)
        #expect(GM2Instrument.explosion.family == .soundEffects)
    }

    @Test
    func family_matchesGM1Instrument() {
        for instrument in GM2Instrument.allCases {
            #expect(instrument.family == instrument.gm1Instrument.family)
        }
    }

    @Test
    func gm1Instrument() {
        #expect(GM2Instrument.acousticGrandPiano.gm1Instrument == .acousticGrandPiano)
        #expect(GM2Instrument.acousticGrandPianoDark.gm1Instrument == .acousticGrandPiano)
        #expect(GM2Instrument.ukulele.gm1Instrument == .acousticGuitarNylon)
        #expect(GM2Instrument.mandolin.gm1Instrument == .acousticGuitarSteel)
        #expect(GM2Instrument.explosion.gm1Instrument == .gunshot)
    }

    @Test
    func gm1Instrument_sharesProgram() {
        for instrument in GM2Instrument.allCases {
            #expect(instrument.gm1Instrument.program == instrument.program)
        }
    }

    @Test
    func init_bankLSBProgram() {
        #expect(GM2Instrument(bankLSB: 0, program: 1) == .acousticGrandPiano)
        #expect(GM2Instrument(bankLSB: 1, program: 1) == .acousticGrandPianoWide)
        #expect(GM2Instrument(bankLSB: 1, program: 25) == .ukulele)
        #expect(GM2Instrument(bankLSB: 9, program: 126) == .burstNoise)
        #expect(GM2Instrument(bankLSB: 3, program: 128) == .explosion)
    }

    @Test
    func init_bankLSBProgram_roundTrip() {
        for instrument in GM2Instrument.allCases {
            #expect(GM2Instrument(bankLSB: instrument.bankLSB,
                                  program: instrument.program) == instrument)
        }
    }

    @Test
    func init_bankLSBProgram_unassigned() {
        #expect(GM2Instrument(bankLSB: 3, program: 1) == nil)
        #expect(GM2Instrument(bankLSB: 1, program: 9) == nil)
        #expect(GM2Instrument(bankLSB: 10, program: 126) == nil)
        #expect(GM2Instrument(bankLSB: 127, program: 128) == nil)
    }

    @Test
    func init_name() {
        #expect(GM2Instrument(name: "Violin") == .violin)
        #expect(GM2Instrument(name: "acoustic grand piano (WIDE)") == .acousticGrandPianoWide)
        #expect(GM2Instrument(name: "\tLead 2c  (double sawtooth)\n") == .lead2cDoubleSawtooth)
        #expect(GM2Instrument(name: "Wide Acoustic Grand") == nil)
        #expect(GM2Instrument(name: "") == nil)
    }

    @Test
    func init_name_roundTrip() {
        for instrument in GM2Instrument.allCases {
            #expect(GM2Instrument(name: instrument.name) == instrument)
        }
    }

    @Test
    func name() {
        #expect(GM2Instrument.acousticGrandPiano.name == "Acoustic Grand Piano")
        #expect(GM2Instrument.acousticGrandPianoDark.name == "Acoustic Grand Piano (dark)")
        #expect(GM2Instrument.twelveStringsGuitar.name == "12-Strings Guitar")
        #expect(GM2Instrument.stringEnsembles1.name == "String Ensembles 1")
        #expect(GM2Instrument.synthStrings3.name == "SynthStrings 3")
        #expect(GM2Instrument.lead2bSawPulse.name == "Lead 2b (saw + pulse)")
        #expect(GM2Instrument.explosion.name == "Explosion")
    }

    @Test
    func name_sixties() {
        // Spelled without an apostrophe, unlike the General MIDI 2
        // specification.
        #expect(GM2Instrument.italianSixtiesOrgan.name == "Italian 60s Organ")
        #expect(GM2Instrument.sixtiesElectricPiano.name == "60s Electric Piano")
        #expect(GM2Instrument.sixtiesStrings.name == "60s Strings")
        #expect(GM2Instrument(name: "60s electric piano") == .sixtiesElectricPiano)
    }

    @Test
    func program() {
        #expect(GM2Instrument.acousticGrandPiano.program == 1)
        #expect(GM2Instrument.acousticGrandPianoDark.program == 1)
        #expect(GM2Instrument.ukulele.program == 25)
        #expect(GM2Instrument.burstNoise.program == 126)
        #expect(GM2Instrument.explosion.program == 128)
    }

    @Test
    func program_everyProgramHasBankLSB0() {
        let programs = GM2Instrument.allCases.filter { $0.bankLSB == 0 }.map(\.program.uintValue)

        #expect(programs == Array(1...128))
    }

    @Test
    func recommendedKeyRange() {
        let range = { (instrument: GM2Instrument) in
            instrument.recommendedKeyRange.map { $0.lowerBound.uintValue...$0.upperBound.uintValue }
        }

        // Values from Appendix A of the General MIDI 2 specification.
        #expect(range(.acousticGrandPiano) == 21...108)
        #expect(range(.clavi) == 36...96)
        #expect(range(.electricPiano1) == 28...103)
        #expect(range(.harpsichordWithKeyOff) == 41...89)
        #expect(range(.fretlessBass) == 28...55)
        #expect(range(.trombone) == 34...75)
        #expect(range(.piccolo) == 74...108)
        #expect(range(.ukulele) == 40...84)
        #expect(range(.steelDrums) == 52...76)
    }

    @Test
    func recommendedKeyRange_effectSounds() {
        for instrument in GM2Instrument.allCases {
            let isEffectSound = instrument.program.uintValue >= 116

            #expect((instrument.recommendedKeyRange == nil) == isEffectSound)
        }
    }

    @Test
    func recommendedKeyRange_sharedByVariations() {
        for instrument in GM2Instrument.allCases {
            let base = GM2Instrument(bankLSB: 0, program: instrument.program)

            #expect(instrument.recommendedKeyRange == base?.recommendedKeyRange)
        }
    }

    @Test
    func selectionMessages() {
        let messages = GM2Instrument.ukulele.selectionMessages(channel: 3)

        #expect(messages == [.controlChange(3, .bankSelectMSB, 121),
                             .controlChange(3, .bankSelectLSB, 1),
                             .programChange(3, 25)])
    }

    @Test
    func selectionMessages_bankLSB0() {
        let messages = GM2Instrument.acousticGrandPiano.selectionMessages(channel: 1)

        #expect(messages == [.controlChange(1, .bankSelectMSB, 121),
                             .controlChange(1, .bankSelectLSB, 0),
                             .programChange(1, 1)])
    }
}
