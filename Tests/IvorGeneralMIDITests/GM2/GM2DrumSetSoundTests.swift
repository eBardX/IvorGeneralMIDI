// © 2026 John Gary Pusey (see LICENSE.md)

import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM2DrumSetSoundTests {
}

// MARK: -

extension GM2DrumSetSoundTests {
    @Test
    func equality() {
        let first = GM2DrumSet.room.sound(for: 41)
        let second = GM2DrumSet.room.sounds.first { $0.note == 41 }

        #expect(first != nil)
        #expect(first == second)
    }

    @Test
    func hashable() throws {
        let tom = try #require(GM2DrumSet.room.sound(for: 41))
        let snare = try #require(GM2DrumSet.room.sound(for: 38))

        #expect(Set([tom, tom, snare]).count == 2)
    }

    @Test
    func inequality_differentDrumSets() {
        // Both play the Standard Set’s Acoustic Snare, but in different sets.
        #expect(GM2DrumSet.standard.sound(for: 38) != GM2DrumSet.room.sound(for: 38))
    }

    @Test
    func inequality_differentNotes() {
        // The Orchestra Set plays “Concert SD” on two notes.
        let first = GM2DrumSet.orchestra.sound(for: 38)
        let second = GM2DrumSet.orchestra.sound(for: 40)

        #expect(first?.name == second?.name)
        #expect(first != second)
    }
}
