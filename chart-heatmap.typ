// chart-heatmap.typ - Heatmap/matrix charts
#import "chart-common.typ": *

// Color interpolation helper
#let lerp-color(c1, c2, t) = {
  // t should be 0-1
  let t-clamped = calc.max(0, calc.min(1, t))
  color.mix((c1, (1 - t-clamped) * 100%), (c2, t-clamped * 100%))
}

// Get heatmap color based on value (0-1)
#let heat-color(val, palette: "viridis") = {
  let v = calc.max(0, calc.min(1, val))

  if palette == "viridis" {
    // Purple -> Blue -> Teal -> Green -> Yellow
    if v < 0.25 {
      lerp-color(rgb("#440154"), rgb("#3b528b"), v * 4)
    } else if v < 0.5 {
      lerp-color(rgb("#3b528b"), rgb("#21918c"), (v - 0.25) * 4)
    } else if v < 0.75 {
      lerp-color(rgb("#21918c"), rgb("#5ec962"), (v - 0.5) * 4)
    } else {
      lerp-color(rgb("#5ec962"), rgb("#fde725"), (v - 0.75) * 4)
    }
  } else if palette == "heat" {
    // Blue -> Cyan -> Green -> Yellow -> Red
    if v < 0.25 {
      lerp-color(rgb("#313695"), rgb("#74add1"), v * 4)
    } else if v < 0.5 {
      lerp-color(rgb("#74add1"), rgb("#a6d96a"), (v - 0.25) * 4)
    } else if v < 0.75 {
      lerp-color(rgb("#a6d96a"), rgb("#fdae61"), (v - 0.5) * 4)
    } else {
      lerp-color(rgb("#fdae61"), rgb("#a50026"), (v - 0.75) * 4)
    }
  } else if palette == "grayscale" {
    luma(int((1 - v) * 255))
  } else {
    // Default blue gradient
    lerp-color(rgb("#f7fbff"), rgb("#08306b"), v)
  }
}

// Heatmap chart
#let heatmap(
  data,  // dict with rows (array of row labels), cols (array of col labels), values (2D array)
  cell-size: 30pt,
  title: none,
  show-values: true,
  palette: "viridis",
  show-legend: true,
) = {
  let rows = data.rows
  let cols = data.cols
  let values = data.values

  let n-rows = rows.len()
  let n-cols = cols.len()

  // Find min/max values
  let all-vals = values.flatten()
  let min-val = calc.min(..all-vals)
  let max-val = calc.max(..all-vals)
  let val-range = max-val - min-val
  if val-range == 0 { val-range = 1 }

  let row-label-width = 60pt
  let col-label-height = 40pt
  let legend-width = if show-legend { 60pt } else { 0pt }

  let grid-width = n-cols * cell-size
  let grid-height = n-rows * cell-size

  box(width: row-label-width + grid-width + legend-width + 20pt, height: col-label-height + grid-height + 40pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #box[
      // Column labels (rotated)
      #for (j, col) in cols.enumerate() {
        place(
          left + top,
          dx: row-label-width + j * cell-size + cell-size / 2 - 5pt,
          dy: 5pt,
          rotate(-45deg, origin: bottom + left, text(size: 7pt)[#col])
        )
      }

      // Grid cells and row labels
      #for (i, row) in rows.enumerate() {
        // Row label
        place(
          left + top,
          dx: 5pt,
          dy: col-label-height + i * cell-size + cell-size / 2 - 5pt,
          text(size: 7pt)[#row]
        )

        // Cells for this row
        for (j, val) in values.at(i).enumerate() {
          let normalized = (val - min-val) / val-range
          let cell-color = heat-color(normalized, palette: palette)

          place(
            left + top,
            dx: row-label-width + j * cell-size,
            dy: col-label-height + i * cell-size,
            rect(
              width: cell-size,
              height: cell-size,
              fill: cell-color,
              stroke: white + 0.5pt,
            )
          )

          // Value label
          if show-values {
            let text-color = if normalized > 0.5 { white } else { black }
            place(
              left + top,
              dx: row-label-width + j * cell-size + cell-size / 2 - 8pt,
              dy: col-label-height + i * cell-size + cell-size / 2 - 5pt,
              text(size: 7pt, fill: text-color)[#calc.round(val, digits: 1)]
            )
          }
        }
      }

      // Color legend
      #if show-legend {
        let legend-x = row-label-width + grid-width + 15pt
        let legend-height = grid-height * 0.8
        let legend-y = col-label-height + (grid-height - legend-height) / 2

        // Gradient bar
        for i in array.range(20) {
          let normalized = 1 - i / 20
          let cell-color = heat-color(normalized, palette: palette)
          place(
            left + top,
            dx: legend-x,
            dy: legend-y + (i / 20) * legend-height,
            rect(
              width: 15pt,
              height: legend-height / 20 + 1pt,
              fill: cell-color,
              stroke: none,
            )
          )
        }

        // Legend labels
        place(left + top, dx: legend-x + 20pt, dy: legend-y - 5pt, text(size: 7pt)[#calc.round(max-val, digits: 1)])
        place(left + top, dx: legend-x + 20pt, dy: legend-y + legend-height - 5pt, text(size: 7pt)[#calc.round(min-val, digits: 1)])
      }
    ]
  ]
}

// Calendar heatmap (like GitHub contribution graph)
#let calendar-heatmap(
  data,  // dict with dates (array of "YYYY-MM-DD") and values (array of numbers)
  cell-size: 12pt,
  title: none,
  palette: "heat",
  show-month-labels: true,
  show-day-labels: true,
) = {
  let dates = data.dates
  let values = data.values
  let n = dates.len()

  // Find min/max
  let min-val = calc.min(..values)
  let max-val = calc.max(..values)
  let val-range = max-val - min-val
  if val-range == 0 { val-range = 1 }

  // Assume dates are in order and calculate grid
  // For simplicity, we'll arrange in a 7-row (days of week) grid
  let n-weeks = calc.ceil(n / 7)

  let day-label-width = if show-day-labels { 25pt } else { 0pt }
  let month-label-height = if show-month-labels { 20pt } else { 0pt }

  box(width: day-label-width + n-weeks * cell-size + 20pt, height: month-label-height + 7 * cell-size + 40pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #box[
      // Day labels (Mon, Wed, Fri)
      #if show-day-labels {
        let days = ("Mon", "", "Wed", "", "Fri", "", "Sun")
        for (i, day) in days.enumerate() {
          if day != "" {
            place(
              left + top,
              dx: 0pt,
              dy: month-label-height + i * cell-size + cell-size / 2 - 4pt,
              text(size: 6pt)[#day]
            )
          }
        }
      }

      // Cells
      #for (i, val) in values.enumerate() {
        let week = calc.floor(i / 7)
        let day = calc.rem(i, 7)
        let normalized = (val - min-val) / val-range
        let cell-color = if val == 0 { luma(240) } else { heat-color(normalized, palette: palette) }

        place(
          left + top,
          dx: day-label-width + week * cell-size,
          dy: month-label-height + day * cell-size,
          rect(
            width: cell-size - 2pt,
            height: cell-size - 2pt,
            fill: cell-color,
            radius: 2pt,
          )
        )
      }

      // Legend
      #let legend-y = month-label-height + 7 * cell-size + 10pt
      #place(left + top, dx: day-label-width, dy: legend-y, text(size: 6pt)[Less])
      #for i in array.range(5) {
        let normalized = i / 4
        let cell-color = heat-color(normalized, palette: palette)
        place(
          left + top,
          dx: day-label-width + 25pt + i * (cell-size + 2pt),
          dy: legend-y,
          rect(width: cell-size, height: cell-size, fill: cell-color, radius: 2pt)
        )
      }
      #place(left + top, dx: day-label-width + 25pt + 5 * (cell-size + 2pt) + 5pt, dy: legend-y, text(size: 6pt)[More])
    ]
  ]
}

