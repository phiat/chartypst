// test-bar.typ — Bar chart tests

#import "../src/lib.typ": *
#import "data.typ": simple-data, multi-data

#set page(margin: 0.5cm)

= Bar Charts

#bar-chart(simple-data, title: "bar-chart")

#horizontal-bar-chart(simple-data, title: "horizontal-bar-chart")

#grouped-bar-chart(multi-data, title: "grouped-bar-chart")

#stacked-bar-chart(multi-data, title: "stacked-bar-chart")

#let grouped-stacked-data = (
  labels: ("Q1", "Q2", "Q3", "Q4"),
  groups: (
    (name: "Product A", segments: (
      (name: "Online", values: (40, 50, 60, 70)),
      (name: "Retail", values: (30, 35, 40, 45)),
    )),
    (name: "Product B", segments: (
      (name: "Online", values: (25, 30, 35, 40)),
      (name: "Retail", values: (20, 25, 30, 35)),
    )),
  ),
)

#grouped-stacked-bar-chart(
  grouped-stacked-data,
  width: 400pt,
  height: 250pt,
  title: "grouped-stacked-bar-chart",
  x-label: "Quarter",
  y-label: "Sales",
)
