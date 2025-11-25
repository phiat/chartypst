// chart-pie.typ - Pie and donut charts
#import "chart-common.typ": *

#let pie-chart(
  data,
  size: 150pt,
  title: none,
  show-legend: true,
  show-percentages: true,
  donut: false,
  donut-ratio: 0.5,
) = {
  let norm = normalize-data(data)
  let labels = norm.labels
  let values = norm.values

  let total = values.sum()
  let n = values.len()
  let radius = size / 2

  // Calculate legend width based on longest label
  let legend-width = 130pt

  // Total width: pie + gap + legend (if shown)
  let total-width = size + (if show-legend { 20pt + legend-width } else { 0pt })

  box(width: total-width, height: size + 40pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    // Use a grid layout to keep pie and legend separate
    #grid(
      columns: if show-legend { (size, legend-width) } else { (size,) },
      column-gutter: 20pt,

      // Pie chart
      box(width: size, height: size)[
        #let center-x = radius
        #let center-y = radius
        #let current-angle = 0deg

        #for (i, val) in values.enumerate() {
          let slice-angle = (val / total) * 360deg
          let segments = calc.max(int(slice-angle.deg() / 3), 3)

          let pts = ((center-x, center-y),)
          for j in array.range(segments + 1) {
            let angle = current-angle + (j / segments) * slice-angle
            let x = center-x + radius * calc.cos(angle)
            let y = center-y + radius * calc.sin(angle)
            pts.push((x, y))
          }

          place(
            left + top,
            polygon(
              fill: get-color(i),
              stroke: white + 1pt,
              ..pts.map(p => (p.at(0), p.at(1)))
            )
          )

          // Percentage label
          if show-percentages {
            let mid-angle = current-angle + slice-angle / 2
            let pct = calc.round((val / total) * 100, digits: 1)
            // Only show percentage if slice is big enough
            if pct >= 5 {
              let label-dist = radius * (if donut { 0.75 } else { 0.6 })
              let lx = center-x + label-dist * calc.cos(mid-angle) - 12pt
              let ly = center-y + label-dist * calc.sin(mid-angle) - 6pt
              place(
                left + top,
                dx: lx,
                dy: ly,
                text(size: 8pt, fill: white, weight: "bold")[#pct%]
              )
            }
          }

          current-angle = current-angle + slice-angle
        }

        // Donut hole
        #if donut {
          place(
            left + top,
            dx: center-x - radius * donut-ratio,
            dy: center-y - radius * donut-ratio,
            circle(radius: radius * donut-ratio, fill: white, stroke: none)
          )
        }
      ],

      // Legend (if shown)
      if show-legend {
        box(width: legend-width)[
          #v(10pt)
          #for (i, lbl) in labels.enumerate() {
            let pct = calc.round((values.at(i) / total) * 100, digits: 1)
            box(inset: (x: 0pt, y: 2pt))[
              #box(width: 12pt, height: 12pt, fill: get-color(i), baseline: 2pt, radius: 2pt)
              #h(6pt)
              #text(size: 8pt)[#lbl (#pct%)]
            ]
            linebreak()
          }
        ]
      }
    )
  ]
}
