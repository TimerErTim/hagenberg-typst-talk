
#import "../common/templates/simple.typ": *
#import "deps.typ": *
#import "theme.typ": accent-colors, apply-base-theme, base-colors, color-cycle

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

#let typst-text-show-rule = ```typst
#show regex("(?i)typst"): text(fill: rgb("#239dad"), font: "Buenard", weight: "bold", "typst", size: 1.25em)
#doc
```

#let slides(handout: false, body) = {
  set text(lang: "de", font: ("Roboto", "Noto Color Emoji"))
  show math.equation: set text(font: "Fira Math")
  show: codly-init.with()
  show: apply-base-theme

  // Pinit for raw blocks
  show raw: it => {
    show regex("\{\{pin(\d+)\}\}"): it => pin(eval(it.text.trim().slice(5).rev().slice(2).rev()))
    it
  }

  let slides = simple-slides(
    config-info(
      title: [typSt],
      subtitle: [Wie man Dokumente programmiert],
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
      slide-preamble: {
        // Style codly
        codly-enable()
        codly(
          breakable: false,
          number-align: right + horizon,
          smart-skip: true,
          languages: codly-languages,
          smart-indent: true,
          skip-last-empty: true,
        )
      },
    ),
    body,
  )

  eval(typst-text-show-rule.text, mode: "markup", scope: (doc: slides))
}

#let master-slide(
  config: (:),
  repeat: auto,
  body,
) = {
  touying-slide-wrapper(self => {
    touying-slide(
      self: self,
      config: config,
      repeat: repeat,
      {
        let content = {
          {
            place(right + bottom, dx: -1cm, dy: -1cm)[
              #context utils.slide-counter.display() <slide-number>
            ]
          }

          set text(size: 18pt)
          body
        }

        if self.handout {
          show: rect.with(
            width: 100%,
            height: 100%,
            inset: 0pt,
            stroke: none,
          )
          content
        } else {
          let pseudoslide-offset = 3mm
          let pseudoslide-stroke-thickness = 3pt
          set page(background: context {
            let pseudoslides = calc.min(
              utils.slide-counter.final().first()
                - utils
                  .slide-counter
                  .at(query(selector(label("slide-number")).after(here())).first().location())
                  .first(),
              3,
            )
            show: move.with(
              dy: (pseudoslides + 1) * pseudoslide-offset,
              dx: (pseudoslides + 1) * pseudoslide-offset,
            )
            range(pseudoslides).fold([], (doc, idx) => move(
              dy: -pseudoslide-offset,
              dx: -pseudoslide-offset,
              box(
                doc,
                width: 100%,
                height: 100%,
                inset: 0mm,
                outset: -0.8cm,
                stroke: accent-colors.sky + pseudoslide-stroke-thickness,
                fill: white.darken(
                  10% * (idx + 1),
                ),
              ),
            ))
          })
          show: rect.with(
            width: 100%,
            height: 100%,
            inset: 0.8cm + pseudoslide-stroke-thickness / 2,
            outset: -0.8cm,
            stroke: accent-colors.sky + pseudoslide-stroke-thickness,
            fill: white,
          )

          content
        }
      },
    )
  })
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
      show: align.with(top + left)
      show: pad.with(top: 2cm, bottom: 1cm, x: 2cm)
      show: box.with(height: 1cm)
      set text(size: 28pt)
      par(spacing: 0cm, strong(title))
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

#let content-description(content, description) = {
  (
    content: content,
    description: description,
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
    show: pad.with(x: 2cm, rest: 0cm)
    show: align.with(top)
    grid(
      columns: (1fr, 1fr, 1fr),
      rows: (auto, auto),
      align: center,
      column-gutter: 1cm,
      row-gutter: 5mm,
      ..for (idx, col) in (column-1, column-2, column-3).enumerate() {
        (
          grid.cell(y: 0, x: idx, {
            show: block.with(
              stroke: base-colors.surface0,
              fill: base-colors.crust,
              inset: 3mm,
            )
            set text(size: 16pt, weight: "bold")
            col.content
          }),
          grid.cell(y: 1, x: idx, inset: 0cm, fill: none, {
            col.description
          }),
        )
      },
    )
  })
}

#let sided-base-slide(
  title: none,
  subcontent: none,
  sidecontent,
  config: (:),
  repeat: auto,
) = {
  master-slide(config: config, repeat: repeat, {
    show: pad.with(2cm)
    grid(
      columns: (7cm, 1fr),
      gutter: 2cm,
      grid.cell(x: 0, y: 0, {
        show: align.with(left)

        {
          show: pad.with(top: 2cm, bottom: 1cm)
          show: box.with(height: 2cm)
          show: align.with(bottom)
          set text(size: 22pt)
          set par(justify: false)
          strong(title)
        }

        subcontent
      }),
      sidecontent,
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
      place(right + horizon, dx: 1cm, rotate(90deg, polygon.regular(
        fill: gray-1,
        size: 1.5cm,
      )))
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
  sided-base-slide(
    config: config,
    repeat: repeat,
    title,
    subcontent: subcontent,
    sidecontent: {
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
    },
  )
}
