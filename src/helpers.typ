/// Returns a new colour based on the first with the given opacity value.
#let transparentize(color, opacity) = {
    let space = color.space()
    let parts = colors.components(alpha: false)
    space(..parts, opacity)
}
