// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

internal import XestiTools

/// A General MIDI 2 (GM2) instrument: one of the 256 melodic sounds that a
/// bank select and program change select.
///
/// Each instrument is identified by a program and a bank LSB, with the bank
/// MSB set to ``bankMSB`` (121). Bank LSB 0 holds the 128 General MIDI 1
/// instruments; the remaining 128 are variations of them.
///
/// ``allCases`` lists the instruments in program order and then bank LSB
/// order, from ``acousticGrandPiano`` (program 1, bank LSB 0) to
/// ``explosion`` (program 128, bank LSB 3).
///
/// Names follow the General MIDI 2 specification, which spells a few bank
/// LSB 0 names differently from the General MIDI 1 specification, such as
/// “String Ensembles 1” rather than “String Ensemble 1”.
public enum GM2Instrument { // swiftlint:disable:this type_body_length

    /// Accordion (program 22, bank LSB 0).
    case accordion

    /// Accordion 2 (program 22, bank LSB 1).
    case accordion2

    /// Acoustic Bass (program 33, bank LSB 0).
    case acousticBass

    /// Acoustic Bass String Slap (program 121, bank LSB 2).
    case acousticBassStringSlap

    /// Acoustic Grand Piano (program 1, bank LSB 0).
    case acousticGrandPiano

    /// Acoustic Grand Piano (dark) (program 1, bank LSB 2).
    case acousticGrandPianoDark

    /// Acoustic Grand Piano (wide) (program 1, bank LSB 1).
    case acousticGrandPianoWide

    /// Acoustic Guitar (nylon) (program 25, bank LSB 0).
    case acousticGuitarNylon

    /// Acoustic Guitar (nylon 2) (program 25, bank LSB 3).
    case acousticGuitarNylon2

    /// Acoustic Guitar (nylon + key off) (program 25, bank LSB 2).
    case acousticGuitarNylonKeyOff

    /// Acoustic Guitar (steel) (program 26, bank LSB 0).
    case acousticGuitarSteel

    /// Agogo (program 114, bank LSB 0).
    case agogo

    /// Alto Sax (program 66, bank LSB 0).
    case altoSax

    /// Analog Synth Brass 1 (program 63, bank LSB 2).
    case analogSynthBrass1

    /// Analog Synth Brass 2 (program 64, bank LSB 2).
    case analogSynthBrass2

    /// Analog Voice (program 55, bank LSB 1).
    case analogVoice

    /// Applause (program 127, bank LSB 0).
    case applause

    /// Attack Pulse (program 40, bank LSB 3).
    case attackPulse

    /// Bag pipe (program 110, bank LSB 0).
    case bagPipe

    /// Banjo (program 106, bank LSB 0).
    case banjo

    /// Baritone Sax (program 68, bank LSB 0).
    case baritoneSax

    /// Bass Hit Plus (program 56, bank LSB 1).
    case bassHitPlus

    /// Bassoon (program 71, bank LSB 0).
    case bassoon

    /// Bird Tweet (program 124, bank LSB 0).
    case birdTweet

    /// Bird Tweet 2 (program 124, bank LSB 3).
    case birdTweet2

    /// Blown Bottle (program 77, bank LSB 0).
    case blownBottle

    /// Brass Section (program 62, bank LSB 0).
    case brassSection

    /// Brass Section 2 (octave mix) (program 62, bank LSB 1).
    case brassSection2OctaveMix

    /// Breath Noise (program 122, bank LSB 0).
    case breathNoise

    /// Bright Acoustic Piano (program 2, bank LSB 0).
    case brightAcousticPiano

    /// Bright Acoustic Piano (wide) (program 2, bank LSB 1).
    case brightAcousticPianoWide

    /// Bright Trombone (program 58, bank LSB 2).
    case brightTrombone

    /// Bubble (program 123, bank LSB 5).
    case bubble

    /// Burst Noise (program 126, bank LSB 9).
    case burstNoise

    /// Car Crash (program 126, bank LSB 4).
    case carCrash

    /// Car Engine (program 126, bank LSB 1).
    case carEngine

