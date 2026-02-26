// Compact showcase — All chart types on 2 pages
// Data themed around Linux kernel subsystems
#import "../src/lib.typ": *

#set page(margin: (x: 0.6cm, y: 0.6cm), paper: "a4")
#set text(size: 7pt)

// ── Page 1: Core chart types ──────────────────────────────────────────────────

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  row-gutter: 6pt,

  // Bar chart — commits per subsystem
  bar-chart(
    (labels: ("net", "fs", "drivers", "mm", "arch", "kernel"),
     values: (4820, 3150, 8930, 2710, 2340, 1890)),
    width: 250pt, height: 110pt,
    title: "Commits by Subsystem (v6.x)",
  ),

  // Horizontal bar — maintainer count
  horizontal-bar-chart(
    (labels: ("drivers", "net", "fs", "arch", "sound", "crypto"),
     values: (312, 187, 145, 98, 67, 42)),
    width: 250pt, height: 110pt,
    title: "Active Maintainers",
  ),

  // Grouped bar — patch activity by quarter
  grouped-bar-chart(
    (labels: ("Q1", "Q2", "Q3", "Q4"),
     series: (
       (name: "net", values: (1240, 1380, 1150, 1050)),
       (name: "fs", values: (780, 820, 910, 640)),
       (name: "mm", values: (620, 710, 680, 700)),
     )),
    width: 250pt, height: 110pt,
    title: "Quarterly Patch Volume",
  ),

  // Stacked bar — bug categories
  stacked-bar-chart(
    (labels: ("6.1", "6.2", "6.3", "6.4", "6.5"),
     series: (
       (name: "Memory", values: (42, 38, 35, 31, 28)),
       (name: "Concurrency", values: (28, 32, 25, 22, 19)),
       (name: "Logic", values: (55, 48, 52, 45, 40)),
     )),
    width: 250pt, height: 110pt,
    title: "Bug Reports by Type",
  ),

  // Line chart — kernel binary size over releases
  line-chart(
    (labels: ("5.15", "5.19", "6.1", "6.3", "6.5", "6.7", "6.9"),
     values: (11.2, 11.8, 12.1, 12.5, 12.9, 13.2, 13.6)),
    width: 250pt, height: 105pt,
    title: "vmlinux Size (MB)",
    show-points: true,
  ),

  // Multi-line — build time by config
  multi-line-chart(
    (labels: ("5.15", "6.0", "6.3", "6.6", "6.9"),
     series: (
       (name: "defconfig", values: (85, 92, 98, 105, 112)),
       (name: "allmodconfig", values: (340, 365, 390, 420, 445)),
       (name: "tinyconfig", values: (18, 19, 20, 21, 22)),
     )),
    width: 250pt, height: 105pt,
    title: "Build Time (sec)",
  ),

  // Area chart — LoC growth
  area-chart(
    (labels: ("5.0", "5.5", "5.10", "5.15", "6.0", "6.5", "6.9"),
     values: (26.1, 27.8, 29.2, 30.5, 31.4, 33.1, 35.2)),
    width: 250pt, height: 105pt,
    title: "Lines of Code (millions)",
    fill-opacity: 40%,
  ),

  // Stacked area — contributor types
  stacked-area-chart(
    (labels: ("2020", "2021", "2022", "2023", "2024"),
     series: (
       (name: "Corporate", values: (1850, 1920, 2050, 2180, 2310)),
       (name: "Independent", values: (620, 580, 550, 510, 480)),
       (name: "Academic", values: (180, 195, 210, 230, 250)),
     )),
    width: 250pt, height: 105pt,
    title: "Contributors by Type",
  ),
)

#pagebreak()

