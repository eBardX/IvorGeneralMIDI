// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import Testing

struct GM2DrumSetCatalogTests {
}

// MARK: -

extension GM2DrumSetCatalogTests {
    @Test
    func catalog_count() {
        #expect(GM2DrumSet.catalog.count == 9)
    }

    @Test
    func catalog_drumSetsAreUnique() {
        #expect(Set(GM2DrumSet.catalog.map(\.drumSet)).count == 9)
    }

    @Test
    func catalog_firstEntry() throws {
        let entry = try #require(GM2DrumSet.catalog.first)

        #expect(entry.drumSet == .standard)
        #expect(entry.program == 1)
        #expect(entry.name == "Standard Set")
    }

    @Test
    func catalog_lastEntry() throws {
        let entry = try #require(GM2DrumSet.catalog.last)

        #expect(entry.drumSet == .sfx)
        #expect(entry.program == 57)
        #expect(entry.name == "SFX Set")
    }

    @Test
    func catalog_namesAreUnique() {
        #expect(Set(GM2DrumSet.catalog.map(\.name)).count == 9)
    }

    @Test
    func catalog_normalizedNamesAreUnique() {
        #expect(Set(GM2DrumSet.catalog.map(\.name.normalizedName)).count == 9)
    }

    @Test
    func catalog_programs() {
        #expect(GM2DrumSet.catalog.map(\.program) == [1, 9, 17, 25, 26, 33, 41, 49, 57])
    }

    @Test
    func exclusiveGroups_notesAreReplaced() {
        for (drumSet, groups) in GM2DrumSet.exclusiveGroups {
            let notes = Set(GM2DrumSet.keyMaps[drumSet, default: []].map(\.note))

            #expect(Set(groups.keys).isSubset(of: notes))
        }
    }

    @Test
    func keyMaps_counts() {
        let counts = GM2DrumSet.allCases.map { GM2DrumSet.keyMaps[$0]?.count ?? 0 }

        #expect(counts == [0, 6, 8, 10, 19, 2, 5, 25, 46])
    }

    @Test
    func keyMaps_notesAreInOrder() {
        for keyMap in GM2DrumSet.keyMaps.values {
            let notes = keyMap.map(\.note)

            #expect(notes == notes.sorted())
            #expect(Set(notes).count == notes.count)
            #expect(notes.allSatisfy { (27...88).contains($0) })
        }
    }

    @Test
    func noteOffNotes_areReplaced() {
        for (drumSet, range) in GM2DrumSet.noteOffNotes {
            let notes = Set(GM2DrumSet.keyMaps[drumSet, default: []].map(\.note))

            #expect(range.allSatisfy { notes.contains($0) })
        }
    }

    @Test
    func silentNotes_areNotReplaced() {
        for (drumSet, silent) in GM2DrumSet.silentNotes {
            let notes = Set(GM2DrumSet.keyMaps[drumSet, default: []].map(\.note))

            #expect(notes.isDisjoint(with: silent))
            #expect(silent.allSatisfy { (27...87).contains($0) })
        }
    }
}
