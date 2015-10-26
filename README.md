# lyTemplates-singlepart

[LilyPond](http://lilypond.org) template for creating music with a solo
instrument and accompaniment chord symbols; essentially a "lead sheet".

## Overview

It is intended to be used as a plug-in to the [music repository][musicrepo].
Here we barrow inspiration from MVC (Model-View-Controller) frameworks to
separate our music, from our layout templates, from our compilation process. If
you're familiar with LilyPond, go at it. Otherwise, head over to that repository
for more explicit instructions.

[musicrepo]: https://github.com/brianclements/lyTemplates-music

## Requirements
Lilypond 2.16.2

## Install

1. First, start with the [music repository][musicrepo] instructions if you
   haven't already.

2. Clone this repo, using submodules, as a template plugin for the [music
   repository][musicrepo].
    * `cd piece-name`
    * `git submodule add git@github.com:brianclements/lyTemplates-singlepart.git template`
        * we have nested submodules so
            * `cd template`
            * `git submodule update --init`

3. Assuming you've already designed your layout in `layout.ily` and input all
   your project info as instructed in the [music repository][musicrepo], you can
   now `lilypond score.ly` or `lilypond parts.ly`.


## Contribution
Suggestions and contributions are always welcome and appreciated.

## Documentation

More detailed documentation is in the works to explain more advanced
configurations and the reasoning behind some design choices.

## License
lyTemplates-singlepart is licensed under the GPL3 license.

## Changelog

### Version 3.0.0

2015.10.26

* Complete re-working of layout and file structure.
    * Separate staff layout into it's own section and put it in it's own
      repository along with the music.
    * Music/layout are separate repository to which single/multipart layouts can
      plug into using git submodules.
* fix name of global chords var
* update lyInclude submodule to v1.1.0
* use relative-includes

### Version 2.3.0

2015.09.16

* add lyInclude library as submodule
* remove many manual layout tweaks, let Lilypond do it's thing
* Character/format/code cleanup from legacy code
* upgrade to LilyPond 2.16.2
* moved `lead_sheet.ly` to own dir
* add documentation
* Apply GPL3 license

### Version 2.2.1

2013.03.16

* Modify for public export to github

### Version 2.2.0

2012.06.22

* Added \compressFullBarRests and shifted some formatting things around in 'Melody' section.
* Make \include path objective
* Removed formatting text for Metronome Mark and Rehearsal Mark in 'Melody' section. Leaving it to auto-formatting
* Simplified chord formatting by replacing with /chordDefaults

### Version 2.1.6

2012.04.19

* First version controlled release
