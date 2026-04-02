#import "globals.typ": *

#let handout-mode = sys.inputs.at("handout", default: false) == "true"
// Disable all emojis if in preview mode (because of tinymist bug, not needed with explicit emoji font)
// #show: doc => if (sys.inputs.at("x-preview", default: none) == none) { doc } else { 
//   dictionary(emoji).values().fold(doc, (doc, emoji) => {
//     show emoji: box(stroke: black, inset: 1em / 2)
//     doc
//   })
// }

// Setup as slideshow
#show: slides.with(handout: handout-mode)

// Display contents
#include "contents.typ"
