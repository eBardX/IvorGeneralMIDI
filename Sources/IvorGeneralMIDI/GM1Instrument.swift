// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

/// A General MIDI (GM1) instrument: one of the 128 melodic sounds that a
/// program change selects.
///
/// ``allCases`` lists the instruments in program order, from
/// ``acousticGrandPiano`` (program 1) to ``gunshot`` (program 128).
///
/// Names follow the General MIDI 1 specification, so “Electric Guitar (jazz)”
/// rather than an abbreviation such as “Jazz Guitar”.
public enum GM1Instrument {

    /// Accordion (program 22).
    case accordion

    /// Acoustic Bass (program 33).
    case acousticBass

    /// Acoustic Grand Piano (program 1).
    case acousticGrandPiano

    /// Acoustic Guitar (nylon) (program 25).
    case acousticGuitarNylon

    /// Acoustic Guitar (steel) (program 26).
    case acousticGuitarSteel

    /// Agogo (program 114).
    case agogo

    /// Alto Sax (program 66).
    case altoSax

    /// Applause (program 127).
    case applause

    /// Bag pipe (program 110).
    case bagPipe

    /// Banjo (program 106).
    case banjo

    /// Baritone Sax (program 68).
    case baritoneSax

    /// Bassoon (program 71).
    case bassoon

    /// Bird Tweet (program 124).
    case birdTweet

    /// Blown Bottle (program 77).
    case blownBottle

    /// Brass Section (program 62).
    case brassSection

    /// Breath Noise (program 122).
    case breathNoise

    /// Bright Acoustic Piano (program 2).
    case brightAcousticPiano

    /// Celesta (program 9).
    case celesta

    /// Cello (program 43).
    case cello

    /// Choir Aahs (program 53).
    case choirAahs

    /// Church Organ (program 20).
    case churchOrgan

    /// Clarinet (program 72).
    case clarinet

    /// Clavinet (program 8).
    case clavinet

    /// Contrabass (program 44).
    case contrabass

    /// Distortion Guitar (program 31).
    case distortionGuitar

    /// Drawbar Organ (program 17).
    case drawbarOrgan

    /// Dulcimer (program 16).
    case dulcimer

    /// Electric Bass (finger) (program 34).
    case electricBassFinger

    /// Electric Bass (pick) (program 35).
    case electricBassPick

    /// Electric Grand Piano (program 3).
    case electricGrandPiano

    /// Electric Guitar (clean) (program 28).
    case electricGuitarClean

    /// Electric Guitar (jazz) (program 27).
    case electricGuitarJazz

    /// Electric Guitar (muted) (program 29).
    case electricGuitarMuted

    /// Electric Piano 1 (program 5).
    case electricPiano1

    /// Electric Piano 2 (program 6).
    case electricPiano2

    /// English Horn (program 70).
    case englishHorn

    /// Fiddle (program 111).
    case fiddle

    /// Flute (program 74).
    case flute

    /// French Horn (program 61).
    case frenchHorn

    /// Fretless Bass (program 36).
    case fretlessBass

    /// FX 1 (rain) (program 97).
    case fx1Rain

    /// FX 2 (soundtrack) (program 98).
    case fx2Soundtrack

    /// FX 3 (crystal) (program 99).
    case fx3Crystal

    /// FX 4 (atmosphere) (program 100).
    case fx4Atmosphere

    /// FX 5 (brightness) (program 101).
    case fx5Brightness

    /// FX 6 (goblins) (program 102).
    case fx6Goblins

    /// FX 7 (echoes) (program 103).
    case fx7Echoes

    /// FX 8 (sci-fi) (program 104).
    case fx8SciFi

    /// Glockenspiel (program 10).
    case glockenspiel

    /// Guitar Fret Noise (program 121).
    case guitarFretNoise

    /// Guitar Harmonics (program 32).
    case guitarHarmonics

    /// Gunshot (program 128).
    case gunshot

    /// Harmonica (program 23).
    case harmonica

    /// Harpsichord (program 7).
    case harpsichord

    /// Helicopter (program 126).
    case helicopter

    /// Honky-tonk Piano (program 4).
    case honkyTonkPiano

    /// Kalimba (program 109).
    case kalimba

    /// Koto (program 108).
    case koto

    /// Lead 1 (square) (program 81).
    case lead1Square

    /// Lead 2 (sawtooth) (program 82).
    case lead2Sawtooth

    /// Lead 3 (calliope) (program 83).
    case lead3Calliope

    /// Lead 4 (chiff) (program 84).
    case lead4Chiff

    /// Lead 5 (charang) (program 85).
    case lead5Charang

    /// Lead 6 (voice) (program 86).
    case lead6Voice

    /// Lead 7 (fifths) (program 87).
    case lead7Fifths

    /// Lead 8 (bass + lead) (program 88).
    case lead8BassAndLead

    /// Marimba (program 13).
    case marimba

    /// Melodic Tom (program 118).
    case melodicTom

    /// Music Box (program 11).
    case musicBox

    /// Muted Trumpet (program 60).
    case mutedTrumpet

    /// Oboe (program 69).
    case oboe

    /// Ocarina (program 80).
    case ocarina

    /// Orchestra Hit (program 56).
    case orchestraHit

    /// Orchestral Harp (program 47).
    case orchestralHarp

    /// Overdriven Guitar (program 30).
    case overdrivenGuitar

    /// Pad 1 (new age) (program 89).
    case pad1NewAge

    /// Pad 2 (warm) (program 90).
    case pad2Warm

    /// Pad 3 (polysynth) (program 91).
    case pad3Polysynth

