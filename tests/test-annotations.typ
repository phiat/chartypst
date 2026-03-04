// test-annotations.typ — Annotation overlay tests

#import "../src/lib.typ": *

#set page(margin: 0.5cm)

= Annotations

#line-chart(
  (labels: ("Jan", "Feb", "Mar", "Apr", "May", "Jun"),
   values: (30, 45, 35, 60, 50, 70)),
  width: 400pt,
  height: 200pt,
  title: "Sales with Annotations",
  annotations: (
    (type: "h-line", value: 50, label: "Target", color: rgb("#e15759"), dash: "dashed"),
    (type: "h-band", from: 40, to: 60, label: "Goal Zone", color: rgb("#59a14f")),
  ),
)

#bar-chart(
  (labels: ("A", "B", "C", "D", "E"), values: (20, 45, 30, 55, 40)),
  width: 350pt,
  height: 200pt,
  title: "Bar Chart with Target Line",
  annotations: (
    (type: "h-line", value: 35, label: "Avg", color: rgb("#4e79a7"), dash: "dashed"),
  ),
)

#scatter-plot(
  (x: (1, 2, 3, 4, 5), y: (10, 25, 15, 30, 20)),
  width: 350pt,
  height: 250pt,
  title: "Scatter with Annotations",
  annotations: (
    (type: "h-line", value: 20, label: "Threshold", color: rgb("#e15759"), dash: "dotted"),
    (type: "v-line", value: 3, label: "Midpoint", color: rgb("#4e79a7"), dash: "dashed"),
    (type: "label", x: 4, y: 30, text: "Peak!", color: rgb("#e15759")),
  ),
)
