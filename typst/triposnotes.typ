/*
 * Usage:
 * #show: project.with(
 *  title: "<Title of the Project>",
 *  authors: (
 *    "<Author 1 Name>", "<Author 2 Name>", etc.
 *  ),
 * )
 */
#import "@preview/physica:0.9.5": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/xarrow:0.3.1": *
#import "@preview/cetz:0.3.4"

#let definition = thmbox(
  "definition",
  "Definition",
  titlefmt: it => (text(font: "New Computer Modern Sans", weight: "bold", it)),
  namefmt: it => (text(font: "New Computer Modern Sans")[(#it)]),
  inset: 0em,
  base_level: 1,
  separator: [#h(0.1em)*.*#h(0.2em)],
)

#let theorem = thmbox(
  "theorem",
  "Theorem",
  titlefmt: it => (text(font: "New Computer Modern Sans", weight: "bold", it)),
  namefmt: it => (text(font: "New Computer Modern Sans")[(#it)]),
  inset: 0em,
  base_level: 1,
  separator: [#h(0.1em)*.*#h(0.2em)],
)

#let conjecture = thmbox(
  "theorem",
  "Conjecture",
  titlefmt: it => (text(font: "New Computer Modern Sans", weight: "bold", it)),
  namefmt: it => (text(font: "New Computer Modern Sans")[(#it)]),
  inset: 0em,
  base_level: 1,
  separator: [#h(0.1em)*.*#h(0.2em)],
).with(numbering: none)

#let proposition = thmbox(
  "theorem",
  "Proposition",
  titlefmt: it => (text(font: "New Computer Modern Sans", weight: "bold", it)),
  namefmt: it => (text(font: "New Computer Modern Sans")[(#it)]),
  inset: 0em,
  base_level: 1,
  separator: [#h(0.1em)*.*#h(0.2em)],
)

#let slemma = thmbox(
  "theorem",
  "Lemma",
  titlefmt: it => (text(font: "New Computer Modern Sans", weight: "bold", it)),
  namefmt: it => (text(font: "New Computer Modern Sans")[(#it)]),
  inset: 0em,
  base_level: 1,
  separator: [#h(0.1em)*.*#h(0.2em)],
).with(numbering: none)

#let lemma = thmbox(
  "theorem",
  "Lemma",
  titlefmt: it => (text(font: "New Computer Modern Sans", weight: "bold", it)),
  namefmt: it => (text(font: "New Computer Modern Sans")[(#it)]),
  inset: 0em,
  base_level: 1,
  separator: [#h(0.1em)*.*#h(0.2em)],
)

#let corollary = thmbox(
  "theorem",
  "Corollary",
  titlefmt: it => (text(font: "New Computer Modern Sans", weight: "bold", it)),
  namefmt: it => (text(font: "New Computer Modern Sans")[(#it)]),
  inset: 0em,
  base_level: 1,
  separator: [#h(0.1em)*.*#h(0.2em)],
)

#let example = thmplain(
  "example",
  "Example",
  titlefmt: it => (text(font: "New Computer Modern Sans", style: "italic", it)),
  namefmt: it => (
    text(font: "New Computer Modern Sans", style: "italic")[(#it)]
  ),
  base_level: 1,
  inset: 0em,
  separator: [#h(0.1em).#h(0.2em)],
)

#let note = thmplain(
  "note",
  "Note",
  titlefmt: it => (text(font: "New Computer Modern Sans", style: "italic", it)),
  namefmt: it => (
    text(font: "New Computer Modern Sans", style: "italic")[(#it)]
  ),
  inset: 0em,
  separator: [#h(0.1em).#h(0.2em)],
).with(numbering: none)

#let remark = thmplain(
  "remark",
  "Remark",
  titlefmt: it => (text(font: "New Computer Modern Sans", style: "italic", it)),
  namefmt: it => (
    text(font: "New Computer Modern Sans", style: "italic")[(#it)]
  ),
  inset: 0em,
  separator: [#h(0.1em).#h(0.2em)],
).with(numbering: none)

#let proof = thmproof(
  "proof",
  "Proof",
  titlefmt: it => (text(font: "New Computer Modern Sans", style: "italic", it)),
  namefmt: it => (
    text(font: "New Computer Modern Sans", style: "italic")[(#it)]
  ),
  inset: 0em,
  bodyfmt: body => [#body #h(1fr) $square$],
  separator: [#h(0.1em).#h(0.2em)],
).with(numbering: none)

// Maths operators
#let Arcsin = $op("Arcsin", limits: #true)$
#let cosec = $op("cosec", limits: #true)$
#let Ai = $op("Ai")$
#let Bi = $op("Bi")$
#let xeq = xarrow.with(sym: sym.eq)

// Main
#let project(title: "", authors: (), body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "New Computer Modern", lang: "en")
  show raw: set text(font: "Liga SFMono Nerd Font")
  set enum(numbering: "(i)")

  // Headings use sans font
  show heading: set text(font: "New Computer Modern Sans", weight: "bold")
  show: thmrules

  // Equation numbering
  show heading.where(level: 1): it => {
    it
    counter(math.equation).update(0)
  }
  set math.equation(numbering: num => {
    let chapter_num = counter(heading).get().first()
    numbering("(1.1)", chapter_num, num)
  })

  // Redefine some math symbols
  show math.gt.eq: math.gt.eq.slant
  show math.lt.eq: math.lt.eq.slant
  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
  ]

  // Author information.
  pad(top: 0.5em, bottom: 0.5em, x: 2em, grid(
    columns: (1fr,) * calc.min(3, authors.len()),
    gutter: 1em,
    ..authors.map(author => align(center, raw(author))),
  ))

  // Main body
  set par(justify: true)
  show heading: set block(above: 1.4em, below: 1em)
  set heading(numbering: "1.")

  show link: set text(blue)

  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }
  set list(marker: ([•], [◦], [-], sym.bullet))
  body
}

