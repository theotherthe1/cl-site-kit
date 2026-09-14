# Brand brief - Williams Cycles

Interview in progress. `?` = still to resolve, not a blank to skip.
Anything marked **required** blocks the build.

---

## 1. Identity

| | |
|---|---|
| Client name | Williams Cycles (as spelled in the design and on the live domain; the ask said "William Cycles" - confirm) |
| Site code / folder on the share | `WILLCL` - `Z:\WILLCL\WILLCL.dev.citruslime.com\SiteSpecific\CustomContent` (a symlink to `\\dev-ecom-sofs\Websites\WILLCL.dev.citruslime.com\SiteSpecific`) |
| Dev URL | `WILLCL.dev.citruslime.com` |
| Live site | https://www.williams-cycles.co.uk/ |
| Design source | Figma `BpFojiIi3E5wWqamXwkhy1`, page **Templeton**, frame **`8002:472` "Desktop - 2"** - the only Williams Cycles homepage frame on the board. Desktop 1440 only; no mobile frame, so mobile is the kit responsive behaviour plus judgement. The file is a *copy of the RVCL (Riverside) file*, so most of the canvas is unrelated Templeton Jones / moodboard material. |

Build mode: **fresh**. Observed 2026-09-07: the tree held only a stock platform
`default.aspx` (`hmBanner1/2/3` + `ctaGrid`), `CommonControls/TopSubBanner.ascx`,
`layout/generalLyout/logo.png`, `Feed/promotions.tsv`, an empty `sitemap.xml`
and an empty `modules/CSS/`. No `01-CC-Brand.css` and no CSS anywhere, so
nothing has been skinned here yet.

**Visual language, in two or three sentences.**

> Near-black canvas as the default ground, not white: the bar, the hero and the
> closing feature all sit on `#050505`, with two white bands cut into the middle
> of the page to carry the statement and the merchandising. Type is heavy
> uppercase grotesk, set tight and large for every heading, with small
> sentence-case body beneath it. The one bright note is a saturated yellow, used
> only for the wordmark and for pill CTAs and never as a field. Chrome is
> hard-edged - square corners, hairline outlines on the search field and product
> tiles - with two deliberate exceptions: the fully rounded yellow pill buttons
> and circular carousel arrows, and one rounded crop on the closing feature
> image.
>
> *(Written from the Figma frame - correct anything that misreads the intent.)*

---

## 2. Colour - **required**

Agreed 2026-09-08. The design carries only three raw values (`#050505`,
`#FFD20A`, `#FFFFFF`), so four of the eleven are derived rather than read - they
are marked below, and they are the ones to revisit if a brand guide turns up
later.

| Token | Value | What it is |
|---|---|---|
| `--brand` | `#050505` | the primary. Drives `--background-inverse`, which is what the hero and closing fields paint with |
| `--brand-focus` | `#050505` | the deep/focus shade; `--brand-dark` points at this, and `03` reads `--navBackground: var(--brand-dark)`, so the black bar comes free |
| `--brand-accent` | `#FFD20A` | the yellow. Used only for pill CTAs and the wordmark, never as a field |
| `--brand-link` | `#050505` | **derived** - no coloured link anywhere in the frame |
| `--sale` | `#c8102e` | **derived** - kit default; nothing in the design speaks to it |
| `--background` | `#FFFFFF` | the two white bands in the middle of the page |
| `--background-raised` | `#F5F4F2` | **derived** - kit default; the product tile ground reads as a near-white grey |
| `--text` | `#050505` | body ink |
| `--text-inverse` | `#FFFFFF` | ink on dark surfaces |
| `--text-on-brand` | `#FFFFFF` | ink sitting on `--brand` |
| `--text-on-accent` | `#050505` | ink sitting on `--brand-accent`. **Dark, not white:** white on this yellow is 1.45:1 and fails outright |

**Contrast check.** `--text` on `--background`: **20.3:1**. `--text-on-brand` on
`--brand`: **20.3:1**. `--text-on-accent` on `--brand-accent`: **14.0:1**. The
derived `--sale` on `--background`: **5.9:1**. All clear of the 4.5:1 body
minimum, so nothing here needed renegotiating.

