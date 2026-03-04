// test-statistical.typ — Histogram, box-plot, violin, funnel, treemap tests

#import "../src/lib.typ": *
#import "data.typ": histogram-data

#set page(margin: 0.5cm)

= Funnel Chart

#funnel-chart(
  (
    labels: ("Visitors", "Leads", "Qualified", "Proposals", "Closed"),
    values: (10000, 5000, 2500, 1200, 500),
  ),
  width: 300pt,
  height: 250pt,
  title: "Sales Funnel",
)

#pagebreak()

= Box Plot

#box-plot(
  (
    labels: ("Group A", "Group B", "Group C", "Group D"),
    boxes: (
      (min: 10, q1: 25, median: 35, q3: 50, max: 70),
      (min: 15, q1: 30, median: 42, q3: 55, max: 65),
      (min: 5, q1: 20, median: 28, q3: 40, max: 60),
      (min: 20, q1: 35, median: 45, q3: 58, max: 75),
    ),
  ),
  width: 350pt,
  height: 200pt,
  title: "Distribution Comparison",
)

#pagebreak()

= Violin Plot

#violin-plot(
  (
    labels: ("Group A", "Group B", "Group C"),
    datasets: (
      (2, 3, 3, 4, 4, 5, 5, 5, 6, 6, 7, 8, 9, 12, 15),
      (1, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6, 7, 8, 10, 11),
      (5, 6, 6, 7, 7, 7, 7, 8, 8, 8, 9, 9, 10, 11, 12),
    ),
  ),
  width: 350pt,
  height: 250pt,
  title: "Distribution Shapes",
)

#v(12pt)

#violin-plot(
  (
    labels: ("Narrow", "Wide"),
    datasets: (
      (5, 5, 5, 5, 5, 5, 5, 5, 5, 5),
      (1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
    ),
  ),
  width: 300pt,
  height: 200pt,
  title: "Violin (no inner box)",
  show-box: false,
)

#pagebreak()

= Histogram

#histogram(histogram-data, title: "Basic Histogram", show-values: true)

#histogram(histogram-data, title: "Histogram (10 bins)", bins: 10)

#histogram(histogram-data, title: "Density Histogram", density: true, color: rgb("#76b7b2"))

#pagebreak()

= Treemap Chart

#treemap(
  (
    labels: ("Rent", "Food", "Transport", "Entertainment", "Savings", "Health"),
    values: (1200, 800, 400, 300, 500, 250),
  ),
  width: 350pt,
  height: 220pt,
  title: "Monthly Budget Breakdown",
)

#treemap(
  (
    labels: ("Stocks", "Bonds", "Real Estate", "Cash", "Crypto"),
    values: (45, 25, 15, 10, 5),
  ),
  width: 300pt,
  height: 200pt,
  title: "Portfolio Allocation",
  show-values: false,
)
