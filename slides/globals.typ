#import "@preview/touying:0.6.1": *
#import "../common/templates/simple.typ": *
#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8"

// Touying compatible utils
#let cetz-canvas = touying-reducer.with(
  reduce: cetz.canvas,
  cover: cetz.draw.hide.with(bounds: true),
)
#let fletcher-diagram = touying-reducer.with(
  reduce: fletcher.diagram,
  cover: fletcher.hide,
)
#let with-self(fn) = touying-fn-wrapper(
  ((self: none) => fn(self)),
)
#let animated(fn) = with-self(self => fn(utils.methods(self)))

// Colors
#let gray-0 = rgb("#eaeced")
#let gray-1 = rgb("#dee0e3")
#let gray-2 = rgb("#adb5bd")
#let gray-3 = rgb("#6c757d")
#let gray-4 = rgb("#495057")
#let gray-5 = rgb("#2b3136")
#let fg-dark = gray-0
#let fg-light = gray-5

// SDG Colors
#let sdg-colors = (
  goal-1: rgb(229, 35, 61),
  goal-2: rgb(221, 167, 58),
  goal-3: rgb(76, 161, 70),
  goal-4: rgb(197, 25, 45),
  goal-5: rgb(239, 64, 44),
  goal-6: rgb(39, 191, 230),
  goal-7: rgb(251, 196, 18),
  goal-8: rgb(163, 28, 68),
  goal-9: rgb(242, 106, 45),
  goal-10: rgb(224, 20, 131),
  goal-11: rgb(248, 157, 42),
  goal-12: rgb(191, 141, 44),
  goal-13: rgb(64, 127, 70),
  goal-14: rgb(31, 151, 212),
  goal-15: rgb(89, 186, 72),
  goal-16: rgb(18, 106, 159),
  goal-17: rgb(19, 73, 107),
)
#let sdg-color-map = sdg-colors.values()
#let get-sdg-color(index, offset: 0) = sdg-color-map.at(calc.rem(index + offset, sdg-color-map.len()))


#let slides(handout: false, body) = {
  set text(lang: "de")
  show: apply-base-theme
  simple-slides(
    config-info(
      title: [Open Source Software],
      subtitle: [Wie viel Last kann sie tragen?],
      author: [Tim Peko],
      date: datetime(year: 2026, month: 1, day: 22),
      institution: [FH Hagenberg],
      logo: box(
        radius: 6pt,
        inset: -1pt,
        fill: white,
        image("assets/fhooe-logo.svg"),
      ),
    ),
    config-common(
      datetime-format: "[day].[month].[year]",
      handout: handout,
    ),
    body,
  )
}

#let master-slide(
  invert: false,
  config: (:),
  repeat: auto,
  body,
) = {
  set text(font: "JetBrainsMono NF", fill: if invert { fg-dark } else {
    fg-light
  })
  //show text: upper

  slide(
    config: config,
    repeat: repeat,
    {
      {
        place(right + bottom, dx: -1cm, dy: -1cm)[
          #context utils.slide-counter.display()
        ]
      }

      body
    },
  )
}

#let focus-slide(
  body,
  config: (:),
  repeat: auto,
) = {
  master-slide(
    {
      show: align.with(center + horizon)
      body
    },
    config: config,
    repeat: repeat,
  )
}

#let default-focus-slide(
  heading,
  subheading: none,
  use-upper: true,
  config: (:),
  repeat: auto,
) = {
  focus-slide(config: config, repeat: repeat, {
    grid(rows: (10fr, 8fr), columns: 1fr, gutter: 8mm, {
        show: align.with(bottom)
        show text: if use-upper { upper } else { it => it }
        set text(size: 42pt, weight: "bold")
        heading
      }, {
        show: align.with(top)
        show text: if use-upper { upper } else { it => it }
        set text(size: 18pt)
        subheading
      })
  })
}

#let quote-slide(
  quote,
  attribution: none,
  config: (:),
  repeat: auto,
) = {
  default-focus-slide(
    use-upper: false,
    config: config,
    repeat: repeat,
    subheading: if attribution != none {
      set align(right)
      show: pad.with(right: 2cm, top: 1cm)
      sym.dash.em
      sym.space
      attribution
    },
  )[
    #box(inset: (bottom: 0pt, top: 2cm, x: 3cm))[
      #set text(size: 100pt, fill: gray-2)
      #place(top + left, dx: -2cm, dy: -0.5cm, sym.quote.l)
      #place(bottom + right, dx: 2cm, dy: 2.25cm, sym.quote.r)
      #set text(size: 30pt, weight: "regular", fill: gray-5)
      #quote
    ]
  ]
}

