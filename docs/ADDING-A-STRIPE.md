# Adding a stripe

The library grows from real client demand, not speculation. Everything currently
in `stripes/` has rendered correctly on a live site - that is the only reason it
can be trusted, and it is the bar a new stripe has to clear.

## Before you add one

Check you actually need a new shape. A different **number of panels**, a
different **aspect ratio**, or a grid where there was a carousel are usually
retunes of an existing stripe, not new shapes. The grid<->carousel swap in
particular is free: both variants of each control pair emit identical class
hooks, so switching which control the `<%@ Register %>` points at changes the
layout mode and the CSS follows.

A new stripe is justified when the **anatomy** differs - a different arrangement
of image, text and CTA, or a different relationship between them.

## Naming

Name it for its **shape**, not for what this client merchandises in it.
`split-feature` describes one tall panel beside two stacked ones and will still
be accurate for the next client. `seasonal-duo` described what Templeton Jones
happened to put there, and was renamed for exactly that reason.

Class is `hp-<name>`, matching the folder.

## Building it

Work in a real site, in `default.aspx` and `CC-Home.css`, and get it rendering
before you extract it. Building it in the parts bin first means shipping
unverified CSS.

**Markup.** One `.col-1` wrapper carrying the class, `data-animate`, and - if it
is a carousel - `data-splide-opts`. Inside it, the platform control(s). No
hardcoded copy: every word comes from the CMS via a banner collection or an FAF
repeater. If the design has a heading you cannot bind, that is a signal to use a
1-item banner collection wrapped in `.CC-HomepageTitles`, not to type it in.

**CSS.** Rules key off the class name only - never off a position or a numbered
section, which is what makes stripes reorderable.

- Tokens only. No raw colour, radius, shadow or font size. If a value is missing,
  add a token to the component that owns it.
- Vertical rhythm from `--section-padding-sm` / `-lg`. A full-bleed opening hero
  carries none at all, so the image runs flush to the nav.
- Horizontal inset from `--gutter`. Do not retype the clamp - it was duplicated
  eight times before it was a token.
- **Chain the carousel height.** Splide's flex layout flows top-down, so a height
  on `.splide` must be passed down explicitly:

  ```css
  .hp-yourstripe .splide { height: clamp(320px, 60vh, 780px); }
  .hp-yourstripe .splide__track,
  .hp-yourstripe .splide__list,
  .hp-yourstripe .splide__slide { height: 100%; }
  ```

  Content-height stripes (product cards, logo rows) omit the chain deliberately.
- Give it a `:not(:has(...))` fallback for the case where the control emits
  partial content. A stripe that collapses badly on incomplete CMS data is a
  stripe that will look broken on someone's launch day.
- If you need to beat `05`'s Splide chrome, use the `[data-splide-opts].hp-yourstripe`
  compound to reach `(0,3,0)`. `.hp-yourstripe` alone ties at `(0,3,0)` with
  `05`'s own selectors and then depends on which bundle loads last - which is not
  guaranteed between folders.

**Comments.** Record *why*, not what. The comments in `CC-Home.css` are the
reason the existing stripes could be refactored safely; a rule whose reasoning is
undocumented is a rule nobody can change later.

## Proving it

In a browser, at 375 / 1024 / 1440:

- it renders correctly with full CMS data
- it degrades sanely with partial data, and disappears cleanly with none
- carousels loop without a drifting gap, and arrows/pagination/keyboard work
- images are sharp at 2x
- no horizontal scroll at 375

## Extracting it into the library

```
stripes/<name>/
  markup.aspx     the .col-1 block, with a  <!-- === N. NAME - shape === -->  header
  stripe.css      the /* ==== N. hp-<name> - ... ==== */ section
```

Then:

- neutralise the control `ID`s - no client prefixes (`TjHero` -> `HeroCarousel`)
- replace back-office ids with `__BANNER_ID__` / `__REPEATER_ID__` so the next
  build cannot silently inherit this client's wiring
- use `N.` in both headers, since the real number depends on the composition
- add a row to the table in `stripes/README.md`: shape, controls, CMS needs
- add any non-obvious trap to that file's "Things that will catch you out". The
  ones already there - `logo-strip`'s `bannerLimit` = logos + 1, the non-empty
  `ImagePath` guard, why `data-splide-skip` must remove rather than hide - are
  each an hour someone else does not have to lose.

Finally, verify the split is lossless: the preamble plus `_shared` plus the
stripe sections should reassemble into exactly the `CC-Home.css` you built. If it
does not round-trip, something was left behind in the page.
