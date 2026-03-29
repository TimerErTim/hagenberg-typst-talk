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
    ]
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
    ..sj.shuffle-f(rng, contents).at(1).zip(sj.choice-f(rng, alignments, size: contents.len()).at(1)).map(((content, alignment)) => grid.cell(align: alignment, content))
  )
  }
  #place(top+left, block(width: 100%, height: 100%, fill: white.transparentize(50%)))
  #place(bottom + center, dy: -2cm, line(length: 95%, stroke: accent-colors.rosewater + 2pt))
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



#master-slide(with-self(self => [
  #let equation = include "audience-equation.typ"
  #{
    set text(size: 32pt)
    equation
  }
  #let func = math-to-func(equation)
  #show: scale.with(150%)
  #lq.diagram(
    width: 40%,
    height: 40%,
    lq.plot(
      range(100).map(it => it / 10),
      func,
      mark: none,
    )
  )
]))

#titled-slide(
  [Hhj],
  with-self(self => [
    #place(center + horizon)[
      #self.colors.primary-darkest
    ]
  ])
)

#titled-slide([Lol], with-self(self => [
  #codly(
    highlighted-lines: (1, 5, 6),
    highlights: (
      (line: 5, start: 3, end: 5),
    )
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
