// Chart Demo - Testing all chart types
#import "charting.typ": *

#set page(margin: 1cm)
#set text(font: "Arial", size: 10pt)

// Load JSON data
#let chars = json("characters.json")
#let events = json("events.json")
#let analytics = json("analytics.json")

= Typst Charting Library Demo

== Bar Charts

=== Vertical Bar Chart
#bar-chart(
  (
    labels: chars.characters.map(c => c.name.split(" ").at(0)),
    values: chars.characters.map(c => c.kills),
  ),
  width: 400pt,
  height: 180pt,
  title: "Enemy Kills by Character",
)

#v(20pt)

=== Horizontal Bar Chart
#horizontal-bar-chart(
  (
    labels: chars.characters.map(c => c.name.split(" ").at(0)),
    values: chars.characters.map(c => c.gold),
  ),
  width: 400pt,
  height: 200pt,
  title: "Gold by Character (Horizontal)",
)

#pagebreak()

=== Grouped Bar Chart
#grouped-bar-chart(
  (
    labels: events.attendance.days,
    series: (
      (name: "Registered", values: events.attendance.registered),
      (name: "In-Person", values: events.attendance.actual),
      (name: "Virtual", values: events.attendance.virtual),
    ),
  ),
  width: 400pt,
  height: 200pt,
  title: "Daily Attendance Breakdown",
)

#v(20pt)

=== Stacked Bar Chart
#stacked-bar-chart(
  (
    labels: ("Q1", "Q2", "Q3", "Q4"),
    series: (
      (name: "Product A", values: (120, 150, 180, 200)),
      (name: "Product B", values: (80, 100, 90, 120)),
      (name: "Product C", values: (50, 70, 85, 95)),
    ),
  ),
  width: 350pt,
  height: 200pt,
  title: "Quarterly Sales by Product",
)

#pagebreak()

== Line Charts

=== Single Line Chart
#line-chart(
  (
    labels: chars.session_history.sessions.map(s => "S" + str(s)),
    values: chars.session_history.party_gold,
  ),
  width: 450pt,
  height: 200pt,
  title: "Party Gold by Session",
  show-points: true,
)

#v(20pt)

=== Multi-Line Chart
#multi-line-chart(
  (
    labels: chars.damage_by_session.sessions,
    series: (
      (name: "Thorin", values: chars.damage_by_session.thorin),
      (name: "Elara", values: chars.damage_by_session.elara),
      (name: "Grok", values: chars.damage_by_session.grok),
    ),
  ),
  width: 450pt,
  height: 200pt,
  title: "Damage Dealt per Session",
)

#pagebreak()

== Area Charts

=== Single Area Chart
#area-chart(
  (
    labels: chars.session_history.sessions.map(s => "S" + str(s)),
    values: chars.session_history.exp_gained,
  ),
  width: 450pt,
  height: 180pt,
  title: "Experience Gained Over Time",
  fill-opacity: 50%,
)

#v(20pt)

=== Stacked Area Chart
#stacked-area-chart(
  analytics.area_chart_data,
  width: 450pt,
  height: 200pt,
  title: "Gold Flow Over Time",
)

#pagebreak()

== Pie Charts

#grid(
  columns: (1fr, 1fr),
  column-gutter: 20pt,

  [
    === Pie Chart
    #pie-chart(
      (
        labels: chars.characters.map(c => c.name.split(" ").at(0)),
        values: chars.characters.map(c => c.kills),
      ),
      size: 150pt,
      title: "Kill Distribution",
    )
  ],

  [
    === Donut Chart
    #pie-chart(
      events.budget_breakdown,
      size: 150pt,
      title: "Budget Allocation",
      donut: true,
      donut-ratio: 0.5,
    )
  ]
)

#pagebreak()

== Radar Charts

=== Single Series Radar
#radar-chart(
  (
    labels: ("STR", "DEX", "CON", "INT", "WIS", "CHA"),
    series: (
      (name: "Thorin", values: (18, 12, 16, 10, 13, 8)),
    ),
  ),
  size: 220pt,
  title: "Thorin - Ability Scores",
)

