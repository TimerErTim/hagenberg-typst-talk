#import "@preview/catppuccin:1.1.0": catppuccin, latte

#let accent-colors = latte.colors.pairs().filter(((k, v)) => v.accent).map(((k, v)) => (k, v.rgb)).to-dict()
#let base-colors = latte.colors.pairs().filter(((k, v)) => not v.accent).map(((k, v)) => (k, v.rgb)).to-dict()

#let apply-base-theme(doc) = {
  catppuccin(latte, doc)
}