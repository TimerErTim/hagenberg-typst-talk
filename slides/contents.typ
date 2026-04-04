#import "globals.typ": *

// Title slide
#master-slide(with-self(self => [
  #{
    let rng = sj.gen-rng-f(6669)
    let contents = (
      box(image("assets/glycin-derivatives-1.png"), fill: base-colors.surface2),
      box(image("assets/glycin-derivatives-2.png"), fill: base-colors.surface2),
      box(image("assets/glycin-derivatives-3.png"), fill: base-colors.surface2),
      box(image("assets/histidin-curve-1.png"), fill: base-colors.surface2),
      image("assets/Biodata_en_2026-03-24.pdf", page: 1),
      image("assets/GBC1_WS2025_Chlorophyll.pdf", page: 1),
      image("assets/GBC1_WS2025_Chlorophyll.pdf", page: 10),
      image("assets/SKT_TimPeko_OpenSourceSoftware_Handout.pdf", page: 8),
      image("assets/SKT_TimPeko_OpenSourceSoftware_Handout.pdf", page: 4),
      image("assets/GBC1_WS2025_Chlorophyll.pdf", page: 7),
      image("assets/task_5.svg"),
      [
        #show: scale.with(10%, reflow: true)
        #include "../hands-on/main.typ"
      ],
    )
    let alignments = for h in (center, left, right) {
      for v in (top, horizon, bottom) {
        (v + h,)
      }
    }
    show: pdf.artifact.with(kind: "other")
    show: block.with(height: 80%)
    grid(
      columns: 6,
      gutter: 2mm,
      ..sj
        .shuffle-f(rng, contents)
        .at(1)
        .zip(sj.choice-f(rng, alignments, size: contents.len()).at(1))
        .map(((content, alignment)) => grid.cell(align: alignment, content))
    )
  }
  #place(top + left, block(width: 100%, height: 100%, fill: white.transparentize(25%)))
  #place(bottom + center, dy: -2cm, line(length: 95%, stroke: accent-colors.rosewater + 2pt))
  #set text(size: 12pt)
  #place(center + horizon)[
    #set text(size: 72pt)
    #self.info.title\
    #set text(size: 32pt)
    #self.info.subtitle
  ]
  #place(left + bottom, dx: 1cm, dy: -1cm)[
    #self.info.author
  ]
  #place(center + bottom, dy: -1cm)[
    #show: align.with(horizon)
    #box(height: 2em, self.info.logo, baseline: (2em - 1em) / 2) #h(5mm)
    #self.info.institution, #self.info.date.display(self.datetime-format)
  ]
]))


// About me slide
#titled-slide([Über mich], subtitle: [], [
  #place(
    right + horizon,
  )[
    #show: align.with(left)
    #pin(1)
    #pad(2cm, left: 5mm, box(stroke: base-colors.overlay2, radius: 3mm, clip: true, image("assets/myself.jpg")))
    #pin(3)
  ]
  #show: pad.with(left: 2cm)
  #pause
  Tim Peko #pin(2)
  #pinit-arrow(2, (1, 3), fill: accent-colors.rosewater, thickness: 1.5pt)
  \
  #show: block.with(width: 100%, height: 1fr, inset: (bottom: 2cm))
  #pause
  #place(left + bottom, dx: 2cm, dy: -5cm)[
    #show: rotate.with(-5deg, reflow: true)
    HTL Grieskirchen
  ]
  #pause
  #place(left + bottom, dx: 0cm, dy: -2cm)[
    #show: rotate.with(8deg, reflow: true)
    4. Semester MBI in Hagenberg
  ]
  #pause
  #place(left + bottom)[
    #show: rotate.with(0deg, reflow: true)
    bentutzt seit 2 Jahren Typst
  ]
  #pause
  #place(left + bottom, dx: 9cm)[
    #show: rotate.with(-15deg, reflow: true)
    erster Vortrag
    #color-cycle.fold(image("assets/spongebob-innocent.png", width: 5cm), (acc, color) => block(
      acc,
      fill: color,
      inset: 0.5pt,
      radius: 1cm,
      clip: true,
    ))
  ]
])

