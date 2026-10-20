// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM1PercussionSoundTests {
}

// MARK: -

extension GM1PercussionSoundTests {
    @Test
    func allCases() {
        #expect(GM1PercussionSound.allCases.count == 47)
        #expect(Set(GM1PercussionSound.allCases).count == 47)
        #expect(GM1PercussionSound.allCases.first == .acousticBassDrum)
        #expect(GM1PercussionSound.allCases.last == .openTriangle)
    }

    @Test
    func channel() {
        #expect(GM1PercussionSound.channel.uintValue == 10)
    }

    @Test
    func init_name() {
        #expect(GM1PercussionSound(name: "Acoustic Snare") == .acousticSnare)
        #expect(GM1PercussionSound(name: "  closed   HI-HAT ") == .closedHiHat)
        #expect(GM1PercussionSound(name: "Snare") == nil)
        #expect(GM1PercussionSound(name: "") == nil)
    }

    @Test
    func init_name_roundTrip() {
        for sound in GM1PercussionSound.allCases {
            #expect(GM1PercussionSound(name: sound.name) == sound)
        }
    }

    @Test
    func init_note() {
        #expect(GM1PercussionSound(note: 35) == .acousticBassDrum)
        #expect(GM1PercussionSound(note: 38) == .acousticSnare)
        #expect(GM1PercussionSound(note: 42) == .closedHiHat)
        #expect(GM1PercussionSound(note: 81) == .openTriangle)
    }

    @Test
    func init_note_roundTrip() {
        for sound in GM1PercussionSound.allCases {
            #expect(GM1PercussionSound(note: sound.note) == sound)
        }
    }

    @Test
    func init_note_unassigned() {
        #expect(GM1PercussionSound(note: 0) == nil)
        #expect(GM1PercussionSound(note: 34) == nil)
        #expect(GM1PercussionSound(note: 82) == nil)
        #expect(GM1PercussionSound(note: 127) == nil)
    }

    @Test
    func name() {
        #expect(GM1PercussionSound.acousticBassDrum.name == "Acoustic Bass Drum")
        #expect(GM1PercussionSound.acousticSnare.name == "Acoustic Snare")
        #expect(GM1PercussionSound.closedHiHat.name == "Closed Hi-Hat")
        #expect(GM1PercussionSound.openTriangle.name == "Open Triangle")
    }

    @Test
    func note_inNoteOrder() {
        #expect(GM1PercussionSound.allCases.map(\.note.uintValue) == Array(35...81))
    }
}
