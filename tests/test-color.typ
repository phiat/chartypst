// test-color.typ — Color system: palettes, reversal, custom arrays, gradient legend

#import "../src/lib.typ": *
#import "data.typ": heatmap-data, calendar-data

#set page(margin: 0.5cm)

= Named Palettes

#let palettes = ("viridis", "heat", "blues", "greens", "reds", "purples", "inferno", "plasma", "coolwarm", "spectral")

#for pal in palettes {
  [== #pal]
  heatmap(heatmap-data, cell-size: 25pt, title: none, palette: pal, show-legend: true)
  v(4pt)
}

#pagebreak()

= Palette Reversal

== viridis vs viridis-r (suffix)
#grid(columns: (1fr, 1fr), column-gutter: 10pt,
  heatmap(heatmap-data, cell-size: 25pt, title: "viridis", palette: "viridis"),
  heatmap(heatmap-data, cell-size: 25pt, title: "viridis-r", palette: "viridis-r"),
)

== heat + reverse param
#grid(columns: (1fr, 1fr), column-gutter: 10pt,
  heatmap(heatmap-data, cell-size: 25pt, title: "heat", palette: "heat"),
  heatmap(heatmap-data, cell-size: 25pt, title: "heat reversed", palette: "heat", reverse: true),
)

== grayscale reversed
#heatmap(heatmap-data, cell-size: 25pt, title: "grayscale-r", palette: "grayscale-r")

#pagebreak()

= Custom Palette Arrays

== Two-stop custom
#heatmap(heatmap-data, cell-size: 25pt, title: "red→blue", palette: (red, blue))

== Three-stop custom
#heatmap(heatmap-data, cell-size: 25pt, title: "green→yellow→red", palette: (green, yellow, red))

== Five-stop custom reversed
#heatmap(heatmap-data, cell-size: 25pt, title: "custom 5-stop reversed",
  palette: (rgb("#000000"), rgb("#1a1a2e"), rgb("#e94560"), rgb("#f5a623"), rgb("#ffffff")),
  reverse: true,
)

#pagebreak()

= Calendar Heatmap Palettes

== Default (heat)
#calendar-heatmap(calendar-data, title: "heat")

== Viridis
#calendar-heatmap(calendar-data, title: "viridis", palette: "viridis")

== Custom array
#calendar-heatmap(calendar-data, title: "custom", palette: (rgb("#eee"), rgb("#e15759")))

== Reversed
#calendar-heatmap(calendar-data, title: "heat reversed", palette: "heat", reverse: true)
