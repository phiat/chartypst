// chart-area.typ - Area charts (single and stacked)
#import "chart-common.typ": *

// Single area chart
#let area-chart(
  data,
  width: 300pt,
  height: 200pt,
  title: none,
  show-line: true,
  show-points: false,
  fill-opacity: 40%,
  line-width: 1.5pt,
) = {
  let norm = normalize-data(data)
  let labels = norm.labels
  let values = norm.values

  let max-val = calc.max(..values)
  let min-val = calc.min(0, ..values)  // Include 0 for area charts
  let val-range = max-val - min-val
  if val-range == 0 { val-range = 1 }

  let n = values.len()

  box(width: width, height: height + 30pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #let chart-height = height - 20pt
    #let chart-width = width - 50pt
    #let x-start = 45pt

    #box(width: width, height: chart-height)[
      // Axes
      #place(left + top, line(start: (40pt, 0pt), end: (40pt, chart-height), stroke: 0.5pt))
      #place(left + bottom, line(start: (40pt, 0pt), end: (width, 0pt), stroke: 0.5pt))

      // Calculate points
      #let points = ()
      #for (i, val) in values.enumerate() {
        let x = x-start + (i / (n - 1)) * (chart-width - 10pt)
        let y = chart-height - ((val - min-val) / val-range) * (chart-height - 20pt) - 10pt
        points.push((x, y))
      }

      // Build polygon for filled area (include baseline)
      #let baseline-y = chart-height - ((0 - min-val) / val-range) * (chart-height - 20pt) - 10pt
      #let area-pts = ()
      // Start at baseline
      area-pts.push((points.at(0).at(0), baseline-y))
      // Add all data points
      for pt in points {
        area-pts.push(pt)
      }
      // End at baseline
      area-pts.push((points.at(n - 1).at(0), baseline-y))

      // Draw filled area
      #place(
        left + top,
        polygon(
          fill: get-color(0).transparentize(100% - fill-opacity),
          stroke: none,
          ..area-pts.map(p => (p.at(0), p.at(1)))
        )
      )

      // Draw line on top
      #if show-line {
        for i in array.range(n - 1) {
          let p1 = points.at(i)
          let p2 = points.at(i + 1)
          place(
            left + top,
            line(
              start: (p1.at(0), p1.at(1)),
              end: (p2.at(0), p2.at(1)),
              stroke: line-width + get-color(0),
            )
          )
        }
      }

      // Draw points
      #if show-points {
        for pt in points {
          place(
            left + top,
            dx: pt.at(0) - 3pt,
            dy: pt.at(1) - 3pt,
            circle(radius: 3pt, fill: get-color(0), stroke: white + 1pt)
          )
        }
      }

      // X-axis labels
      #for (i, lbl) in labels.enumerate() {
        let x = x-start + (i / (n - 1)) * (chart-width - 10pt)
        place(
          left + bottom,
          dx: x - 15pt,
          dy: 10pt,
          text(size: 7pt)[#lbl]
        )
      }

      // Y-axis labels
      #for i in array.range(5) {
        let y-val = calc.round(min-val + val-range * i / 4, digits: 1)
        let y-pos = chart-height - (i / 4) * (chart-height - 20pt) - 10pt
        place(
          left + top,
          dx: 5pt,
          dy: y-pos - 5pt,
          text(size: 7pt)[#y-val]
        )
      }
    ]
  ]
}

// Stacked area chart
#let stacked-area-chart(
  data,
  width: 350pt,
  height: 200pt,
  title: none,
  show-lines: true,
  fill-opacity: 70%,
  show-legend: true,
) = {
  let labels = data.labels
  let series = data.series
  let n = labels.len()
  let n-series = series.len()

  // Calculate cumulative values for stacking
  let cumulative = ()
  for i in array.range(n) {
    let cum = ()
    let running = 0
    for s in series {
      running = running + s.values.at(i)
      cum.push(running)
    }
    cumulative.push(cum)
  }

  let max-val = calc.max(..cumulative.map(c => c.at(n-series - 1)))

  box(width: width, height: height + 50pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #let chart-height = height - 20pt
    #let chart-width = width - 50pt
    #let x-start = 45pt

    #box(width: width, height: chart-height)[
      // Axes
      #place(left + top, line(start: (40pt, 0pt), end: (40pt, chart-height), stroke: 0.5pt))
      #place(left + bottom, line(start: (40pt, 0pt), end: (width, 0pt), stroke: 0.5pt))

      // Draw areas from top to bottom (reverse order so bottom series is on top visually)
      #for si in array.range(n-series - 1, -1, step: -1) {
        let color = get-color(si)

        // Build polygon points
        let area-pts = ()

        // Top edge (current cumulative)
        for i in array.range(n) {
          let x = x-start + (i / (n - 1)) * (chart-width - 10pt)
          let y = chart-height - (cumulative.at(i).at(si) / max-val) * (chart-height - 20pt) - 10pt
          area-pts.push((x, y))
        }

        // Bottom edge (previous cumulative or baseline)
        for i in array.range(n - 1, -1, step: -1) {
          let x = x-start + (i / (n - 1)) * (chart-width - 10pt)
          let y = if si == 0 {
            chart-height - 10pt  // baseline
          } else {
            chart-height - (cumulative.at(i).at(si - 1) / max-val) * (chart-height - 20pt) - 10pt
          }
          area-pts.push((x, y))
        }

        place(
          left + top,
          polygon(
            fill: color.transparentize(100% - fill-opacity),
            stroke: if show-lines { color + 1pt } else { none },
            ..area-pts.map(p => (p.at(0), p.at(1)))
          )
        )
      }

      // X-axis labels
      #for (i, lbl) in labels.enumerate() {
        let x = x-start + (i / (n - 1)) * (chart-width - 10pt)
        place(
          left + bottom,
          dx: x - 15pt,
          dy: 10pt,
          text(size: 7pt)[#lbl]
        )
      }

      // Y-axis labels
      #for i in array.range(5) {
        let y-val = calc.round(max-val * i / 4, digits: 0)
        let y-pos = chart-height - (i / 4) * (chart-height - 20pt) - 10pt
        place(
          left + top,
          dx: 5pt,
          dy: y-pos - 5pt,
          text(size: 7pt)[#y-val]
        )
      }
    ]

    // Legend
    #if show-legend {
      v(5pt)
      align(center)[
        #for (i, s) in series.enumerate() {
          box(inset: 3pt)[
            #box(width: 12pt, height: 12pt, fill: get-color(i), baseline: 2pt, radius: 2pt)
            #h(3pt)
            #text(size: 8pt)[#s.name]
          ]
          h(10pt)
        }
      ]
    }
  ]
}
