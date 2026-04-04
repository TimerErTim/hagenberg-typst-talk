#import "@preview/touying:0.6.1": *

#let simple-slides(
  ..configs,
  body,
) = {
  show: touying-slides.with(
    config-page(
      paper: "presentation-16-9",
      margin: 0pt,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: none,
      slide-level: 0,
      zero-margin-footer: true,
      zero-margin-header: true,
    ),
    ..configs,
  )

  body
}

#let only-handoutless(visible-subslides, only-cont) = {
  touying-fn-wrapper(
    (self: none, ..args) => if not self.handout { utils.only(self: self, ..args) },
    last-subslide: utils.last-required-subslide(visible-subslides),
    visible-subslides,
    only-cont,
  )
}
