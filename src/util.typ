// util.typ - Shared utilities for typst-charts

// Normalize data format — accepts dict with labels/values or array of tuples.
// Returns (labels: array, values: array).
#let normalize-data(data) = {
  let labels = if type(data) == dictionary { data.labels } else { data.map(d => d.at(0)) }
  let values = if type(data) == dictionary { data.values } else { data.map(d => d.at(1)) }
  (labels: labels, values: values)
}

// Color interpolation: mix c1 and c2 by factor t (0 = c1, 1 = c2).
#let lerp-color(c1, c2, t) = {
  let t-clamped = calc.max(0, calc.min(1, t))
  color.mix((c1, (1 - t-clamped) * 100%), (c2, t-clamped * 100%))
}

// Heatmap color from a 0-1 value using named palette.
// Palettes: "viridis", "heat", "grayscale", or default blue gradient.
#let heat-color(val, palette: "viridis") = {
  let v = calc.max(0, calc.min(1, val))

  if palette == "viridis" {
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
    lerp-color(rgb("#f7fbff"), rgb("#08306b"), v)
  }
}

// Clamp a numeric value to the range [lo, hi].
#let clamp(val, lo, hi) = {
  calc.max(lo, calc.min(hi, val))
}

// Format a number with a given number of decimal digits.
#let format-number(val, digits: 1) = {
  calc.round(val, digits: digits)
}
