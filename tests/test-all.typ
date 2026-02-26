// test-all.typ — Compilation test for all chart types and theme presets
// Verifies that every exported chart function works with minimal inline data.

#import "../src/lib.typ": *

#set page(margin: 0.5cm)

// ── Test Data ──────────────────────────────────────────────────────────────

#let simple-data = (labels: ("A", "B", "C"), values: (10, 20, 15))

#let multi-data = (
  labels: ("A", "B"),
  series: (
    (name: "X", values: (10, 20)),
    (name: "Y", values: (15, 25)),
  ),
)

#let scatter-data = (x: (1, 2, 3), y: (10, 20, 15))

#let bubble-data = (x: (1, 2, 3), y: (10, 20, 15), size: (5, 10, 8))

#let heatmap-data = (
  rows: ("R1", "R2"),
  cols: ("C1", "C2"),
  values: ((1, 2), (3, 4)),
)

#let calendar-data = (
  dates: ("2024-01-01", "2024-01-02", "2024-01-03", "2024-01-04", "2024-01-05", "2024-01-06", "2024-01-07"),
  values: (1, 3, 0, 5, 2, 4, 1),
)

#let correlation-data = (
  labels: ("A", "B"),
  values: ((1.0, 0.5), (0.5, 1.0)),
)

#let radar-data = (
  labels: ("A", "B", "C", "D"),
  series: ((name: "S1", values: (5, 8, 6, 7)),),
)

#let multi-scatter-data = (
  series: (
    (name: "G1", points: ((1, 2), (3, 4))),
    (name: "G2", points: ((2, 3), (4, 5))),
  ),
)

// ── Bar Charts ─────────────────────────────────────────────────────────────

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

#pagebreak()

// ── Line Charts ────────────────────────────────────────────────────────────

= Line Charts

#line-chart(simple-data, title: "line-chart")

#multi-line-chart(multi-data, title: "multi-line-chart")

#let dual-data = (
  labels: ("Q1", "Q2", "Q3", "Q4"),
  left: (name: "Revenue", values: (100, 150, 130, 180)),
  right: (name: "Growth %", values: (10, 15, 12, 18)),
)

#dual-axis-chart(
  dual-data,
  width: 400pt,
  height: 250pt,
  title: "dual-axis-chart",
  left-label: "Revenue ($)",
  right-label: "Growth (%)",
  x-label: "Quarter",
  show-grid: true,
)

#pagebreak()

// ── Area Charts ────────────────────────────────────────────────────────────

= Area Charts

#area-chart(simple-data, title: "area-chart")

#stacked-area-chart(multi-data, title: "stacked-area-chart")

#pagebreak()

// ── Pie Chart ──────────────────────────────────────────────────────────────

= Pie Chart

#pie-chart(simple-data, title: "pie-chart")

#pie-chart(simple-data, title: "pie-chart (donut)", donut: true)

#pagebreak()

// ── Radar Chart ────────────────────────────────────────────────────────────

= Radar Chart

#radar-chart(radar-data, title: "radar-chart")

#pagebreak()

// ── Scatter & Bubble ───────────────────────────────────────────────────────

= Scatter & Bubble Charts

#scatter-plot(scatter-data, title: "scatter-plot")

#multi-scatter-plot(multi-scatter-data, title: "multi-scatter-plot")

#bubble-chart(bubble-data, title: "bubble-chart")

#pagebreak()

// ── Gauge & Progress ───────────────────────────────────────────────────────

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

#pagebreak()

// ── Heatmap Charts ─────────────────────────────────────────────────────────

= Heatmap Charts

#heatmap(heatmap-data, title: "heatmap")

#calendar-heatmap(calendar-data, title: "calendar-heatmap")

#correlation-matrix(correlation-data, title: "correlation-matrix")

#pagebreak()

// ── Theme Presets ──────────────────────────────────────────────────────────

= Theme Presets

== themes.default
#bar-chart(simple-data, title: "default theme", theme: themes.default)

== themes.minimal
#bar-chart(simple-data, title: "minimal theme", theme: themes.minimal)

== themes.dark
#bar-chart(simple-data, title: "dark theme", theme: themes.dark)

