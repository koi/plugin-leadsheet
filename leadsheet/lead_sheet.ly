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

\version "2.16.2"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%               Include                     %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\include "english.ly"
\include "../lyInclude/lyInclude/definitions.ily"
\include "../lyInclude/lyInclude/jazzChords.ily"
\include "../../music.ily"

#(set-global-staff-size 20)


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
        \chordDefaults
        \new Staff { << \global \partA >> }
        >>
        }
    \layout { 
        pagenumber = yes
        \set Score.markFormatter = #format-mark-box-alphabet
        \override MultiMeasureRest #'expand-limit = #2
        \compressFullBarRests
        \numericTimeSignature
        \context {
            \Score
            \remove "Bar_number_engraver"
            }
        }
    \midi { }
    }
