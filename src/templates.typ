/// General template for most written assignments.
#let assignment(
    title,
    author,
    course-code: none,
    course-name: none,
    pdf-title: auto,
    pdf-author: none,
    title-page: false,
    table-of-contents: false,
    page-size: "us-letter",
    page-margins: 1in,
    main-font: ("New Computer Modern", "Linux Libertine"),
    math-font: ("New Computer Modern Math"),
    code-font: ("New Computer Modern Mono", "Cascadia Code", "Consolas", "SF Mono"),
    footnotes-line-color: blue,
    footnotes-per-page: false,
    doc
) = {
    // A couple "private" defaults
    let par-spacing = 1.40em
    let par-leading = 0.70em

    // =============================================================================================
    // ==== General text styles and spacing
    // =============================================================================================

    // Set fonts
    set text(size: 11pt, font: main-font, lang: "en")
    show math.equation: set text(font: math-font)
    show raw: set text(font: code-font)

    // Block spacing
    set block(spacing: par-spacing) // Default spacing for all blocks, can be overridden
    show heading: set block(above: 1.6em, below: 1.2em)

    // Leading
    set par(leading: par-leading, linebreaks: "optimized")
    set list(indent: 1.25em, spacing: par-spacing)
    set enum(indent: 1.25em, spacing: par-spacing)

    // Remove the regular block spacing underneath that appears after tight lists. This joins them
    // with the paragraphs that follow them.
    let list-show-fn = it => {
        // Also make any equations within them only be `par-leading` away (give or take) from the
        // paragraph before them.
        show math.equation: set block(spacing: par-leading)
        it + v(par-leading, weak: true)
        // (this is a temporary workaround: what would be preferred would be to only put block
        // spacing _between_ two paragraphs, not _before and after every_ paragraph).
    }

    show list.where(tight: true): list-show-fn
    show enum.where(tight: true): list-show-fn

    // Highlight links blue and underline them, but only if they're hyperlinks
    show link: it => {
        if type(it.dest) == str and (
            it.dest.starts-with("http://") or
            it.dest.starts-with("https://") or
            it.dest.starts-with("mailto:") or
            it.dest.starts-with("tel:")
        ) {
            underline(text(fill: rgb(0, 98, 209), it))
        } else {
            it
        }
    }

    // =============================================================================================
    // ==== Page-wide layout
    // =============================================================================================

    set document(
        title: if pdf-title != auto { pdf-title } else [ #title ],
        author: if pdf-author != none { pdf-author } else { () },
    )

    // Creates a block that will extend horizontally outwards by half the page margins.
    let margin-block(body) = {
        set text(size: 0.90em)
        move(dx: -page-margins / 2, block(width: 100% + page-margins, body))
    }

    let header-content = margin-block[
        #if footnotes-per-page {
            counter(footnote).update(0)
        }

        #author #h(1fr) #course-code: #title
    ]

    let footer-content = margin-block[
        #set align(right)
        #counter(page).display("p. 1/1", both: true)
    ]

    set page(
        paper: page-size,
        numbering: "1",
        margin: page-margins,
        header-ascent: page-margins / 2,
        footer-descent: page-margins / 2,
        header: header-content,
        footer: footer-content,
    )

    // =============================================================================================
    // ==== Styles for individual elements
    // =============================================================================================

    // -- Footnotes
    // --------------------------------------------------------

    set footnote.entry(
        gap: 0.5em,
        clearance: 1em,
        separator: line(length: 100%, stroke: (thickness: 0.75pt, paint: footnotes-line-color, cap: "round")),
    )

    show footnote.entry: it => {
        set par(justify: true)
        set text(size: 0.90em)

        let loc = it.note.location()
        let num = numbering(it.note.numbering, ..counter(footnote).at(loc))

        let space = 0.65em
        grid(
            columns: (auto, 1fr),
            column-gutter: 0pt,
            block(inset: (right: space, top: 0.2em), width: 1.7em, align(right, strong(num))),
            block(inset: (left: space, y: 0.2em), stroke: (left: 0.25pt + gray), it.note.body),
        )
    }

    // -- Figures
    // --------------------------------------------------------

    set figure(gap: par-leading * 1.85)

    // Un-justify and shrink figure caption text, make supplement and counter bold
    show figure.caption: it => {
        set text(0.90em)
        set par(justify: false)
        [*#it.supplement #it.counter.display():* #it.body]
    }

    // =============================================================================================
    // ====                                   END OF PREAMBLE                                   ====
    // =============================================================================================

    let title-block = {
        set align(center)
        set par(leading: 1.15em)
        set text(1.15em)

        // If there's a title alone on its own title page, it doesn't need any padding below it.
        let title-padding = if title-page and not table-of-contents {
            0pt
        } else {
            3.25em
        }

        block(below: title-padding)[
            #if course-code != none and course-name != none [
                #course-code: #course-name \
            ] else if course-code != none [
                #course-code \
            ] else if course-name != none [
                #course-name \
            ]
            #text(2.00em, weight: 700, title) \
            #author
        ]
    }

    // If we have a title page, wrap the title block in it its own page with some different spacing
    // first. Otherwise, just spit it out right away.
    if title-page {
        let footer = margin-block[
            #set align(right)
            #counter(page).display("i.")
        ]

        page(numbering: "i", footer: footer, {
            v(0.25fr)
            title-block

            if table-of-contents {
                outline(indent: 2.4em)
            }

            v(1.00fr)
        })

        counter(page).update(1)
    } else {
        // Fix for a "bug?" For some reason, the margin-blocks in the header and footer get shifted
        // to the side
        v(0pt, weak: false)

        title-block
        if table-of-contents {
            outline(indent: 2.4em)
            v(par-spacing * 2, weak: true)
        }
    }

    doc
}
