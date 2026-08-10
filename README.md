# cl-sitekit

A starter kit for Citrus Lime storefronts. A new site should be: fill a brief,
copy the kit, set one CSS file, pick your homepage stripes, write the taste
layer, QA. The framework is the part you never touch.

Extracted from the Templeton Jones build, which remains the worked example.

```
brand-brief.template.md   the intake sheet - every build starts from a filled copy
MANIFEST.md               every file marked FRAMEWORK / CLIENT / VERBATIM
kit/CustomContent/        the tree you copy into a new site
stripes/                  parts bin: 8 pickable homepage stripes + mandatory _shared
examples/templeton-jones/ a finished skin, for reference
docs/                     CONTRACT, BUILD, ADDING-A-STRIPE, QA-CHECKLIST
tools/lint.ps1            the only automated check that exists here
```

## Start here

| I want to... | Read |
|---|---|
| understand what I'm allowed to change | `docs/CONTRACT.md` |
| build or reskin a site | `docs/BUILD.md` |
| pick homepage stripes | `stripes/README.md` |
| add a new stripe shape | `docs/ADDING-A-STRIPE.md` |
| check a build before shipping | `tools/lint.ps1`, then `docs/QA-CHECKLIST.md` |

## What a build actually edits

Six entries, all marked `CLIENT` in `MANIFEST.md`:

| | |
|---|---|
| `modules/CSS/global/01-CC-Brand.css` | the reskin surface: type roles, brand, copy, switches |
| `modules/CSS/global/99-CC-Custom.css` | this client's taste - **rewritten from scratch**, never edited |
| `modules/CSS/home/CC-Home.css` | the homepage, assembled from `stripes/` |
| `default.aspx` | the homepage markup |
| `font/` | three (or four) typefaces |
| `layout/` | wordmark and nav icons |

Everything else is framework and copies forward untouched. That is the update
mechanism: framework files are client-neutral **by construction**, so they can be
overwritten wholesale without being read. `lint.ps1` checks that property holds.

## The three ideas worth knowing

**Roles, not values.** Nothing names a font, a colour or a word directly. Rules
name `var(--font-display)`, `var(--brand)`, `var(--copy-addToCart)`; `01` decides
what those resolve to. A reskin repoints; it does not rewrite.

**Switches, not overrides.** Choices between known options - nav seam, link case,
underline hover, CTA strip, pagination shape, arrow feel - are values in `01`,
not blocks of CSS in the client layer. The default lives with the component that
owns it and is documented there. Turning one off is deleting a line.

**Stripes, not a homepage.** A homepage is a pick and order of eight (so far)
reusable shapes, assembled additively into one page and one stylesheet. Every
rule keys off a class name, never a position, which is what makes them
reorderable.

## Caveats worth stating plainly

- **The refactored framework has not yet rendered in a browser.** It was derived
  from a tree that renders, with equivalence checked change by change and rule
  order preserved deliberately - but the retrofit onto a live site is the proof,
  and it has not happened yet. See `CHANGELOG.md` for what is verified how.
- **There is no build and no test suite.** Editing a file deploys it. `lint.ps1`
  plus `QA-CHECKLIST.md` is the entire safety net.
- **Two hardcoded colours remain** in framework files, flagged by lint rather
  than silently changed: `CC-faf.css:138` and `08-CC-MiniBasket.css:34`.
  Tokenising them changes rendered colour, which is a call to make with the
  design in front of you.
- **The kit's fonts are TTF only.** `@font-face` prefers woff2, so until they are
  converted each slot costs one cheap 404 on cold load. Lint warns.
