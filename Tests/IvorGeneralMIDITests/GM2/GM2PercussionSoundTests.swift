// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM2PercussionSoundTests {
}

// MARK: -

extension GM2PercussionSoundTests {
    @Test
    func allCases() {
        #expect(GM2PercussionSound.allCases.count == 61)
        #expect(Set(GM2PercussionSound.allCases).count == 61)
        #expect(GM2PercussionSound.allCases.first == .highQ)
        #expect(GM2PercussionSound.allCases.last == .openSurdo)
    }

    @Test
    func exclusiveGroup() {
        #expect(GM2PercussionSound.closedHiHat.exclusiveGroup == 1)
        #expect(GM2PercussionSound.openHiHat.exclusiveGroup == 1)
        #expect(GM2PercussionSound.longGuiro.exclusiveGroup == 3)
        #expect(GM2PercussionSound.openSurdo.exclusiveGroup == 6)
        #expect(GM2PercussionSound.scratchPush.exclusiveGroup == 7)
        #expect(GM2PercussionSound.acousticSnare.exclusiveGroup == nil)
    }

    @Test
    func gm1PercussionSound() {
        #expect(GM2PercussionSound.acousticBassDrum.gm1PercussionSound == .acousticBassDrum)
        #expect(GM2PercussionSound.acousticSnare.gm1PercussionSound == .acousticSnare)
        #expect(GM2PercussionSound.openTriangle.gm1PercussionSound == .openTriangle)
    }

    @Test
    func gm1PercussionSound_addedSounds() {
        #expect(GM2PercussionSound.highQ.gm1PercussionSound == nil)
        #expect(GM2PercussionSound.metronomeBell.gm1PercussionSound == nil)
        #expect(GM2PercussionSound.shaker.gm1PercussionSound == nil)
        #expect(GM2PercussionSound.openSurdo.gm1PercussionSound == nil)
    }

    @Test
    func gm1PercussionSound_sharesNote() {
        for sound in GM2PercussionSound.allCases {
            guard let gm1Sound = sound.gm1PercussionSound
            else { continue }

            #expect(sound.note == gm1Sound.note)
        }
    }

    @Test
    func init_name() {
        #expect(GM2PercussionSound(name: "Metronome Click") == .metronomeClick)
        #expect(GM2PercussionSound(name: "  closed   HI-HAT ") == .closedHiHat)
        #expect(GM2PercussionSound(name: "Surdo") == nil)
        #expect(GM2PercussionSound(name: "") == nil)
    }

    @Test
    func init_name_roundTrip() {
        for sound in GM2PercussionSound.allCases {
            #expect(GM2PercussionSound(name: sound.name) == sound)
        }
    }

    @Test
    func init_note() {
        #expect(GM2PercussionSound(note: 27) == .highQ)
        #expect(GM2PercussionSound(note: 34) == .metronomeBell)
        #expect(GM2PercussionSound(note: 38) == .acousticSnare)
        #expect(GM2PercussionSound(note: 82) == .shaker)
        #expect(GM2PercussionSound(note: 87) == .openSurdo)
    }

    @Test
    func init_note_roundTrip() {
        for sound in GM2PercussionSound.allCases {
            #expect(GM2PercussionSound(note: sound.note) == sound)
        }
    }

    @Test
    func init_note_unassigned() {
        #expect(GM2PercussionSound(note: 0) == nil)
        #expect(GM2PercussionSound(note: 26) == nil)
        #expect(GM2PercussionSound(note: 88) == nil)
        #expect(GM2PercussionSound(note: 127) == nil)
    }

    @Test
    func name() {
        #expect(GM2PercussionSound.highQ.name == "High Q")
        #expect(GM2PercussionSound.acousticSnare.name == "Acoustic Snare")
        #expect(GM2PercussionSound.bellTree.name == "Bell Tree")
        #expect(GM2PercussionSound.highBongo.name == "High Bongo")
        #expect(GM2PercussionSound.openSurdo.name == "Open Surdo")
    }

    @Test
    func note_inNoteOrder() {
        #expect(GM2PercussionSound.allCases.map(\.note.uintValue) == Array(27...87))
    }

    @Test
    func pan() {
        #expect(GM2PercussionSound.highQ.pan == 49)
        #expect(GM2PercussionSound.acousticBassDrum.pan == 64)
        #expect(GM2PercussionSound.lowFloorTom.pan == 34)
        #expect(GM2PercussionSound.bellTree.pan == 104)
        #expect(GM2PercussionSound.openSurdo.pan == 44)
    }
}
