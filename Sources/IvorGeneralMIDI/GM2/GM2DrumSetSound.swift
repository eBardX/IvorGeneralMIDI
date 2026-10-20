// © 2026 John Gary Pusey (see LICENSE.md)

public import IvorMIDI

/// The sound that a note plays in a General MIDI 2 (GM2) drum set.
///
/// Get a drum set’s sounds from ``GM2DrumSet/sounds`` or
/// ``GM2DrumSet/sound(for:)``. A drum set plays the Standard Set sound on most
/// notes, in which case ``standardSound`` identifies it, and replaces the rest
/// with sounds of its own.
public struct GM2DrumSetSound {

    // MARK: Public Instance Properties

    /// The drum set that plays this sound.
    public let drumSet: GM2DrumSet

    /// The exclusive group of this sound, or `nil` if it has none.
    ///
    /// Sounds of the same drum set in the same exclusive group cut each other
    /// off, such as the closed, pedal, and open hi-hats.
    public let exclusiveGroup: UInt?

    /// The name of this sound, as the General MIDI 2 specification gives it,
    /// such as “Room Low Tom 2”.
    ///
    /// Names are not unique: a drum set can play the same sound on more than
    /// one note, and different drum sets can play sounds with the same name.
    public let name: String

    /// The note that plays this sound.
    public let note: MIDIData1Value

    /// The preset pan of this sound, from hard left (0) through center (64)
    /// to hard right (127).
    public let pan: MIDIData1Value

    /// A Boolean value indicating whether this sound stops on Note Off.
    ///
    /// A rhythm channel ignores Note Off, so most sounds play for a fixed
    /// duration.
    public let respondsToNoteOff: Bool

    /// The Standard Set sound that this sound is, or `nil` if the drum set
    /// replaces the Standard Set sound on this note.
    public let standardSound: GM2PercussionSound?
}

// MARK: - Equatable

extension GM2DrumSetSound: Equatable {
}

// MARK: - Hashable

extension GM2DrumSetSound: Hashable {
}

// MARK: - Sendable

extension GM2DrumSetSound: Sendable {
}
