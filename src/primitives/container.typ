// container.typ - Chart container wrapper

#import "../theme.typ": *
#import "./title.typ": draw-title

// Wraps chart body in a box with optional background/border and title.
#let chart-container(width, height, title, theme, extra-height: 0pt, body) = {
  box(
    width: width,
    height: height + extra-height,
    fill: theme.background,
    stroke: theme.border,
  )[
    #draw-title(title, theme)
    #body
  ]
}
