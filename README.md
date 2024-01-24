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
local packages][package-install].

The easiest way to install this package is probably to clone it into your
`{data-dir}` (again, see Typst's guide). More specifically, you can clone a
specific version without any extra history by setting the `--depth` flag to `1`
and using `--branch` to target a tag on this repository.

On Windows, Typst's `{data-dir}` is located in `%LOCALAPPDATA%`. So, in Git
Bash, you might run:

```bash
VER="0.1.0"
mkdir -p "${LOCALAPPDATA}/typst/packages/local/assignmatts"
git clone git@github.com:matthew-e-brown/assignmatts.git \
  --branch "v${VER}" \
  --depth 1 "${LOCALAPPDATA}/typst/packages/local/assignmatts/${VER}"
```


[package-install]: https://github.com/typst/packages/?tab=readme-ov-file#local-packages