// Agenda
#titled-slide[Ablauf][
  #v(-1cm)
  #show: align.with(center + top)
  #let contents = (
    [
      Vortrag
    ],
    [
      Hands-On
    ],
    [
      Q & A
    ],
  )
  #let top-contents = (
    box(clip: true, width: 3cm, height: 4cm, align(top + left, image(
      "assets/YouAreHere.svg",
      width: 6cm,
      height: 8cm,
      fit: "contain",
    ))),
    [
      #image("assets/hands-on-meme.png", width: 5cm)
    ],
    [
      #image("assets/q-n-a.png", width: 4cm)
    ],
  )

  #fletcher-diagram(
    spacing: 1cm,
    for (index, (content, top-content)) in contents.zip(top-contents).enumerate() {
      let color = color-cycle.at(calc.rem(index, color-cycle.len()))
      (
        pause,
        fletcher.node(
          (index, 0),
          content,
          shape: fletcher.shapes.chevron,
          stroke: color.lighten(50%) + 2pt,
          fill: color.lighten(75%),
          width: 7cm,
          height: 3cm,
        ),
        fletcher.node(
          (index, -1),
          top-content,
        ),
      )
    },
  )
]

// What is Typst?
#sided-base-slide(
  title: [Was ist Typst?],
  subcontent: [
    #let heart-wrap(body, fill: none, stroke: accent-colors.red, padding: 15pt) = context {
      // 1. Measure the text/content
      let size = measure(body)

      // 2. Add padding to ensure the text doesn't touch the edges
      let w = size.width + padding * 2
      let h = size.height + padding * 2

      cetz.canvas({
        import cetz.draw: bezier, content, group, merge-path, move-to, scale

        // 3. Determine scale factors.
        // The mathematical heart below is roughly 3 units wide and 2.2 units tall.
        let sx = w.cm() / 2
        let sy = h.cm() / 1.5

        // 4. Draw the scaled heart shape using bezier curves
        group({
          scale(x: sx, y: sy)
          merge-path(close: true, fill: fill, stroke: stroke, {
            // Start at the bottom tip
            move-to((0, -1.5))
            // Curve up to the center cleft (Right lobe)
            bezier((0, -1.5), (0, 0.5), (3, 0), (2, 1.5))
            // Curve back down to the bottom tip (Left lobe)
            bezier((0, 0.5), (0, -1.5), (-2, 1.5), (-3, 0))
          })
        })

        // 5. Place the content.
        // We offset it slightly upwards because a heart is wider at the top.
        content((0, 0), body)
      })
    }
    #pause
    #heart-wrap(stroke: accent-colors.red + 4pt, [
      #show: pad.with(top: 1cm, bottom: -5mm)
      #show: box.with(width: 3cm, height: 3cm, inset: -5mm)
      #place(left + top, image("assets/word-logo.png", width: 2cm))
      #place(right + top, image("assets/latex-logo.svg", width: 2cm))
      #place(center + bottom, image("assets/markdown-logo.svg", width: 2cm))
    ])
    #pause
  ],
)[
  #show: align.with(center + horizon)
  #show: box.with(width: 100%, height: 100%)
  #set text(size: 16pt)
  #show grid.cell: align.with(center + horizon)
  #set par(spacing: 5mm)
  #show heading.where(level: 2): it => align(top, text(size: 18pt)[*#it*])
  #let color-index(x, y) = calc.rem(y * 2 + x + 2, color-cycle.len())
  #show grid.cell: it => {
    if it.y == auto or it.y == none {
      return it
    }

    show heading: text.with(fill: color-cycle.at(color-index(it.x, it.y)).lighten(0%))
    it
  }
  #grid(
    columns: (1fr, 1fr),
    rows: (1fr, 1fr),
    inset: 5mm,
    gutter: 2mm,
    fill: base-colors.crust,
    stroke: base-colors.surface0,
    [
      == Open Source
      #image("assets/GitHub_Invertocat_Black.svg", width: 1.8cm)
      *400+* Contributors\
      *50k+* Stars
    ],
    [
      #show: only.with("4-")
      #heading(level: 2)[
        #show: text.with(fill: codly-languages.rust.color)
        Rust
      ]
      #block(codly-languages.rust.icon, height: 4em)
      _*Blazingly fast!*_
    ],
    grid.cell(colspan: 2)[
      #show: only.with("5-")
      == Geschichte

      #grid(
        columns: (auto, auto, auto),
        rows: 3cm,
        gutter: 2mm,
        align: center,
        figure(image("assets/martin_haug.webp"), numbering: none, caption: [Martin Haug]),
        [Seit *2019* in Entwicklung\
          Gegründet *2023* in *Berlin*],
        figure(image("assets/laurenz-madje.webp"), numbering: none, caption: [Laurenz Mädje]),
      )
    ],
  )
]

