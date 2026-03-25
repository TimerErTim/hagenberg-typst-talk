#import "globals.typ": *

#let handout-mode = sys.inputs.at("handout", default: false) == "true"

// Setup as slideshow
#show: slides.with(handout: handout-mode)

// Display contents
#include "contents.typ"
