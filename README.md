# FH Hagenberg Typst Talk

This repo contains a Typst talk and a small hands-on exercise.

## Hands-On

The main exercise is in `hands-on/main.typ`.

Its purpose is to give participants a simple Typst file they can edit during the workshop to try:

- headings and text
- math
- code blocks
- figures and tables
- small Typst functions and logic

Build it with:

```bash
mkdir -p hands-on/out
typst compile hands-on/main.typ hands-on/out/hands-on.pdf
```

For live editing, use a Typst-capable editor such as VS Code with Tinymist.

## Slides

The presentation lives in `slides/`.

Build it with:

```bash
cd slides
mise run compile
```

You will need to install mise-en-place for this to work. See the [Mise documentation](https://mise.jdx.dev/installing-mise.html) for installation instructions.