#let typst-compiled(code, mode: "markup", direction: "horizontal") = {
  grid(
    columns: if direction == "horizontal" { (1fr, auto, 1fr) } else { 1 },
    rows: if direction == "horizontal" { auto } else { (auto, auto, auto) },
    column-gutter: 5mm,
    row-gutter: 5mm,
    align: if direction == "horizontal" { horizon } else { center },
    code,
    if direction == "horizontal" { sym.arrow.r } else { sym.arrow.b },
    grid.cell(align: if direction == "horizontal" {
      left
    } else { center })[
      #show: block.with()
      #show: align.with(left)
      #eval(code.text, mode: mode)
    ],
  )
}

// Why fall in love
#three-bodied-column-slide(
  [
    Warum Typst?
  ],
  content-description(
    [
      #set text(size: 12pt)
      #codly-enable()
      #codly-local(stroke: accent-colors.mauve + 1pt, typst-compiled(
        ```typst
        #for i in range(4) [
           $#i^3 = #calc.pow(i, 3)$\
        ]
        ```,
        direction: "vertical",
      ))
    ],
    [
      #show: strong
      Programmierbar\
      \= Doc-as-Code
      #pause
    ],
  ),
  content-description(
    [
      #codly-disable()
      #set text(size: 12pt)
      ```log
      error: unknown variable: a
          ┌─ contents.typ:271:3
          │
      271 │  #(a * 3)
          │    ^
          │
      help: error occurred while importing this module
          ┌─ main.typ:9:9
          │
       9  │ #include "contents.typ"
          │          ^^^^^^^^^^^^^^
      ```
    ],
    [
      #show: strong
      Hilfreiche Fehlermeldungen

      #pause
    ],
  ),
  content-description(
    [
      #set text(size: 12pt)
      #show quote.where(block: true): set par(justify: true)
      #quote(block: true, attribution: [Typst README])[
        There are two ways to make something flexible: Have a knob for everything or have a few knobs that you can combine in many ways. Typst is designed with the second way in mind.
      ]
    ],
    [
      #show: strong
      Flexibel durch Komposition
    ],
  ),
)

#three-bodied-column-slide(
  [Warum typst?
    #codly-disable()
  ],
  content-description(
    [
      #set text(size: 12pt)
      #typst-compiled(
        ```typst
        = Head
        ```,
        direction: "horizontal",
      )
      #typst-compiled(
        ```typst
        = Headi
        ```,
        direction: "horizontal",
      )
      #typst-compiled(
        ```typst
        = Headin
        ```,
        direction: "horizontal",
      )
      #typst-compiled(
        ```typst
        = Heading
        ```,
        direction: "horizontal",
      )
    ],
    [
      #show: strong
      Echtzeit Rendering
      #pause
    ],
  ),
  content-description(
    [
      #set text(size: 16pt)
      ```bash
      eza -al $(which typst)
      > ... 16M .../typst
      ```
    ],
    [
      #show: strong
      Lightweight Binary\
      16 MB
      #pause
    ],
  ),
  content-description(
    [
      #set text(size: 12pt)
      #emoji.warning v0.x #sym.arrow.r Breaking Changes

      #emoji.package *Ökosystem*: klein (aber fein)
    ],
    [
      #show: strong
      #set text(fill: accent-colors.yellow)
      Realitätscheck
    ],
  ),
)

