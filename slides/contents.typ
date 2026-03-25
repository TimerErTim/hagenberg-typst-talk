#import "globals.typ": *

#default-focus-slide(
  config: config-page(
    background: [
      #image("assets/phone.png")
      #place(top + left, box(
        fill: white.transparentize(25%),
        width: 100%,
        height: 100%,
      ))
    ],
  ),
  subheading: [
    Open Source Anteil
  ],
)[
  #set text(size: 120pt)
  #pause
  70%
]

// Title slide
#master-slide(with-self(self => [
  #place(dy: -10%, horizon + left)[
    #show: box.with(fill: gray-5, inset: (rest: 2cm, bottom: 1.5cm))
    #set text(fill: gray-0, size: 36pt, weight: "bold")
    #{
      show: box.with(stroke: (left: gray-0 + 1mm), inset: (left: 1cm))
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

#three-bodied-column-slide(
  "Was ist Open Source?",
  subtitle: [
    #pause
    Und was sind die Vorteile?

  ],
  header-body[
    #show: uncover.with("3-")
    Transparenz
  ][
    #show: uncover.with("3-")
    #show: align.with(center + horizon)
    "Many eyes make all bugs shallow" (Linus' Law)

    #box(image("assets/tresor-glas.png"), stroke: gray-5, radius: 5%, clip: true, fill: gray-0)
  ],
  header-body[
    #show: uncover.with("4-")
    Demokratisierung
  ][
    #alternatives-cases(("4", "5", "6-"), case => {
      let image = image("assets/linus-setup.png", width: if case != 2 { 20cm } else { auto })

      if case == 2 {
        show: align.with(horizon)
        show: box.with(radius: 5%, clip: true)
        image
      } else {
        place(top + left, dx: -7cm, dy: -5cm, box(clip: case == 0, width: 11cm, image))
      }
    })
  ],
  header-body[
    #show: uncover.with("6-")
    Kosteneffizienz
  ][
    #show: uncover.with("6-")
    #[
      #set text(size: 22pt, weight: "bold")
      #sym.tilde\70 Mrd. € Wertschöpfung\
      #set text(size: 11pt)
      jährlich in der EU
    ]

    #[
      #set text(size: 22pt, weight: "bold")
      ~96% OSS\
      #set text(size: 11pt)
      als maßgebliche Komponente
    ]
  ],
)


#quote-slide(attribution: [UN Generalsekretär], config: config-page(background: place(
  bottom + left,
  dx: 1cm,
  dy: -1cm,
  image("assets/sdgs.png", height: 6cm),
)))[
  open source software ... that adhere to privacy and other applicable laws and best practices, do no harm, and help attain the SDGs

  #{
    show: only.with("2-")
    place(top + left)[
      #show: rotate.with(15deg, reflow: true)
      #set text(size: 53pt, weight: "bold", fill: gradient.linear(..sdg-color-map))
      #show: highlight.with(fill: gray-4, extent: 0.2em, stroke: gray-5)
      Digital Public Goods
    ]
  }
]

#let frame-layout(body, sdg-logo: none) = {
  place(left + top, sdg-logo, dx: 0.5cm, dy: 0.5cm)
  show: align.with(center + bottom)
  show: pad.with(0.5cm)
  set par(spacing: 5mm, justify: true)
  body
}
#four-side-frames-slide(
  "Digital Public Goods",
  subcontent: [
    //#cite(<src_dpgs-casestudy>, form: none)
    #show: box.with(width: 10cm)
    #set text(size: 18pt)
    #let cur-color-index = state("sdg-list-col-index", 0)
    #cur-color-index.update(0)
    #set list(marker: it => context [
      #let color = get-sdg-color(cur-color-index.get())
      #cur-color-index.update(c => c + 1)
      #set text(fill: color)
      
    ])
    - Open standards
    - Open source software
    - Open content
    - Open AI models
    - Open data
    - Open hardware

    #show: uncover.with("6-")
    #image("assets/sdg-01.png", height: 4cm)
  ],
  frame-1: [
    #show: uncover.with("2-")
    #show: frame-layout.with(sdg-logo: image("assets/sdg-04.png", height: 1.5cm))

    #image("assets/moodle-logo.png", height: 1cm)
    #[
      #set text(size: 48pt, weight: "bold")
      60%
    ]

    Aller höheren Bildungseinrichtungen weltweit
  ],
  frame-2: [
    #show: uncover.with("3-")

    #show: frame-layout.with(sdg-logo: image("assets/sdg-16.png", height: 1.5cm))

    #image("assets/mosip-logo.png", height: 2cm)

    #[
      #set text(size: 28pt, weight: "bold")
      118 Mio.
    ]

    erfasste Personen in\
    *27* Ländern
  ],
  frame-3: [
    #show: uncover.with("4-")
    #show: frame-layout.with(sdg-logo: image("assets/sdg-03.png", height: 1.5cm))

    #image("assets/dhis2-logo.png", height: 1.5cm)
    #[
      #set text(size: 28pt, weight: "bold")
      3.2 Mrd.
    ]

    verwaltete Personen

    *80+* Länder
  ],
  frame-4: [
    #show: uncover.with("5-")
    #show: frame-layout.with(sdg-logo: image("assets/sdg-08.png", height: 1.5cm))

    #image("assets/mpesa-logo.png", height: 1.5cm)

    #[
      #set text(size: 28pt, weight: "bold")
      125 Mrd.
    ]

    Transaktionen pro Jahr

    *OpenShift/Linux* für *8k* TPS
  ],
)

