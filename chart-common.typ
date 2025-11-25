// chart-common.typ - Shared utilities for chart library

// Color palette for charts
#let chart-colors = (
  rgb("#4e79a7"),
  rgb("#f28e2b"),
  rgb("#e15759"),
  rgb("#76b7b2"),
  rgb("#59a14f"),
  rgb("#edc948"),
  rgb("#b07aa1"),
  rgb("#ff9da7"),
  rgb("#9c755f"),
  rgb("#bab0ac"),
)

// Get color from palette (cycles if more items than colors)
#let get-color(index) = {
  chart-colors.at(calc.rem(index, chart-colors.len()))
}

// Normalize data format - accepts array of tuples or dict with labels/values
#let normalize-data(data) = {
  let labels = if type(data) == dictionary { data.labels } else { data.map(d => d.at(0)) }
  let values = if type(data) == dictionary { data.values } else { data.map(d => d.at(1)) }
  (labels: labels, values: values)
}