#sided-base-slide(
  title: [
    Demo:\
    Typst Präsentation
  ],
  subcontent: [
    #pause
    #show: box.with(inset: (left: -1cm, bottom: -1cm))
    #image("assets/gru-equation.png")
  ],
)[
  #pause
  #let equation = include "audience-equation.typ"
  #{
    set text(size: 22pt, fill: accent-colors.mauve)
    equation
  }

  #let eq-data = math-to-data(equation)
  #let data = range(100).map(it => it / 10).map(it => (it, (eq-data.func)(it)))
  #show: scale.with(150%, reflow: true)
  #lq.diagram(
    width: 100%,
    height: 5cm,
    legend: (position: left + top),
    xlim: (0, calc.max(..data.map(((x, y)) => x))),
    ylim: (auto, calc.max(..data.map(((x, y)) => y)) * 1.2),
    lq.plot(
      data.map(((x, y)) => x),
      data.map(((x, y)) => y),
      mark: none,
      smooth: true,
      label: [
        #set text(size: 8pt)
        Publikumsfunktion #eq-data.fx-math
      ],
      stroke: accent-colors.mauve + 2pt,
    ),
  )
]

// Theorie
#let holy-trinity-diagram(highlight-section: none) = {
  let distance = 4.5cm
  let radius = 1.5cm
  show raw: highlight.with(fill: base-colors.mantle, extent: 2pt, top-edge: 1em, bottom-edge: -1em / 3)
  fletcher.diagram(
    fletcher.node(
      (90deg, distance),
      [
        #set text(fill: color-cycle.at(calc.rem(0, color-cycle.len())))
        #show: strong
        Mark\ up
      ],
      shape: fletcher.shapes.circle,
      stroke: if highlight-section == "markup" { accent-colors.mauve + 3pt } else { base-colors.text + 2pt },
      width: radius,
      height: radius,
      name: "markup",
    ),
    fletcher.node(
      (330deg, distance),
      [
        #set text(fill: color-cycle.at(calc.rem(4, color-cycle.len())))
        #show: strong
        Math
      ],
      shape: fletcher.shapes.circle,
      stroke: if highlight-section == "math" { accent-colors.mauve + 3pt } else { base-colors.text + 2pt },
      width: radius,
      height: radius,
      name: "math",
    ),
    fletcher.node(
      (210deg, distance),
      [
        #set text(fill: color-cycle.at(calc.rem(3, color-cycle.len())))
        #show: strong
        Code
      ],
      shape: fletcher.shapes.circle,
      stroke: if highlight-section == "code" { accent-colors.mauve + 3pt } else { base-colors.text + 2pt },
      width: radius,
      height: radius,
      name: "code",
    ),
    fletcher.edge(
      <markup>,
      <math>,
      "-|>",
      `$...$`,
      stroke: if highlight-section == "markup" { accent-colors.yellow } else { base-colors.overlay0 } + 2pt,
      shift: 2mm,
    ),
    //fletcher.edge(<math>, <markdown>, "-|>", stroke: base-colors.overlay2 + 1.5pt, shift: 2mm),
    fletcher.edge(
      <markup>,
      <code>,
      "-|>",
      `#...`,
      stroke: if highlight-section == "markup" { accent-colors.yellow } else { base-colors.overlay0 } + 2pt,
      shift: 2mm,
      label-side: left,
    ),
    fletcher.edge(
      <code>,
      <markup>,
      "-|>",
      `[...]`,
      stroke: if highlight-section == "code" { accent-colors.yellow } else { base-colors.overlay0 } + 2pt,
      shift: 2mm,
    ),
    fletcher.edge(
      <code>,
      <math>,
      "-|>",
      `$...$`,
      stroke: if highlight-section == "code" { accent-colors.yellow } else { base-colors.overlay0 } + 2pt,
      shift: 2mm,
    ),
    fletcher.edge(
      <math>,
      <code>,
      "-|>",
      `#...`,
      stroke: if highlight-section == "math" { accent-colors.yellow } else { base-colors.overlay0 } + 2pt,
      shift: 2mm,
      label-side: left,
    ),
  )
}