    /// Carillon (program 15, bank LSB 2).
    case carillon

    /// Car Pass (program 126, bank LSB 3).
    case carPass

    /// Car Stop (program 126, bank LSB 2).
    case carStop

    /// Castanets (program 116, bank LSB 1).
    case castanets

    /// Celesta (program 9, bank LSB 0).
    case celesta

    /// Cello (program 43, bank LSB 0).
    case cello

    /// Choir Aahs (program 53, bank LSB 0).
    case choirAahs

    /// Choir Aahs 2 (program 53, bank LSB 1).
    case choirAahs2

    /// Church Bell (program 15, bank LSB 1).
    case churchBell

    /// Church Organ (program 20, bank LSB 0).
    case churchOrgan

    /// Church Organ (octave mix) (program 20, bank LSB 1).
    case churchOrganOctaveMix

    /// Clarinet (program 72, bank LSB 0).
    case clarinet

    /// Clavi (program 8, bank LSB 0).
    case clavi

    /// Clavi Bass (program 39, bank LSB 3).
    case claviBass

    /// Concert Bass Drum (program 117, bank LSB 1).
    case concertBassDrum

    /// Contrabass (program 44, bank LSB 0).
    case contrabass

    /// Dark Trumpet Soft (program 57, bank LSB 1).
    case darkTrumpetSoft

    /// Detuned Church Organ (program 20, bank LSB 2).
    case detunedChurchOrgan

    /// Detuned Drawbar Organ (program 17, bank LSB 1).
    case detunedDrawbarOrgan

    /// Detuned Electric Piano 1 (program 5, bank LSB 1).
    case detunedElectricPiano1

    /// Detuned Electric Piano 2 (program 6, bank LSB 1).
    case detunedElectricPiano2

    /// Detuned Percussive Organ (program 18, bank LSB 1).
    case detunedPercussiveOrgan

    /// Distorted Rhythm Guitar (program 31, bank LSB 2).
    case distortedRhythmGuitar

    /// Distortion Guitar (program 31, bank LSB 0).
    case distortionGuitar

    /// Distortion Guitar (with feedback) (program 31, bank LSB 1).
    case distortionGuitarWithFeedback

    /// Dog (program 124, bank LSB 1).
    case dog

    /// Door (program 125, bank LSB 3).
    case door

    /// Door Creaking (program 125, bank LSB 2).
    case doorCreaking

    /// Drawbar Organ (program 17, bank LSB 0).
    case drawbarOrgan

    /// Drawbar Organ 2 (program 17, bank LSB 3).
    case drawbarOrgan2

    /// Dulcimer (program 16, bank LSB 0).
    case dulcimer

    /// Electric Bass (finger) (program 34, bank LSB 0).
    case electricBassFinger

    /// Electric Bass (pick) (program 35, bank LSB 0).
    case electricBassPick

    /// Electric Drum (program 119, bank LSB 2).
    case electricDrum

    /// Electric Grand Piano (program 3, bank LSB 0).
    case electricGrandPiano

    /// Electric Grand Piano (wide) (program 3, bank LSB 1).
    case electricGrandPianoWide

    /// Electric Guitar (clean) (program 28, bank LSB 0).
    case electricGuitarClean

    /// Electric Guitar (detuned clean) (program 28, bank LSB 1).
    case electricGuitarDetunedClean

    /// Electric Guitar (funky cutting) (program 29, bank LSB 1).
    case electricGuitarFunkyCutting

    /// Electric Guitar (jazz) (program 27, bank LSB 0).
    case electricGuitarJazz

    /// Electric Guitar (muted) (program 29, bank LSB 0).
    case electricGuitarMuted

    /// Electric Guitar (muted velo-sw) (program 29, bank LSB 2).
    case electricGuitarMutedVeloSw

    /// Electric Guitar (pedal steel) (program 27, bank LSB 1).
    case electricGuitarPedalSteel

    /// Electric Piano 1 (program 5, bank LSB 0).
    case electricPiano1