// Correlation matrix (symmetric heatmap with diagonal)
#let correlation-matrix(
  data,  // dict with labels and values (2D symmetric array, -1 to 1 range)
  cell-size: 35pt,
  title: none,
  show-values: true,
) = {
  let labels = data.labels
  let values = data.values
  let n = labels.len()

  let label-area = 50pt

  // Correlation color: blue (-1) -> white (0) -> red (+1)
  let corr-color(val) = {
    let v = calc.max(-1, calc.min(1, val))
    if v < 0 {
      lerp-color(rgb("#2166ac"), white, (v + 1))
    } else {
      lerp-color(white, rgb("#b2182b"), v)
    }
  }

  box(width: label-area + n * cell-size + 20pt, height: label-area + n * cell-size + 40pt)[
    #if title != none {
      align(center)[*#title*]
      v(5pt)
    }

    #box[
      // Column labels
      #for (j, lbl) in labels.enumerate() {
        place(
          left + top,
          dx: label-area + j * cell-size + cell-size / 2 - 10pt,
          dy: 5pt,
          rotate(-45deg, origin: bottom + left, text(size: 7pt)[#lbl])
        )
      }

      // Cells and row labels
      #for (i, row-lbl) in labels.enumerate() {
        // Row label
        place(
          left + top,
          dx: 5pt,
          dy: label-area + i * cell-size + cell-size / 2 - 5pt,
          text(size: 7pt)[#row-lbl]
        )

        // Cells
        for (j, val) in values.at(i).enumerate() {
          let cell-color = corr-color(val)

          place(
            left + top,
            dx: label-area + j * cell-size,
            dy: label-area + i * cell-size,
            rect(
              width: cell-size,
              height: cell-size,
              fill: cell-color,
              stroke: white + 0.5pt,
            )
          )

          if show-values {
            let text-color = if calc.abs(val) > 0.5 { white } else { black }
            place(
              left + top,
              dx: label-area + j * cell-size + cell-size / 2 - 10pt,
              dy: label-area + i * cell-size + cell-size / 2 - 5pt,
              text(size: 7pt, fill: text-color)[#calc.round(val, digits: 2)]
            )
          }
        }
      }
    ]
  ]
}