== themes.presentation
#bar-chart(simple-data, title: "presentation theme", theme: themes.presentation)

== themes.print
#bar-chart(simple-data, title: "print theme", theme: themes.print)

== themes.accessible
#bar-chart(simple-data, title: "accessible theme", theme: themes.accessible)

#pagebreak()

// ── Sparklines ───────────────────────────────────────────────────────────

= Sparklines

#let spark-data = (4, 7, 2, 9, 5, 8, 3, 6, 1, 8)

== sparkline (basic)
Inline: #sparkline(spark-data) — sits right in text.

== sparkline (fill-area)
Filled: #sparkline(spark-data, fill-area: true)

== sparkbar
Bars: #sparkbar(spark-data)

== sparkdot
Dots: #sparkdot(spark-data)

// ── Funnel Chart ───────────────────────────────────────────────────────────

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

// ── Annotations ──────────────────────────────────────────────────────────

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

#pagebreak()

== Sparklines in a table

#table(
  columns: (auto, auto),
  align: (left, center),
  [*Metric*], [*Trend*],
  [Revenue], [#sparkline((3, 5, 4, 7, 6, 9, 8), color: rgb("#59a14f"))],
  [Users],   [#sparkbar((2, 4, 3, 6, 5, 8, 7), color: rgb("#4e79a7"))],
  [Errors],  [#sparkdot((8, 6, 7, 4, 5, 2, 3), color: rgb("#e15759"))],
)

#pagebreak()

// ── Waterfall Chart ──────────────────────────────────────────────────────────

= Waterfall Chart

#waterfall-chart(
  (
    labels: ("Start", "+Sales", "+Service", "-COGS", "-OpEx", "Total"),
    values: (1000, 400, 150, -300, -200, 1050),
  ),
  width: 400pt,
  height: 200pt,
  title: "Revenue Waterfall",
)

#pagebreak()

// ── Box Plot ──────────────────────────────────────────────────────────────

= Data Helpers

#let raw = (labels: ("C", "A", "D", "B"), values: (30, 10, 40, 20))

#bar-chart(sort-data(raw), title: "sort-data (ascending)")

#bar-chart(top-n(raw, 2), title: "top-n(2)")

#bar-chart(percent-of-total(raw), title: "percent-of-total")

#let multi = (
  labels: ("A", "B", "C"),
  series: (
    (name: "X", values: (10, 20, 30)),
    (name: "Y", values: (5, 15, 25)),
  ),
)
#bar-chart(aggregate(multi, fn: "sum"), title: "aggregate(sum)")

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

// ── Violin Plot ─────────────────────────────────────────────────────────

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

// ── Histogram ────────────────────────────────────────────────────────────

= Histogram

#let histogram-data = (2.1, 3.5, 4.2, 4.8, 5.1, 5.3, 5.7, 6.0, 6.2, 6.5, 6.8, 7.1, 7.3, 7.5, 7.8, 8.0, 8.2, 8.5, 9.0, 9.5)

#histogram(histogram-data, title: "Basic Histogram", show-values: true)

#histogram(histogram-data, title: "Histogram (10 bins)", bins: 10)

#histogram(histogram-data, title: "Density Histogram", density: true, color: rgb("#76b7b2"))

#pagebreak()

// ── Treemap Chart ──────────────────────────────────────────────────────────

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

#pagebreak()

// ── Lollipop Charts ────────────────────────────────────────────────────────

= Lollipop Charts

#lollipop-chart(simple-data, title: "lollipop-chart")

#lollipop-chart(
  (labels: ("Mon", "Tue", "Wed", "Thu", "Fri"), values: (12, 28, 19, 35, 22)),
  width: 350pt,
  height: 200pt,
  title: "Weekly Activity",
  dot-size: 5pt,
  stem-width: 2pt,
  x-label: "Day",
  y-label: "Count",
)

#horizontal-lollipop-chart(simple-data, title: "horizontal-lollipop-chart")

#horizontal-lollipop-chart(
  (labels: ("Alpha", "Beta", "Gamma", "Delta"), values: (40, 25, 60, 35)),
  width: 400pt,
  height: 200pt,
  title: "Horizontal Lollipop (custom)",
  dot-size: 6pt,
  stem-width: 2pt,
  x-label: "Score",
  y-label: "Group",
)

