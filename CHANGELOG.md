# Changelog

Sites record the kit commit they were built from, in their own `CLAUDE.md`.
`git log` is the detail; this is the shape of it.

---

## Unreleased - the CTA strip is a USP bar

The platform CTA strip (`TopSubBanner.ascx`, banner 3) is now drawn as a USP
bar by default: one row of equal columns, each an icon (the entry's
`ImagePath`) beside a bold Title and a one-line Description, on
`--background-raised` under a 2px `--brand-accent` rule. Under 640px the row
swipes sideways with scroll-snap. First used on Yester (YEST).

- **The old CTA rules were dead.** They targeted the legacy `.bannerTxtCtr` /
  `.photo` markup, but the strip has rendered the maintained control's
  `cc-banner__*` markup since its registration was repointed. Only the panel's
  flex row and the wrapper's background still applied; each entry fell through
  to 04's photo-banner foundation. The block is rewritten against `cc-banner__*`,
  scoped under `.ctaContainer` to out-rank 04.
- **`03` tokens**: new `--ctaBorderTop`, `--ctaBorderBottom`, `--ctaDescColor`,
  `--ctaTitleFontFamily`, `--ctaTitleFontSize`, `--ctaIconSize`, `--ctaIconGap`,
  `--ctaPaddingBlock`. **Changed defaults:** `--ctaBackground` `--brand-dark` ->
  `--background-raised`, `--ctaColor` `--text-inverse` -> `--text`,
  `--ctaDivider` `1px solid var(--white-30)` -> `none`. `--ctaFontSize` now
  sizes the description only.
- **Every entry needs an image.** `BannerCollectionDisplayGrid.ascx` drops an
  entry with no `ImagePath`; that was already true, it now matters. Icons are
  painted as uploaded (no recolouring), so upload them in the bar's colour.
- **`01` template**: commented `--cta*` retune lines beside `--ctaStrip-display`.
  **`99` template**: the "what does not belong here" index names `--cta*`.
- **Sites showing the strip will change look on their next update.** A site
  that wants the old dark text-only bar sets `--ctaBackground`, `--ctaColor`,
  `--ctaBorderTop: 0` in its `01`; there is no text-only mode.

## Unreleased - nav assets are inline SVG

A referenced `.svg` does not display on iPhone. `03` said so in a comment beside
`--icon-search`, which was inline, while its neighbours `--logo`, `--icon-bag`
and `--icon-account` pointed at `.svg` files under `/layout/generalLyout/` -
and the documented reskin method was "replace those files". So every build's
bag and account icons, and every SVG wordmark, were missing on iPhone.

- **`03`**: `--icon-bag` and `--icon-account` default to the kit's own glyphs
  as data URIs (the same artwork as the old files). `--logo` defaults to an
  inline blank bar - never another company's mark; the old `logo.svg` default
  was the Citrus Lime logo.
- **`01` template**: `--logo` is now a live `<<< SET THIS` line; the icon lines
  show data-URI form. The brand-assets comment says every SVG goes in inline.
- **`layout/`**: `logo.svg` and `icons/{bag,account,search,arrow}.svg` deleted,
  so there is nothing to point at.
- **`default.aspx` template** (and the Templeton Jones example): the
  `favicon.svg` link is gone - an SVG favicon is a referenced SVG. `.ico` and
  `.png` cover every browser.
- **`lint.ps1`**: new "svg must be inline" section. FAIL on any `url(...)` in
  CSS, or `src` / `href` / `srcset` / `data-*` / `url()` in `.aspx` / `.ascx` /
  `.html`, that targets an `.svg` (query strings included, `data:` exempt),
  framework files included. FAIL when `01` does not set `--logo`. FAIL when
  `layout/generalLyout/logo.svg` or `icons/{bag,account,search}.svg` exists but
  `01` does not set the matching token - that artwork is no longer shown. WARN on
  any other `.svg` file in the tree.
- **`update-site.ps1`**: before pushing `03`, refuses (exit 3) if the site's
  `01` does not set `--logo`, or keeps `icons/bag.svg` / `icons/account.svg`
  without setting `--icon-bag` / `--icon-account`. It never edits CLIENT files;
  inlining the art is a build task.
- **Docs**: `CLAUDE.md` rule 5b, `BUILD.md` step 3, `START-HERE.md`,
  `brand-brief.template.md` section 4, `/new-site` Q12-Q13, `MANIFEST.md`.

