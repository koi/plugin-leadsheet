% lead_sheet.ly: lilypond template for leadsheets
% Copyright (C) 2015, Brian Clements

% This program is free software: you can redistribute it and/or modify it under
% the terms of the GNU General Public License as published by the Free Software
% Foundation, either version 3 of the License, or (at your option) any later
% version.

% This program is distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
% details.

% You should have received a copy of the GNU General Public License along with
% this program.  If not, see <http://www.gnu.org/licenses/>.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%               Lead Sheet                  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%lead sheet template v2.2.1%%

\version "2.14.2"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%               Include                     %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\include "english.ly"
\include "../lyInclude/lyInclude/definitions.ily"
\include "../lyInclude/lyInclude/jazzChords.ily"

#(set-global-staff-size 20)

\header {
    dedication = ""
    title = ""
    subtitle = ""
    subsubtitle = ""
    instrument = ""
    poet = ""
    composer = ""
    catalog = ""
    year = ""
    meter = ""
    opus = ""
    arranger = ""
    piece = ""
    head = ""
    owner = "Brian Clements"
    enteredby = "Brian Clements"
    maintainer = "Brian Clements"
    maintainerEmail = "brian@brianclements.net"
    copyright = \markup {
        Copyright © \year by \owner
        }
    footer = ""
    tagline = \markup {
        \override #'(box-padding . 0.5) \override #'(baseline-skip . 1.0) \box \center-column {
            \small \line {
                Typeset using \with-url #"http://www.LilyPond.org" \line {
                    \teeny www. \hspace #-1.0 LilyPond \hspace #-1.0 \teeny .org \hspace #0.5
                    }
                • \hspace #0.5 Reference: \catalog
                }
            \small \line {
                Copyright © \year by \owner \hspace #0.5 • \hspace #0.5 Used by permission. All rights reserved.
                }
            }
        }
    }

\paper {
    #(set-paper-size "letter")
    head-separation = 5\mm
    top-margin = 15\mm
    left-margin = 15\mm
    line-width = #185
    bottom-margin = 18\mm
    indent = 0\mm
    after-title-space = 45\mm
    between-system-space = 30\mm
    between-system-padding = #2
    ragged-last-bottom = ##t
    ragged-last = ##t
    ragged-bottom = ##f
    oddHeaderMarkup = \markup \fill-line {
        \on-the-fly #print-page-number-check-first \fromproperty #'page:page-number-string
        \null
        \on-the-fly #not-first-page \fromproperty #'header:title
        \null
        \on-the-fly #not-first-page \fromproperty #'header:instrument
        }
    evenHeaderMarkup = \markup \fill-line {
        \on-the-fly #not-first-page \fromproperty #'header:instrument
        \null
        \fromproperty #'header:title
        \null
        \on-the-fly #print-page-number-check-first \fromproperty #'page:page-number-string
        }
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%               Variables                   %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

defaults = {
    \key c \major
    \tempo 4=76
    \time 4/4
    \numericTimeSignature
    }

codaSpace = {
    \cadenzaOn \stopStaff
    \once \override Staff.Clef #'transparent = ##t
    \once \override Staff.KeySignature #'transparent = ##t
    \once \override Score.BarNumber #'transparent = ##t
    \skip 1*1 \bar ""
    %uncomment below to add extra space above the coda
    %\once \override Staff.Clef #'break-visibility = #all-invisible
    %\once \override Staff.KeySignature #'break-visibility = #all-invisible
    %\break \skip 1*1
    \startStaff \cadenzaOff
    \once \override Staff.Clef #'break-visibility = #all-visible
    \once \override Staff.KeySignature #'break-visibility = #all-visible
    \once \override Score.MetronomeMark #'stencil = ##f
    \defaults
    s1*0\mark \markup { \huge \box \musicglyph #"scripts.coda" }
    }

parenthesizeBar = {
    \once \override Score.RehearsalMark #'padding = #1
    \once \override Score.RehearsalMark #'font-size = #10
    \once \override Score.RehearsalMark #'extra-offset = #'(10 . -11.15)
    s1*0\mark \markup { "(" \hspace #13.0 ")" }
    }

textSpanModOne = {
    \override TextSpanner #'dash-period = #1
    \override TextSpanner #'dash-fraction = #0.25
    \once \override TextSpanner #'(bound-details left text) = \markup { \lower #0.5 \draw-line #'(0 . -2) \upright { "play 1" \hspace #-0.75 \tiny st "x only" }}
    \once \override TextSpanner #'(bound-details right text) = \markup { \hspace #1 \draw-line #'(0 . -2) }
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                   Melody                  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Melody section has all formating parameters

melody = \relative c' {
    \set Staff.midiInstrument = "acoustic grand"
    \set Score.markFormatter = #format-mark-box-alphabet
    \compressFullBarRests
    \override MultiMeasureRest #'expand-limit = #2
    \clef treble
    \defaults
    %1
        R1
        \bar "|."
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                   Part B                  %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

partb = \relative c {
    \set Staff.midiInstrument = "acoustic grand"
    \clef bass
    \defaults
    \override Staff.TimeSignature #'style = #'()
    %1
        R1
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%               Chord Changes               %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

chordChanges = \chords {
    \chordDefaults
    %1
        R1
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                   Harmony                 %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

harmony = \relative c' {
    \set Staff.midiInstrument = "acoustic grand"
    \clef treble
    \defaults
    \chords { \chordChanges }
    }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                   Score                   %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\score {
    \transpose c c {
        <<
        \chordChanges
        \new Staff { \melody }
        %\new Staff { \partb }
        >>
        }
    \layout { pagenumber = yes
        \context {
            \Score
            \remove "Bar_number_engraver"
            }
        }
    \midi { }
    }
