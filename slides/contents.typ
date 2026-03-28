#import "globals.typ": *

// Title slide
#master-slide(with-self(self => [
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