    /// Electric Piano 1 (velocity mix) (program 5, bank LSB 2).
    case electricPiano1VelocityMix

    /// Electric Piano 2 (program 6, bank LSB 0).
    case electricPiano2

    /// Electric Piano 2 (velocity mix) (program 6, bank LSB 2).
    case electricPiano2VelocityMix

    /// English Horn (program 70, bank LSB 0).
    case englishHorn

    /// EP Legend (program 6, bank LSB 3).
    case epLegend

    /// EP Phase (program 6, bank LSB 4).
    case epPhase

    /// Euro Hit (program 56, bank LSB 3).
    case euroHit

    /// Explosion (program 128, bank LSB 3).
    case explosion

    /// Fiddle (program 111, bank LSB 0).
    case fiddle

    /// Finger Slap Bass (program 34, bank LSB 1).
    case fingerSlapBass

    /// Flute (program 74, bank LSB 0).
    case flute

    /// Flute Key Click (program 122, bank LSB 1).
    case fluteKeyClick

    /// Footsteps (program 127, bank LSB 5).
    case footsteps

    /// French Horn (program 61, bank LSB 0).
    case frenchHorn

    /// French Horn 2 (warm) (program 61, bank LSB 1).
    case frenchHorn2Warm

    /// Fretless Bass (program 36, bank LSB 0).
    case fretlessBass

    /// FX 1 (rain) (program 97, bank LSB 0).
    case fx1Rain

    /// FX 2 (soundtrack) (program 98, bank LSB 0).
    case fx2Soundtrack

    /// FX 3a (synth mallet) (program 99, bank LSB 1).
    case fx3aSynthMallet

    /// FX 3 (crystal) (program 99, bank LSB 0).
    case fx3Crystal

    /// FX 4 (atmosphere) (program 100, bank LSB 0).
    case fx4Atmosphere

    /// FX 5 (brightness) (program 101, bank LSB 0).
    case fx5Brightness

    /// FX 6 (goblins) (program 102, bank LSB 0).
    case fx6Goblins

    /// FX 7a (echo bell) (program 103, bank LSB 1).
    case fx7aEchoBell

    /// FX 7b (echo pan) (program 103, bank LSB 2).
    case fx7bEchoPan

    /// FX 7 (echoes) (program 103, bank LSB 0).
    case fx7Echoes

    /// FX 8 (sci-fi) (program 104, bank LSB 0).
    case fx8SciFi

    /// Glockenspiel (program 10, bank LSB 0).
    case glockenspiel

    /// Guitar Cutting Noise (program 121, bank LSB 1).
    case guitarCuttingNoise

    /// Guitar Feedback (program 32, bank LSB 1).
    case guitarFeedback

    /// Guitar Fret Noise (program 121, bank LSB 0).
    case guitarFretNoise

    /// Guitar Harmonics (program 32, bank LSB 0).
    case guitarHarmonics

    /// Guitar Pinch (program 30, bank LSB 1).
    case guitarPinch

    /// Gunshot (program 128, bank LSB 0).
    case gunshot

    /// Hammer (program 39, bank LSB 4).
    case hammer

    /// Harmonica (program 23, bank LSB 0).
    case harmonica

    /// Harpsichord (program 7, bank LSB 0).
    case harpsichord

    /// Harpsichord (octave mix) (program 7, bank LSB 1).
    case harpsichordOctaveMix

    /// Harpsichord (wide) (program 7, bank LSB 2).
    case harpsichordWide

    /// Harpsichord (with key off) (program 7, bank LSB 3).
    case harpsichordWithKeyOff

    /// Heart Beat (program 127, bank LSB 4).
    case heartBeat

    /// Helicopter (program 126, bank LSB 0).
    case helicopter

    /// Honky-tonk Piano (program 4, bank LSB 0).
    case honkyTonkPiano

    /// Honky-tonk Piano (wide) (program 4, bank LSB 1).
    case honkyTonkPianoWide

    /// Horse Gallop (program 124, bank LSB 2).
    case horseGallop

    /// Humming (program 54, bank LSB 1).
    case humming