#let holy-trinity-slide(highlight-section: none, content) = {
  titled-slide(
    [Theorie\ Modes],
  )[
    #show: pad.with(right: 2cm)
    #grid(
      columns: (auto, 1fr),
      rows: 1fr,
      gutter: 1cm,
      box(inset: 5mm)[
        #holy-trinity-diagram(highlight-section: highlight-section)
      ],
      [
        #show: pad.with(top: -3cm)
        #content
      ],
    )
  ]
}

#titled-slide(
  [Theorie\ Modes],
)[
  #show: pad.with(right: 2cm)
  #grid(
    columns: (auto, 1fr),
    rows: 1fr,
    gutter: 1cm,
    box(inset: 5mm)[
      #only("1", holy-trinity-diagram())
      #only("2-", holy-trinity-diagram(highlight-section: "markup"))
    ],
    [
      #show: pad.with(top: -3cm)
      #pause
      #only-handoutless("3-", codly(
        highlights: (
          (
            line: 3,
            start: 1,
            end: 1,
            fill: accent-colors.yellow,
          ),
          (
            line: 3,
            start: 2,
            end: none,
            fill: accent-colors.red,
          ),
        ),
      ))
      #only-handoutless("4-", codly(highlights: (
        (
          line: 4,
          start: 1,
          end: 1,
          fill: accent-colors.yellow,
        ),
        (
          line: 4,
          start: 2,
          end: 36,
          fill: accent-colors.green,
        ),
        (
          line: 4,
          start: 37,
          end: 37,
          fill: accent-colors.yellow,
        ),
      )))
      #typst-compiled(
        direction: "vertical",
        ```typst
        == A Title
        *Bold* and _italic_ content.
        #rect(stroke: red, "Trapped")
        $ E(X) = sum_(i=1)^n x_i P(X = x_i) $
        ```,
      )
    ],
  )
]

#holy-trinity-slide(highlight-section: "code")[
  #only-handoutless("2", codly(
    highlights: (
      (
        line: 1,
        start: 1,
        end: 1,
        fill: accent-colors.yellow,
      ),
      (
        line: 1,
        start: 2,
        end: 2,
        fill: accent-colors.red,
      ),
      (
        line: 5,
        start: 1,
        end: 1,
        fill: accent-colors.red,
      ),
    ),
    highlighted-lines: (2, 3, 4).map(it => (it, accent-colors.red.lighten(75%))),
  ))
  #typst-compiled(
    ```typ
    #{
      let x = 5
      let y = 2
      calc.pow(x, y)
    }
    ```,
    direction: "vertical",
  )
]

#holy-trinity-slide(highlight-section: "code")[
  #only("2", codly(highlights: (
    (
      line: 1,
      start: 10,
      end: 10,
      fill: accent-colors.yellow,
    ),
    (line: 1, start: 11, end: 19, fill: accent-colors.green),
    (line: 1, start: 20, end: 20, fill: accent-colors.yellow),
  )))
  #only-handoutless("3", codly(
    highlights: (
      (
        line: 2,
        start: 19,
        end: 21,
        fill: accent-colors.yellow,
      ),
      (
        line: 5,
        start: 0,
        end: 2,
        fill: accent-colors.yellow,
      ),
    ),
    highlighted-lines: (3, 4).map(it => (it, accent-colors.blue.lighten(75%))),
  ))
  #show list: set align(left)
  #typst-compiled(
    ```typc
    let eq = $E = m c^2$
    for i in range(2) [
      - *Bold* and
      - _italic_ content
    ]
    eq
    ```,
    direction: "vertical",
    mode: "code",
  )
]

#holy-trinity-slide(highlight-section: "math")[
  #only("2", codly(
    highlights: (
      (
        line: 1,
        start: 19,
        end: 19,
        fill: accent-colors.yellow,
      ),
      (
        line: 1,
        start: 10,
        end: 18,
        fill: accent-colors.green,
      ),
      (
        line: 1,
        start: 9,
        end: 9,
        fill: accent-colors.yellow,
      ),
    ),
  ))
  #only-handoutless("3", codly(
    highlights: (
      (
        line: 3,
        start: 8,
        end: 8,
        fill: accent-colors.yellow,
      ),
      (
        line: 3,
        start: 9,
        end: 9,
        fill: accent-colors.mauve,
      ),
      (
        line: 3,
        start: 10,
        end: 21,
        fill: accent-colors.green,
      ),
      (
        line: 3,
        start: 22,
        end: 22,
        fill: accent-colors.mauve,
      ),
      (
        line: 3,
        start: 23,
        end: 23,
        fill: accent-colors.yellow,
      ),
    ),
  ))
  #typst-compiled(
    ```typ
    Inline: $E = m c^2$

    Block: $ p in [-1, 1] $
    ```,
    direction: "vertical",
  )
]

