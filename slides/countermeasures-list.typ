#import "globals.typ": *

#let contents = (
  [*Code*\ Bugs, Features, Docs],
  [*Corporate Voice*\ OSS-Sponsoring fördern],
  [*Nutzen*\ Bewusste Tool-Wahl],
  [*Spenden*\ Private Unterstützung],
  [*Werben*\ Community vergrößern],
)

#set text(fill: gray-0, size: 12pt)
#fletcher-diagram(
  spacing: 6mm,
  for (index, content) in contents.enumerate() {
    let color = get-sdg-color(index, offset: -2)
    (
      pause,
      fletcher.node(
        (0, index),
        content,
        shape: fletcher.shapes.parallelogram,
        stroke: color.darken(50%),
        fill: color,
        width: 6.5cm,
        inset: 3mm,
      ),
    )
  },
)
