// test-heatmap.typ — Heatmap, calendar, correlation tests

#import "../src/lib.typ": *
#import "data.typ": heatmap-data, calendar-data, correlation-data

#set page(margin: 0.5cm)

= Heatmap Charts

#heatmap(heatmap-data, title: "heatmap")

#heatmap(heatmap-data, title: "heatmap (reversed)", reverse: true)

#heatmap(heatmap-data, title: "heatmap (custom palette)", palette: (rgb("#2c3e50"), rgb("#e74c3c"), rgb("#f39c12")))

#calendar-heatmap(calendar-data, title: "calendar-heatmap")

#calendar-heatmap(calendar-data, title: "calendar (reversed)", reverse: true)

#correlation-matrix(correlation-data, title: "correlation-matrix")
