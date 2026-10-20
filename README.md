# IvorGeneralMIDI

General MIDI instrument, instrument family, and percussion sound types.

[![Swift 6.3](https://img.shields.io/badge/Swift-6.3-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS-lightgrey.svg)](https://developer.apple.com)
[![SwiftPM](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/eBardX/IvorGeneralMIDI/blob/main/LICENSE.md)

* [Overview](#overview)
* [Requirements](#requirements)
* [Installation](#installation)
    * [Swift Package Manager](#spm_installation)
* [Quick Start](#quick_start)
* [Reference Documentation](#reference_documentation)
* [Credits](#credits)
* [License](#license)

## <a name="overview">Overview</a>

The IvorGeneralMIDI framework provides the [General MIDI 1][gm1] sound set as
Swift enumerations: the 128 instruments that a program change selects, the 16
instrument families they fall into, and the 47 sounds of the percussion key
map. Each sound can be looked up by its program or note, or by its name as the
specification gives it, and converted back again. Programs, notes, and
channels use the [IvorMIDI][ivormidi] data value types.

## <a name="requirements">Requirements</a>

* iOS 18.0+ / macOS 15.0+
* Swift 6.3 toolchain
* Swift 6 language mode

## <a name="installation">Installation</a>

### <a name="spm_installation">Swift Package Manager</a>

IvorGeneralMIDI is distributed exclusively through the [Swift Package Manager][spm].

To add IvorGeneralMIDI to a Swift package, add it to the `dependencies` in your
`Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/eBardX/IvorGeneralMIDI.git",
             .upToNextMinor(from: "0.1.0"))
]
```

Then add `IvorGeneralMIDI` to the dependencies of any target that uses it:

```swift
.target(name: "MyTarget",
        dependencies: [.product(name: "IvorGeneralMIDI",
                                package: "IvorGeneralMIDI")])
```

To add IvorGeneralMIDI to an Xcode project, choose **File ▸ Add Package
Dependencies…** and enter the repository URL:

```
https://github.com/eBardX/IvorGeneralMIDI.git
```

IvorGeneralMIDI depends on [IvorMIDI][ivormidi] and [XestiTools][xestitools];
the Swift Package Manager resolves them automatically.

## <a name="quick_start">Quick Start</a>

```swift
import IvorGeneralMIDI

let guitar = GM1Instrument(program: 25)

guitar              // .acousticGuitarNylon
guitar.name         // "Acoustic Guitar (nylon)"
guitar.family       // .guitar

// Name lookup ignores case and extra whitespace.
let snare = GM1PercussionSound(name: "acoustic snare")

snare?.note         // 38
GM1PercussionSound.channel  // 10
```

Every program selects an instrument, so `GM1Instrument(program:)` always
succeeds. The name initializers and `GM1PercussionSound(note:)` are failable:
they return `nil` for a name the specification doesn’t use, or for a note
outside the percussion key map (35–81).

## <a name="reference_documentation">Reference Documentation</a>

Full [reference documentation][refdoc] is available courtesy of [DocC][docc].

## <a name="credits">Credits</a>

John Gary Pusey (ebardx@gmail.com)

## <a name="license">License</a>

IvorGeneralMIDI is available under [the MIT license][license].

[docc]:         https://www.swift.org/documentation/docc/
[gm1]:          https://midi.org/general-midi
[ivormidi]:     https://github.com/eBardX/IvorMIDI
[license]:      https://github.com/eBardX/IvorGeneralMIDI/blob/main/LICENSE.md
[refdoc]:       https://eBardX.github.io/ivor-packages-docs/documentation/ivorgeneralmidi
[spm]:          https://swift.org/package-manager/
[xestitools]:   https://github.com/eBardX/XestiTools
