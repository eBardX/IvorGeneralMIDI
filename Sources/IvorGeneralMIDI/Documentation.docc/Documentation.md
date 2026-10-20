# ``IvorGeneralMIDI``

@Metadata {
    @PageColor(blue)
}

General MIDI 1 and 2 instrument, drum set, and percussion sound types.

## Overview

The IvorGeneralMIDI framework provides the [General MIDI 1][gm1] and General
MIDI 2 sound sets as Swift enumerations. For General MIDI 1: the 128
instruments that a program change selects, the 16 instrument families they
fall into, and the 47 sounds of the percussion key map. For General MIDI 2:
the 256 instruments that a bank select and program change select, the 9 drum
sets, and the 61 sounds of the extended percussion key map. Each sound can be
looked up by its program, bank, or note, or by its name as the specification
gives it, and converted back again. Programs, notes, and channels use the
``IvorMIDI`` data value types, and the system exclusive messages that turn General
MIDI on and off are available as `MIDISystemMessage` values.

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

// A General MIDI 2 variation falls back to its General MIDI 1 instrument.
let ukulele = GM2Instrument(bankLSB: 1, program: 25)

ukulele?.name           // "Ukulele"
ukulele?.gm1Instrument  // .acousticGuitarNylon
GM2Instrument.bankMSB   // 121

// Bank select MSB 121, bank select LSB 1, then program change 25.
let messages = ukulele?.selectionMessages(channel: 1)

MIDISystemMessage.gm2SystemOn  // F0 7E 7F 09 03 F7
```

Every public type is a `Sendable` value type, so instances can be freely shared
across tasks and actor boundaries.

[gm1]: https://midi.org/general-midi

## Topics

### General MIDI 1

- ``GM1Instrument``
- ``GM1InstrumentFamily``
- ``GM1PercussionSound``

### General MIDI 2

- ``GM2Instrument``
- ``GM2DrumSet``
- ``GM2DrumSetSound``
- ``GM2PercussionSound``

### General MIDI 2 Effects

- ``GM2ReverbType``
- ``GM2ReverbParameter``
- ``GM2ChorusType``
- ``GM2ChorusParameter``

### General MIDI 2 Controllers

- ``GM2ControllerDestination``
- ``GM2KeyBasedController``