**What a site sees after updating:** nothing, if its `01` already sets the
tokens. Otherwise `update-site.ps1` refuses until it does. **Every site built
before this change needs its `01` edited first** - in each, inline the site's
`layout/generalLyout/logo.svg` (or point at its `.png`) and
`icons/bag.svg` / `account.svg` as data URIs, delete the files, and drop any
`favicon.svg` link from `default.aspx`. YEST is done; MRGL is being done in
parallel; TEMP, RVCL, JESR, WILLCL, BREM and HOVA were not checked.

### Verified how

| Claim | How it was checked |
|---|---|
| The new 03 defaults render | Headless Edge, a CSS-mask test page reading `03`'s `--icon-bag`, `--icon-account`, `--icon-search`, `--logo`: bag, person and magnifier glyphs, and a blank bar |
| Lint catches it | A scratch copy of `kit/CustomContent` with an `.svg` `url()` in `99` (with `?v2`), an `<img src=".svg">` in `default.aspx`, and an `icons/bag.svg` with no `--icon-bag`: three FAILs, plus WARNs for the stray files |
| update-site refuses an unready site | `-DryRun` against YEST before its `01` was fixed: exit 3, naming `icons/bag.svg` and `icons/account.svg` |
| The kit's own copy is still only a blank template | `lint.ps1` on `kit/CustomContent`: 8 `[placeholder]` fails (was 7; `--logo` is the new one), nothing else; `bootstrap.ps1 -Check` OK |
| YEST is clean | `lint.ps1` on YEST after the fix: 0 errors |
| Pure ASCII | `grep -P '[^\x00-\x7F]'` over every changed file |

**Not fixed here, found on the way:** `update-site.ps1 -DryRun` on YEST would
ADD `google54a34bbb51446c1b.html` - the kit's VERBATIM `google*.html` is
another site's Search Console verification file, and the update model pushes it
to every site. That deserves its own change.

---

## Unreleased - 03: the mobile block no longer leaks to desktop

A stray `}` after `.menu-icons-header` in `03`'s `@media (max-width: 1024px)`
block closed it early, and nothing closed it where it was meant to end. The
four rules after the brace applied at every width:

- `body { padding-top: 103px !important }` - the visible one. It beat the
  115px desktop offset, so on desktop the page started 12px under the fixed
  115px bar, hiding the top of the first stripe and of the platform CTA strip.
- `.logoContainer { width: auto !important }` - inert on desktop, since the
  later `--logoWidth` rule wins at the same specificity.
- `#search.srchCtr { max-width: 100% }` and `.ctrNavigation { top: 50px
  !important }` - no desktop effect: `#navi` is not positioned there.

The brace moved to the end of the block; nothing else changed.

**What a site sees after updating:** desktop content moves down 12px and clears
the bar. Mobile is unchanged.

### Verified how

| Claim | How it was checked |
|---|---|
| The leak was real | On MRGL (live render via headless Edge), computed `body` padding-top was 103px at 1440 against a 115px fixed masthead, and the CTA strip started at y=103 |
| Braces balance after the fix | Comment- and string-stripped count: 129 `{`, 129 `}`, never negative |
| Pure ASCII, no client name | `grep -P '[^\x00-\x7F]'` and lint |

Found on MRGL. Any site whose `03` carries the stray brace has the same 12px
overlap; their copies were not checked. Look for the `}` straight after
`.menu-icons-header` in the mobile block before updating each one.

---

## Unreleased - HOVA's carousel arrows become the default

`05` now ships HOVA's arrow as its token defaults: a 39px circular disc on
`--background`, the masked arrow chevron in `--text` (SVG written inline as a data URI, since referenced .svg files do not display on iPhone), hover dims to 0.75
with no scale bounce. `arrow.svg` was already in the kit, byte-identical to
HOVA's. Before this the glyph was opt-in and Splide's own SVG showed.

The hardcoded arrow blocks in `CC-Home.css` and `stripes/_shared/stripe.css`
are gone; they sat at 05's specificity in another bundle and would have
overridden the tokens depending on load order. `hero-fade` drops its
transparent-arrow overrides so the hero takes the disc, as HOVA's does.

A site that wants the old look sets `--splideArrowGlyphContent: none` and
`--splideArrowSvgOpacity: 1` in `01`. Existing sites are unaffected until they
pull a new `05`.

