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
    steht auf Typst + vermutlich Geek
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
    column-gutter: 2mm,
    row-gutter: 4mm,
    align: if direction == "horizontal" { horizon } else { center },
    code,
    if direction == "horizontal" { sym.arrow.r } else { sym.arrow.b }, eval(code.text, mode: mode),
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
      #codly(stroke: accent-colors.mauve + 1pt)
      #typst-compiled(
        ```typst
        #for i in range(4) [
           $#i^3 = #calc.pow(i, 3)$\
        ]
        ```,
        direction: "vertical",
      )
    ],
    [
      #show: strong
      Programmierbar\
      & Doc-as-Code
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
  [Warum typst?],
  content-description([
    
  ], [
    asd
    #pause
  ]),
  content-description(
    [asd],
    [],
  ),
  content-description([asd], [asd]),
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

#sided-base-slide(
  title: [
    Demo:\
    Labor Analyse
  ],
  subcontent: [
    #let file-path = "assets/histidin_curve_v1.csv"
    #let (headers, ..data) = csv(file-path, delimiter: ";")
    #show table: set block(breakable: false)
    #show: align.with(right)
    #set text(size: 16pt)
    #table(
      columns: (auto, auto),
      fill: white,
      table.header(table.cell(colspan: 2, strong(file-path.split("/").last()))),
      table.header(
        ..for head in headers {
          ((emph(head)),)
        },
      ),
      ..for entry in data.flatten() {
        ([#entry],)
      },
    )
  ],
)[
  #pause
  #show: align.with(bottom + left)
  #pin(21)
  #show: box.with(fill: base-colors.text, inset: 1mm)
  #image("assets/histidin-curve-1.png")
  #pin(22)
  #pinit-arrow(
    (21, 22),
    (21, 22),
    start-dx: -1.8cm,
    end-dx: -2mm,
    fill: accent-colors.rosewater,
    thickness: 4pt,
    start-dy: 2cm,
    end-dy: 2cm,
  )
]

#titled-slide(
  [Hhj],
  with-self(self => [
    #place(center + horizon)[
      #self.colors.primary-darkest
    ]
  ]),
)

#titled-slide([Lol], with-self(self => [
  #codly(
    highlighted-lines: (1, 5, 6),
    highlights: (
      (line: 5, start: 3, end: 5),
    ),
  )
  ```rust
  fn main() {
    for i in 0..10 {
      println!("Hello, world! {}", i);
    }
    let x = loop {
      break 1;
    }
    println!("x: {}", x);
    println!("i: {}", i);
    println!("Hello, world!");
  }
  ```
]))
