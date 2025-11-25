// chart-bar.typ - Bar charts (simple, horizontal, grouped, stacked)
#import "chart-common.typ": *

// Horizontal bar chart
#let horizontal-bar-chart(
  data,
  width: 350pt,
  height: 200pt,
  bar-height: 0.6,
  title: none,
  show-values: true,
) = {
  let norm = normalize-data(data)
  let labels = norm.labels
  let values = norm.values

  let max-val = calc.max(..values)
  let n = values.len()

  // Calculate label width based on content
  let label-area = 80pt

  box(width: width, height: height + 30pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #let chart-height = height - 10pt
    #let chart-width = width - label-area - 30pt

    #box(width: width, height: chart-height)[
      // Y-axis
      #place(left + top, line(start: (label-area, 0pt), end: (label-area, chart-height), stroke: 0.5pt))
      // X-axis
      #place(left + bottom, line(start: (label-area, 0pt), end: (width - 10pt, 0pt), stroke: 0.5pt))

      #let spacing = chart-height / n
      #let actual-bar-height = spacing * bar-height

      #for (i, val) in values.enumerate() {
        let bar-w = (val / max-val) * chart-width
        let y-pos = i * spacing + (spacing - actual-bar-height) / 2

        // Bar
        place(
          left + top,
          dx: label-area,
          dy: y-pos,
          rect(
            width: bar-w,
            height: actual-bar-height,
            fill: get-color(i),
            stroke: none,
          )
        )

        // Value label
        if show-values {
          place(
            left + top,
            dx: label-area + bar-w + 5pt,
            dy: y-pos + actual-bar-height / 2 - 5pt,
            text(size: 8pt)[#val]
          )
        }

        // Y-axis label (category)
        place(
          left + top,
          dx: 5pt,
          dy: y-pos + actual-bar-height / 2 - 5pt,
          text(size: 7pt)[#labels.at(i)]
        )
      }

      // X-axis labels
      #for i in array.range(5) {
        let x-val = calc.round(max-val * i / 4, digits: 0)
        let x-pos = label-area + (i / 4) * chart-width
        place(
          left + bottom,
          dx: x-pos - 10pt,
          dy: 8pt,
          text(size: 7pt)[#x-val]
        )
      }
    ]
  ]
}

// Simple vertical bar chart
#let bar-chart(
  data,
  width: 300pt,
  height: 200pt,
  bar-width: 0.6,
  title: none,
  show-values: true,
  horizontal: false,
) = {
  let norm = normalize-data(data)
  let labels = norm.labels
  let values = norm.values

  let max-val = calc.max(..values)
  let n = values.len()

  box(width: width, height: height + 30pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #let chart-height = height - 20pt
    #let chart-width = width - 40pt

    #box(width: width, height: chart-height)[
      #place(left + top, line(start: (30pt, 0pt), end: (30pt, chart-height), stroke: 0.5pt))
      #place(left + bottom, line(start: (30pt, 0pt), end: (width, 0pt), stroke: 0.5pt))

      #for (i, val) in values.enumerate() {
        let bar-h = (val / max-val) * (chart-height - 10pt)
        let spacing = (chart-width) / n
        let actual-bar-width = spacing * bar-width
        let x-pos = 35pt + (i * spacing) + (spacing - actual-bar-width) / 2

        place(
          left + bottom,
          dx: x-pos,
          dy: 0pt,
          rect(
            width: actual-bar-width,
            height: bar-h,
            fill: get-color(i),
            stroke: none,
          )
        )

        if show-values {
          place(
            left + bottom,
            dx: x-pos + actual-bar-width / 2 - 8pt,
            dy: -bar-h - 12pt,
            text(size: 8pt)[#val]
          )
        }

        place(
          left + bottom,
          dx: x-pos + actual-bar-width / 2 - 15pt,
          dy: 12pt,
          text(size: 7pt)[#labels.at(i)]
        )
      }

      #for i in array.range(5) {
        let y-val = calc.round(max-val * i / 4, digits: 1)
        let y-pos = chart-height - (i / 4) * (chart-height - 10pt)
        place(
          left + top,
          dx: 0pt,
          dy: y-pos - 5pt,
          text(size: 7pt)[#y-val]
        )
      }
    ]
  ]
}