---

## Unreleased - 03: one wordmark only

On mobile the masthead showed two logos. `03` paints the wordmark on
`.logoContainer`, but the platform also paints a logo background on the `.logo`
link inside it (`.logoContainer > .logo.navOption`) at some breakpoints. The
existing `.logoContainer img { visibility: hidden }` only covered the `<img>`
case. `03` now drops the link's background as well, keeping the link itself as
the click target.

### Verified how

| Claim | How it was checked |
|---|---|
| The second logo came from the inner link's background | Reported in DevTools on a built site: the logo background image was set on both `col-1 logoContainer` and `logo navOption` |
| The kit never styles `.logo` itself | `grep '\.logo\b'` over the kit's CSS returns only a commented-out rule, so the background can only be the platform's |
| No site loses its wordmark | Every site gets its wordmark from `.logoContainer` (mask or image mode, both in `03`); nothing in the kit relies on the inner link's paint |
| Pure ASCII, no client name | `grep -P '[^\x00-\x7F]'` and lint's client-name check over the changed files |

**Not proven in a browser.** The platform rule's specificity is unknown; the
new rule is `(0,3,0)`. If a second logo still shows, the platform rule is
heavier and the selector needs raising to match it.

---

## Unreleased - the kit becomes portable, and intake becomes an interview

Two changes to process, no change to any rendered file.

### Portability

Builds happen on a build server over RDP, and until now the things a build needs
were split across two places: the repo, and one laptop's `~/.claude`. The
`/new-site` skill lived only in the user profile, three docs hardcoded
`C:\Users\<someone>\cl-sitekit`, and filled briefs were saved "beside the
project", which is nowhere durable at all.

Everything a build depends on now lives in the repository:

- the skill moved from `skill/new-site.SKILL.md` to `.claude/skills/new-site/`
- filled briefs get a home in `briefs/`, one per site code, committed
- `tools/bootstrap.ps1` sets `CL_SITEKIT`, installs the repo's skills to user
  scope, and checks git / manifest / lint on a fresh machine. Idempotent; `-Check`
  reports without writing
- `docs/PORTING.md` covers the clone, the remote, and the pull-build-push loop
- the three hardcoded paths now resolve through `$env:CL_SITEKIT`

The skill is installed to user scope rather than left project-scoped because
`/new-site` is run in the *site* folder, not in the kit, and a project skill only
loads inside its project. The repo stays the source of truth and bootstrap
overwrites the installed copy from it, so the two cannot silently drift.

### Intake is now an interview

`/new-site` asks one question at a time and writes the brief itself, rather than
handing someone `brand-brief.template.md` to fill in. The script is
`.claude/skills/new-site/INTERVIEW.md`.

The output is unchanged - a filled brief in the template's shape - so nothing
downstream moves. The template remains the schema and hand-filling still works;
a supplied brief is read and only its gaps get asked about.

Two rules do the real work. Blocking questions come first, so stripes and the
transparent-nav decision are settled before colour. And one question may ask for
a lot if one answer naturally carries it: the palette is one question, not
eleven, because eleven turns of the same answer is the form again with extra
steps.

### Verified how

| Claim | How it was checked |
|---|---|
| Bootstrap is idempotent | Ran three times: first run installed the skill and set `CL_SITEKIT`; second and third reported `already set` and `installed and matches the repo`, exit 0 |
| Drift between repo and installed skill is detected | The pre-existing `~/.claude/skills/new-site/SKILL.md` was flagged `DIFFERS from the repo` by `-Check` before the install run overwrote it |
| Bootstrap does not trip on the kit's own placeholders | The kit's `CustomContent` is an unfilled template, so `lint.ps1` exits 1 there by design. Bootstrap matches `^FAIL\s+\[` and excludes `[placeholder]`, reporting `only the 7 expected template placeholders fail` |
| Lint output is actually captured | `lint.ps1` reports via `Write-Host`, so `2>&1` captured nothing and the first version passed vacuously; changed to `*>&1`, which is how the 7 placeholder lines became visible to the check |
| No client name entered a shared file | The new skill, interview, bootstrap and `PORTING.md` name no client. `SITES.md` rows are referenced by site code only |
| Pure ASCII | `grep -P '[^\x00-\x7F]'` over all eleven added and changed files returns nothing |

