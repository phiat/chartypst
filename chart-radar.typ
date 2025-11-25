// chart-radar.typ - Radar/spider charts
#import "chart-common.typ": *

#let radar-chart(
  data,
  size: 200pt,
  title: none,
  show-legend: true,
  show-value-labels: true,
  fill-opacity: 30%,
) = {
  let labels = data.labels
  let series = data.series
  let n = labels.len()
  let radius = size / 2 - 30pt  // More padding for labels
  let cx = size / 2

  // Find max value across all series
  let all-values = series.map(s => s.values).flatten()
  let max-val = calc.max(..all-values)

  // Calculate legend width
  let legend-width = if show-legend and series.len() > 1 { 100pt } else { 0pt }

  box(width: size + legend-width, height: size + 40pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #grid(
      columns: if legend-width > 0pt { (size, legend-width) } else { (size,) },

      // Radar chart
      box(width: size, height: size)[
        // Draw grid polygons with value labels
        #for level in array.range(1, 5) {
          let r = radius * level / 4
          let pts = ()
          for i in array.range(n) {
            let angle = -90deg + (i / n) * 360deg
            pts.push((
              cx + r * calc.cos(angle),
              cx + r * calc.sin(angle)
            ))
          }
          pts.push(pts.at(0))

          place(
            left + top,
            polygon(
              fill: none,
              stroke: luma(200) + 0.5pt,
              ..pts.map(p => (p.at(0), p.at(1)))
            )
          )

          // Value label on first axis (top)
          if show-value-labels {
            let val = calc.round(max-val * level / 4, digits: 0)
            place(
              left + top,
              dx: cx + 3pt,
              dy: cx - r - 4pt,
              text(size: 6pt, fill: gray)[#val]
            )
          }
        }

        // Draw axis lines and labels
        #for (i, lbl) in labels.enumerate() {
          let angle = -90deg + (i / n) * 360deg
          let x-end = cx + radius * calc.cos(angle)
          let y-end = cx + radius * calc.sin(angle)

          // Axis line
          place(
            left + top,
            line(
              start: (cx, cx),
              end: (x-end, y-end),
              stroke: luma(180) + 0.5pt
            )
          )

          // Label positioning - push labels outward based on angle
          let label-dist = radius + 18pt
          let lx = cx + label-dist * calc.cos(angle)
          let ly = cx + label-dist * calc.sin(angle)

          // Adjust text anchor based on position
          let anchor-x = if calc.cos(angle) < -0.1 { -35pt }
                         else if calc.cos(angle) > 0.1 { -5pt }
                         else { -20pt }
          let anchor-y = if calc.sin(angle) < -0.1 { -2pt }
                         else if calc.sin(angle) > 0.1 { -10pt }
                         else { -6pt }

          place(
            left + top,
            dx: lx + anchor-x,
            dy: ly + anchor-y,
            text(size: 8pt, weight: "medium")[#lbl]
          )
        }

        // Draw data series
        #for (si, s) in series.enumerate() {
          let pts = ()
          for (i, val) in s.values.enumerate() {
            let angle = -90deg + (i / n) * 360deg
            let r = (val / max-val) * radius
            pts.push((
              cx + r * calc.cos(angle),
              cx + r * calc.sin(angle)
            ))
          }

          let color = get-color(si)

          // Filled area
          place(
            left + top,
            polygon(
              fill: color.transparentize(100% - fill-opacity),
              stroke: color + 2pt,
              ..pts.map(p => (p.at(0), p.at(1)))
            )
          )

          // Points with value labels
          for (i, pt) in pts.enumerate() {
            place(
              left + top,
              dx: pt.at(0) - 4pt,
              dy: pt.at(1) - 4pt,
              circle(radius: 4pt, fill: color, stroke: white + 1pt)
            )

            // Show value near point (offset based on angle to avoid overlap)
            if show-value-labels and series.len() == 1 {
              let angle = -90deg + (i / n) * 360deg
              let offset-x = 8pt * calc.cos(angle)
              let offset-y = 8pt * calc.sin(angle)
              place(
                left + top,
                dx: pt.at(0) + offset-x - 8pt,
                dy: pt.at(1) + offset-y - 5pt,
                text(size: 7pt, fill: color, weight: "bold")[#s.values.at(i)]
              )
            }
          }
        }
      ],

      // Legend
      if legend-width > 0pt {
        box(width: legend-width)[
          #v(20pt)
          #for (i, s) in series.enumerate() {
            box(inset: (x: 5pt, y: 3pt))[
              #box(width: 12pt, height: 12pt, fill: get-color(i), baseline: 2pt, radius: 2pt)
              #h(6pt)
              #text(size: 8pt)[#s.name]
            ]
            linebreak()
          }
        ]
      }
    )
  ]
}
