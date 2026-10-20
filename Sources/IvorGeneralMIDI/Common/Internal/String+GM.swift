// © 2026 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Internal Instance Properties

    // This string lowercased and trimmed, with each run of whitespace
    // collapsed to one space, so that names match loosely.
    internal var normalizedName: String {
        lowercased()
            .split(whereSeparator: \.isWhitespace)
            .joined(separator: " ")
    }
}