**Not proven:** none of this has been run on the build server. Bootstrap was
exercised on the development machine only, so the fresh-clone path - no
`CL_SITEKIT`, no `~/.claude/skills`, possibly no git remote reachable - is
reasoned about rather than observed. The interview has not yet been run against
a real client.

## Unreleased - heading face split from bold emphasis

The kit now runs a regular-weight interface: only semantic headings carry the
bold face. Nav links, prices, the sale badge, size chips, stock and form labels,
button text, facet headers and banner titles all render in the body face.

`--font-bold` was doing two jobs at once - 01 said so itself: "semantic headings
(h1-h6) and bold UI emphasis". 31 rules named it, one of them the `h1`-`h6` rule
in `02` and the other 30 various UI furniture. Because both jobs shared a role,
asking for a regular-weight interface took the headings with it.

### New role (`02`, default preserves current behaviour)

`--font-heading`, defaulting to `var(--font-bold)`. The `h1`-`h6` rule in `02` is
the only consumer; the other 30 rules were left on `--font-bold` untouched. The
default lives in `02` because `02` owns the rule that reads it, and it is
`var(--font-bold)` rather than a slot name so a site whose `01` predates the
token needs no edit.

`01` then ships the split set: `--font-heading: 'citrfontbold'` and
`--font-bold: var(--font-body)`.

### What it cannot reach

The platform names `citrfontbold` literally in ~186 declarations outside this
tree, so platform-rendered bold text - basket, checkout, account - stays bold.
The split is therefore visible on platform-heavy pages. Going single-weight
everywhere is an asset change, not a token one: ship the regular face as
`font/bold.*`, leave `--font-bold` on `'citrfontbold'`, and point
`--font-heading` at `var(--font-display)`. Both routes are documented in `01`.

### Verified how

| Claim | How it was checked |
|---|---|
| Existing sites keep bold headings | `examples/templeton-jones/01-CC-Brand.css` sets no `--font-heading`, so `02`'s `var(--font-bold)` default resolves to its `'citrfontbold'` - the same family the `h1`-`h6` rule named before the split |
| `01` beats `02`'s default | `01`'s `:root:root` is (0,2,0) against `02`'s `:root` at (0,1,0), so load order does not matter |
| No circular `var()` | `01` sets `--font-heading` to a family literal, not `var(--font-bold)`, so repointing `--font-bold` at the body face cannot feed back into the heading |
| Only the heading rule changed structurally | `grep -rn font-heading` returns exactly one consumer, `02:327`; the 30 `var(--font-bold)` rules in `03`-`08`, `detail/`, `faf/` and `misc/` are byte-identical |
| Buttons were already on the body face | `--global-buttonFontFamily` in `01` has defaulted to `var(--font-body)` since extraction, so the CTA ramp is unaffected either way |
| Both slots still hold real files | The `@font-face` blocks in `02` are untouched; only the role tokens moved, so the platform's literal `citrfontreg`/`citrfontbold` still resolve |

**Not proven in a browser.** The regular-weight interface has not been rendered
at any width, and the platform/overlay split described above has not been looked
at on a basket or checkout page.

## Unreleased - page container

`.cc-container` wraps the run of homepage stripes between the hero and the
footer and holds it to a maximum measure. Until now every page in the kit was
edge to edge: stripes are full-bleed and inset their own content with
`--gutter`, and a client wanting a fixed measure had no mechanism at all.

The rule lives in `02` (which already owns the page canvas, `--gutter` and the
section rhythm). The wrapper is markup in `default.aspx`, a CLIENT file, so a
design that does not want one deletes the div.

### New tokens (`02`, defaults are a no-op)

`--container-maxWidth: none`, `--container-gutter: 0`. Both are the identity
values for their properties, so the div is a transparent pass-through and adding
it changes nothing. The client value goes in `01`'s switches block, commented
out like the rest of them.

`--container-gutter` defaults to 0 rather than to `--gutter` on purpose: stripes
already apply `--gutter` internally, so a padded container would inset the same
text twice.

### No full-bleed breakout class

A stripe that must stay edge to edge inside a contained page goes outside the
container - close the div before it, open a new one after. The usual
`margin-inline: calc(50% - 50vw)` breakout was rejected because `100vw` counts
the scrollbar, so it overflows the page by the scrollbar width wherever one is
shown. Splitting the container needs no CSS and cannot fail that way.