#holy-trinity-slide(highlight-section: "math")[
  #only-handoutless("2", codly(
    highlights: (
      (
        line: 2,
        start: 12,
        end: 12,
        fill: accent-colors.green,
      ),
      (
        line: 4,
        start: 1,
        end: 1,
        fill: accent-colors.green,
      ),
    ),
    highlighted-lines: (3,).map(it => (it, accent-colors.green.lighten(75%))),
  ))
  #only-handoutless("3", codly(
    highlights: (
      (
        line: 5,
        start: 12,
        end: 12,
        fill: accent-colors.yellow,
      ),
      (
        line: 5,
        start: 13,
        end: 13,
        fill: accent-colors.yellow,
      ),
      (
        line: 8,
        start: 1,
        end: 1,
        fill: accent-colors.yellow,
      ),
    ),
    highlighted-lines: (6, 7).map(it => (it, accent-colors.blue.lighten(75%))),
  ))
  #typst-compiled(
    ```typ
    $
    underbrace([
        sum_(i=0)^n x_i
    ], "Math Mode")
    underbrace(#[
      + Items on
      + enumerated list
    ], "Markup Mode")
    $
    ```,
    direction: "vertical",
  )
]

#sided-base-slide(title: [Theorie\ Funktionen], subcontent: [
  #show: only.with("2-")
  Alles ist eine Funktion!

  #set text(size: 14pt)
  #codly-disable()
  #typst-compiled(
    ```typ
    = Title
    _Italic_
    ```,
  )
  #v(5mm)
  #typst-compiled(
    ```typ
    #heading(
      "Title")
    #emph(
      "Italic")
    ```,
  )

])[
  #codly-enable()
  #typst-compiled(
    ```typ
    #let repeat(
      cont,
      n: 1
    ) = {
      for i in range(n) {
        cont
      }
    }
    #repeat[Hello!]\ /*pin1*/
    #repeat(n: 3)[Hello! ]
    ```,
    direction: "vertical",
  )

  #set text(size: 12pt)
  #pinit-point-from(
    1,
    offset-dy: -1cm,
    pin-dy: -5pt,
    pin-dx: -5pt,
    body-dy: -5pt,
    fill: base-colors.overlay2,
  )[Zeilenumbruch]
]

#titled-slide([Theorie\ `#set` Rules])[
  #show: pad.with(rest: 2cm, top: 0cm)
  Globale Standardwerte
  #pause
  #typst-compiled(
    ```typ
    Normaler Text /*pin2*/
    #set text(fill: /*pin3*/red)
    = Title
    Roter Text /*pin1*/
    ```,
  )
  #only("3", {
    place(left + top, dx: 6cm, dy: 6cm)[
      #pin(5) ```typ #text(fill: /*pin4*/red, "Roter Text")```
    ]
    pinit-arrow(5, 1, fill: base-colors.overlay2)
    pinit-point-from(2, pin-dx: -5pt, fill: base-colors.overlay2, offset-dy: -1cm, pin-dy: -5pt, body-dy: -5pt)[
      ```typ #text("Normaler Text")```
    ]
    let (offset-x, offset-y) = (0cm, -1em)
    pinit-arrow(
      4,
      3,
      fill: accent-colors.red,
      end-dx: offset-x + 8mm,
      start-dx: offset-x,
      end-dy: offset-y + 8mm,
      start-dy: offset-y + 5pt,
    )
  })
  #pause
  #pause
  #v(5mm)
  #typst-compiled(
    ```typ
    Normaler Text
    #set align(right)
    = Title
    Rechter Text
    ```,
  )
]