#pagebreak()

// ── Sankey Chart ──────────────────────────────────────────────────────────

= Sankey Chart

#sankey-chart(
  (
    nodes: ("Budget", "Salary", "Invest", "Rent", "Food", "Savings", "Stocks", "Bonds"),
    flows: (
      (from: 0, to: 1, value: 5000),
      (from: 0, to: 2, value: 2000),
      (from: 1, to: 3, value: 2000),
      (from: 1, to: 4, value: 1500),
      (from: 1, to: 5, value: 1500),
      (from: 2, to: 6, value: 1200),
      (from: 2, to: 7, value: 800),
    ),
  ),
  width: 400pt,
  height: 250pt,
  title: "Budget Allocation",
)

#sankey-chart(
  (
    nodes: ("Source A", "Source B", "Process", "Output X", "Output Y"),
    flows: (
      (from: 0, to: 2, value: 30),
      (from: 1, to: 2, value: 20),
      (from: 2, to: 3, value: 35),
      (from: 2, to: 4, value: 15),
    ),
  ),
  width: 350pt,
  height: 200pt,
  title: "Sankey (with values)",
  show-values: true,
)

#pagebreak()

// ── Chord Diagram ──────────────────────────────────────────────────────────

= Chord Diagram

#chord-diagram(
  (
    labels: ("A", "B", "C", "D"),
    matrix: (
      (0, 10, 5, 3),
      (8, 0, 7, 2),
      (4, 6, 0, 9),
      (2, 3, 8, 0),
    ),
  ),
  size: 300pt,
  title: "Basic Chord Diagram",
)

#v(12pt)

#chord-diagram(
  (
    labels: ("Sales", "Marketing", "Engineering"),
    matrix: (
      (0, 20, 10),
      (15, 0, 25),
      (5, 12, 0),
    ),
  ),
  size: 250pt,
  arc-width: 20pt,
  gap: 4,
  title: "Department Collaboration",
)

#v(12pt)

// Minimal: two entities
#chord-diagram(
  (
    labels: ("X", "Y"),
    matrix: (
      (0, 50),
      (30, 0),
    ),
  ),
  size: 200pt,
  title: "Two-Entity Chord",
  show-labels: false,
)

#pagebreak()

// ── Bullet Charts ──────────────────────────────────────────────────────────

= Bullet Charts

#bullet-chart(275, 250, (150, 225, 300), title: "Revenue ($K)")

#v(12pt)

#bullet-chart(82, 90, (60, 80, 100), title: "Satisfaction", label: "out of 100")

#v(12pt)

#bullet-charts(
  (bullets: (
    (value: 275, target: 250, ranges: (150, 225, 300), title: "Revenue ($K)"),
    (value: 82, target: 90, ranges: (60, 80, 100), title: "Satisfaction (%)"),
    (value: 45, target: 50, ranges: (25, 40, 60), title: "New Customers"),
  )),
  width: 350pt,
  bar-height: 25pt,
  gap: 15pt,
  title: "KPI Dashboard",
)

#v(12pt)

#bullet-chart(0, 50, (30, 60, 100), title: "Zero value")

#v(12pt)

#bullet-chart(120, 80, (30, 60, 100), title: "Over max")

#pagebreak()

// ── Slope Chart ──────────────────────────────────────────────────────────

= Slope Chart

#slope-chart(
  (
    labels: ("Company A", "Company B", "Company C", "Company D"),
    start-values: (85, 70, 60, 45),
    end-values: (65, 90, 55, 80),
    start-label: "2023",
    end-label: "2024",
  ),
  width: 300pt,
  height: 250pt,
  title: "Market Position Change",
)

#slope-chart(
  (
    labels: ("Alpha", "Beta", "Gamma"),
    start-values: (50, 50, 50),
    end-values: (80, 30, 50),
    start-label: "Before",
    end-label: "After",
  ),
  width: 280pt,
  height: 200pt,
  title: "Slope (equal start)",
  show-values: false,
)

#pagebreak()