**What this mapping buys.** The black bar with white links and white icons IS the
framework default once `--brand-focus` is black (`03`: `--navBackground:
var(--brand-dark)`, `--navIcons: var(--text-inverse)`, `--navLinks: 0.85 alpha of
it), so nav needs no colour work at all.

**What it does not.** The yellow wordmark. `.logoContainer` is a mask painted with
`currentColor` and `03` gives it `--navLinks-hover`, which is white here. Yellow
wordmark over white links therefore needs one rule, which goes in `99` - and it is
a **promotion candidate**: a `--logoColor` switch in `03` defaulting to
`var(--navLinks-hover)` would preserve current behaviour exactly. Left in `99` for
now because the kit promotes on the second occurrence, and this is the first.

---

## 3. Type - **required**

**Two families, four faces.** Read off the frame (nodes `8005:733`, `8005:971`,
`8002:473`): the whole page is **Apfel Grotezk** in three weights, with **Work
Sans SemiBold** used for button labels only.

Source pack: `C:\Users\theo.fapohunda\Downloads\apfel-grotezk-main (2)\apfel-grotezk-main\fonts`
(Regular / Mittel / Satt / Fett / Brukt, each as `.woff2`, `.woff` and `.otf`).

| Slot | Face | File supplied | Role |
|---|---|---|---|
| `font/body.woff2` | Apfel Grotezk **Regular** | `ApfelGrotezk-Regular.woff2` | running text, inputs, CTA labels |
| `font/bold.woff2` | Apfel Grotezk **Mittel** | `ApfelGrotezk-Mittel.woff2` | nav links, prices, labels, bold UI, and button labels |
| `font/display.woff2` | Apfel Grotezk **Satt** | `ApfelGrotezk-Satt.woff2` | every heading on this design, not just stripe statements |
| `font/accent.*` | - | **not used** | see below |

**woff2 only, and that is fine.** The pack ships no `.ttf`. `02` lists woff2
first in every `src` and every browser in scope takes it, so the ttf fallback is
never requested - unlike the reverse case (ttf-only), which costs one 404 per
slot on cold load.

**Work Sans was dropped** (decided 2026-09-08). The design set button labels in
Work Sans SemiBold, the one non-Apfel face on the page, and it was not in the
pack. Rather than fetch a second family for one string, button labels render in
Apfel Grotezk Mittel: one family across the whole site, one fewer file, and
`--global-buttonFontFamily` points at `var(--font-bold)`. This is a deliberate,
recorded departure from the design on every CTA label.

Consequences for `01` beyond the file drop:

- `--font-heading` must point at `var(--font-display)`, not the default
  `'citrfontbold'`. Satt is the heading face here; Mittel is interface weight.
- `--global-buttonFontFamily` points at `var(--font-bold)` (Mittel), per the
  Work Sans decision above.
- `--font-bold` stays on `'citrfontbold'` (the Mittel file) rather than the kit
  default of pointing it back at body: this design does want nav links and
  labels a weight up from running text.
- `--font-accent` can be left pointed at body, since nothing reads it.

Type specs measured off the frame:

| | |
|---|---|
| Hero title | Satt, 64px, line-height 0.73, tracking -2.56px (-0.04em), uppercase |
| Statement | Satt, 64px, line-height 0.8, tracking -1.28px (-0.02em), uppercase |
| Body | Regular, 20px, line-height 1.3 |
| Nav links | Mittel, 16px, line-height 1, tracking 0 |
| Button label | Work Sans SemiBold, 20px, line-height 1, tracking 0, no uppercasing |

| | |
|---|---|
| Geometry: `--global-radius` | **`0`**, with the button radius broken out to a pill (decided 2026-09-08). Tiles, inputs, panels and the search field are hard-edged as the frame draws them; `--global-buttonRadius` and `--global-buttonRadiusHover` go to `999px`, and the carousel arrows are circles. Radius is therefore two decisions here, not one - a later "soften the corners" has to touch both. The file's `cta-radius: 0` variable is stale and was not followed. |
| Nav link case | sentence case as typed by the CMS author (framework default; matches the frame) |
| Nav link tracking | normal (framework default; matches the frame) |
| Button label case | **not** uppercase - the frame sets "Shop all" as typed, so `--global-buttonTextTransform` moves off its `uppercase` default |

---

## 4. Assets - **required**

All four are available **out of the Figma navbar component** (`8002:473`) and were
pulled and inspected on 2026-09-08.

| Path | Supplied |
|---|---|
| `layout/generalLyout/logo.svg` | **The same art, wrapped - a fallback, not the asset in use.** `03` hardcodes this path as the `--logo` default, so lint fails if it is absent, and putting the kit's placeholder back would leave another brand's mark in the tree. `01` repoints `--logo` at the `.png` instead: an SVG whose content is an embedded raster is not a safe mask source, and when it renders nothing the mask is empty and hides the entire wordmark, including the platform background image beneath it, with no error anywhere. That is exactly what happened on the first pass of this build. **Both files must be replaced together if the wordmark ever changes.** |
| `layout/generalLyout/logo.png` | **Figma export, a 250x80 RGBA PNG** - decided 2026-09-08, in preference to chasing a vector. Kept because `06` reads this exact path for the footer wordmark. The two-line lockup (WILLIAMS / Cycles, plus "Cheltenham Since 1904") in `#FFD20A`. Verified a real transparent cutout: all four corners and the centre gap are A=0, glyph pixels A=255. It is raster in Figma too, not vector - the layer is a placed image. Displayed at 119x40 in the bar, so 250px wide is ~2.1x density. Being a mask, only its alpha is used, so the yellow in the file is irrelevant; the paint comes from the `99` rule in section 2. **`--logo` must be repointed** at the `.png`, since `03` defaults it to `logo.svg`. |
| `layout/generalLyout/icons/bag.svg` | **Figma export** - clean 24x24, one path, `fill="white"`. Opaque, so it masks correctly. |
| `layout/generalLyout/icons/account.svg` | **Figma export** - same shape of file. |
| `layout/generalLyout/icons/search.svg` | **Figma export** - same. Still needed despite there being no search *toggle*: it is the glyph inside the exposed search field. |
| favicons (site root, outside this tree) | **the client is handling these** (confirmed 2026-09-08). `favicon.ico`, `favicon.svg`, `favicon-96x96.png` and `apple-touch-icon.png` sit at the site root, outside `CustomContent`, so the build cannot place them. Until they land the site serves whatever is there now, which is presumably the Citrus Lime default. |

The `logo.png` already in the tree is the **Citrus Lime placeholder**, not a
Williams asset. It gets replaced, not kept.

Nav icons are drawn at **24px** in the frame, so `--navIconSize` moves off its
22px default.

---

## 5. Copy the stylesheets write

**Every one stays on its framework default** (decided 2026-09-08). The footer is
not drawn in the frame, so there was nothing to read for the newsletter pair, and
the client had no wording to give; the defaults are bland but correct rather than
another client's words.

| Token | Default, kept | Note |
|---|---|---|
| `--copy-newsletterTitle` | "Join Our Newsletter" | footer, visible on every page - worth revisiting with the client later |
| `--copy-newsletterBody` | "Sign up for news and offers." | as above |
| `--copy-statementEyebrow` | `""` (empty string) | correct for this design: the statement stripe carries no eyebrow. Must stay an empty string, never `none` - the same `::before` draws the stripe opening hairline via `border-top`, and `none` would delete the rule and the hairline with it |
| `--copy-signature` | `none` | no closing flourish in the design |
| `--copy-addToCart` | "Add To Cart" | |
| `--copy-stockNotification` | "Stock Notification" | |
| `--copy-specialOrder` | "Special Order" | |
| `--copy-comingSoon` | "Coming Soon" | |
| `--copy-search` | "Search" | matches the frame, which places "Search" in the exposed field |
| `--copy-otherColours` | "Other Colours Available" | |
| `--copy-rrp` | "RRP " | |

---

## 6. Nav

Settled 2026-09-08.

| Decision | This client |
|---|---|
| Bar floats transparent over the first stripe? | **no** - the frame shows a solid black bar above a black hero. Transparent here would be invisible by accident rather than a feature, and it also makes the four `--navSolid-*` tokens inert, so they stay untouched. |
| Solid-state bar | **dark**, and it comes free: `03` reads `--navBackground: var(--brand-dark)` which resolves to `#050505`, with `--navIcons: var(--text-inverse)` and `--navLinks` at 0.85 alpha of it. No colour work in the nav at all. |
| Accent seam under the bar | **none** - `--navBorderBottom: 0`. Nothing like it in the frame, and over a black-bar-on-black-hero join the seam would be the only thing marking a seam the design deliberately hides. |
| Underline-draw hover on nav links | **keep** (framework default). A static frame cannot show a hover state, so this is the default rather than a reading. |
| Platform CTA strip above the bar | **hide** - `--ctaStrip-display: none`. The frame shows nothing above the bar; the black field runs to the top of the viewport. |
| Nav link case / tracking | framework defaults, both of which match the frame (as typed by the CMS author, normal tracking) |
| Nav icon size | **24px** - `--navIconSize: 24px`, up from the 22px default, per the frame |
| Exposed search field in the bar | **yes** - `class="cl-search-exposed"` on `<body>` in `default.aspx`. The mode is a body class, not a token. |

**Exposed search geometry, measured off `8002:473`:** the field is 41px tall, no
radius, `1px solid rgba(255,255,255,0.2)` on the `#050505` field, max-width 800px,
flexed to fill the space between wordmark and icons, placeholder "Search" in
Mittel 16px white, and the magnifier glyph sits at the **right** end with 10px of
padding. Bar padding is 40px inline / 20px block with a 15px gap to the nav-link
row. The relevant switches are `--searchMaxWidth`, `--searchHeight`,
`--searchRadius`, `--searchBorder` and the icon-right form of `--searchPadding`.

---

## 7. Homepage stripes - **required**

| # | Stripe | Back-office id | Entries | Notes |
|---|---|---|---|---|
| 1 | `hero-fade`, retuned | `bannerid="1"` **(unconfirmed)** | 3-5 | Split stage rather than full-bleed: copy mid-left on the black field, photo right inside an angled polygon crop. Same control and the same hooks, so the crop and the stage geometry are client chrome, not a new anatomy. Arrows sit at the outer edges; no pagination visible. |
| 2 | `statement` | none - reads `HomePageText` | - | Exact library match. |
| 3 | **NEW** `hp-panel-rail` | `bannerid="2"` **and** `repeaterid="1"` **(both unconfirmed)** | 1 banner + 6 products | Composite, and the reason it is new: the left panel photo comes from a **1-entry banner collection**, while the panel copy and its CTA come from the **FAF repeater** (`repeaterTitle` / `repeaterDesc` / the view-more link), same as `product-rail`. The rail itself is `product-rail` retuned from a carousel to a 2-column by 3-row grid - that swap is free, both control variants emit identical hooks. |
| 4 | `hp-cards-4` - `panels-3`, retuned | `bannerid="3"` **(unconfirmed)** | **5** - entry 1 is the "SERVICES" heading, entries 2-5 are the cards | Four cards in a 2x2 rather than a 3-up row, and card anatomy rather than full-bleed gradient panels: a landscape crop on a raised grey tile, title, one line of body, yellow pill CTA at the card's right. Count and anatomy only, so it is a retune, and it carries over Riverside's entry-1-is-the-heading device. **Renamed off `hp-panels-3`** because that name states a count this band no longer has. Entry 1 still needs a non-empty `ImagePath` or the heading renders nothing at all. |
| 5 | `hp-overlay-feature` - **NEW** | `bannerid="4"` **(unconfirmed)** | 1 | ONE banner entry: a wide crop with a rounded corner, inset on the dark field, with the copy overlaid at its **top-left**. **Corrected during the build:** this was first read as a port of Riverside's `hp-accent-split`, which it is not - there the copy and the crop are two columns side by side, whereas here the copy sits on top of the photograph. Closer to `panels-3`'s overlaid panel with a single full-width entry, which no library stripe provides, so it was authored as a new stripe. |

**All five ids are provisional and unconfirmed** (decided 2026-09-08). They were
assigned sequentially so the build could complete and lint could pass, not read
off the back office. Every one of them is a guess, and the failure mode is
silent: a wrong id binds nothing, the platform hides the control's `<asp:Panel>`,
and the stripe vanishes entirely rather than rendering empty. Check all five
against the back office before anyone judges the page.

Not in this design and therefore not used: `logo-strip`, `icon-strip`,
`split-feature`, `cta-close`.

---

## 8. Carousels

| Decision | This client |
|---|---|
| Pagination markers | **none on the hero** - `"pagination": false` in the hero's `data-splide-opts` JSON, since the frame shows arrows at the outer edges and no markers at all. Options belong in markup, so this costs no stylesheet rule and the kit's marker geometry tokens stay on their defaults for any later carousel. |
| Arrow hover | framework default (scale bounce). Not readable from a static frame. |
| Arrow shape | circles at the outer left and right edges of the stage (`8005:1345`, `8005:1344`: 50x50 frames holding a 15x15 glyph) - geometry for the `hero-fade` retune rather than a switch. |

---

## 9. Back-office data

The build cannot create any of this, and none of it was confirmed as populated
during the interview. An unpopulated collection makes its stripe vanish
entirely rather than render empty, so this list is the difference between a
finished page and a page that looks broken.

- [ ] **Banner 1** (hero), 3-5 entries, each with a real image, Title,
      Description and NavigateLink
- [ ] **Banner 2** (best sellers panel), exactly 1 entry - its image is the whole
      point of the entry
- [ ] **Repeater 1** (best sellers rail), 6 products, **plus the repeater's own
      Title, Description and link** - those three are what the left panel prints
      over the banner photo, so an untitled repeater leaves the panel wordless
- [ ] **Banner 3** (services), **5** entries: entry 1 is the heading, entries 2-5
      are the cards
- [ ] **Banner 4** (closing feature), exactly 1 entry
- [ ] **Home Page Text** - the `statement` stripe reads
      `CitrusStoreConfiguration.HomePageText` and renders nothing without it.
      The design wants "WELCOME TO WILLIAMS CYCLES. SERVING THE CYCLING COMMUNITY
      OF CHELTENHAM SINCE 1904."
- [ ] Delivery description, Returns policy, Privacy policy, opening times,
      address, phone, email - the interior pages read all of these from
      `CitrusStoreConfiguration` and carry no hardcoded prose

Two that bite on this particular composition:

- **Banner 3 entry 1 still needs a non-empty `ImagePath`** even though the CSS
  hides its image slot. `BannerCollectionDisplayGrid.ascx` guards on a non-empty
  `ImagePath`, so a title-only heading entry renders nothing at all and the
  section loses its "SERVICES" heading while the four cards stay.
- **Stripe 3 fails in two halves.** The banner and the repeater are separate
  controls, so an empty banner leaves the copy floating on a dead panel, and an
  empty repeater takes the entire rail with it - including the panel copy, since
  the repeater's own Panel is the grid.

---

## Appendix A - what the Figma frame actually shows

Read from frame `8002:472` on 2026-09-07, before any build work.

**Figma variables, verbatim** (the file own tokens, not kit tokens):

| Figma name | Value |
|---|---|
| `Dark` | `#050505` |
| `brandColor` | `#FFD20A` |
| `white` | `#FFFFFF` |
| `cta-radius` | `0` |
| `heroSection-innerPadding` | `40` |
| `buttonText` | Work Sans SemiBold 20/1, tracking 0 |
| `link-text` | Apfel Grotezk Mittel 16/1, tracking 0 |

`cta-radius: 0` is contradicted by the frame itself, where every "Shop all"
button is a full pill and the carousel arrows are circles. The variable looks
stale; resolved in section 3 rather than guessed.

**Nav bar** (`8002:473`, 1440x113): black field, yellow two-line wordmark at far
left, a **centred exposed search input** with a hairline border and a magnifier
glyph inside it, then account and bag icons in white at far right - **no search
icon**, because search is exposed. Nav links sit on a **single row beneath** the
bar, white, sentence case as typed (Men, Women, Children, Pets, Gifts and
Homeware, Brands). No accent seam under the bar.

**Composition, top to bottom:**

1. **Hero** - black stage, copy at mid-left (heavy uppercase title, two lines of
   body, yellow pill CTA), photograph on the right inside an **angled polygon
   crop** rather than a rectangle. Circular prev/next arrows sit at the far left
   and right edges (`8005:1345`, `8005:1344`), so it is a carousel.
2. **Statement** - "WELCOME TO WILLIAMS CYCLES. SERVING THE CYCLING COMMUNITY OF
   CHELTENHAM SINCE 1904." Large black uppercase on white, full width.
3. **Best sellers** - a dark **photo panel on the left** carrying "BEST SELLERS"
   and a yellow pill CTA, and **six product tiles on the right** in a 2-column by
   3-row grid; each tile is a hairline-outlined light square with the product
   name and price beneath it.
4. **Services** - a "SERVICES" heading above a **2x2 grid of four cards**:
   landscape photo, title, one small line of body, yellow pill CTA.
5. **Closing feature** - back to the black field: copy low-left (uppercase title,
   small line of body, yellow pill CTA) with a **rounded-corner photo on the
   right**. One entry.

Below stripe 5 the frame is empty black - that is where the platform footer
lands, and it is not designed here.

---

## Appendix B - what was actually built, 2026-09-08

Built from kit commit `84afd2b` **plus uncommitted working-tree changes** to
`kit/CustomContent/default.aspx` and to `01`, `02` and `03`. This site's
framework is therefore not exactly that commit; the same is true of Jesse's
e-Rides, which makes it the second occurrence and worth fixing at the source.

**Lint exits 0.** Its two remaining warnings (`CC-faf.css:138`,
`08-CC-MiniBasket.css:34`) are hardcoded colours in framework files the kit
ships, not from this build.

**Files authored:** `01-CC-Brand.css`, `99-CC-Custom.css`,
`modules/CSS/home/CC-Home.css`, `default.aspx`, plus the `font/` and `layout/`
assets. No framework file was edited.

**Departures from the design, all deliberate and each commented where it
happens:**

1. **Button labels are Apfel Grotezk Mittel, not Work Sans SemiBold** - the face
   was not in the supplied pack. Affects every CTA label.
2. **The hero's angled crop is an approximation**, a 7-vertex `polygon()` in
   percentages of the stage rather than a trace of the design's vector. A
   `path()` is in user units and would drift at every viewport width.
3. **The hero photograph does not overhang into the white band below**, as it
   does in the frame. Reproducing that needs the hero to overflow the next
   stripe, which on a full-bleed carousel risks a horizontal scrollbar and
   breaks the slide box.
4. **Stripe 5 carries a soft veil under its copy**; the design has none. White
   copy set straight onto a photograph works for the image the mockup happens to
   show and fails for any lighter one the client uploads later.
5. **Hover states are invented throughout** - a static frame shows none. Every
   CTA holds its geometry and darkens the yellow slightly, rather than taking
   the kit default that re-pads on hover and makes a pill visibly resize.

**The wordmark did not render on the first pass, and it is worth recording why,
because both causes are silent.** `--logo` was pointed at the SVG wrapper, and a
mask that renders nothing hides the whole container including the platform's own
background image beneath it; and the yellow was set on a bare `.logoContainer`
in `99`, which loses to `03`'s `.wrapper.masthead .logoContainer` at `(0,3,0)`
however late `99` loads. Fixed by repointing `--logo` at the `.png` (as Jesse's
e-Rides does), matching the compound selector, and sizing the empty anchor
explicitly - our `03` overrides the platform's container width with `auto`, so
the masked box could otherwise collapse. Full account in the site's `CLAUDE.md`.

**One promotion candidate, deliberately not promoted:** a `--logoColor` token in
`03`, defaulting to `var(--navLinks-hover)`. This design needs a yellow wordmark
against white nav links and one token cannot carry both inks, so it is a rule in
`99` for now. Riverside and Jesse's both take the default, so this is the first
occurrence and the kit promotes on the second.

**Two new stripes, neither extracted:** `hp-panel-rail` and
`hp-overlay-feature`. Nothing enters `stripes/` unproven, and neither has been
rendered.

**Open, and blocking a working page rather than the build:**

- all five back-office ids are unconfirmed guesses
- no CMS data is confirmed populated, including Home Page Text
- favicons, which the client is handling
- **the footer decision.** It runs on framework defaults, which means its
  wordmark - painted by `06` as a plain background image rather than a mask, so
  it shows its own yellow - sits on a white ground and reads weakly. The design
  does not draw a footer, so nothing was invented. The token set for a dark
  footer is listed in `99`, including the social-icon filter that would need
  inverting.
- **nothing has been rendered in a browser.** Lint cannot see whether the hero
  clip, the `display: contents` composition in stripe 3, or the exposed-search
  geometry behave as intended.
