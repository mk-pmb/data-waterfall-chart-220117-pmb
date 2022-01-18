#!/bin/sed -urf
# -*- coding: UTF-8, tab-width: 2 -*-

: waterfall
  s~(^|\r)( +)([:V])+~\1\2\f<waterfall \3>\r~
t waterfall
s~\r~~g

s~\f<waterfall :>~┆~g   # box drawings light triple dash vertical
s~\f<waterfall :>~│~g   # box drawings light vertical
s~\f<waterfall V>~▼~g   # black down-pointing triangle
s~\f<waterfall V>~↓~g   # down arrow
s~\f<waterfall V>~⇣~g   # downwards dashed arrow

# box content heavy line:
s~\.(\=+)\.~┏\f<bar ━ \1 >┓~g
s~(^| )\|{2}( [^|]+ )\|{2}$~\1┃\2  ┃~
s~(^| )\|{2}(\^+)\|{2}$~\1┠\f<bar ─ --\2 >┨~
s~(^| )'(\-+)'$~\1┗\f<bar ━ \2 >┛~
s~(^| )\|( [^|]+ )\|$~\1┃\2┃~

# box content light line:
s~(^| )\|{2}(\^+)\|{2}~\1┡\f<bar ━ --\2 >┩~g
s~'(\-+)'~└\f<bar ─ \1 >┘~g
s~(^| )\|( [^|]+ )\|$~\1│\2│~

: horiz_bar
  s~(\f<bar (\S+) \S*)\S >~\2\1 >~g
t horiz_bar
s~\f<bar \S+  >~~g

s~<<ref (\S+) >>~※ \1~g