// ── Diverging Bar Chart ──────────────────────────────────────────────────

= Diverging Bar Chart

#let diverging-data = (
  labels: ("Product A", "Product B", "Product C", "Product D"),
  left-values: (45, 30, 60, 25),
  right-values: (55, 70, 40, 75),
  left-label: "Disagree",
  right-label: "Agree",
)

#diverging-bar-chart(
  diverging-data,
  width: 400pt,
  height: 200pt,
  title: "Survey Results",
)

#v(12pt)

#diverging-bar-chart(
  (
    labels: ("Male", "Female"),
    left-values: (100, 90),
    right-values: (95, 105),
    left-label: "2020",
    right-label: "2025",
  ),
  width: 350pt,
  height: 150pt,
  title: "Population Pyramid",
  bar-height: 0.8,
)

#v(12pt)

// Without legend (no left-label/right-label)
#diverging-bar-chart(
  (
    labels: ("A", "B", "C"),
    left-values: (10, 20, 30),
    right-values: (30, 20, 10),
  ),
  title: "No Legend Variant",
  show-values: false,
)

#pagebreak()

// ── Gantt Chart ──────────────────────────────────────────────────────────

= Gantt Chart

#gantt-chart(
  (
    tasks: (
      (name: "Research", start: 0, end: 3, group: "Planning"),
      (name: "Design", start: 2, end: 5, group: "Planning"),
      (name: "Backend", start: 4, end: 9, group: "Development"),
      (name: "Frontend", start: 5, end: 10, group: "Development"),
      (name: "Testing", start: 8, end: 12, group: "QA"),
      (name: "Launch", start: 12, end: 13, group: "Release"),
    ),
    time-labels: ("W1", "W2", "W3", "W4", "W5", "W6", "W7", "W8", "W9", "W10", "W11", "W12", "W13"),
  ),
  width: 420pt,
  title: "Project Schedule",
  today: 7,
)

#v(12pt)

#gantt-chart(
  (
    tasks: (
      (name: "Task A", start: 0, end: 3),
      (name: "Task B", start: 2, end: 6),
      (name: "Task C", start: 5, end: 8),
    ),
  ),
  width: 350pt,
  title: "Gantt (no groups, auto labels)",
)

#pagebreak()

// ── Waffle Chart ──────────────────────────────────────────────────────────

= Waffle Chart

#waffle-chart(
  (
    labels: ("Category A", "Category B", "Category C"),
    values: (45, 30, 25),
  ),
  title: "Basic Waffle (percentages)",
)

#v(12pt)

#waffle-chart(
  (
    labels: ("Rent", "Food", "Transport", "Savings"),
    values: (35, 25, 20, 20),
  ),
  size: 180pt,
  title: "Budget Breakdown",
  rounded: false,
)

#v(12pt)

#waffle-chart(
  (
    labels: ("Yes", "No"),
    values: (72, 28),
  ),
  size: 150pt,
  gap: 3pt,
  title: "Survey Response",
  show-values: true,
)

#v(12pt)

// Non-percentage values (will be normalized)
#waffle-chart(
  (
    labels: ("Dogs", "Cats", "Birds"),
    values: (500, 300, 200),
  ),
  size: 160pt,
  title: "Pet Ownership (normalized)",
  show-legend: true,
)

#pagebreak()

// ── Bump Chart ──────────────────────────────────────────────────────────

= Bump Chart

#bump-chart(
  (
    labels: ("2020", "2021", "2022", "2023", "2024"),
    series: (
      (name: "Team A", values: (1, 2, 1, 3, 2)),
      (name: "Team B", values: (3, 1, 2, 1, 1)),
      (name: "Team C", values: (2, 3, 3, 2, 3)),
    ),
  ),
  width: 400pt,
  height: 250pt,
  title: "F1 Championship Positions",
)

#v(12pt)

#bump-chart(
  (
    labels: ("Q1", "Q2", "Q3", "Q4"),
    series: (
      (name: "Alpha", values: (1, 1, 2, 1)),
      (name: "Beta", values: (2, 3, 1, 2)),
      (name: "Gamma", values: (3, 2, 3, 3)),
    ),
  ),
  width: 350pt,
  height: 200pt,
  title: "Bump Chart (no labels)",
  show-labels: false,
  dot-size: 6pt,
  line-width: 3pt,
)

