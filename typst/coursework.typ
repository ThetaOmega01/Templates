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
#import "@preview/great-theorems:0.1.2": *
#import "@preview/rich-counters:0.2.1": *

#let question_counter = rich-counter(
  identifier: "questions",
  inherited_levels: 0,
)

#let inquestion = mathblock(
  blocktitle: text(font: "New Computer Modern Sans")[Question],
  counter: question_counter,
  numbering: num => (text(font: "New Computer Modern Sans")[#num]),
)

#let question(body) = block[
  #counter(math.equation).update(0)
  #inquestion[#body]
]

#let answer = mathblock(blocktitle: text(
  font: "New Computer Modern Sans",
)[Answer])

#let claim = mathblock(blocktitle: text(
  font: "New Computer Modern Sans",
)[Claim])

#let proof = proofblock()

// Maths operators
#let Arcsin = $op("Arcsin", limits: #true)$
#let cosec = $op("cosec", limits: #true)$
#let Ai = $op("Ai")$
#let Bi = $op("Bi")$

// Main
#let project(title: "", authors: (), body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "New Computer Modern", lang: "en")
  show raw: set text(font: "Liga SFMono Nerd Font")
  set enum(numbering: "(i)")

  // Theorem styles
  show: great-theorems-init

  // Equation numbering
  set math.equation(numbering: num => {
    numbering("(1.1)", int((question_counter.display)()), num)
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
