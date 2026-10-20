// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorGeneralMIDI
import Testing

struct GM1InstrumentCatalogTests {
}

// MARK: -

extension GM1InstrumentCatalogTests {
    @Test
    func catalog_count() {
        #expect(GM1Instrument.catalog.count == 128)
    }

    @Test
    func catalog_firstEntry() throws {
        let entry = try #require(GM1Instrument.catalog.first)

        #expect(entry.instrument == .acousticGrandPiano)
        #expect(entry.name == "Acoustic Grand Piano")
    }

    @Test
    func catalog_instrumentsAreUnique() {
        #expect(Set(GM1Instrument.catalog.map(\.instrument)).count == 128)
    }

    @Test
    func catalog_lastEntry() throws {
        let entry = try #require(GM1Instrument.catalog.last)

        #expect(entry.instrument == .gunshot)
        #expect(entry.name == "Gunshot")
    }

    @Test
    func catalog_namesAreUnique() {
        #expect(Set(GM1Instrument.catalog.map(\.name)).count == 128)
    }

    @Test
    func catalog_normalizedNamesAreUnique() {
        #expect(Set(GM1Instrument.catalog.map(\.name.normalizedName)).count == 128)
    }
}
