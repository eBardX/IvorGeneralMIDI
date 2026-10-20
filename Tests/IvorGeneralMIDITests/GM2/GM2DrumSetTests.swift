// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import IvorMIDI
import Testing
import XestiTools

struct GM2DrumSetTests {
}

// MARK: -

extension GM2DrumSetTests {
    @Test
    func allCases() {
        #expect(GM2DrumSet.allCases.count == 9)
        #expect(Set(GM2DrumSet.allCases).count == 9)
        #expect(GM2DrumSet.allCases.first == .standard)
        #expect(GM2DrumSet.allCases.last == .sfx)
    }

    @Test
    func bankLSB() {
        #expect(GM2DrumSet.bankLSB.uintValue == 0)
    }

    @Test
    func bankMSB() {
        #expect(GM2DrumSet.bankMSB.uintValue == 0x78)
    }

    @Test
    func init_name() {
        #expect(GM2DrumSet(name: "Standard Set") == .standard)
        #expect(GM2DrumSet(name: "  jazz   SET ") == .jazz)
        #expect(GM2DrumSet(name: "Jazz") == nil)
        #expect(GM2DrumSet(name: "") == nil)
    }

    @Test
    func init_name_roundTrip() {
        for drumSet in GM2DrumSet.allCases {
            #expect(GM2DrumSet(name: drumSet.name) == drumSet)
        }
    }

    @Test
    func init_program() {
        #expect(GM2DrumSet(program: 1) == .standard)
        #expect(GM2DrumSet(program: 26) == .analog)
        #expect(GM2DrumSet(program: 57) == .sfx)
    }

    @Test
    func init_program_roundTrip() {
        for drumSet in GM2DrumSet.allCases {
            #expect(GM2DrumSet(program: drumSet.program) == drumSet)
        }
    }

    @Test
    func init_program_unassigned() {
        #expect(GM2DrumSet(program: 2) == nil)
        #expect(GM2DrumSet(program: 27) == nil)
        #expect(GM2DrumSet(program: 58) == nil)
        #expect(GM2DrumSet(program: 128) == nil)
    }

    @Test
    func name() {
        #expect(GM2DrumSet.standard.name == "Standard Set")
        #expect(GM2DrumSet.analog.name == "Analog Set")
        #expect(GM2DrumSet.sfx.name == "SFX Set")
    }

    @Test
    func program() {
        #expect(GM2DrumSet.standard.program == 1)
        #expect(GM2DrumSet.room.program == 9)
        #expect(GM2DrumSet.brush.program == 41)
        #expect(GM2DrumSet.sfx.program == 57)
    }

    @Test
    func selectionMessages() {
        let messages = GM2DrumSet.brush.selectionMessages(channel: 11)

        #expect(messages == [.controlChange(11, .bankSelectMSB, 120),
                             .controlChange(11, .bankSelectLSB, 0),
                             .programChange(11, 41)])
    }

    @Test
    func selectionMessages_defaultChannel() {
        let messages = GM2DrumSet.jazz.selectionMessages()

        #expect(messages == [.controlChange(10, .bankSelectMSB, 120),
                             .controlChange(10, .bankSelectLSB, 0),
                             .programChange(10, 33)])
    }

    @Test
    func soundFor_replacedSound() throws {
        let tom = try #require(GM2DrumSet.room.sound(for: 41))

        #expect(tom.drumSet == .room)
        #expect(tom.name == "Room Low Tom 2")
        #expect(tom.note == 41)
        #expect(tom.pan == 34)
        #expect(tom.exclusiveGroup == nil)
        #expect(!tom.respondsToNoteOff)
        #expect(tom.standardSound == nil)
    }

    @Test
    func soundFor_silentNote() {
        #expect(GM2DrumSet.standard.sound(for: 26) == nil)
        #expect(GM2DrumSet.standard.sound(for: 88) == nil)
        #expect(GM2DrumSet.sfx.sound(for: 27) == nil)
        #expect(GM2DrumSet.sfx.sound(for: 38) == nil)
        #expect(GM2DrumSet.sfx.sound(for: 85) == nil)
        #expect(GM2DrumSet.sfx.sound(for: 87) == nil)
        #expect(GM2DrumSet.orchestra.sound(for: 89) == nil)
    }

    @Test
    func soundFor_soundAboveStandardKeyMap() throws {
        let applause = try #require(GM2DrumSet.orchestra.sound(for: 88))

        #expect(applause.name == "Applause")
        #expect(applause.respondsToNoteOff)
        #expect(applause.standardSound == nil)
    }

    @Test
    func soundFor_standardSound() throws {
        let snare = try #require(GM2DrumSet.room.sound(for: 38))

        #expect(snare.drumSet == .room)
        #expect(snare.name == "Acoustic Snare")
        #expect(snare.pan == GM2PercussionSound.acousticSnare.pan)
        #expect(snare.standardSound == .acousticSnare)
    }

    @Test
    func sounds_count() {
        let counts = GM2DrumSet.allCases.map(\.sounds.count)

        #expect(counts == [61, 61, 61, 61, 61, 61, 61, 62, 46])
    }

    @Test
    func sounds_exclusiveGroups() {
        #expect(GM2DrumSet.standard.sound(for: 42)?.exclusiveGroup == 1)
        #expect(GM2DrumSet.standard.sound(for: 86)?.exclusiveGroup == 6)
        #expect(GM2DrumSet.room.sound(for: 46)?.exclusiveGroup == 1)
        #expect(GM2DrumSet.analog.sound(for: 44)?.exclusiveGroup == 1)
        #expect(GM2DrumSet.orchestra.sound(for: 27)?.exclusiveGroup == 1)
        #expect(GM2DrumSet.orchestra.sound(for: 42)?.exclusiveGroup == nil)
        #expect(GM2DrumSet.sfx.sound(for: 41)?.exclusiveGroup == 7)
    }

    @Test
    func sounds_inNoteOrder() {
        for drumSet in GM2DrumSet.allCases {
            let notes = drumSet.sounds.map(\.note.uintValue)

            #expect(notes == notes.sorted())
            #expect(Set(notes).count == notes.count)
        }
    }

    @Test
    func sounds_matchSoundFor() {
        for drumSet in GM2DrumSet.allCases {
            for sound in drumSet.sounds {
                #expect(sound.drumSet == drumSet)
                #expect(drumSet.sound(for: sound.note) == sound)
            }
        }
    }

    @Test
    func sounds_respondsToNoteOff() {
        let notes = GM2DrumSet.allCases.map { $0.sounds.filter(\.respondsToNoteOff).map(\.note.uintValue) }

        #expect(notes == [[], [], [], [], [], [], [], [88], Array(47...84)])
    }

    @Test
    func sounds_standardSet() {
        #expect(GM2DrumSet.standard.sounds.map(\.standardSound) == GM2PercussionSound.allCases)
    }
}
