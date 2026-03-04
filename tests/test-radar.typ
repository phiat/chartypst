// test-radar.typ — Radar chart tests

#import "../src/lib.typ": *
#import "data.typ": radar-data

#set page(margin: 0.5cm)

= Radar Chart

#radar-chart(radar-data, title: "radar-chart")