### Verified how

| Claim | How it was checked |
|---|---|
| The defaults are a no-op | `max-width: none`, `margin-inline: auto` and `padding-inline: 0` on a block element leave it laid out exactly as its parent's content box - no computed geometry changes |
| Nothing keys off body being the stripes' parent | `homepage-nav.js` selects `.wrapper.masthead`, emitted by the platform's TopBanner and outside the new div; the reveal observers select `[data-animate]` by attribute; no rule in `02`-`08` or the stripe library uses a child combinator from `body` or `100vw` |
| `01` will not be overridden by `02`'s default | The container switch sits in an existing `:root:root` block, (0,2,0) against `02`'s `:root` at (0,1,0), so load order does not matter |
| `.grid.fixed` still behaves | Its `max-width: var(--global-NavFooterWidth) !important` is `100%`, which resolves against the container rather than the viewport - the intended effect |

**Not proven in a browser.** No site uses it yet, and the containered layout has
not been rendered at any width.

## Unreleased - exposed search bar switch

Added while building Jesse's e-Rides (JESR), which needed the search input laid
out inline in the bar rather than behind the magnifier toggle.

**`03` already contained a complete "Search Bar (Exposed)" implementation, and
all 48 lines of it were dead** - the section header opened a `/*` that was not
closed until after the mobile block, so the whole thing was one comment. It is
now live, gated on `class="cl-search-exposed"` on `<body>`.

### Why a body class rather than a display token

The obvious shape would have been `--searchToggle-display` / `--searchExposed-display`
in the switches block. It was rejected: the toggle rule
(`.menu-icons-header > .icon-search`) would then need a **default** display value
on every site, including all the ones that never opt in, and the platform styles
that element outside our tree - so a default of `block` risks moving the icon on
a site that asked for nothing. Gating on a class means that with no class no rule
matches at all, which is the only default that is provably a no-op. Same pattern
and same reasoning as `cl-nav-over-hero`.

### New tokens (`03`, defaults preserve previous behaviour)

`--searchMaxWidth` 600px, `--searchHeight` 40px, `--searchRadius`
`var(--global-radius)`, `--searchBorder` `var(--global-border)`,
`--searchPadding` (icon at the left end).

The block's hardcoded `600px` / `40px` / `40px` literals became these tokens on
the way out of the comment. The previously commented-out mobile `max-width: none`
rule is now live, since it is gated too.

Documented in `01`'s switches block and in `default.aspx`'s `<body>` comment,
alongside the `cl-nav-over-hero` opt-in.


### Desktop placement tokens, and a latent centring bug

`#search` is absolutely positioned on desktop and was centred with a literal
`left: calc(50% - 300px)` - **300px being half the 600px default width, coupled
by hand**. Any site that changed `--searchMaxWidth` was left off-centre by half
the difference, with no error and nothing to point at. JESR hit it immediately.

It is now `--searchLeft: calc(50% - (var(--searchMaxWidth) / 2))`, derived from
the token it depends on, so the two cannot disagree. Identical output at the
default.

Added alongside it, all defaulting to current behaviour:

`--searchLeft`, `--searchRight` (`auto`), `--searchWidth` (`auto`), and
`--navIconsWidth` (`250px`, previously a literal on `.menu-icons-header`).

Together they let a site pin the bar beside the icon cluster instead of centring
it - `--searchLeft: auto` + `--searchRight: calc(var(--navIconsWidth) + 1.5rem)`
+ an explicit `--searchWidth`. The width is not optional in that arrangement: an
absolutely positioned box with `left: auto` shrink-to-fits.

**Not proven in a browser.** JESR is the first site to use it.

## Unreleased - initial extraction

Extracted from the Templeton Jones build on `TEMP.dev.citruslime.com`.

**Not yet proven in a browser.** Everything below was derived from a tree that
renders, with equivalence checked change by change, but the retrofit onto a live
site has not happened. Until it does, treat the framework as reviewed rather than
verified.

### Verified how

