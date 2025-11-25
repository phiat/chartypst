// chart-line.typ - Line charts (single and multi-series)
#import "chart-common.typ": *

// Single line chart
#let line-chart(
  data,
  width: 300pt,
  height: 200pt,
  title: none,
  show-points: true,
  show-values: false,
  line-width: 1.5pt,
  point-size: 4pt,
  fill-area: false,
) = {
  let norm = normalize-data(data)
  let labels = norm.labels
  let values = norm.values

  let max-val = calc.max(..values)
  let min-val = calc.min(..values)
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

    #box(width: width, height: chart-height)[
      #place(left + top, line(start: (40pt, 0pt), end: (40pt, chart-height), stroke: 0.5pt))
      #place(left + bottom, line(start: (40pt, 0pt), end: (width, 0pt), stroke: 0.5pt))

      #let points = ()
      #for (i, val) in values.enumerate() {
        let x = 45pt + (i / (n - 1)) * (chart-width - 10pt)
        let y = chart-height - ((val - min-val) / val-range) * (chart-height - 20pt) - 10pt
        points.push((x, y))
      }

      #for i in array.range(n - 1) {
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

      #if show-points {
        for (i, pt) in points.enumerate() {
          place(
            left + top,
            dx: pt.at(0) - point-size / 2,
            dy: pt.at(1) - point-size / 2,
            circle(radius: point-size / 2, fill: get-color(0), stroke: white + 1pt)
          )

          if show-values {
            place(
              left + top,
              dx: pt.at(0) - 10pt,
              dy: pt.at(1) - 15pt,
              text(size: 7pt)[#values.at(i)]
            )
          }
        }
      }

      #for (i, lbl) in labels.enumerate() {
        let x = 45pt + (i / (n - 1)) * (chart-width - 10pt)
        place(
          left + bottom,
          dx: x - 15pt,
          dy: 10pt,
          text(size: 7pt)[#lbl]
        )
      }

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

// Multi-series line chart
#let multi-line-chart(
  data,
  width: 300pt,
  height: 200pt,
  title: none,
  show-points: true,
  show-legend: true,
) = {
  let labels = data.labels
  let series = data.series

  let all-values = series.map(s => s.values).flatten()
  let max-val = calc.max(..all-values)
  let min-val = calc.min(..all-values)
  let val-range = max-val - min-val
  if val-range == 0 { val-range = 1 }

  let n = labels.len()

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

      #for (si, s) in series.enumerate() {
        let values = s.values
        let color = get-color(si)

        let points = ()
        for (i, val) in values.enumerate() {
          let x = 45pt + (i / (n - 1)) * (chart-width - 10pt)
          let y = chart-height - ((val - min-val) / val-range) * (chart-height - 20pt) - 10pt
          points.push((x, y))
        }

        for i in array.range(n - 1) {
          let p1 = points.at(i)
          let p2 = points.at(i + 1)
          place(
            left + top,
            line(
              start: (p1.at(0), p1.at(1)),
              end: (p2.at(0), p2.at(1)),
              stroke: 1.5pt + color,
            )
          )
        }

        if show-points {
          for pt in points {
            place(
              left + top,
              dx: pt.at(0) - 3pt,
              dy: pt.at(1) - 3pt,
              circle(radius: 3pt, fill: color, stroke: white + 0.5pt)
            )
          }
        }
      }

      #for (i, lbl) in labels.enumerate() {
        let x = 45pt + (i / (n - 1)) * (chart-width - 10pt)
        place(
          left + bottom,
          dx: x - 15pt,
          dy: 10pt,
          text(size: 7pt)[#lbl]
        )
      }

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

    #if show-legend {
      v(5pt)
      align(center)[
        #for (i, s) in series.enumerate() {
          box(inset: 3pt)[
            #box(width: 15pt, height: 2pt, fill: get-color(i), baseline: -2pt)
            #h(3pt)
            #text(size: 8pt)[#s.name]
          ]
          h(10pt)
        }
      ]
    }
  ]
}