#titled-slide([Theorie\ `#show` Rules])[
  #show: pad.with(rest: 2cm, top: 0cm)
  Bei X mach Y
  #pause
  #only("3", codly(
    highlights: (
      (
        line: 2,
        start: 16,
        end: none,
        fill: accent-colors.mauve,
      ),
    ),
  ))
  #{
    show: only.with("2-3")
    codly(header: [Transformation])
    typst-compiled(
      ```typ
      == Boring Heading
      #show heading: it => rect(stroke: red, it)
      == WUHU, HEEAAADDING
      ```,
    )
  }
  #only("4", codly(
    highlights: (
      (
        line: 2,
        start: 16,
        end: none,
        fill: accent-colors.mauve,
      ),
    ),
  ))
  #{
    show: only.with("4")
    codly(header: [Transformation])
    typst-compiled(
      ```typ
      == Boring Heading
      #show heading: rect.with(stroke: red)
      == WUHU, HEEAAADDING
      ```,
    )
  }
  #{
    show: only.with("5-")
    codly(offset: 1, header: [Transformation])
    typst-compiled(
      ```typ
      #show heading: rect.with(stroke: red)
      == WUHU, HEEAAADDING
      ```,
    )
  }

  #range(3).map(_ => pause).join([])
  #v(1cm)
  #codly(header: [`set` & `show` Rules])
  #typst-compiled(
    ```typ
    #show heading: set text(fill: red)
    = Rote Überschrift
    Text darunter
    ```,
  )
]

#titled-slide([Theorie\ `#show` Rules])[
  #show: pad.with(rest: 2cm, top: 0cm)
  Bei X mach Y
  #only("1", {
    codly(header: [Komplett Überschreiben])
    typst-compiled(
      ```typ
      #show "shit": underline(stroke: red)[censored]
      shitty review, lots of bullshit
      ```,
    )
  })
  #only("2", codly(
    highlights: (
      (
        line: 1,
        start: 7,
        end: 29,
        fill: accent-colors.mauve,
      ),
    ),
  ))
  #only("2-", {
    show: codly-local.with(header: [Komplett Überschreiben mit RegEx], lang-format: none)
    typst-compiled(
      ```typ
      #show regex("\b\w*shit\w*\b"): underline(stroke: red)[censored]
      shitty review, lots of bullshit
      ```,
    )
  })
  #pause
  #pause
  #v(1cm)
  #codly(header: [Alles Folgende])
  #typst-compiled(
    ```typ
    #show: rotate.with(20deg)
    #show: rect.with(stroke: red)
    = Title
    Text darunter
    ```,
  )
]

#titled-slide([Und vieles vieles mehr...])[
  #show: pad.with(rest: 2cm, top: 0cm)
  #let rng = sj.gen-rng-f(824)
  #let items = (
    [Packages],
    [Introspection],
    [State],
    [Locate],
    [Query],
    [Context],
    [Drawing],
  )
  #let (rng, random-stuff) = sj.uniform-f(rng, low: 0, high: 1.0, size: items.len() * 3)
  #let map-rotation(val) = {
    // val is in [0, 1]
    let low = -45deg
    let high = 45deg
    let range = high - low
    let normalized = val * range + low
    normalized
  }
  #let (dx, dy, rotation) = random-stuff.chunks(items.len(), exact: true)
  #let rotated-items = items.zip(rotation).map(((item, rotation)) => rotate(map-rotation(rotation), item, reflow: true))
  #grid(
    columns: (1fr,) * items.len(),
    rows: 9cm,
    gutter: 1cm,
    ..for (item, dx, dy) in rotated-items.zip(dx, dy) {
      let h-align = if dx > 0.5 { left } else { right }
      let v-align = if dy > 0.5 { top } else { bottom }
      (grid.cell(item, align: h-align + v-align),)
    }
  )

  #pause
  #show: place.with(center + horizon)
  #show: rotate.with(20deg, reflow: true)
  #show: rect.with(width: 20cm, fill: white, stroke: base-colors.mantle)
  #codly(header: [Alles Folgende])
  #typst-compiled(
    ```typ
    #show: rotate.with(20deg)
    #show: rect.with(stroke: red)
    = Title
    Text darunter
    ```,
  )
]