#pagebreak()

// ── Radial Bar Chart ──────────────────────────────────────────────────────

= Radial Bar Chart

#radial-bar-chart(
  (
    labels: ("Sales", "Marketing", "Engineering", "Support", "HR"),
    values: (85, 62, 95, 48, 30),
  ),
  title: "Department Performance",
)

#v(12pt)

#radial-bar-chart(
  (
    labels: ("Q1", "Q2", "Q3", "Q4"),
    values: (120, 95, 140, 110),
  ),
  size: 200pt,
  inner-radius: 0.4,
  title: "Quarterly Revenue",
  show-values: true,
)

#v(12pt)

#radial-bar-chart(
  (
    labels: ("A", "B", "C"),
    values: (50, 50, 50),
  ),
  size: 180pt,
  inner-radius: 0.0,
  title: "Equal Values (no hole)",
  show-labels: false,
)

#pagebreak()

// ── Dumbbell Chart ──────────────────────────────────────────────────────

= Dumbbell Chart

#dumbbell-chart(
  (
    labels: ("Revenue", "Costs", "Profit", "Headcount"),
    start-values: (100, 80, 20, 50),
    end-values: (150, 70, 80, 65),
    start-label: "2023",
    end-label: "2024",
  ),
  width: 400pt,
  height: 200pt,
  title: "Year-over-Year Comparison",
  show-values: true,
)

#v(12pt)

#dumbbell-chart(
  (
    labels: ("Math", "Science", "English"),
    start-values: (70, 70, 70),
    end-values: (85, 60, 90),
    start-label: "Pre-test",
    end-label: "Post-test",
  ),
  width: 350pt,
  height: 180pt,
  title: "Dumbbell (no values)",
  dot-size: 6pt,
)

#v(12pt)

// Equal values edge case
#dumbbell-chart(
  (
    labels: ("A", "B"),
    start-values: (50, 50),
    end-values: (50, 50),
  ),
  width: 300pt,
  height: 120pt,
  title: "Dumbbell (equal values)",
)

#pagebreak()

// ── Metric Card ──────────────────────────────────────────────────────

= Metric Card

// Full-featured metric card with delta and trend sparkline
#metric-card(
  value: 1234,
  label: "Revenue",
  delta: 12.5,
  trend: (80, 85, 82, 90, 88, 95, 92, 100),
)

#v(12pt)

// Minimal metric card — value and label only
#metric-card(value: 42, label: "Users Online")

#v(12pt)

// Negative delta
#metric-card(
  value: 8750,
  label: "Expenses",
  delta: -5.2,
  trend: (100, 98, 95, 90, 88, 85, 82, 80),
  format: "comma",
)

#v(12pt)

// Metric row — multiple cards side by side
#metric-row(
  (
    (value: 1234, label: "Revenue", delta: 12.5),
    (value: 42, label: "Users Online"),
    (value: 8750, label: "Expenses", delta: -5.2, format: "si"),
    (value: 99.9, label: "Uptime %", delta: 0.1, trend: (99, 99, 100, 99, 100, 100, 99, 100)),
  ),
  gap: 12pt,
)

#pagebreak()

// ── Sunburst Chart ──────────────────────────────────────────────────────

= Sunburst Chart

#sunburst-chart(
  (
    name: "Total",
    value: 100,
    children: (
      (name: "A", value: 60, children: (
        (name: "A1", value: 35),
        (name: "A2", value: 25),
      )),
      (name: "B", value: 40, children: (
        (name: "B1", value: 15),
        (name: "B2", value: 10),
        (name: "B3", value: 15),
      )),
    ),
  ),
  title: "Hierarchical Breakdown",
)

#v(12pt)

