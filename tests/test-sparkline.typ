// test-sparkline.typ — Sparkline, sparkbar, sparkdot tests

#import "../src/lib.typ": *
#import "data.typ": spark-data

#set page(margin: 0.5cm)

= Sparklines

== sparkline (basic)
Inline: #sparkline(spark-data) — sits right in text.

== sparkline (fill-area)
Filled: #sparkline(spark-data, fill-area: true)

== sparkbar
Bars: #sparkbar(spark-data)

== sparkdot
Dots: #sparkdot(spark-data)

== Sparklines in a table

#table(
  columns: (auto, auto),
  align: (left, center),
  [*Metric*], [*Trend*],
  [Revenue], [#sparkline((3, 5, 4, 7, 6, 9, 8), color: rgb("#59a14f"))],
  [Users],   [#sparkbar((2, 4, 3, 6, 5, 8, 7), color: rgb("#4e79a7"))],
  [Errors],  [#sparkdot((8, 6, 7, 4, 5, 2, 3), color: rgb("#e15759"))],
)
