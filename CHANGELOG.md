# Changelog

Sites record the kit commit they were built from, in their own `CLAUDE.md`.
`git log` is the detail; this is the shape of it.

---

## Unreleased — initial extraction

Extracted from the Templeton Jones build on `TEMP.dev.citruslime.com`.

**Not yet proven in a browser.** Everything below was derived from a tree that
renders, with equivalence checked change by change, but the retrofit onto a live
site has not happened. Until it does, treat the framework as reviewed rather than
verified.

### Verified how

| Claim | How it was checked |
|---|---|
| The stripe split is lossless | Preamble + `_shared` + 8 stripe files reassemble to byte-identical `CC-Home.css` — 35,244 chars both ways |
| Type scale is desktop-neutral | Every ramp computes to its previous **static** size at 1440px and to its floor at 375px |
| `cl-nav-over-hero` is cascade-neutral | `:has()` contributes its argument's specificity, so `body:has(.hp-hero)` and `body.cl-nav-over-hero` are both (0,1,1); compounds match too |
| Promoted rules keep their order | The transparent-nav run was contiguous in `99` (which loads after `03`–`08`) and is appended at the **end** of `03`, preserving position and internal order. `04`–`08` verified not to touch masthead / logo / icon / splide-pagination selectors |
| The underline switch is desktop-only | `03`'s rule confirmed inside `@media (min-width: 1024px)` at brace depth 2, matching `99`'s old desktop-only kill |
| CTA strip switch is equivalent | Hiding the wrapper takes the container inside it; `99` hid both, which was belt-and-braces |
| `pages/`, `feed/`, `ReturnsPDFs/` untouched | Re-copied from the share and hash-verified, 10/10 byte-identical |
| Lint earns its place | Run against the live un-refactored site it **independently found** the `var(--maxWidth)` bug, the `--tj-*` prefixes and the hardcoded `#fff` canvas |

### Bugs found and fixed

- **`06-CC-Footer.css` referenced `var(--maxWidth)`, declared nowhere** — the
  `max-width` was invalid and silently computed to `none`. The real token is
  `--footer-maxWidth`. Practical effect nil (`width: 100%` on the same rule
  already constrained it), but it is the exact class of bug lint now catches.
- **The transparent-nav mode was keyed to a stripe class name**, in `03` as well
  as `99`. Any client whose hero was a different stripe silently lost nav
  transparency, the scrolled fill and all six panel-open triggers.
- **`SiteSpecific/CustomContent/modules/Controls/BannerCollectionDisplayGrid.ascx`
  was unreachable dead code.** `TopSubBanner.ascx` registered
  `/modules/Controls/...`, a root-absolute path resolving to the **platform's**
  control folder. `CLAUDE.md` told readers to "check both copies" — sending them
  to a file with no effect. Deleted; the registration now points at the
  maintained control, so the CTA strip renders modern markup and becomes a
  usable optional stripe instead of something every build hides.
- **`06-CC-Footer.css` shipped a previous client's newsletter copy** about "the
  latest bikes", kept off the page only by a matching override in `99`. Any build
  that forgot that override would have advertised bikes.
- **The display face was spelled two ways** — `citrfontboldalt` and
  `citrfontboldAlt` — working only because CSS family matching is
  case-insensitive.
- **`02` hardcoded `background: #fff`** while `99` overrode it to
  `var(--background)`, so the token was defeated by default.

### Constraints discovered

- **`font/body.*` and `font/bold.*` are not optional.** Around 186 platform
  declarations under `Modules/CSS/**` and `citr-*.css` name `citrfontreg` and
  `citrfontbold` **literally**. Those rules are outside this tree and cannot be
  repointed, so both slots must always hold a real file — which is why Templeton
  Jones ships two byte-identical text fonts. That is required, not waste.
- **Interior pages carry no hardcoded prose at all.** Every one reads from
  `CitrusStoreConfiguration`, so they are framework files and ship untouched.
- **Clients do not customise platform pages.** `DetailFast.aspx` and
  `FacetResults.aspx` at the site root are byte-identical to the reference site,
  confirming `SiteSpecific/CustomContent` as the correct kit boundary.
- **Bundle order between CSS folders is not guaranteed.** `CC-Home.css` beats
  `05` on specificity, never on order.

### Changed

- **Fonts** are role tokens (`--font-body|bold|display|accent`); 56 declarations
  across 11 files converted. Files renamed to their roles, killing the
  `boldAlt`/`boldalt` case trap. `@font-face` prefers woff2 with a ttf fallback.
- **Copy** is 11 `--copy-*` tokens in `01`, consumed as `var(--x, "default")`.
  Two default to nothing on purpose: `--copy-signature` to `none`,
  `--copy-statementEyebrow` to `""` — because the same `::before` draws a
  hairline that `none` would delete.
- **Type scale**: `mdl`–`3xl` are fluid `clamp()`, written `rem + vw` so zoom
  still works. New `--fontSize-mdl` fills the old `1rem`→`2rem` gap. New
  `--gutter` replaces a clamp repeated verbatim eight times. *(`02`'s comment
  already described a fluid scale that had never been implemented.)*
- **Mechanism promoted** out of the client layer: the masked wordmark and nav
  icons, and the whole transparent-over-hero mode, now live in `03`. The page
  canvas moved to `02`.
- **Switches** exposed: `--navBorderBottom`, `--nav-fontSize`,
  `--navItems{LetterSpacing,TextTransform}`, `--navUnderline-display`,
  `--ctaStrip-display`, `--navIconSize`, `--logo`, `--icon-*`,
  `--splidePagination{Width,Height,Radius,WidthActive}`,
  `--splideArrowHover{Color,Opacity,Scale}`.
- **Stripes renamed by shape**: `hp-hero-fade`, `hp-product-rail`,
  `hp-panels-3`, `hp-logo-strip`, `hp-split-feature`, `hp-icon-strip`,
  `hp-statement`, `hp-cta-close`.
- **`99` detoxified**: `--tj-*` → `--skin-*`, `--skin-trackingCaps` (was `0.12em`
  ×4), `--skin-navHeight` (was `73px` ×8). Client name removed from the headers
  of `03`–`07`. 311 → 182 lines in the example.

### Deliberately not done

- **The single-row nav stayed client chrome.** It is not expressible as a value:
  besides height it repoints `#navi`, recentres the link row, reverses `03`'s
  scroll-state fade and runs a `pointer-events` dance. Promote it whole when a
  second client wants the same bar — half-tokenising it would be worse than
  leaving it.
- **The search pill, dropdown framing and footer devices stayed too.** Taste, not
  mechanism. Promoting taste is how every future site ends up looking like
  Templeton Jones.
- **The framework's nav height chain is not tokenised.** `02`'s body offset and
  `03`'s 75px/115px desktop heights still hold literals. It spans three files and
  two media queries — worth doing, and exactly the kind of change that looks
  right and renders wrong, so it wants its own pass.
- **No style presets.** With mechanism promoted and switches exposed, a preset is
  a handful of token values. Revisit after client #3, with three real `01` files
  to compare instead of guesses.
- **No `/update-kit` skill.** `MANIFEST.md` is machine-readable so the data is
  ready if it is ever wanted.
- **Two hardcoded colours left flagged** rather than silently changed —
  `CC-faf.css:138`, `08-CC-MiniBasket.css:34`.