    /// Italian 60s Organ (program 17, bank LSB 2).
    case italianSixtiesOrgan

    /// Jazz Man (program 29, bank LSB 3).
    case jazzMan

    /// Jetplane (program 126, bank LSB 7).
    case jetplane

    /// Jump Brass (program 63, bank LSB 3).
    case jumpBrass

    /// Kalimba (program 109, bank LSB 0).
    case kalimba

    /// Koto (program 108, bank LSB 0).
    case koto

    /// Lasergun (program 128, bank LSB 2).
    case lasergun

    /// Laughing (program 127, bank LSB 1).
    case laughing

    /// Lead 1a (square 2) (program 81, bank LSB 1).
    case lead1aSquare2

    /// Lead 1b (sine) (program 81, bank LSB 2).
    case lead1bSine

    /// Lead 1 (square) (program 81, bank LSB 0).
    case lead1Square

    /// Lead 2a (sawtooth 2) (program 82, bank LSB 1).
    case lead2aSawtooth2

    /// Lead 2b (saw + pulse) (program 82, bank LSB 2).
    case lead2bSawPulse

    /// Lead 2c (double sawtooth) (program 82, bank LSB 3).
    case lead2cDoubleSawtooth

    /// Lead 2d (sequenced analog) (program 82, bank LSB 4).
    case lead2dSequencedAnalog

    /// Lead 2 (sawtooth) (program 82, bank LSB 0).
    case lead2Sawtooth

    /// Lead 3 (calliope) (program 83, bank LSB 0).
    case lead3Calliope

    /// Lead 4 (chiff) (program 84, bank LSB 0).
    case lead4Chiff

    /// Lead 5a (wire lead) (program 85, bank LSB 1).
    case lead5aWireLead

    /// Lead 5 (charang) (program 85, bank LSB 0).
    case lead5Charang

    /// Lead 6 (voice) (program 86, bank LSB 0).
    case lead6Voice

    /// Lead 7 (fifths) (program 87, bank LSB 0).
    case lead7Fifths

    /// Lead 8a (soft wrl) (program 88, bank LSB 1).
    case lead8aSoftWrl

    /// Lead 8 (bass + lead) (program 88, bank LSB 0).
    case lead8BassAndLead

    /// Machine Gun (program 128, bank LSB 1).
    case machineGun

    /// Mandolin (program 26, bank LSB 2).
    case mandolin

    /// Marimba (program 13, bank LSB 0).
    case marimba

    /// Marimba (wide) (program 13, bank LSB 1).
    case marimbaWide

    /// Melodic Tom (program 118, bank LSB 0).
    case melodicTom

    /// Melodic Tom 2 (power) (program 118, bank LSB 1).
    case melodicTom2Power

    /// Mid Tone Guitar (program 28, bank LSB 2).
    case midToneGuitar

    /// Music Box (program 11, bank LSB 0).
    case musicBox

    /// Muted Trumpet (program 60, bank LSB 0).
    case mutedTrumpet

    /// Muted Trumpet 2 (program 60, bank LSB 1).
    case mutedTrumpet2

    /// Oboe (program 69, bank LSB 0).
    case oboe

    /// Ocarina (program 80, bank LSB 0).
    case ocarina

    /// Orchestra Hit (program 56, bank LSB 0).
    case orchestraHit

    /// Orchestral Harp (program 47, bank LSB 0).
    case orchestralHarp

    /// Overdriven Guitar (program 30, bank LSB 0).
    case overdrivenGuitar

    /// Pad 1 (new age) (program 89, bank LSB 0).
    case pad1NewAge

    /// Pad 2a (sine pad) (program 90, bank LSB 1).
    case pad2aSinePad

    /// Pad 2 (warm) (program 90, bank LSB 0).
    case pad2Warm

    /// Pad 3 (polysynth) (program 91, bank LSB 0).
    case pad3Polysynth

    /// Pad 4a (itopia) (program 92, bank LSB 1).
    case pad4aItopia

    /// Pad 4 (choir) (program 92, bank LSB 0).
    case pad4Choir

