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
  #place(top + left, block(width: 100%, height: 100%, fill: white.transparentize(50%)))
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
    #color-cycle.fold(image("assets/spongebob-innocent.png", width: 5cm), (acc, color) => block(acc, fill: color, inset: 0.5pt, radius: 1cm, clip: true))
  ]
])

// Agenda
#titled-slide[Ablauf][
  #v(-2cm)
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
    box(clip: true, width: 3cm, height: 4cm, align(top + left, image("assets/YouAreHere.svg", width: 6cm, height: 8cm, fit: "contain"))),
    [
      #image("assets/typst-webapp-preview-handson.png", width: 5cm)
    ],
    [
      #image("assets/q-n-a.png", width: 4cm)
    ]
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
        )
      )
    },
  )
]

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
    set text(size: 22pt)
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
      table.header(..for head in headers {
        ((emph(head)),)
      }),
      ..for entry in data.flatten() {
        ([#entry],)
      }
    )
  ],
)[
  #pause
  #show: align.with(bottom + left)
  #show: box.with(fill: base-colors.text)
  #pin(21)
  #image("assets/histidin-curve-1.png")
  #pin(22)
  #pinit-arrow((21, 22), (21, 22), start-dx: -1.8cm, end-dx: -2mm, fill: accent-colors.rosewater, thickness: 4pt, start-dy: 2cm, end-dy: 2cm)
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
