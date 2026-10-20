// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import Testing

struct GM2PercussionSoundCatalogTests {
}

// MARK: -

extension GM2PercussionSoundCatalogTests {
    @Test
    func catalog_count() {
        #expect(GM2PercussionSound.catalog.count == 61)
    }

    @Test
    func catalog_firstEntry() throws {
        let entry = try #require(GM2PercussionSound.catalog.first)

        #expect(entry.sound == .highQ)
        #expect(entry.note == 27)
        #expect(entry.name == "High Q")
    }

    @Test
    func catalog_gm1EntriesDifferOnlyInSpelling() {
        let gm2Entries = GM2PercussionSound.catalog.filter { (35...81).contains($0.note) }
        let gm1Entries = GM1PercussionSound.catalog
        let notes = zip(gm2Entries, gm1Entries).filter { $0.name != $1.name }.map(\.0.note)

        #expect(gm2Entries.map(\.note) == gm1Entries.map(\.note))
        #expect(notes == [42, 44, 46, 48, 58, 60])
    }

    @Test
    func catalog_lastEntry() throws {
        let entry = try #require(GM2PercussionSound.catalog.last)

        #expect(entry.sound == .openSurdo)
        #expect(entry.note == 87)
        #expect(entry.name == "Open Surdo")
    }

    @Test
    func catalog_namesAreUnique() {
        #expect(Set(GM2PercussionSound.catalog.map(\.name)).count == 61)
    }

    @Test
    func catalog_normalizedNamesAreUnique() {
        #expect(Set(GM2PercussionSound.catalog.map(\.name.normalizedName)).count == 61)
    }

    @Test
    func catalog_notesAreConsecutive() {
        #expect(GM2PercussionSound.catalog.map(\.note) == Array(27...87))
    }

    @Test
    func catalog_soundsAreUnique() {
        #expect(Set(GM2PercussionSound.catalog.map(\.sound)).count == 61)
    }

    @Test
    func exclusiveGroups_eachHasSeveralSounds() {
        let sizes = Dictionary(grouping: GM2PercussionSound.exclusiveGroups.values) { $0 }.mapValues(\.count)

        #expect(GM2PercussionSound.exclusiveGroups.count == 15)
        #expect(sizes == [1: 3, 2: 2, 3: 2, 4: 2, 5: 2, 6: 2, 7: 2])
    }

    @Test
    func pans_coverEverySound() {
        #expect(Set(GM2PercussionSound.pans.keys) == Set(GM2PercussionSound.allCases))
        #expect(GM2PercussionSound.pans.values.allSatisfy { $0 <= 127 })
    }
}