| Claim | How it was checked |
|---|---|
| The stripe split is lossless | Preamble + `_shared` + 8 stripe files reassemble to byte-identical `CC-Home.css` - 35,244 chars both ways |
| Type scale is desktop-neutral | Every ramp computes to its previous **static** size at 1440px and to its floor at 375px |
| `cl-nav-over-hero` is cascade-neutral | `:has()` contributes its argument's specificity, so `body:has(.hp-hero)` and `body.cl-nav-over-hero` are both (0,1,1); compounds match too |
| Promoted rules keep their order | The transparent-nav run was contiguous in `99` (which loads after `03`-`08`) and is appended at the **end** of `03`, preserving position and internal order. `04`-`08` verified not to touch masthead / logo / icon / splide-pagination selectors |
| The underline switch is desktop-only | `03`'s rule confirmed inside `@media (min-width: 1024px)` at brace depth 2, matching `99`'s old desktop-only kill |
| CTA strip switch is equivalent | Hiding the wrapper takes the container inside it; `99` hid both, which was belt-and-braces |
| `pages/`, `feed/`, `ReturnsPDFs/` untouched | Re-copied from the share and hash-verified, 10/10 byte-identical |
| Lint earns its place | Run against the live un-refactored site it **independently found** the `var(--maxWidth)` bug, the `--tj-*` prefixes and the hardcoded `#fff` canvas |

### Bugs found and fixed

- **`06-CC-Footer.css` referenced `var(--maxWidth)`, declared nowhere** - the
  `max-width` was invalid and silently computed to `none`. The real token is
  `--footer-maxWidth`. Practical effect nil (`width: 100%` on the same rule
  already constrained it), but it is the exact class of bug lint now catches.
- **The transparent-nav mode was keyed to a stripe class name**, in `03` as well
  as `99`. Any client whose hero was a different stripe silently lost nav
  transparency, the scrolled fill and all six panel-open triggers.
- **`SiteSpecific/CustomContent/modules/Controls/BannerCollectionDisplayGrid.ascx`
  was unreachable dead code.** `TopSubBanner.ascx` registered
  `/modules/Controls/...`, a root-absolute path resolving to the **platform's**
  control folder. `CLAUDE.md` told readers to "check both copies" - sending them
  to a file with no effect. Deleted; the registration now points at the
  maintained control, so the CTA strip renders modern markup and becomes a
  usable optional stripe instead of something every build hides.
- **`06-CC-Footer.css` shipped a previous client's newsletter copy** about "the
  latest bikes", kept off the page only by a matching override in `99`. Any build
  that forgot that override would have advertised bikes.
- **The display face was spelled two ways** - `citrfontboldalt` and
  `citrfontboldAlt` - working only because CSS family matching is
  case-insensitive.
- **`02` hardcoded `background: #fff`** while `99` overrode it to
  `var(--background)`, so the token was defeated by default.

### Constraints discovered

- **`font/body.*` and `font/bold.*` are not optional.** Around 186 platform
  declarations under `Modules/CSS/**` and `citr-*.css` name `citrfontreg` and
  `citrfontbold` **literally**. Those rules are outside this tree and cannot be
  repointed, so both slots must always hold a real file - which is why Templeton
  Jones ships two byte-identical text fonts. That is required, not waste.
- **Interior pages carry no hardcoded prose at all.** Every one reads from
  `CitrusStoreConfiguration`, so they are framework files and ship untouched.
- **Clients do not customise platform pages.** `DetailFast.aspx` and
  `FacetResults.aspx` at the site root are byte-identical to the reference site,
  confirming `SiteSpecific/CustomContent` as the correct kit boundary.
- **Bundle order between CSS folders is not guaranteed.** `CC-Home.css` beats
  `05` on specificity, never on order.

### Fixed - the switches were inert (found via a second client)

**Thirteen switches never worked.** `01-CC-Brand.css` loads FIRST; the component
files that declare a token's default (`03` nav, `05` carousels) load AFTER it. Two
`:root` declarations of the same token have identical specificity, so the later one
wins - meaning every value set in the SWITCHES block was silently overridden by the
default it was meant to replace.

On Templeton Jones that shipped as eight live regressions: the CTA strip showing,
the nav seam back, nav links neither uppercase nor letterspaced, the underline-draw
hover returned, carousel dots instead of dashes, and the arrow bounce restored.

Refactor F verified that the switch VALUES matched. It never verified the
declaration could be REACHED. Value equivalence is not cascade equivalence, and
nothing in a CSS pipeline reports this: no error, no warning, just the wrong value.

