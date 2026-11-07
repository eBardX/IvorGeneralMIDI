# Using IvorGeneralMIDI

Look up General MIDI 1 and 2 sounds, and build the messages that select and
control them.

## Overview

IvorGeneralMIDI turns the sound sets of the General MIDI 1 and General MIDI 2
specifications into Swift enumerations:

 Type                       | Represents
:----                       |:----------
 ``GM1Instrument``          | One of the 128 General MIDI 1 instruments
 ``GM1InstrumentFamily``    | One of the 16 families of 8 instruments
 ``GM1PercussionSound``     | One of the 47 sounds of the percussion key map
 ``GM2Instrument``          | One of the 256 General MIDI 2 instruments
 ``GM2DrumSet``             | One of the 9 General MIDI 2 drum sets
 ``GM2DrumSetSound``        | The sound a note plays in a drum set
 ``GM2PercussionSound``     | One of the 61 sounds of the extended key map

Every sound can be looked up by the numbers that select it — a program, a bank
LSB, or a note — or by its name, and gives those numbers back. Programs,
notes, and channels are [IvorMIDI](https://github.com/eBardX/IvorMIDI) data
values (`MIDIProgram`, `MIDIData1Value`, and `MIDIChannel`), so they can go
straight into a `MIDIChannelMessage`.

Name lookup ignores case, leading and trailing whitespace, and the amount of
whitespace between words. Names are spelled as the specification gives them,
and the two specifications spell a few differently: General MIDI 2 has “String
Ensembles 1” and “High Bongo” where General MIDI 1 has “String Ensemble 1” and
“Hi Bongo”.

## General MIDI 1 instruments

A program change selects one of the 128 ``GM1Instrument`` cases. Every program
selects one, so ``GM1Instrument/init(program:)`` never fails:

```swift
let piano = GM1Instrument(program: 1)   // .acousticGrandPiano

piano.name      // "Acoustic Grand Piano"
piano.family    // .piano
piano.patch     // program 1, no bank
```

The instruments fall into 16 ``GM1InstrumentFamily`` groups of 8 consecutive
programs, from ``GM1InstrumentFamily/piano`` (programs 1–8) to
``GM1InstrumentFamily/soundEffects`` (programs 121–128); a family lists its
``GM1InstrumentFamily/instruments`` in program order. Both enumerations list
their ``GM1Instrument/allCases`` in program order.

## General MIDI 1 percussion

On ``GM1PercussionSound/channel`` (channel 10), each note from 35 to 81 plays
one of the 47 ``GM1PercussionSound`` cases. ``GM1PercussionSound/init(note:)``
returns `nil` for a note outside that range:

```swift
let kick = GM1PercussionSound(note: 36)     // .bassDrum1

kick?.name      // "Bass Drum 1"
```

## General MIDI 2 instruments

General MIDI 2 keeps the 128 General MIDI 1 instruments and adds 128
variations of them. A ``GM2Instrument`` is selected by a bank select MSB of
``GM2Instrument/bankMSB`` (121), a bank select LSB, and a program change: bank
LSB 0 holds the General MIDI 1 instruments, and higher LSBs their variations.
``GM2Instrument/init(bankLSB:program:)`` returns `nil` for a bank LSB that the
program has no variation in.

```swift
let ukulele = GM2Instrument(bankLSB: 1, program: 25)!

ukulele.gm1Instrument       // .acousticGuitarNylon
ukulele.patch               // program 25 in bank 121:1
ukulele.selectionMessages(channel: 1)
// Bank select MSB 121, bank select LSB 1, then program change 25.
```

A device that lacks a variation plays its ``GM2Instrument/gm1Instrument``
instead. ``GM2Instrument/recommendedKeyRange`` gives the notes over which an
instrument keeps its proper character; it is `nil` for the effect sounds of
programs 116–128, which have no defined pitch.

## Drum sets

A rhythm channel plays one of the 9 ``GM2DrumSet`` cases, selected by a bank
select MSB of ``GM2DrumSet/bankMSB`` (120), a bank select LSB of
``GM2DrumSet/bankLSB`` (0), and a program change. Its
``GM2DrumSet/selectionMessages(channel:)`` default to channel 10.

The ``GM2DrumSet/standard`` set plays the 61 ``GM2PercussionSound`` cases on
notes 27–87: the 47 General MIDI 1 sounds on notes 35–81, plus 8 below and 6
above. Every other set replaces some of them with sounds of its own, and the
``GM2DrumSet/sfx`` set replaces nearly all. ``GM2DrumSet/sound(for:)`` and
``GM2DrumSet/sounds`` give the ``GM2DrumSetSound`` each note plays in a set:

```swift
let jazz = GM2DrumSet.jazz

jazz.program                        // 33
jazz.sound(for: 36)?.name           // the set’s own kick
jazz.sound(for: 36)?.standardSound  // nil: the set replaces this note
```

A ``GM2DrumSetSound`` carries the note’s preset ``GM2DrumSetSound/pan``, its
``GM2DrumSetSound/exclusiveGroup`` (sounds in the same group, such as the
closed, pedal, and open hi-hats, cut each other off), and whether it
``GM2DrumSetSound/respondsToNoteOff``; ``GM2DrumSetSound/standardSound`` is the
Standard Set sound it is, or `nil` if the set replaces it.

## Turning General MIDI on and off

``GMMessage`` holds the universal system exclusive messages of General MIDI, and
converts to and from a `MIDISystemMessage`. A message addresses all devices unless
you provide a `deviceID:`. The messages that switch a device into or out of
General MIDI are ``GMMessage/Content/gm1SystemOn``,
``GMMessage/Content/gm2SystemOn``, and ``GMMessage/Content/gmSystemOff``. Send one
before anything else, so that the device starts from the specification’s default
state:

```swift
let start = GMMessage(content: .gm2SystemOn)

start.systemMessage     // F0 7E 7F 09 03 F7
```

## General MIDI 2 effects and controllers

General MIDI 2 devices have a reverb and a chorus, set with global parameter
control messages. Pass the parameters in the order to set them, with the type
first, since selecting a type resets the other parameters to that type’s
defaults:

```swift
let reverb = GMMessage(content: .gm2Reverb([.type(.largeHall), .time(64)]))
let chorus = GMMessage(content: .gm2Chorus([.type(.chorus3), .feedback(16)]))
```

``GM2ReverbType`` and ``GM2ChorusType`` name the effect types and give their
defaults, such as ``GM2ReverbType/defaultTime``.

A controller destination setting assigns channel pressure, or one control
change, to sound parameters such as pitch, filter cutoff, or vibrato depth
(``GM2ControllerDestination``). A key-based instrument control message adjusts
the pan, volume, or effect sends of one note of a drum set
(``GM2KeyBasedController``):

```swift
// Let the modulation wheel add vibrato on channel 1.
let vibrato = GMMessage(content: .controlChangeDestinations(.modulationWheelMSB,
                                                            1,
                                                            [.lfoPitchDepth(32)]))

// Pan the kick of the drum set on channel 10 hard left, and keep it dry.
let kick = GMMessage(content: .keyBasedInstrumentControl(10,
                                                         note: 36,
                                                         [.pan(0),
                                                          .reverbSendLevel(0)]))
```

A ``GMMessage/Content/controlChangeDestinations(_:_:_:)`` message can’t be encoded
for a controller outside the assignable ranges, 1–31 and 64–95, so its
``GMMessage/envelope`` and `systemMessage` are `nil`.

To read a message, such as one from a Standard MIDI File, create a ``GMMessage``
from it, which returns `nil` for anything that isn’t a valid General MIDI message:

```swift
if let reply = GMMessage(message),
   case let .gm2Reverb(parameters) = reply.content {
    // Use the parameters.
}
```

## Error handling

IvorGeneralMIDI throws no errors. Every lookup that can fail returns `nil`
instead: the name initializers, ``GM1PercussionSound/init(note:)``,
``GM2Instrument/init(bankLSB:program:)``, ``GM2DrumSet/init(program:)``,
``GM2PercussionSound/init(note:)``, ``GM2DrumSet/sound(for:)``, and the decoding
and encoding of ``GMMessage``.

## Concurrency

IvorGeneralMIDI is built for Swift 6 strict concurrency. Every public type is a
`Sendable` value type, so instances can be freely shared across tasks and actor
boundaries.
