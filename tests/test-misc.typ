// test-misc.typ — Waffle, parliament, radial-bar, sunburst, wordcloud, metric tests

#import "../src/lib.typ": *

#set page(margin: 0.5cm)

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

// Metric card with suffix
#metric-card(value: 94.2, label: "Uptime", suffix: "%")

#v(12pt)

// Metric row — multiple cards side by side, with suffix
#metric-row(
  (
    (value: 1234, label: "Revenue", delta: 12.5),
    (value: 42, label: "Users Online"),
    (value: 8750, label: "Expenses", delta: -5.2, format: "si"),
    (value: 99.9, label: "Uptime", delta: 0.1, suffix: "%", trend: (99, 99, 100, 99, 100, 100, 99, 100)),
  ),
  gap: 12pt,
)

#pagebreak()

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

#v(12pt)

// Word cloud with circle shape
#word-cloud(
  (
    words: (
      (text: "Circle", weight: 10),
      (text: "Shape", weight: 8),
      (text: "Cloud", weight: 6),
      (text: "Words", weight: 5),
      (text: "Layout", weight: 3),
      (text: "Spiral", weight: 2),
    ),
  ),
  width: 250pt,
  height: 200pt,
  title: "Word Cloud (circle)",
  shape: "circle",
)

#v(12pt)

// Word cloud with diamond shape
#word-cloud(
  (
    words: (
      (text: "Diamond", weight: 10),
      (text: "Shape", weight: 7),
      (text: "Mask", weight: 5),
      (text: "Test", weight: 3),
    ),
  ),
  width: 250pt,
  height: 200pt,
  title: "Word Cloud (diamond)",
  shape: "diamond",
)