// ── Page 2: Specialized charts + themes ───────────────────────────────────────

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  row-gutter: 6pt,

  // Pie — subsystem LoC share
  pie-chart(
    (labels: ("drivers", "arch", "fs", "net", "sound", "other"),
     values: (42, 16, 12, 10, 5, 15)),
    size: 95pt,
    title: "Code Share by Subsystem (%)",
  ),

  // Radar — subsystem health scores
  radar-chart(
    (labels: ("Test Cov", "Doc", "Review", "Latency", "Churn", "Bugs"),
     series: (
       (name: "net", values: (85, 70, 92, 78, 65, 80)),
       (name: "mm", values: (72, 55, 88, 90, 45, 70)),
     )),
    size: 130pt,
    title: "Subsystem Health",
    fill-opacity: 25%,
  ),

  // Scatter — complexity vs bugs
  scatter-plot(
    (x: (12, 28, 45, 8, 35, 18, 52),
     y: (3, 12, 22, 2, 18, 8, 28)),
    width: 250pt, height: 110pt,
    title: "Cyclomatic Complexity vs Bugs",
    x-label: "Avg Complexity",
    y-label: "Bug Count",
    annotations: (
      (type: "h-line", value: 15, label: "Threshold", color: rgb("#e15759"), dash: "dashed"),
    ),
  ),

  // Gauge + progress — kernel health dashboard
  [
    #text(size: 8pt, weight: "bold")[Kernel CI Dashboard]
    #v(2pt)
    #grid(
      columns: (1fr, 1fr, 1fr),
      gauge-chart(78, size: 60pt, title: "Build", label: "pass"),
      gauge-chart(94, size: 60pt, title: "Boot", label: "pass"),
      gauge-chart(61, size: 60pt, title: "Perf", label: "score"),
    )
    #v(2pt)
    #progress-bar(87, width: 250pt, title: "Test Suite Coverage")
  ],

  // Waterfall — patch lifecycle
  waterfall-chart(
    (labels: ("Submitted", "+Reviewed", "+Tested", "-NAKed", "-Dropped", "Merged"),
     values: (1200, 350, 180, -280, -150, 1300)),
    width: 250pt, height: 115pt,
    title: "Patch Lifecycle (v6.8-rc1)",
  ),

  // Funnel — patch review pipeline
  funnel-chart(
    (labels: ("Submitted", "Reviewed", "Acked", "Applied", "Released"),
     values: (5000, 3200, 2100, 1800, 1650)),
    width: 250pt, height: 130pt,
    title: "Patch Review Pipeline",
  ),

  // Box plot — latency by scheduler
  box-plot(
    (labels: ("CFS", "EEVDF", "BPF", "RT"),
     boxes: (
       (min: 5, q1: 12, median: 18, q3: 28, max: 45),
       (min: 3, q1: 8, median: 14, q3: 22, max: 38),
       (min: 2, q1: 6, median: 11, q3: 18, max: 30),
       (min: 1, q1: 3, median: 5, q3: 8, max: 15),
     )),
    width: 250pt, height: 115pt,
    title: "Schedule Latency (μs)",
    show-grid: true,
  ),

  // Heatmap — subsystem activity by day
  heatmap(
    (rows: ("net", "fs", "mm", "drv"),
     cols: ("Mon", "Tue", "Wed", "Thu", "Fri"),
     values: (
       (82, 95, 78, 88, 65),
       (45, 52, 68, 71, 38),
       (33, 41, 55, 48, 29),
       (91, 87, 93, 85, 72),
     )),
    cell-size: 22pt,
    title: "Commit Activity by Day",
    palette: "viridis",
  ),
)

// Sparkline row at bottom
#v(4pt)
#table(
  columns: (auto, auto, auto, auto, auto),
  align: (left, center, center, center, right),
  inset: 3pt,
  [*Subsystem*], [*Commits*], [*Churn*], [*Bugs*], [*Trend*],
  [networking], [#sparkline((45, 52, 48, 61, 58, 72, 68), color: rgb("#4e79a7"), width: 50pt, height: 12pt)], [#sparkbar((8, 12, 9, 15, 11, 18, 14), color: rgb("#f28e2b"), width: 50pt, height: 12pt)], [#sparkdot((5, 3, 4, 2, 3, 1, 2), color: rgb("#e15759"), width: 50pt, height: 12pt)], [↑ 12%],
  [memory], [#sparkline((32, 28, 35, 31, 38, 42, 40), color: rgb("#4e79a7"), width: 50pt, height: 12pt)], [#sparkbar((6, 8, 5, 10, 7, 12, 9), color: rgb("#f28e2b"), width: 50pt, height: 12pt)], [#sparkdot((8, 6, 7, 5, 4, 3, 2), color: rgb("#59a14f"), width: 50pt, height: 12pt)], [↑ 8%],
  [filesystems], [#sparkline((22, 25, 19, 28, 24, 30, 27), color: rgb("#4e79a7"), width: 50pt, height: 12pt)], [#sparkbar((4, 6, 3, 8, 5, 9, 7), color: rgb("#f28e2b"), width: 50pt, height: 12pt)], [#sparkdot((3, 4, 2, 3, 2, 1, 1), color: rgb("#59a14f"), width: 50pt, height: 12pt)], [↑ 5%],
)
