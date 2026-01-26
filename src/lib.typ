#import "./palettes.typ" as palettes

/// A pre-configured block to place questions into.
#let question = block.with(
    width: 100%,
    inset: 1.0em,
    breakable: false,
    stroke: (left: 1pt + gray),
    radius: (right: 1pt),
    fill: luma(240),
)