    /// Pad 5 (bowed) (program 93, bank LSB 0).
    case pad5Bowed

    /// Pad 6 (metallic) (program 94, bank LSB 0).
    case pad6Metallic

    /// Pad 7 (halo) (program 95, bank LSB 0).
    case pad7Halo

    /// Pad 8 (sweep) (program 96, bank LSB 0).
    case pad8Sweep

    /// Pan Flute (program 76, bank LSB 0).
    case panFlute

    /// Percussive Organ (program 18, bank LSB 0).
    case percussiveOrgan

    /// Percussive Organ 2 (program 18, bank LSB 2).
    case percussiveOrgan2

    /// Piccolo (program 73, bank LSB 0).
    case piccolo

    /// Pizzicato Strings (program 46, bank LSB 0).
    case pizzicatoStrings

    /// Puff Organ (program 21, bank LSB 1).
    case puffOrgan

    /// Pulse Clavi (program 8, bank LSB 1).
    case pulseClavi

    /// Punch (program 127, bank LSB 3).
    case punch

    /// Rain (program 123, bank LSB 1).
    case rain

    /// Recorder (program 75, bank LSB 0).
    case recorder

    /// Reed Organ (program 21, bank LSB 0).
    case reedOrgan

    /// Reverse Cymbal (program 120, bank LSB 0).
    case reverseCymbal

    /// Rhythm Box Tom (program 119, bank LSB 1).
    case rhythmBoxTom

    /// Rock Organ (program 19, bank LSB 0).
    case rockOrgan

    /// Scratch (program 125, bank LSB 4).
    case scratch

    /// Screaming (program 127, bank LSB 2).
    case screaming

    /// Seashore (program 123, bank LSB 0).
    case seashore

    /// Shakuhachi (program 78, bank LSB 0).
    case shakuhachi

    /// Shamisen (program 107, bank LSB 0).
    case shamisen

    /// Shanai (program 112, bank LSB 0).
    case shanai

    /// Siren (program 126, bank LSB 5).
    case siren

    /// Sitar (program 105, bank LSB 0).
    case sitar

    /// Sitar 2 (bend) (program 105, bank LSB 1).
    case sitar2Bend

    /// 6th Hit (program 56, bank LSB 2).
    case sixthHit

    /// 60s Electric Piano (program 5, bank LSB 3).
    case sixtiesElectricPiano

    /// 60s Strings (program 49, bank LSB 2).
    case sixtiesStrings

    /// Slap Bass 1 (program 37, bank LSB 0).
    case slapBass1

    /// Slap Bass 2 (program 38, bank LSB 0).
    case slapBass2

    /// Soprano Sax (program 65, bank LSB 0).
    case sopranoSax

    /// Starship (program 126, bank LSB 8).
    case starship

    /// Steel Drums (program 115, bank LSB 0).
    case steelDrums

    /// Steel Guitar with Body Sound (program 26, bank LSB 3).
    case steelGuitarWithBodySound

    /// Stream (program 123, bank LSB 4).
    case stream

    /// String Ensembles 1 (program 49, bank LSB 0).
    case stringEnsembles1

    /// String Ensembles 2 (program 50, bank LSB 0).
    case stringEnsembles2

    /// Strings and Brass (program 49, bank LSB 1).
    case stringsAndBrass

    /// Synth Bass 1 (program 39, bank LSB 0).
    case synthBass1

    /// Synth Bass 2 (program 40, bank LSB 0).
    case synthBass2

    /// Synth Bass 3 (resonance) (program 39, bank LSB 2).
    case synthBass3Resonance

    /// Synth Bass 4 (attack) (program 40, bank LSB 1).
    case synthBass4Attack

    /// Synth Bass (rubber) (program 40, bank LSB 2).
    case synthBassRubber

    /// Synth Bass (warm) (program 39, bank LSB 1).
    case synthBassWarm

    /// Synth Brass 1 (program 63, bank LSB 0).
    case synthBrass1

    /// Synth Brass 2 (program 64, bank LSB 0).
    case synthBrass2

    /// Synth Brass 3 (program 63, bank LSB 1).
    case synthBrass3