// Grouped bar chart
#let grouped-bar-chart(
  data,
  width: 350pt,
  height: 200pt,
  title: none,
  show-legend: true,
) = {
  let labels = data.labels
  let series = data.series
  let n-groups = labels.len()
  let n-series = series.len()

  let all-values = series.map(s => s.values).flatten()
  let max-val = calc.max(..all-values)

  box(width: width, height: height + 50pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #let chart-height = height - 20pt
    #let chart-width = width - 50pt

    #box(width: width, height: chart-height)[
      #place(left + top, line(start: (40pt, 0pt), end: (40pt, chart-height), stroke: 0.5pt))
      #place(left + bottom, line(start: (40pt, 0pt), end: (width, 0pt), stroke: 0.5pt))

      #let group-width = chart-width / n-groups
      #let bw = (group-width * 0.8) / n-series

      #for (gi, _) in labels.enumerate() {
        for (si, s) in series.enumerate() {
          let val = s.values.at(gi)
          let bar-h = (val / max-val) * (chart-height - 10pt)
          let x-pos = 45pt + gi * group-width + si * bw + (group-width * 0.1)

          place(
            left + bottom,
            dx: x-pos,
            rect(
              width: bw - 2pt,
              height: bar-h,
              fill: get-color(si),
              stroke: none,
            )
          )
        }

        let x-center = 45pt + gi * group-width + group-width / 2 - 15pt
        place(
          left + bottom,
          dx: x-center,
          dy: 12pt,
          text(size: 7pt)[#labels.at(gi)]
        )
      }

      #for i in array.range(5) {
        let y-val = calc.round(max-val * i / 4, digits: 1)
        let y-pos = chart-height - (i / 4) * (chart-height - 10pt)
        place(
          left + top,
          dx: 5pt,
          dy: y-pos - 5pt,
          text(size: 7pt)[#y-val]
        )
      }
    ]

    #if show-legend {
      v(5pt)
      align(center)[
        #for (i, s) in series.enumerate() {
          box(inset: 3pt)[
            #box(width: 10pt, height: 10pt, fill: get-color(i), baseline: 2pt)
            #h(3pt)
            #text(size: 8pt)[#s.name]
          ]
          h(10pt)
        }
      ]
    }
  ]
}

// Stacked bar chart
#let stacked-bar-chart(
  data,
  width: 300pt,
  height: 200pt,
  title: none,
  show-legend: true,
) = {
  let labels = data.labels
  let series = data.series
  let n = labels.len()

  let totals = ()
  for i in array.range(n) {
    let total = series.map(s => s.values.at(i)).sum()
    totals.push(total)
  }
  let max-val = calc.max(..totals)

  box(width: width, height: height + 50pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #let chart-height = height - 20pt
    #let chart-width = width - 50pt

    #box(width: width, height: chart-height)[
      #place(left + top, line(start: (40pt, 0pt), end: (40pt, chart-height), stroke: 0.5pt))
      #place(left + bottom, line(start: (40pt, 0pt), end: (width, 0pt), stroke: 0.5pt))

      #let bar-spacing = chart-width / n
      #let bw = bar-spacing * 0.6

      #for (i, _) in labels.enumerate() {
        let x-pos = 45pt + i * bar-spacing + (bar-spacing - bw) / 2
        let y-offset = 0pt

        for (si, s) in series.enumerate() {
          let val = s.values.at(i)
          let bar-h = (val / max-val) * (chart-height - 10pt)

          place(
            left + bottom,
            dx: x-pos,
            dy: -y-offset,
            rect(
              width: bw,
              height: bar-h,
              fill: get-color(si),
              stroke: white + 0.5pt,
            )
          )

          y-offset = y-offset + bar-h
        }

        place(
          left + bottom,
          dx: x-pos + bw / 2 - 15pt,
          dy: 12pt,
          text(size: 7pt)[#labels.at(i)]
        )
      }

      #for i in array.range(5) {
        let y-val = calc.round(max-val * i / 4, digits: 1)
        let y-pos = chart-height - (i / 4) * (chart-height - 10pt)
        place(
          left + top,
          dx: 5pt,
          dy: y-pos - 5pt,
          text(size: 7pt)[#y-val]
        )
      }
    ]

    #if show-legend {
      v(5pt)
      align(center)[
        #for (i, s) in series.enumerate() {
          box(inset: 3pt)[
            #box(width: 10pt, height: 10pt, fill: get-color(i), baseline: 2pt)
            #h(3pt)
            #text(size: 8pt)[#s.name]
          ]
          h(10pt)
        }
      ]
    }
  ]
}
