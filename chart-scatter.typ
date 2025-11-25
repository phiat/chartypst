// chart-scatter.typ - Scatter plot and bubble chart
#import "chart-common.typ": *

// Scatter plot
#let scatter-plot(
  data,  // array of (x, y) points or dict with x, y arrays
  width: 300pt,
  height: 250pt,
  title: none,
  x-label: none,
  y-label: none,
  point-size: 5pt,
  show-grid: true,
  color: none,
) = {
  // Normalize data format
  let points = if type(data) == dictionary {
    data.x.zip(data.y)
  } else {
    data
  }

  let x-vals = points.map(p => p.at(0))
  let y-vals = points.map(p => p.at(1))

  let x-min = calc.min(..x-vals)
  let x-max = calc.max(..x-vals)
  let y-min = calc.min(..y-vals)
  let y-max = calc.max(..y-vals)

  // Add padding to ranges
  let x-range = x-max - x-min
  let y-range = y-max - y-min
  if x-range == 0 { x-range = 1 }
  if y-range == 0 { y-range = 1 }

  let point-color = if color != none { color } else { get-color(0) }

  box(width: width, height: height + 30pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #let chart-height = height - 30pt
    #let chart-width = width - 60pt
    #let x-start = 50pt
    #let y-start = 10pt

    #box(width: width, height: chart-height + 20pt)[
      // Grid lines
      #if show-grid {
        for i in array.range(5) {
          // Horizontal grid
          let y-pos = y-start + (i / 4) * chart-height
          place(
            left + top,
            line(
              start: (x-start, y-pos),
              end: (x-start + chart-width, y-pos),
              stroke: luma(230) + 0.5pt
            )
          )
          // Vertical grid
          let x-pos = x-start + (i / 4) * chart-width
          place(
            left + top,
            line(
              start: (x-pos, y-start),
              end: (x-pos, y-start + chart-height),
              stroke: luma(230) + 0.5pt
            )
          )
        }
      }

      // Axes
      #place(left + top, line(start: (x-start, y-start), end: (x-start, y-start + chart-height), stroke: 0.5pt))
      #place(left + top, line(start: (x-start, y-start + chart-height), end: (x-start + chart-width, y-start + chart-height), stroke: 0.5pt))

      // Plot points
      #for pt in points {
        let px = x-start + ((pt.at(0) - x-min) / x-range) * chart-width
        let py = y-start + chart-height - ((pt.at(1) - y-min) / y-range) * chart-height

        place(
          left + top,
          dx: px - point-size / 2,
          dy: py - point-size / 2,
          circle(radius: point-size / 2, fill: point-color, stroke: white + 0.5pt)
        )
      }

      // X-axis labels
      #for i in array.range(5) {
        let x-val = calc.round(x-min + x-range * i / 4, digits: 1)
        let x-pos = x-start + (i / 4) * chart-width
        place(
          left + top,
          dx: x-pos - 12pt,
          dy: y-start + chart-height + 8pt,
          text(size: 7pt)[#x-val]
        )
      }

      // Y-axis labels
      #for i in array.range(5) {
        let y-val = calc.round(y-min + y-range * i / 4, digits: 1)
        let y-pos = y-start + chart-height - (i / 4) * chart-height
        place(
          left + top,
          dx: 5pt,
          dy: y-pos - 5pt,
          text(size: 7pt)[#y-val]
        )
      }

      // Axis labels
      #if x-label != none {
        place(
          left + bottom,
          dx: x-start + chart-width / 2 - 20pt,
          dy: -5pt,
          text(size: 8pt)[#x-label]
        )
      }

      #if y-label != none {
        place(
          left + top,
          dx: -5pt,
          dy: y-start + chart-height / 2,
          rotate(-90deg, text(size: 8pt)[#y-label])
        )
      }
    ]
  ]
}

// Multi-series scatter plot
#let multi-scatter-plot(
  data,  // dict with series array of {name, points: [(x,y), ...]}
  width: 300pt,
  height: 250pt,
  title: none,
  x-label: none,
  y-label: none,
  point-size: 5pt,
  show-grid: true,
  show-legend: true,
) = {
  let series = data.series

  // Get all points to find ranges
  let all-points = series.map(s => s.points).flatten()
  let x-vals = ()
  let y-vals = ()
  for s in series {
    for pt in s.points {
      x-vals.push(pt.at(0))
      y-vals.push(pt.at(1))
    }
  }

  let x-min = calc.min(..x-vals)
  let x-max = calc.max(..x-vals)
  let y-min = calc.min(..y-vals)
  let y-max = calc.max(..y-vals)

  let x-range = x-max - x-min
  let y-range = y-max - y-min
  if x-range == 0 { x-range = 1 }
  if y-range == 0 { y-range = 1 }

  box(width: width, height: height + 50pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #let chart-height = height - 30pt
    #let chart-width = width - 60pt
    #let x-start = 50pt
    #let y-start = 10pt

    #box(width: width, height: chart-height + 20pt)[
      // Grid lines
      #if show-grid {
        for i in array.range(5) {
          let y-pos = y-start + (i / 4) * chart-height
          place(left + top, line(start: (x-start, y-pos), end: (x-start + chart-width, y-pos), stroke: luma(230) + 0.5pt))
          let x-pos = x-start + (i / 4) * chart-width
          place(left + top, line(start: (x-pos, y-start), end: (x-pos, y-start + chart-height), stroke: luma(230) + 0.5pt))
        }
      }

      // Axes
      #place(left + top, line(start: (x-start, y-start), end: (x-start, y-start + chart-height), stroke: 0.5pt))
      #place(left + top, line(start: (x-start, y-start + chart-height), end: (x-start + chart-width, y-start + chart-height), stroke: 0.5pt))

      // Plot points for each series
      #for (si, s) in series.enumerate() {
        let color = get-color(si)
        for pt in s.points {
          let px = x-start + ((pt.at(0) - x-min) / x-range) * chart-width
          let py = y-start + chart-height - ((pt.at(1) - y-min) / y-range) * chart-height

          place(
            left + top,
            dx: px - point-size / 2,
            dy: py - point-size / 2,
            circle(radius: point-size / 2, fill: color, stroke: white + 0.5pt)
          )
        }
      }

      // X-axis labels
      #for i in array.range(5) {
        let x-val = calc.round(x-min + x-range * i / 4, digits: 1)
        let x-pos = x-start + (i / 4) * chart-width
        place(left + top, dx: x-pos - 12pt, dy: y-start + chart-height + 8pt, text(size: 7pt)[#x-val])
      }

      // Y-axis labels
      #for i in array.range(5) {
        let y-val = calc.round(y-min + y-range * i / 4, digits: 1)
        let y-pos = y-start + chart-height - (i / 4) * chart-height
        place(left + top, dx: 5pt, dy: y-pos - 5pt, text(size: 7pt)[#y-val])
      }
    ]

    // Legend
    #if show-legend {
      v(5pt)
      align(center)[
        #for (i, s) in series.enumerate() {
          box(inset: 3pt)[
            #circle(radius: 5pt, fill: get-color(i), stroke: white + 0.5pt)
            #h(3pt)
            #text(size: 8pt)[#s.name]
          ]
          h(10pt)
        }
      ]
    }
  ]
}

