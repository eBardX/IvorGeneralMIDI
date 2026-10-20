// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import Testing

struct GM2InstrumentCatalogTests {
}

// MARK: -

extension GM2InstrumentCatalogTests {
    @Test
    func catalog_count() {
        #expect(GM2Instrument.catalog.count == 128)
        #expect(GM2Instrument.catalog.joined().count == 256)
    }

    @Test
    func catalog_firstEntry() throws {
        let entry = try #require(GM2Instrument.catalog.first?.first)

        #expect(entry.instrument == .acousticGrandPiano)
        #expect(entry.name == "Acoustic Grand Piano")
    }

    @Test
    func catalog_gm1EntriesDifferOnlyInSpelling() {
        let gm2Names = GM2Instrument.catalog.compactMap(\.first?.name)
        let gm1Names = GM1Instrument.catalog.map(\.name)
        let programs = zip(gm2Names, gm1Names).enumerated().filter { $1.0 != $1.1 }.map { $0.offset + 1 }

        #expect(gm2Names.count == 128)
        #expect(programs == [32, 49, 50, 63, 64])
    }

    @Test
    func catalog_groupsAreNotEmpty() {
        #expect(GM2Instrument.catalog.allSatisfy { !$0.isEmpty })
    }

    @Test
    func catalog_instrumentsAreUnique() {
        #expect(Set(GM2Instrument.catalog.joined().map(\.instrument)).count == 256)
    }

    @Test
    func catalog_lastEntry() throws {
        let entry = try #require(GM2Instrument.catalog.last?.last)

        #expect(entry.instrument == .explosion)
        #expect(entry.name == "Explosion")
    }

    @Test
    func catalog_namesAreUnique() {
        #expect(Set(GM2Instrument.catalog.joined().map(\.name)).count == 256)
    }

    @Test
    func catalog_normalizedNamesAreUnique() {
        #expect(Set(GM2Instrument.catalog.joined().map(\.name.normalizedName)).count == 256)
    }

    @Test
    func catalog_variationCounts() {
        #expect(GM2Instrument.catalog[0].count == 3)
        #expect(GM2Instrument.catalog[5].count == 5)
        #expect(GM2Instrument.catalog[8].count == 1)
        #expect(GM2Instrument.catalog[125].count == 10)
        #expect(GM2Instrument.catalog[127].count == 4)
    }

    @Test
    func keyRanges_areValidNotes() {
        #expect(GM2Instrument.keyRanges.values.allSatisfy { $0.lowerBound < $0.upperBound && $0.upperBound <= 127 })
    }

    @Test
    func keyRanges_coverNonEffectPrograms() {
        #expect(Set(GM2Instrument.keyRanges.keys) == Set(1...115))
    }
}