    /// Synth Brass 4 (program 64, bank LSB 1).
    case synthBrass4

    /// Synth Drum (program 119, bank LSB 0).
    case synthDrum

    /// SynthStrings 1 (program 51, bank LSB 0).
    case synthStrings1

    /// SynthStrings 2 (program 52, bank LSB 0).
    case synthStrings2

    /// SynthStrings 3 (program 51, bank LSB 1).
    case synthStrings3

    /// Synth Voice (program 55, bank LSB 0).
    case synthVoice

    /// Taiko Drum (program 117, bank LSB 0).
    case taikoDrum

    /// Taisho Koto (program 108, bank LSB 1).
    case taishoKoto

    /// Tango Accordion (program 24, bank LSB 0).
    case tangoAccordion

    /// Telephone Ring (program 125, bank LSB 0).
    case telephoneRing

    /// Telephone Ring 2 (program 125, bank LSB 1).
    case telephoneRing2

    /// Tenor Sax (program 67, bank LSB 0).
    case tenorSax

    /// Thunder (program 123, bank LSB 2).
    case thunder

    /// Timpani (program 48, bank LSB 0).
    case timpani

    /// Tinkle Bell (program 113, bank LSB 0).
    case tinkleBell

    /// Train (program 126, bank LSB 6).
    case train

    /// Tremolo Strings (program 45, bank LSB 0).
    case tremoloStrings

    /// Trombone (program 58, bank LSB 0).
    case trombone

    /// Trombone 2 (program 58, bank LSB 1).
    case trombone2

    /// Trumpet (program 57, bank LSB 0).
    case trumpet

    /// Tuba (program 59, bank LSB 0).
    case tuba

    /// Tubular Bells (program 15, bank LSB 0).
    case tubularBells

    /// 12-Strings Guitar (program 26, bank LSB 1).
    case twelveStringsGuitar

    /// Ukulele (program 25, bank LSB 1).
    case ukulele

    /// Vibraphone (program 12, bank LSB 0).
    case vibraphone

    /// Vibraphone (wide) (program 12, bank LSB 1).
    case vibraphoneWide

    /// Viola (program 42, bank LSB 0).
    case viola

    /// Violin (program 41, bank LSB 0).
    case violin

    /// Violin (slow attack) (program 41, bank LSB 1).
    case violinSlowAttack

    /// Voice Oohs (program 54, bank LSB 0).
    case voiceOohs

    /// Whistle (program 79, bank LSB 0).
    case whistle

    /// Wind (program 123, bank LSB 3).
    case wind

    /// Wind Chime (program 125, bank LSB 5).
    case windChime

    /// Woodblock (program 116, bank LSB 0).
    case woodblock

    /// Xylophone (program 14, bank LSB 0).
    case xylophone

    /// Yang Chin (program 47, bank LSB 1).
    case yangChin

    // MARK: Public Initializers

    /// Creates a `GM2Instrument` instance from the provided bank LSB and
    /// program, or `nil` if no instrument has that bank LSB and program.
    ///
    /// - Parameter bankLSB:    The bank LSB. Bank LSB 0 selects the General
    ///                         MIDI 1 instruments; higher values select their
    ///                         variations.
    /// - Parameter program:    The program.
    public init?(bankLSB: MIDIData1Value,
                 program: MIDIProgram) {
        let variations = Self.catalog[Int(program.uintValue) - 1]

        guard bankLSB.uintValue < variations.count
        else { return nil }

        self = variations[Int(bankLSB.uintValue)].instrument
    }

    /// Creates a `GM2Instrument` instance from the provided instrument name,
    /// or `nil` if no instrument has that name.
    ///
    /// Matching ignores case, leading and trailing whitespace, and the
    /// amount of whitespace between words.
    ///
    /// - Parameter name:   The instrument name, such as “Acoustic Grand
    ///                     Piano (wide)”.
    public init?(name: String) {
        guard let instrument = Self.instrumentsByName[name.normalizedName]
        else { return nil }

        self = instrument
    }
}