#v(20pt)

=== Multi-Series Radar
#radar-chart(
  (
    labels: ("STR", "DEX", "CON", "INT", "WIS", "CHA"),
    series: (
      (name: "Fighter", values: (18, 12, 16, 10, 13, 8)),
      (name: "Wizard", values: (8, 14, 12, 18, 15, 11)),
      (name: "Barbarian", values: (20, 14, 18, 6, 10, 8)),
    ),
  ),
  size: 250pt,
  title: "Class Comparison",
  fill-opacity: 25%,
)

#pagebreak()

== Scatter Plots

=== Simple Scatter Plot
#scatter-plot(
  (
    x: chars.characters.map(c => c.hp),
    y: chars.characters.map(c => c.kills),
  ),
  width: 350pt,
  height: 250pt,
  title: "HP vs Kills",
  x-label: "Hit Points",
  y-label: "Kill Count",
)

#v(15pt)

=== Multi-Series Scatter Plot
#multi-scatter-plot(
  analytics.scatter_data,
  width: 350pt,
  height: 250pt,
  title: "Character Classes: Level vs Kills",
  x-label: "Level",
  y-label: "Kills",
)

#pagebreak()

== Bubble Chart

#bubble-chart(
  analytics.bubble_data,
  width: 400pt,
  height: 300pt,
  title: "Characters: HP vs AC (bubble size = gold)",
  x-label: "Hit Points",
  y-label: "Armor Class",
  min-radius: 8pt,
  max-radius: 35pt,
  show-labels: true,
  labels: analytics.bubble_data.labels,
)

#pagebreak()

== Gauges & Progress Indicators

=== Gauge Charts
#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 10pt,

  gauge-chart(
    analytics.kpi_gauges.quest_completion,
    size: 120pt,
    title: "Quest Progress",
    label: "completion",
  ),

  gauge-chart(
    analytics.kpi_gauges.party_health,
    size: 120pt,
    title: "Party Health",
    label: "average",
  ),

  gauge-chart(
    analytics.kpi_gauges.xp_progress,
    size: 120pt,
    title: "XP to Level",
    label: "progress",
  ),
)

#v(20pt)

=== Progress Bars
#grid(
  columns: (1fr, 1fr),
  column-gutter: 30pt,

  [
    ==== Horizontal Progress
    #progress-bar(75, width: 200pt, title: "Main Quest")
    #v(10pt)
    #progress-bar(45, width: 200pt, title: "Side Quests", color: rgb("#f28e2b"))
    #v(10pt)
    #progress-bar(92, width: 200pt, title: "Combat Rating", color: rgb("#e15759"))
  ],

  [
    ==== Circular Progress
    #grid(
      columns: (1fr, 1fr, 1fr),
      circular-progress(85, size: 70pt, title: "STR"),
      circular-progress(62, size: 70pt, title: "DEX", color: rgb("#f28e2b")),
      circular-progress(78, size: 70pt, title: "CON", color: rgb("#59a14f")),
    )
  ]
)

#v(20pt)

=== Multiple Progress Bars
#progress-bars(
  analytics.progress_data,
  width: 350pt,
  title: "Campaign Progress by Category",
)

#pagebreak()

== Heatmaps

=== Skill Usage Heatmap
#heatmap(
  analytics.heatmap_data,
  cell-size: 35pt,
  title: "Skill Usage by Character",
  palette: "viridis",
)

#v(30pt)

=== Correlation Matrix
#correlation-matrix(
  analytics.correlation_data,
  cell-size: 40pt,
  title: "Stat Correlations",
)

#pagebreak()

=== Activity Calendar Heatmap
#calendar-heatmap(
  analytics.activity_data,
  cell-size: 14pt,
  title: "28-Day Activity",
  palette: "heat",
)

#v(40pt)

#align(center)[
  #text(size: 8pt, fill: gray)[
    Charts generated using Typst primitives (rect, circle, line, polygon, place) \
    No external dependencies required
  ]
]
