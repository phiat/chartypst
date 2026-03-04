// test-pie.typ — Pie chart tests

#import "../src/lib.typ": *
#import "data.typ": simple-data

#set page(margin: 0.5cm)

= Pie Chart

#pie-chart(simple-data, title: "pie-chart")

#pie-chart(simple-data, title: "pie-chart (donut)", donut: true)
