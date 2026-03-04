// test-heatmap.typ — Heatmap, calendar, correlation tests

#import "../src/lib.typ": *
#import "data.typ": heatmap-data, calendar-data, correlation-data

#set page(margin: 0.5cm)

= Heatmap Charts

#heatmap(heatmap-data, title: "heatmap")

#calendar-heatmap(calendar-data, title: "calendar-heatmap")

#correlation-matrix(correlation-data, title: "correlation-matrix")
