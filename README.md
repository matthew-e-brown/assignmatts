# Assignmatts

This is my personal library of templates and helper functions for my various
assignments, labs, and projects at university.

This has been turned into a package so that:

- I can import it from my `@local` namespace even from different course
  directories.
- So that my friends, who I'm trying to get to use Typst, can use the same theme
  as me. 😄


## Installation

I'm not going to bother putting this on the Typst package repository (at least
not until they add themes as their own thing). Unfortunately, you can't
`#import` from a Git URL yet; to install this package, follow [Typst's guide on
local packages][package-install]. Also unfortunately, the requirement that a
package live within a directory named after its version means that you can't
even get away with cloning this repository into your packages folder. You'll
have to download a fresh copy for ech version you want to use.


[package-install]: https://github.com/typst/packages/?tab=readme-ov-file#local-packages
