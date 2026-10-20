// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import Testing

struct GM1PercussionSoundCatalogTests {
}

// MARK: -

extension GM1PercussionSoundCatalogTests {
    @Test
    func catalog_count() {
        #expect(GM1PercussionSound.catalog.count == 47)
    }

    @Test
    func catalog_firstEntry() throws {
        let entry = try #require(GM1PercussionSound.catalog.first)

        #expect(entry.sound == .acousticBassDrum)
        #expect(entry.note == 35)
        #expect(entry.name == "Acoustic Bass Drum")
    }

    @Test
    func catalog_lastEntry() throws {
        let entry = try #require(GM1PercussionSound.catalog.last)

        #expect(entry.sound == .openTriangle)
        #expect(entry.note == 81)
        #expect(entry.name == "Open Triangle")
    }

    @Test
    func catalog_namesAreUnique() {
        #expect(Set(GM1PercussionSound.catalog.map(\.name)).count == 47)
    }

    @Test
    func catalog_normalizedNamesAreUnique() {
        #expect(Set(GM1PercussionSound.catalog.map(\.name.normalizedName)).count == 47)
    }

    @Test
    func catalog_notesAreConsecutive() {
        #expect(GM1PercussionSound.catalog.map(\.note) == Array(35...81))
    }

    @Test
    func catalog_soundsAreUnique() {
        #expect(Set(GM1PercussionSound.catalog.map(\.sound)).count == 47)
    }
}
