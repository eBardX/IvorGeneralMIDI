// © 2026 John Gary Pusey (see LICENSE.md)

/// A General MIDI (GM1) instrument family: one of the 16 groups of 8
/// consecutive programs.
///
/// ``allCases`` lists the families in program order, from ``piano``
/// (programs 1–8) to ``soundEffects`` (programs 121–128).
public enum GM1InstrumentFamily {

    /// The bass family (programs 33–40).
    case bass

    /// The brass family (programs 57–64).
    case brass

    /// The chromatic percussion family (programs 9–16).
    case chromaticPercussion

    /// The ensemble family (programs 49–56).
    case ensemble

    /// The ethnic family (programs 105–112).
    case ethnic

    /// The guitar family (programs 25–32).
    case guitar

    /// The organ family (programs 17–24).
    case organ

    /// The percussive family (programs 113–120).
    case percussive

    /// The piano family (programs 1–8).
    case piano

    /// The pipe family (programs 73–80).
    case pipe

    /// The reed family (programs 65–72).
    case reed

    /// The sound effects family (programs 121–128).
    case soundEffects

    /// The strings family (programs 41–48).
    case strings

    /// The synth effects family (programs 97–104).
    case synthEffects

    /// The synth lead family (programs 81–88).
    case synthLead

    /// The synth pad family (programs 89–96).
    case synthPad
}

// MARK: -

extension GM1InstrumentFamily {

    // MARK: Public Instance Properties

    /// The 8 instruments in this family, in program order.
    public var instruments: [GM1Instrument] {
        GM1Instrument.allCases.filter { $0.family == self }
    }

    /// The name of this family, as the General MIDI specification gives it,
    /// such as “Chromatic Percussion”.
    public var name: String {
        switch self {
        case .bass:
            "Bass"

        case .brass:
            "Brass"

        case .chromaticPercussion:
            "Chromatic Percussion"

        case .ensemble:
            "Ensemble"

        case .ethnic:
            "Ethnic"

        case .guitar:
            "Guitar"

        case .organ:
            "Organ"

        case .percussive:
            "Percussive"

        case .piano:
            "Piano"

        case .pipe:
            "Pipe"

        case .reed:
            "Reed"

        case .soundEffects:
            "Sound Effects"

        case .strings:
            "Strings"

        case .synthEffects:
            "Synth Effects"

        case .synthLead:
            "Synth Lead"

        case .synthPad:
            "Synth Pad"
        }
    }
}

// MARK: - CaseIterable

extension GM1InstrumentFamily: CaseIterable {

    // MARK: Public Type Properties

    /// Every family, in program order.
    public static let allCases: [Self] = [.piano,
                                          .chromaticPercussion,
                                          .organ,
                                          .guitar,
                                          .bass,
                                          .strings,
                                          .ensemble,
                                          .brass,
                                          .reed,
                                          .pipe,
                                          .synthLead,
                                          .synthPad,
                                          .synthEffects,
                                          .ethnic,
                                          .percussive,
                                          .soundEffects]
}

// MARK: - Equatable

extension GM1InstrumentFamily: Equatable {
}

// MARK: - Hashable

extension GM1InstrumentFamily: Hashable {
}

// MARK: - Sendable

extension GM1InstrumentFamily: Sendable {
}