#sunburst-chart(
  (
    name: "Root",
    value: 200,
    children: (
      (name: "Engineering", value: 80, children: (
        (name: "Backend", value: 45, children: (
          (name: "API", value: 25),
          (name: "DB", value: 20),
        )),
        (name: "Frontend", value: 35),
      )),
      (name: "Sales", value: 70, children: (
        (name: "Direct", value: 40),
        (name: "Channel", value: 30),
      )),
      (name: "Support", value: 50),
    ),
  ),
  size: 350pt,
  inner-radius: 50pt,
  ring-width: 40pt,
  title: "Organization Budget (3 levels)",
)

#v(12pt)

// Minimal: single level (no grandchildren)
#sunburst-chart(
  (
    name: "Root",
    value: 100,
    children: (
      (name: "X", value: 50),
      (name: "Y", value: 30),
      (name: "Z", value: 20),
    ),
  ),
  size: 200pt,
  title: "Sunburst (single ring)",
  show-labels: false,
)

#pagebreak()

// ── Timeline Chart ──────────────────────────────────────────────────────

= Timeline Chart

#timeline-chart(
  (
    events: (
      (date: "Jan 2024", title: "Project Start", description: "Initial planning phase"),
      (date: "Mar 2024", title: "v0.1 Release", description: "First public beta"),
      (date: "Jun 2024", title: "v0.5 Release", description: "Added 20 chart types"),
      (date: "Sep 2024", title: "v1.0 Launch", description: "Production ready"),
    ),
  ),
  title: "Project Milestones",
)

#v(12pt)

// With categories for color coding
#timeline-chart(
  (
    events: (
      (date: "Week 1", title: "Research", description: "Market analysis", category: "Planning"),
      (date: "Week 3", title: "Design", description: "UI/UX mockups", category: "Planning"),
      (date: "Week 5", title: "Backend", description: "API development", category: "Dev"),
      (date: "Week 8", title: "Frontend", description: "React components", category: "Dev"),
      (date: "Week 10", title: "Testing", description: "QA and bug fixes", category: "QA"),
      (date: "Week 12", title: "Launch", category: "Release"),
    ),
  ),
  width: 400pt,
  event-gap: 55pt,
  marker-size: 7pt,
  title: "Timeline with Categories",
)

#v(12pt)

// Minimal: no descriptions
#timeline-chart(
  (
    events: (
      (date: "2023", title: "Founded"),
      (date: "2024", title: "Series A"),
      (date: "2025", title: "IPO"),
    ),
  ),
  width: 300pt,
  event-gap: 50pt,
  title: "Company History (minimal)",
)

#pagebreak()

// ── Parliament Chart ──────────────────────────────────────────────────────

= Parliament Chart

#parliament-chart(
  (
    labels: ("Party A", "Party B", "Party C", "Independent"),
    values: (120, 95, 70, 15),
  ),
  title: "Parliament (300 seats)",
)

#v(12pt)

#parliament-chart(
  (
    labels: ("Left", "Center", "Right"),
    values: (200, 150, 100),
  ),
  size: 300pt,
  dot-size: 3pt,
  gap: 1pt,
  title: "Large Parliament (450 seats)",
)

#v(12pt)

#parliament-chart(
  (
    labels: ("Majority", "Opposition"),
    values: (30, 20),
  ),
  size: 180pt,
  dot-size: 6pt,
  gap: 2pt,
  title: "Small Chamber (50 seats)",
  show-legend: false,
)

#pagebreak()

// ── Word Cloud ──────────────────────────────────────────────────────

= Word Cloud

#word-cloud(
  (
    words: (
      (text: "Typst", weight: 100),
      (text: "Charts", weight: 80),
      (text: "Data", weight: 60),
      (text: "Visualization", weight: 50),
      (text: "Pure", weight: 40),
      (text: "Native", weight: 35),
      (text: "Theme", weight: 30),
      (text: "Color", weight: 25),
      (text: "Simple", weight: 20),
      (text: "Fast", weight: 15),
    ),
  ),
  width: 350pt,
  height: 200pt,
  title: "Word Cloud",
)

#v(12pt)

#word-cloud(
  (
    words: (
      (text: "Alpha", weight: 50),
      (text: "Beta", weight: 50),
      (text: "Gamma", weight: 50),
    ),
  ),
  width: 300pt,
  height: 150pt,
  title: "Word Cloud (equal weights)",
  min-size: 14pt,
  max-size: 14pt,
)
