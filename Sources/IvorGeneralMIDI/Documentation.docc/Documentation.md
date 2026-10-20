# ``IvorGeneralMIDI``

@Metadata {
    @PageColor(blue)
}

General MIDI instrument, instrument family, and percussion sound types.

## Overview

The IvorGeneralMIDI framework provides the [General MIDI 1][gm1] sound set as
Swift enumerations: the 128 instruments that a program change selects, the 16
instrument families they fall into, and the 47 sounds of the percussion key
map. Each sound can be looked up by its program or note, or by its name as the
specification gives it, and converted back again. Programs, notes, and
channels use the ``IvorMIDI`` data value types.

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

Every public type is a `Sendable` value type, so instances can be freely shared
across tasks and actor boundaries.

[gm1]: https://midi.org/general-midi

## Topics

### General MIDI 1

- ``GM1Instrument``
- ``GM1InstrumentFamily``
- ``GM1PercussionSound``
