//#import "template.typ": project

// #show: project.with(
//   title: "Typst Hands-On: The Hagenberg Template",
//   author: "Your Name Here",
//   date: datetime.today().display()
// )

#set math.equation(numbering: "1.")

= Introduction
Welcome to the Typst hands-on session. Typst is a new markup-based typesetting system that is designed to be as powerful as LaTeX while being much easier to learn and use. 

#lorem(30)

== The Math Engine
Typst has excellent math support. Here is an inline equation: $z = a + i b => |z| = sqrt(a^2 + b^2)$. 
And here is a numbered display equation that we will reference later:

$ E = m c^2 $ <eq-einstein>

== Code and Logic
As software engineers, we write a lot of code. Sometimes we mention variables inline, like `let x = 10;`, and sometimes we need full code blocks:

```rust
fn main() {
    println!("Hello, Hagenberg!");
}
```

= Advanced Elements

== Figures and Tables

You can easily include images and tables. See @fig-logo for our placeholder image and @tab-comp for the engine comparison.

#figure(
image("mandelbrot.png", width: 40%),
caption: [A placeholder logo for our document.]
) <fig-logo>

#figure(
table(
columns: 2,
[If you like...], [Typst gives you...],
[Microsoft Word], [The 'What You See Is What You Get' feel via instant preview.],
[Markdown], [The clean, readable text files that are perfect for Git/JJ.],
[LaTeX], [Professional math, automated bibliographies, and perfect layouts.]
),
caption: [Comparing typesetting engines.]
) <tab-comp>

== Functional Programming

#let n = 10

Typst is a functional programming language. So let's have @prime-table be filled with the first #n primes automatically:

#let is-prime(x) = {
    if x < 2 {
      return false
    }
    for i in range(2, x) {
      if calc.rem(x, i) == 0 {
        return false
      }
    }
    return true
  }

#let prime(n) = {
  let current = 1
  let count = 0
  while count < n {
    current = current + 1
    if is-prime(current) {
      count = count + 1
    }
  }
  return current
}

#figure(
  table(
    columns: n + 1,
    [n],
    ..for i in range(1, n + 1) {
      ([#i],)
    },
    [prime(n)],
    ..for i in range(1, n + 1) {
      ([#prime(i)],)
    },
  ),
  caption: [The first #n primes.]
) <prime-table>

= Conclusion

#lorem(20)

As we saw in @eq-einstein, mass and energy are related. If you want to learn more, check out the official documentation at #link("https://typst.app/docs"). 