// Bubble chart
#let bubble-chart(
  data,  // array of (x, y, size) or dict with x, y, size arrays
  width: 300pt,
  height: 250pt,
  title: none,
  x-label: none,
  y-label: none,
  min-radius: 5pt,
  max-radius: 30pt,
  show-grid: true,
  color: none,
  show-labels: false,
  labels: none,
) = {
  // Normalize data format
  let points = if type(data) == dictionary {
    let zipped = data.x.zip(data.y).zip(data.size)
    zipped.map(p => (p.at(0).at(0), p.at(0).at(1), p.at(1)))
  } else {
    data
  }

  let x-vals = points.map(p => p.at(0))
  let y-vals = points.map(p => p.at(1))
  let size-vals = points.map(p => p.at(2))

  let x-min = calc.min(..x-vals)
  let x-max = calc.max(..x-vals)
  let y-min = calc.min(..y-vals)
  let y-max = calc.max(..y-vals)
  let size-min = calc.min(..size-vals)
  let size-max = calc.max(..size-vals)

  let x-range = x-max - x-min
  let y-range = y-max - y-min
  let size-range = size-max - size-min
  if x-range == 0 { x-range = 1 }
  if y-range == 0 { y-range = 1 }
  if size-range == 0 { size-range = 1 }

  let bubble-color = if color != none { color } else { get-color(0) }

  box(width: width, height: height + 30pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #let chart-height = height - 30pt
    #let chart-width = width - 60pt
    #let x-start = 50pt
    #let y-start = 10pt

    #box(width: width, height: chart-height + 20pt)[
      // Grid lines
      #if show-grid {
        for i in array.range(5) {
          let y-pos = y-start + (i / 4) * chart-height
          place(left + top, line(start: (x-start, y-pos), end: (x-start + chart-width, y-pos), stroke: luma(230) + 0.5pt))
          let x-pos = x-start + (i / 4) * chart-width
          place(left + top, line(start: (x-pos, y-start), end: (x-pos, y-start + chart-height), stroke: luma(230) + 0.5pt))
        }
      }

      // Axes
      #place(left + top, line(start: (x-start, y-start), end: (x-start, y-start + chart-height), stroke: 0.5pt))
      #place(left + top, line(start: (x-start, y-start + chart-height), end: (x-start + chart-width, y-start + chart-height), stroke: 0.5pt))

      // Plot bubbles
      #for (i, pt) in points.enumerate() {
        let px = x-start + ((pt.at(0) - x-min) / x-range) * chart-width
        let py = y-start + chart-height - ((pt.at(1) - y-min) / y-range) * chart-height
        let radius = min-radius + ((pt.at(2) - size-min) / size-range) * (max-radius - min-radius)

        place(
          left + top,
          dx: px - radius,
          dy: py - radius,
          circle(
            radius: radius,
            fill: bubble-color.transparentize(40%),
            stroke: bubble-color + 1.5pt
          )
        )

        // Optional label
        if show-labels and labels != none and i < labels.len() {
          place(
            left + top,
            dx: px - 15pt,
            dy: py - 5pt,
            text(size: 7pt, weight: "bold")[#labels.at(i)]
          )
        }
      }

      // X-axis labels
      #for i in array.range(5) {
        let x-val = calc.round(x-min + x-range * i / 4, digits: 1)
        let x-pos = x-start + (i / 4) * chart-width
        place(left + top, dx: x-pos - 12pt, dy: y-start + chart-height + 8pt, text(size: 7pt)[#x-val])
      }

      // Y-axis labels
      #for i in array.range(5) {
        let y-val = calc.round(y-min + y-range * i / 4, digits: 1)
        let y-pos = y-start + chart-height - (i / 4) * chart-height
        place(left + top, dx: 5pt, dy: y-pos - 5pt, text(size: 7pt)[#y-val])
      }

      // Axis labels
      #if x-label != none {
        place(left + bottom, dx: x-start + chart-width / 2 - 20pt, dy: -5pt, text(size: 8pt)[#x-label])
      }
    ]
  ]
}