// MARK: -

extension GM2Instrument {

    // MARK: Public Type Properties

    /// The bank select MSB that selects the General MIDI 2 melodic bank
    /// (121).
    public static let bankMSB: MIDIData1Value = 121

    // MARK: Public Instance Properties

    /// The bank LSB that, together with ``program``, selects this
    /// instrument.
    public var bankLSB: MIDIData1Value {
        entry.bankLSB
    }

    /// The instrument family of this instrument, which is the family of its
    /// program.
    public var family: GM1InstrumentFamily {
        gm1Instrument.family
    }

    /// The General MIDI 1 instrument with the same program as this
    /// instrument.
    ///
    /// A device that lacks this instrument plays this one instead.
    public var gm1Instrument: GM1Instrument {
        GM1Instrument(program: program)
    }

    /// The name of this instrument, as the General MIDI 2 specification
    /// gives it, such as “Acoustic Grand Piano (wide)”.
    public var name: String {
        entry.name
    }

    /// The program that, together with ``bankLSB``, selects this instrument.
    public var program: MIDIProgram {
        entry.program
    }

    /// The range of notes over which this instrument plays its proper sound,
    /// or `nil` if this instrument is an effect sound.
    ///
    /// Within this range, a General MIDI 2 device plays every note at the
    /// correct pitch, with the character of the instrument. Outside it, notes
    /// still play at the correct pitch but may lose that character. Every
    /// variation of a program shares the program’s range.
    ///
    /// Effect sounds, the instruments of programs 116–128, have no defined
    /// pitch. Their normal note lies between 60 and 72.
    public var recommendedKeyRange: ClosedRange<MIDIData1Value>? {
        guard let range = Self.keyRanges[program.uintValue]
        else { return nil }

        return MIDIData1Value(clamping: range.lowerBound)...MIDIData1Value(clamping: range.upperBound)
    }

    // MARK: Public Instance Methods

    /// Returns the channel messages that select this instrument on the
    /// provided channel: a bank select MSB of ``bankMSB``, a bank select LSB
    /// of ``bankLSB``, and a program change to ``program``, in that order.
    ///
    /// - Parameter channel:    The channel on which to select this
    ///                         instrument.
    ///
    /// - Returns:  The bank select and program change messages.
    public func selectionMessages(channel: MIDIChannel) -> [MIDIChannelMessage] {
        [.controlChange(channel, .bankSelectMSB, Self.bankMSB),
         .controlChange(channel, .bankSelectLSB, bankLSB),
         .programChange(channel, program)]
    }

    // MARK: Private Type Properties

    private static let entries: [Self: (program: MIDIProgram, bankLSB: MIDIData1Value, name: String)] = {
        var map: [Self: (program: MIDIProgram, bankLSB: MIDIData1Value, name: String)] = [:]

        for (programIndex, variations) in catalog.enumerated() {
            for (bankLSB, entry) in variations.enumerated() {
                map[entry.instrument] = (MIDIProgram(clamping: programIndex + 1),
                                         MIDIData1Value(clamping: bankLSB),
                                         entry.name)
            }
        }

        return map
    }()

    private static let instrumentsByName: [String: Self] = {
        var map: [String: Self] = [:]

        for entry in catalog.joined() {
            map[entry.name.normalizedName] = entry.instrument
        }

        return map
    }()

    // MARK: Private Instance Properties

    private var entry: (program: MIDIProgram, bankLSB: MIDIData1Value, name: String) {
        guard let entry = Self.entries[self]
        else { fatalError("GM2Instrument catalog has no entry for \(self)") }

        return entry
    }
}

// MARK: - CaseIterable

extension GM2Instrument: CaseIterable {

    // MARK: Public Type Properties

    /// Every instrument, in program order and then bank LSB order.
    public static let allCases: [Self] = catalog.joined().map(\.instrument)
}

// MARK: - Equatable

extension GM2Instrument: Equatable {
}

// MARK: - Hashable

extension GM2Instrument: Hashable {
}

// MARK: - Sendable

extension GM2Instrument: Sendable {
}
