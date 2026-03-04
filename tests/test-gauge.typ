// test-gauge.typ — Gauge, progress-bar, circular-progress, rings tests

#import "../src/lib.typ": *
#import "data.typ": simple-data

#set page(margin: 0.5cm)

= Gauge & Progress Charts

#gauge-chart(65, title: "gauge-chart")

#progress-bar(72, title: "progress-bar")

#circular-progress(45, title: "circular-progress")

#progress-bars(simple-data, title: "progress-bars")

#ring-progress(
  (
    (name: "Move", value: 75, max: 100),
    (name: "Exercise", value: 45, max: 60),
    (name: "Stand", value: 10, max: 12),
  ),
  title: "ring-progress (fitness rings)",
)

#ring-progress(
  (
    (name: "Overflow", value: 130, max: 100),
    (name: "Half", value: 50, max: 100),
  ),
  title: "ring-progress (overflow)",
)
