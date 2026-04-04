#import "@preview/catppuccin:1.1.0": catppuccin, latte
#import "deps.typ": *

#let accent-colors = (
  latte.colors.pairs().filter(((k, v)) => v.accent).map(((k, v)) => (k, v.rgb)).to-dict()
)
#let base-colors = (
  latte.colors.pairs().filter(((k, v)) => not v.accent).map(((k, v)) => (k, v.rgb)).to-dict()
)
#let color-cycle = (
  accent-colors.blue,
  accent-colors.yellow,
  accent-colors.mauve,
  accent-colors.red,
  accent-colors.green,
  accent-colors.sky,
  accent-colors.peach,
  accent-colors.pink
)

#let apply-base-theme(doc) = {
  show: catppuccin.with(latte)
  //set page(fill: white)  // We are instead using white background in the slides

  // Style lilaq diagrams
  show: lq.set-diagram(cycle: color-cycle)
  show: lq.set-spine(stroke: base-colors.overlay2)
  show: lq.set-grid(stroke: base-colors.crust)
 
  doc
}

#let apply-codly-theme() = {
  // Theme codly
  codly(
    zebra-fill: base-colors.crust,
    fill: base-colors.mantle,
    stroke: none,
    lang-fill: (lang) => lang.color.lighten(75%),
    lang-stroke: (lang) => 1pt + lang.color.lighten(70%),
    highlighted-default-color: accent-colors.peach.lighten(85%),
    highlight-fill: (color) => color.lighten(75%),
    highlight-stroke: (color) => 1pt + color.lighten(70%),
    highlight-inset: 0pt,
    //highlight-outset: 2pt,
  )
}