Fixed structurally rather than with thirteen patches, so tokens added later cannot
inherit the bug: every token block in `01` now uses `:root:root`, which is (0,2,0)
and beats a component's `:root` at (0,1,0) regardless of load order. It does not
disturb the nav state machinery, whose body-level selectors are (0,4,1) and above.
Applied to the kit template, the worked example, and both live sites.

Found only because a second client wanted the opposite of a default. One client
cannot reveal an inert switch, because a switch that does nothing looks exactly
like a default that happens to be right.

Also fixed:
- lint matched the SET THIS instruction prose in `01`'s own header, so a correctly
  filled brand file could never pass. The header now describes the marker without
  reproducing it.
- lint's stripe-header regex was line-anchored, so an indented `==== N. ====`
  header made it report a stripe as having no CSS. Now tolerates leading space.
- lint's client-name check skipped `.js` and read comment-stripped lines - two
  gaps that between them hid a previous client's name in a comment in a JS file.
### Changed

- **Transparent nav is now OPT-IN and off by default.** It was shipping enabled
  in the page template, which is wrong: transparency only works over a full-bleed
  image, so any client whose homepage opened on a light stripe would have got an
  invisible nav and had to know to remove a class. The mechanism is unchanged and
  still gated on `body.cl-nav-over-hero` (21 rules in `03`); only the default
  moved. `03` now states OPT-IN and OFF BY DEFAULT at the head of the block, the
  brief defaults the answer to no, and `01`'s `--navSolid-*` block says plainly
  that those four tokens are inert unless you opt in. Templeton Jones opts in,
  which makes `examples/templeton-jones/default.aspx` the worked example of how.
  Noted while documenting it: the scroll blur/shadow is gated on the same class,
  so a default solid-bar site gets none. That is consistent, but a client wanting
  a scrolled shadow on a solid bar needs a new switch rather than this class.

- **Every maintained file is pure ASCII.** 346 em and en dashes removed, plus box
  drawing, arrows, ellipses, multiplication and section signs - 616 characters in
  all, across both the kit and the live site, comments included. Applies to code
  and prose alike. The vendored `splide.min.*` files and the untouchable
  `pages/`, `feed/` and `ReturnsPDFs/` trees were excluded, and were verified to
  contain none anyway, so nothing was touched that should not have been.

- **Fonts** are role tokens (`--font-body|bold|display|accent`); 56 declarations
  across 11 files converted. Files renamed to their roles, killing the
  `boldAlt`/`boldalt` case trap. `@font-face` prefers woff2 with a ttf fallback.
- **Copy** is 11 `--copy-*` tokens in `01`, consumed as `var(--x, "default")`.
  Two default to nothing on purpose: `--copy-signature` to `none`,
  `--copy-statementEyebrow` to `""` - because the same `::before` draws a
  hairline that `none` would delete.
- **Type scale**: `mdl`-`3xl` are fluid `clamp()`, written `rem + vw` so zoom
  still works. New `--fontSize-mdl` fills the old `1rem`->`2rem` gap. New
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
- **`99` detoxified**: `--tj-*` -> `--skin-*`, `--skin-trackingCaps` (was `0.12em`
  x4), `--skin-navHeight` (was `73px` x8). Client name removed from the headers
  of `03`-`07`. 311 -> 182 lines in the example.

### Deliberately not done

- **The single-row nav stayed client chrome.** It is not expressible as a value:
  besides height it repoints `#navi`, recentres the link row, reverses `03`'s
  scroll-state fade and runs a `pointer-events` dance. Promote it whole when a
  second client wants the same bar - half-tokenising it would be worse than
  leaving it.
- **The search pill, dropdown framing and footer devices stayed too.** Taste, not
  mechanism. Promoting taste is how every future site ends up looking like
  Templeton Jones.
- **The framework's nav height chain is not tokenised.** `02`'s body offset and
  `03`'s 75px/115px desktop heights still hold literals. It spans three files and
  two media queries - worth doing, and exactly the kind of change that looks
  right and renders wrong, so it wants its own pass.
- **No style presets.** With mechanism promoted and switches exposed, a preset is
  a handful of token values. Revisit after client #3, with three real `01` files
  to compare instead of guesses.
- **No `/update-kit` skill.** `MANIFEST.md` is machine-readable so the data is
  ready if it is ever wanted.
- **Two hardcoded colours left flagged** rather than silently changed -
  `CC-faf.css:138`, `08-CC-MiniBasket.css:34`.