#let titled-slide(
  title,
  subtitle: none,
  body,
  config: (:),
  repeat: auto,
) = {
  master-slide(config: config, repeat: repeat, {
    {
      show: align.with(top + center)
      show: pad.with(top: 2cm, bottom: 1cm)
      show: box.with(height: 2.5cm)
      show: upper
      set text(size: 28pt, weight: "bold")
      par(spacing: 0cm, title)
      if subtitle != none {
        set text(size: 20pt)
        subtitle
      }
    }
    body
  })
}

#let three-column-slide(
  title,
  subtitle: none,
  column-1,
  column-2,
  column-3,
  config: (:),
  repeat: auto,
) = {
  titled-slide(config: config, repeat: repeat, title, subtitle: subtitle, {
    show: pad.with(x: 2cm)
    grid(
      columns: (1fr, 1fr, 1fr),
      rows: (1fr,),
      align: center,
      gutter: 1cm,
      column-1, column-2, column-3,
    )
  })
}

#let header-body(header, body) = {
  (
    header: header,
    body: body,
  )
}

#let three-bodied-column-slide(
  title,
  subtitle: none,
  column-1,
  column-2,
  column-3,
  config: (:),
  repeat: auto,
) = {
  titled-slide(config: config, repeat: repeat, title, subtitle: subtitle, {
    show: pad.with(x: 2cm)
    v(1fr)
    grid(
      columns: (1fr, 1fr, 1fr),
      rows: (auto, auto),
      align: center,
      gutter: 1cm,
      ..for (idx, col) in (column-1, column-2, column-3).enumerate() {
        (
          grid.cell(y: 0, x: idx, {
            show: move.with(dy: 1.5cm)
            show: box.with(stroke: gray-5, fill: gray-0, inset: 3mm, radius: 100%)
            set text(size: 16pt, weight: "bold")
            col.header
          }),
          grid.cell(y: 1, x: idx, inset: 1cm, fill: gray-4, {
            set text(fill: gray-0)
            col.body
          }),
        )
      },
    )
  })
}

#let sided-base-slide(
  title,
  subcontent: none,
  sidecontent: none,
  config: (:),
  repeat: auto,
) = {
  master-slide(config: config, repeat: repeat, {
    grid(
      columns: (auto, auto),
      gutter: 1.5cm,
      sidecontent,
      grid.cell(x: 1, y: 0, {
        show: align.with(left)
        show: pad.with(right: 1cm, bottom: 1cm)

        {
          show: align.with(top + right)
          show: pad.with(top: 2cm, bottom: 1cm)
          show: box.with(height: 2cm)
          show: upper
          set text(size: 24pt, weight: "bold")
          set par(justify: false)
          title
        }

        subcontent
      }),
    )
  })
}

#let side-content-slide(
  title,
  side-image: none,
  main-content,
  config: (:),
  repeat: auto,
) = {
  sided-base-slide(
    title,
    subcontent: main-content,
    sidecontent: {
      show: box.with(height: 100%, width: 100%, fill: gray-1)
      show: align.with(center + horizon)
      place(right + horizon, dx: 1cm, rotate(90deg, polygon.regular(fill: gray-1, size: 1.5cm)))
      side-image
    },
    config: config,
    repeat: repeat,
  )
}

#let four-side-frames-slide(
  title,
  subcontent: none,
  frame-1: none,
  frame-2: none,
  frame-3: none,
  frame-4: none,
  config: (:),
  repeat: auto,
) = {
  sided-base-slide(config: config, repeat: repeat, title, subcontent: subcontent, sidecontent: {
    show: box.with(inset: (right: 0pt, rest: 1cm), width: 100%, height: 100%)
    let grids = (
      grid(
        columns: (1fr, auto),
        rows: (1fr,),
        gutter: 2mm,
        frame-1, frame-2,
      ),
      grid(
        columns: (auto, 1fr),
        rows: (1fr,),
        gutter: 2mm,
        frame-3, frame-4,
      ),
    ).map(it => {
      set grid.cell(fill: gray-1, align: center)
      it
    })
    grid(
      rows: (1fr, 1fr),
      gutter: 2mm,
      ..grids,
    )
  })
}