#titled-slide("Womit hat OSS zu kämpfen?")[
  //#cite(<src_log4shell>, form: none)
  #let annotate(..args) = {
    box(place(bottom + left, ..args))
    h(0pt, weak: false)
  }

  #show: pad.with(top: 0cm, rest: 2cm)
  #let tailwind-fire = {
    image("assets/tailwindcss.png", width: 10cm)
    box(place(top + left, image("assets/fire-effect.png", height: 7cm, width: 15cm), dx: -2cm, dy: -7cm))
  }
  #pause
  #move(tailwind-fire, dy: 3cm, dx: 30%)
]

#master-slide[
  #{
    show: align.with(center + horizon)
    show: box.with(inset: 2cm, stroke: gray-4, radius: 3%, outset: -2cm, clip: true)

    image("assets/christian-grobmeier.png", width: 100%)
    place(top + left, dx: 1cm, dy: 2cm, image("assets/log4j-logo.png", width: 12cm))
  }
]

#let countermeasures-code = read("countermeasures-list.typ")
#side-content-slide(
  "Wie können wir helfen?",
  side-image: [
    #show: align.with(top)
    #only("7")[
      #show: pad.with(1cm)
      #let images = (
        image("assets/typst-seeklogo.svg", height: 2.5cm),
        image("assets/touying-removebg-preview.png", height: 2cm),
        image("assets/pympress.png", height: 2.5cm),
        image("assets/rust.png", height: 3cm),
        image("assets/tinymist-logo.png", height: 2cm),
        image("assets/nerd-fonts.png", height: 2cm),
        image("assets/mise-logo.svg", height: 2.5cm),
        image("assets/jujutsu-logo.png", height: 1.5cm),
        image("assets/gimp-logo.png", height: 1.5cm),
      )
      #let rng = gen-rng-f(182390143865)
      #let scatter-points = uniform(rng, size: 2 * images.len()).last().chunks(2)
      #{ scatter-points.at(7) = (0.6, 0.7) }
      #{ scatter-points.at(8) = (0.9, 0.2) }

      #for (image, (x, y)) in images.zip(scatter-points) {
        layout(((width: con-w, height: con-h)) => {
          let (width, height) = measure(image)
          let (dx, dy) = (x * (con-w - width), y * (con-h - height))
          place(left + bottom, dx: dx, dy: dy, image)
        })
      }
    ]
    #only("8")[
      #codly-range(3)
      #show raw: box.with(inset: 1cm, stroke: gray-5, radius: 6pt, outset: -8mm)
      #raw(countermeasures-code, lang: "typst", block: true)
      #place(right + horizon)[]
    ]
  ],
)[
  #show: pad.with(x: 2cm)
  #eval(countermeasures-code, mode: "markup")
]

#quote-slide(
  [
    #set text(size: 26pt)
    Open Source Software kann unsere Zukunft tragen, aber nicht ohne *Unterstützung*. Macht aus 'Open Source' heute ein '*Supported Source*'.
  ],
  attribution: "Euer Vortragender, Tim",
)

#titled-slide(
  "Quellen",
)[
  #show: pad.with(x: 2cm)
  #set text(size: 18pt)
  //#bibliography("refs.yaml", title: none, style: "copernicus")
]