    /// Pad 4 (choir) (program 92).
    case pad4Choir

    /// Pad 5 (bowed) (program 93).
    case pad5Bowed

    /// Pad 6 (metallic) (program 94).
    case pad6Metallic

    /// Pad 7 (halo) (program 95).
    case pad7Halo

    /// Pad 8 (sweep) (program 96).
    case pad8Sweep

    /// Pan Flute (program 76).
    case panFlute

    /// Percussive Organ (program 18).
    case percussiveOrgan

    /// Piccolo (program 73).
    case piccolo

    /// Pizzicato Strings (program 46).
    case pizzicatoStrings

    /// Recorder (program 75).
    case recorder

    /// Reed Organ (program 21).
    case reedOrgan

    /// Reverse Cymbal (program 120).
    case reverseCymbal

    /// Rock Organ (program 19).
    case rockOrgan

    /// Seashore (program 123).
    case seashore

    /// Shakuhachi (program 78).
    case shakuhachi

    /// Shamisen (program 107).
    case shamisen

    /// Shanai (program 112).
    case shanai

    /// Sitar (program 105).
    case sitar

    /// Slap Bass 1 (program 37).
    case slapBass1

    /// Slap Bass 2 (program 38).
    case slapBass2

    /// Soprano Sax (program 65).
    case sopranoSax

    /// Steel Drums (program 115).
    case steelDrums

    /// String Ensemble 1 (program 49).
    case stringEnsemble1

    /// String Ensemble 2 (program 50).
    case stringEnsemble2

    /// Synth Bass 1 (program 39).
    case synthBass1

    /// Synth Bass 2 (program 40).
    case synthBass2

    /// Synth Brass 1 (program 63).
    case synthBrass1

    /// Synth Brass 2 (program 64).
    case synthBrass2

    /// Synth Drum (program 119).
    case synthDrum

    /// Synth Strings 1 (program 51).
    case synthStrings1

    /// Synth Strings 2 (program 52).
    case synthStrings2

    /// Synth Voice (program 55).
    case synthVoice

    /// Taiko Drum (program 117).
    case taikoDrum

    /// Tango Accordion (program 24).
    case tangoAccordion

    /// Telephone Ring (program 125).
    case telephoneRing

    /// Tenor Sax (program 67).
    case tenorSax

    /// Timpani (program 48).
    case timpani

    /// Tinkle Bell (program 113).
    case tinkleBell

    /// Tremolo Strings (program 45).
    case tremoloStrings

    /// Trombone (program 58).
    case trombone

    /// Trumpet (program 57).
    case trumpet

    /// Tuba (program 59).
    case tuba

    /// Tubular Bells (program 15).
    case tubularBells

    /// Vibraphone (program 12).
    case vibraphone

    /// Viola (program 42).
    case viola

    /// Violin (program 41).
    case violin

    /// Voice Oohs (program 54).
    case voiceOohs

    /// Whistle (program 79).
    case whistle

    /// Woodblock (program 116).
    case woodblock

    /// Xylophone (program 14).
    case xylophone

    // MARK: Public Initializers

    /// Creates a `GM1Instrument` instance from the provided instrument name,
    /// or `nil` if no instrument has that name.
    ///
    /// Matching ignores case, leading and trailing whitespace, and the
    /// amount of whitespace between words.
    ///
    /// - Parameter name:   The instrument name, such as “Acoustic Grand
    ///                     Piano”.
    public init?(name: String) {
        guard let instrument = Self.instrumentsByName[name.normalizedName]
        else { return nil }

        self = instrument
    }

    /// Creates a `GM1Instrument` instance from the provided program.
    ///
    /// Every program selects a General MIDI instrument, so this never fails.
    ///
    /// - Parameter program:    The program.
    public init(program: MIDIProgram) {
        self = Self.allCases[Int(program.uintValue) - 1]
    }
}

// MARK: -

extension GM1Instrument {

    // MARK: Public Instance Properties

    /// The instrument family of this instrument.
    public var family: GM1InstrumentFamily {
        GM1InstrumentFamily.allCases[(Int(program.uintValue) - 1) / 8]
    }

    /// The name of this instrument, as the General MIDI specification gives
    /// it, such as “Acoustic Grand Piano”.
    public var name: String {
        entry.name
    }

    /// The program that selects this instrument.
    public var program: MIDIProgram {
        entry.program
    }

    // MARK: Private Type Properties

    private static let entries: [Self: (program: MIDIProgram, name: String)] = {
        var map: [Self: (program: MIDIProgram, name: String)] = [:]

        for (index, entry) in catalog.enumerated() {
            map[entry.instrument] = (MIDIProgram(clamping: index + 1), entry.name)
        }

        return map
    }()

    private static let instrumentsByName: [String: Self] = {
        var map: [String: Self] = [:]

        for entry in catalog {
            map[entry.name.normalizedName] = entry.instrument
        }

        return map
    }()

    // MARK: Private Instance Properties

    private var entry: (program: MIDIProgram, name: String) {
        guard let entry = Self.entries[self]
        else { fatalError("GM1Instrument catalog has no entry for \(self)") }

        return entry
    }
}

// MARK: - CaseIterable

extension GM1Instrument: CaseIterable {

    // MARK: Public Type Properties

    /// Every instrument, in program order.
    public static let allCases: [Self] = catalog.map(\.instrument)
}

// MARK: - Equatable

extension GM1Instrument: Equatable {
}

// MARK: - Hashable

extension GM1Instrument: Hashable {
}

// MARK: - Sendable

extension GM1Instrument: Sendable {
}
