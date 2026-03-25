#import "globals.typ": *


// Title slide
#master-slide(with-self(self => [
  #place(dy: -10%, horizon + left)[
    #show: box.with(fill: base-colors.surface0, inset: (
      rest: 2cm,
      bottom: 1.5cm,
    ))
    #set text(fill: base-colors.text, size: 36pt, weight: "bold")
    #{
      show: box.with(
        stroke: (left: base-colors.mantle + 1mm),
        inset: (left: 1cm),
      )
      show text: upper
      self.info.title
      [\ ]
      set text(size: 24pt, weight: "regular")
      self.info.subtitle
    }

    #set text(size: 15pt, weight: "regular")
    #box(height: 15pt * 2, baseline: 8pt, self.info.logo)
    #self.info.institution, #self.info.date.display(self.datetime-format)
  ]
  #place(left + bottom, dx: 1cm, dy: -1cm)[
    #self.info.author
  ]
]))
