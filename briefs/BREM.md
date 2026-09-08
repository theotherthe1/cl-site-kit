# Brand brief - Bike Remedy

Interview in progress. Anything `?` is unresolved. **required** blocks the build.

---

## 1. Identity

| | |
|---|---|
| Client name | Bike Remedy |
| Site code / folder on the share | `BREM` - `\\dev-ecom-sofs\Websites\BREM.dev.citruslime.com\SiteSpecific\CustomContent` |
| Dev URL | https://BREM.dev.citruslime.com |
| Design source | **Figma, authoritative:** `Bike Remedy -- Citruslime (Copy)`, file key `KQURS5QvnSzALjgsBHZawK`, desktop homepage frame `node-id=8002-472`, 1440x5594. Read as a PNG export plus the frame's CSS dump. **It is a full redesign, not a rebuild of the live look** - different palette, different type, different homepage anatomy. Where it disagrees with the live site, Figma wins. |
| Secondary / superseded | https://www.bikeremedy.co.uk/ - a **Saledock** storefront, so this is a platform migration. Its CSS was read first (`/scss/BikeRemedy.min.css`) and is now **superseded**; kept in §10 only because it still holds the two values Figma does not supply. |

**Mode: `fresh`.** Observed, not assumed: `modules/CSS/` is empty, there is no
`01-CC-Brand.css`, `default.aspx` is the stock share homepage (three
`BannerCollectionDisplayGrid` blocks plus the platform CTA grid), and
`layout/generalLyout/` holds only the placeholder Citrus Lime `logo.png`.

**Visual language, in two or three sentences.** *(written from the design, for
correction - this becomes the header of `99-CC-Custom.css`)*

> One white canvas broken by wide `#F4F4F4` panels, never a border. Type does the
> work: a light serif at negative tracking for every heading, a neutral grotesk
> for everything else. Chrome is square - zero radius on every image, panel and
> the search field - with one deliberate exception, the fully-rounded pill, which
> is the only shape allowed to curve and is reserved for CTAs and carousel
> arrows. Photography is full-bleed and edge-to-edge; where copy sits on it, a
> bottom-up black gradient carries it rather than a scrim or a box.

### Design source access - resolved, but note for next time

The Figma MCP server could **not** read this file. The authorised account is
`theo.fapo@gmail.com`, on Starter plans (KUB x3, Theo, Leadlove) plus BONT on a
View seat. Starter allows **20 read calls per month** and the quota was already
spent: `get_metadata` and `get_screenshot` both failed on first attempt.
`whoami` worked only because identity and write tools are exempt. It is a
monthly cap, so retrying does not help.

Worked around by reading a **PNG export plus the Figma CSS dump**, which is
lossless for our purposes - it gave exact hexes, exact type styles and exact
geometry. If a Citrus Lime Figma org exists and `theo.fapohunda@citruslime.com`
has a Full or Dev seat, moving the file there and re-authorising MCP would give
200-600 calls/day and make the next reskin much cheaper.

---

## 2. Colour - **COMPLETE**

Six tokens are quoted from the Figma frame; two of those names are Figma
variables, given verbatim (`brandColor`, `Dark`). Five states the design never
draws were resolved in the interview and are marked *decided*.

| Token | Value | Source |
|---|---|---|
| `--brand` | `#7ABF41` | Figma variable **`brandColor`** - the green CTA pill on stripe 1 |
| `--brand-focus` | `#619833` | *decided.* Absent from the design; this is the client's own deeper green from the live site, within ~1% of a derived darker `#7ABF41` |
| `--brand-accent` | `#7ABF41` | *decided.* Absent from the design. Add To Cart takes the **primary brand colour**, same pill as the hero CTA. Deliberately identical to `--brand` |
| `--brand-link` | `#1E1E1E` | *decided.* Matches the design's only link - `Shop all`, ink with `text-decoration-line: underline`. **The underline carries the affordance and must not be removed** |
| `--sale` | `#c3193d` | *decided.* Absent from the design but **it will render** - see §7 |
| `--background` | `#FFFFFF` | Figma variable **`white`**; the frame ground |
| `--background-raised` | `#F4F4F4` | the split-section panel and every product card |
| `--text` | `#1E1E1E` | Figma variable **`Dark`** - H1, H2, body, button labels |
| `--text-inverse` | `#FFFFFF` | nav links, and heading/body on the gradient cards |
| `--text-on-brand` | `#1E1E1E` | **the design already does this correctly** - `Shop all` is `#1E1E1E` on the `#7ABF41` pill, never white |
| `--text-on-accent` | `#1E1E1E` | follows from accent being the brand green |

Nav bar tokens - the bar is its own near-black, distinct from `--text`, so all
four `--navSolid-*` must be set rather than left inert:

| Token | Value | Source |
|---|---|---|
| `--navSolid-background` | `#11110F` | `navbar { background: #11110F }` |
| `--navSolid-links` | `#FFFFFF` | all six nav links |
| `--navSolid-linksHover` | `#7ABF41` | *decided.* A static frame cannot show hover. Green on the dark bar is **8.42:1** - the one place the brand green can legibly carry type |
| `--navSolid-icons` | `#FFFFFF` | the three 24px glyphs |

`--brand-accent` being the same value as `--brand` is intentional, not an
oversight - do not "fix" it. The consequence to know: Add To Cart and a browse
CTA are the same pill, so the PDP's primary action has no colour hierarchy of its
own. The alternative considered and rejected was `#1E1E1E` (16.7:1), which would
have given a two-tier system of green-to-browse, black-to-buy.

Two loose ends in the design itself, both worth a decision rather than a silent fix:

- **Product card text is `#000000`, not `#1E1E1E`.** Every other ink in the file
  is `#1E1E1E`. Almost certainly drift rather than intent; using `--text`
  throughout is the tidier answer.
- **The logo green is `#7AC143`, the brand green is `#7ABF41`.** Two different
  greens, ~1% apart. The logo is a placed asset from the old site, so it did not
  get updated when the palette did.

**Contrast check** (computed):

| Pair | Ratio | Verdict |
|---|---|---|
| `--text` `#1E1E1E` on `--background` `#FFFFFF` | 16.7:1 | pass |
| `--text` `#1E1E1E` on `--background-raised` `#F4F4F4` | 15.2:1 | pass |
| `--text-on-brand` `#1E1E1E` on `--brand` `#7ABF41` | **7.43:1** | pass |
| white on `--brand` `#7ABF41` | **2.25:1** | fails - and the design correctly never does this |
| `#FFFFFF` on `--navSolid-background` `#11110F` | 18.9:1 | pass |
| `#1E1E1E` on the white pill | 16.7:1 | pass |

**The design is accessible as drawn.** The one trap - type on the brand green at
body size - it already avoids, by using `#1E1E1E` on the pill and never white.

**The green cannot be used as text at all, in either direction.** Contrast is
symmetric, so the brand green against white is the same failing ratio whichever
one is the ink:

| Pair | Ratio | Verdict |
|---|---|---|
| white on `#7ABF41` | 2.25:1 | fail |
| `#7ABF41` on white | 2.25:1 | fail - the identical pair |
| `#79be40` on white *(live site)* | 2.27:1 | fail |

This is a live-site defect the new design fixes. `bikeremedy.co.uk` sets
`a{color:#79be40}` and `h1,h2,h3{color:#79be40}` - every link and every heading
on that site is green text on white at about 2.27:1, well under the 4.5:1 body
minimum. The redesign correctly demotes the green to a **CTA fill only** and
uses `#1E1E1E` for headings and links. Do not carry the live behaviour over.

---

## 3. Type - **required**

The design names **three** families with named styles. Quoted verbatim:

| Figma style | Family | Weight | Size / line-height / tracking | Used on |
|---|---|---|---|---|
| `H1` | **Sentient Variable** | 300 | 48px / 100% / `-0.04em`, `capitalize` | split-section headings |
| `H2` | **Sentient Variable** | 300 | 32px / 130% / `-0.04em` | section headings, card headings |
| `body-md` | **DM Sans** | 400 | 20px / 130% | all body copy |
| `link-text` | **DM Sans** | 400 | 16px / 100% | nav links, search placeholder |
| `buttonText` | **DM Sans** | 500 | 16px / 100% | CTA labels, "Shop all" |
| *(unnamed)* | **Apfel Grotezk** | 400 | 20px / 120% | product card title |
| *(unnamed)* | **Apfel Grotezk** | 500 | 20px / 120% | product card price |

### Slot mapping - **DECIDED, AND THE FILES ARE INSTALLED.**

| Slot | File installed | Format | Note |
|---|---|---|---|
| `font/body.ttf` | `DMSans-Regular.ttf` (400) | ttf only | **required** - about 186 platform declarations outside our tree name this family literally |
| `font/bold.ttf` | `DMSans-Bold.ttf` (700) | ttf only | **required.** A real Bold, not the design's 500. Everything the platform bolds and we cannot re-template - basket totals, validation errors, table headers - needs to actually look bold |
| `font/display.woff2` + `.ttf` | `Sentient-Light` (300) | **both** | `--font-heading` repoints here, as Williams Cycles did |
| `font/accent.ttf` | `DMSans-Medium.ttf` (500) | ttf only | **a departure**, but a cheaper one than planned - see below |

**Sentient: the STATIC Light, not the variable.** `Sentient-Variable.woff2` was
available and was deliberately not used. `02` declares every slot with
`font-weight: normal !important`, so a variable font would render at its default
instance rather than at 300 - the static Light gives the drawn weight with no
`font-variation-settings` plumbing.

**Three of the four slots are ttf-only, which lint warns about and which is
fine.** Google's DM Sans download ships static `.ttf` only, and no woff2
converter was available on the build machine - Python is the Windows Store stub
and there is no fonttools. This is the kit's documented progressive contract:
`02` lists woff2 first, so each of these three costs **one cheap 404 per cold
load** and about 40% extra bytes until someone converts them. Worth doing, not
worth blocking on.

**Two recorded departures from the design, both deliberate:**

1. **Apfel Grotezk is dropped.** The design uses it on exactly two elements, the
   product card title (400) and price (500). Those live on the PLP and PDP, so
   shipping it would cost a webfont on most pages of the site to restyle two
   lines. **Product cards take DM Sans 400/500 instead.** Both are neutral
   grotesks and the difference at 20px is subtle - Apfel has a slightly quirkier
   `a` and `g`. If the client notices and objects, the reversal is cheap: the
   woff2 files already exist in the WILLCL tree.
2. **Bold is 700 and Medium is 500, shipped side by side.** The kit has one bold
   slot and the design only ever draws 500, so taking the design literally would
   leave every platform-bolded element under-weighted. Shipping both fixes that
   without losing the drawn button weight.

   **Implemented more cheaply than planned.** The intention was a bespoke
   `@font-face` in `99`. In the event the kit already has a fourth slot -
   `citrfontaccent`, reading `font/accent.*`, which `02` declares and which no
   platform rule names - so DM Sans 500 goes there and **`99` needs no
   `@font-face` at all**. Buttons name it through `--global-buttonFontFamily`
   and the product card price through `--font-accent`; `--font-bold` stays on the
   body face, which is what the nav wants.

   Note the accent slot holds a **weight, not a fourth typeface**. That is worth
   saying out loud because the slot is named for a face, and someone will
   otherwise assume Apfel Grotezk went in there.

   `--font-accent` is also the only slot whose value carries a **fallback**
   (`'citrfontaccent', 'citrfontreg'`). The other three are guaranteed to exist -
   lint fails without body and bold, and display ships with the kit - but accent
   is genuinely optional, so without the fallback a build whose `accent.woff2`
   has not landed would drop CTA labels and prices to the browser default rather
   than to the body face.

**Sourcing: the client supplied all files.** Installed from
`Downloads\Sentient_Complete\...\Fonts\WEB\fonts` and `Downloads\DM_Sans.zip`.
Licences were **not** read or verified by the build - that remains the client's
call. What is believed but unverified: DM Sans is open-source (its zip carries
`OFL.txt`); Sentient is Fontshare / Indian Type Foundry. Confirm before go-live.

Apfel Grotezk exists as woff2 in the WILLCL tree if the drop is ever reversed,
though reusing it on a second client site may not be licensed - moot while it
stays dropped.

| | |
|---|---|
| Geometry: `--global-radius` | **`0`** - the search field, every image, every panel and every card outer is `border-radius: 0px` |
| Geometry: `--global-buttonRadius` | **`999px`** - every CTA is `border-radius: 51px` on a 48px-tall box, i.e. a full pill; arrows are `35.5px` on 50px, i.e. a circle |
| One extra radius | `10px` on the product card's inner image tile only. Needs a `--skin-*` token in `99`, exactly as Williams Cycles did for its single rounded crop |
| Nav link case | **as typed** - "Men", "Women", "Gifts & Homeware". No `text-transform`. This is a change from the live site's `uppercase` |
| Nav link tracking | **normal** - no `letter-spacing` on `link-text`. Also a change from the live site's `.05rem` |

Radius is therefore **two deliberate decisions plus one local exception**, the
same shape of answer Williams Cycles needed.

---

## 4. Assets - **required**

| Path | Status |
|---|---|
| `layout/generalLyout/logo.svg` | **INSTALLED.** The client's own Illustrator export, cleaned. `--logo` points here with a `?v1` cache bust, and `99` overrides the mask so it paints in its own two colours |
| `layout/generalLyout/logo.png` | **replaced with a 68-byte transparent 1x1, on purpose** - see below |
| `layout/generalLyout/icons/bag.svg` | **kit default** - decided. 587 bytes, 24x24, single path, built for masking |
| `layout/generalLyout/icons/account.svg` | **kit default** - decided. 1281 bytes, 24x24 |
| `layout/generalLyout/icons/search.svg` | **kit default** - decided. 783 bytes, 24x24 |
| favicons | **client's task, outstanding** - site root, outside this tree, cannot be placed from here. `favicon.ico`, `favicon.svg`, `favicon-96x96.png`, `apple-touch-icon.png`. Note the wordmark is a wide horizontal lockup (119 x 24.8) and **will not reduce to a square** - a mark needs drawing, most likely a single glyph |

The kit icons are 24x24 with `viewBox="0 0 24 24"` and `fill="none"` plus a single
path, which is exactly the size and treatment the design draws, so no icon assets
are needed from the client.

**The wordmark is a two-colour lockup and the kit cannot mask it.** Confirmed
from both sides now. In the Figma frame the logo is 119 x 24.8px and built from
vectors with two fills: `#FFFFFF` on the "bike" glyphs and `#7AC143` on the
"remedy" glyphs. The live site's `bike-remedy-logo.svg` is the same art as an
Illustrator export, with a style block of `.st1{fill:#F5BB60}`,
`.st2{fill:#FFFFFF}`, `.st3{fill:#7AC143}`.

`03` paints `--logo` as a **CSS mask filled with `currentColor`**
(`mask: var(--logo) left center / contain no-repeat`, at `03:1021`), which uses
only the alpha channel. Both files therefore flatten to one colour, losing the
white/green split.

**RESOLVED: the client's SVG, painted rather than masked.**

The plan was a two-tone PNG. When the actual file arrived it turned out to be
**clean vector art with real fills** - not the raster-wrapper trap WILLCL hit -
so painting the SVG directly is strictly better: no rasterising step, and it
stays sharp at any size where a 119px-wide PNG would not on a retina screen. **A
PNG was never produced**, and could not have been: there is no ImageMagick,
Inkscape, rsvg or usable Python on the build machine. If a PNG is preferred
later, drop it in and repoint `--logo`; `99` needs no change.

Note the thing that caught this interview out: **choosing a file format does not
by itself escape the mask.** `03` consumes `--logo` inside `mask:` whatever the
file type. Both a repoint *and* a mask override are required; either alone gives
a single-colour wordmark.

**The mark has TWO failure modes under a mask, not one.** Beyond losing the green
"remedy", the **white cross inside the badge disappears** - it is drawn as a hole
in the green starburst with a white rounded rect showing through, so once every
fill collapses to one colour the cross fills in and the badge becomes a solid
blob. That second failure is the stronger argument against masking.

**What the file turned out to contain.** 12 paths: 5 white (the badge field plus
`b`,`i`,`k`,`e`) and 7 green (`r`,`e`,`m`,`e`,`d`,`y` plus the starburst).
Cleaning removed an **unreferenced `<pattern id="Polka_Dot_Pattern">`** that was
**89% of the file** - 48,760 bytes down to 5,155 - and which carried the only use
of `#F5BB60`, explaining why that amber appears nowhere on the mark. The artwork
paths themselves are unaltered. XML validated.

`99` carries two rules, both about this wordmark, with the four traps recorded
inline: the empty-mask trap, the (0,3,0) specificity of
`.wrapper.masthead .logoContainer`, the empty anchor needing an explicit box, and
clearing **both** the prefixed and unprefixed `mask`.

**`logo.png` is now a 68-byte transparent 1x1.** It cannot be deleted - `06:468`
is a FRAMEWORK file naming it, and lint fails on a CSS reference to a missing
file - but it could not be left either, because the kit's placeholder is the
**Citrus Lime logo**, and one deleted line in `99` would have put another
company's mark in this client's footer. A transparent pixel fails visibly instead
of plausibly.

**Fallback if the two-tone misbehaves in a browser:** supply a flat
single-colour version, delete the `99` nav block, and let the mask do its job -
colour then follows `--navLinks-hover` for free. Cost: the green half and the
white cross.

---

## 5. Copy the stylesheets write

**All framework defaults kept.** Decided - no `--copy-*` token is set for this
client. They can be changed later in `01` with no CSS restructuring.

`--copy-search` needs no attention either way: the design draws "Search" as the
field placeholder, which is already the default.

Worth flagging now: **every string in the design frame is placeholder, and from
the wrong industry.** Body copy throughout reads *"When it comes to clothing,
finding the perfect fit can be a real challenge. That's where made-to-measure
tailoring"* - tailoring copy on a bike site, so the frame was adapted from a
clothing template. Headings read "New Spring Collections" four times, and
"Our Top Picks: Favourite Bikes We Love!" twice. None of it can ship, but almost
all of it comes from the back office rather than from CSS, so it is a CMS task
rather than a build one.

---

## 6. Nav

Read from the design frame:

| Decision | This client | Source |
|---|---|---|
| Bar floats transparent over the first stripe? | **no** | the first stripe starts at `top: 113px`, exactly the bar's height, so it sits below rather than under. Also right for this design: stripe 1's left half is `#F4F4F4`, and a transparent bar over it would put a white wordmark on near-white |
| Solid-state bar | **dark** - `#11110F` ground, `#FFFFFF` links and icons | `navbar { background: #11110F }` |
| Accent seam under the bar | **none** | the design has no `border-bottom` on the bar. A change from both the kit default and the live site, which uses `border-bottom:2px solid #79be40` |
| Underline-draw hover on nav links | **keep** (kit default) | *decided.* A static frame cannot show hover. Consistent with a design whose one link is already underline-as-affordance |
| Platform CTA strip above the bar | **hide** | the bar sits at `top: 0` with nothing above it |
| Exposed search | **yes** - `cl-search-exposed` | switch already exists in `01`; measured geometry below |

Bar anatomy - 113px tall, two rows inside `padding: 20px 40px`, content width 1360:

- **Row 1** (41px): wordmark left at 119px wide -> search field -> two 24px
  glyphs (account, bag). Right-hand group is 343px.
- **Row 2** (16px): the six nav links, left-aligned, 20px gaps - Men, Women,
  Children, Pets, Gifts & Homeware, Brands.
- **Search field**: 255px wide, `max-width: 800px`, 41px tall,
  `background: #1E1E1E`, `border: 1px solid rgba(255,255,255,0.2)`,
  **`border-radius: 0`**, `padding: 1px 10px 1px 19px`, placeholder "Search" in
  DM Sans 400 16px white, 24px glyph at the **right**.

That geometry is very close to what Williams Cycles already measured for the same
switch (800px max, 41px tall, square, hairline white at 20%, glyph right), which
is a good sign the switch will take it without local edits.

**Wordmark is LEFT**, which is the kit default. Note the live site centres it
absolutely - that is being dropped, correctly.

---

## 7. Homepage stripes - **required**

**CONFIRMED.** Five sections, three stripe shapes, in the order below. The blank
canvas under the frame is where the **existing standard footer bar** goes, so the
design is complete as drawn and the footer runs on `06-CC-Footer.css` framework
defaults - it is not a missing section. The live site's **brand logo strip**
(Giant, Specialized, Trek, Liv, Genesis, Frog) is **dropped** and does not appear
in the new homepage; `logo-strip` stays in the library, unused here.

Sections in the frame, in `top` order, with the arrows and pagination resolved to
the stripe they belong to:

| # | `top` | Design section | Anatomy as drawn | Nearest stripe | Verdict |
|---|---|---|---|---|---|
| 1 | 113 | **Split hero carousel** | 1360x665, two 680 halves: text panel left on `#F4F4F4` (`padding: 40px 120px`, H1 48px, body-md, green pill CTA) and full-bleed photo right, radius 0. 50px white circular arrows at the outer edges, vertically centred. **Four 36.5px pagination dashes** bottom-left inside the grey panel, first at full black, other three at `opacity: 0.2` | `hero-fade` | **new shape.** hero-fade is a full-bleed image carousel with text *over* the photo; this constrains the photo to half and puts the copy in a solid panel. Same control and same hooks, so build it *from* hero-fade |
| 2 | 858 | **Product carousel** | heading row - H2 "Our Top Picks..." left, underlined "Shop all" right - above five 283px cards, 10px gaps, each `#F4F4F4` with a 10px-radius inner image tile, then title and price. Clipped at the right edge, and arrows at `top: 1080` | `product-rail` | **retune.** product-rail puts its text in a rail to the *left* of the cards; this puts it in a heading row *above*. Same `FafCustomRepeaterSplide` |
| 3 | 1388 | **2x2 card grid** | four 670x598 image cards at (40,0), (730,0), (40,618), (730,618) - so 20px gaps, no arrows, **not** a carousel. Each has `linear-gradient(360deg, rgba(0,0,0,0.9), rgba(0,0,0,0))` over the photo, radius 0, `padding: 40px`, content bottom-left: H2 32px white, body-md white, white pill CTA with `#1E1E1E` label | `panels-3` | **retune to four.** This is exactly Williams Cycles' `hp-cards-4`, which already exists in that site and is waiting to be extracted into the library |
| 4 | 2688 | **Split feature, mirrored** | same 1360x665 two-half anatomy as #1 but **flipped** - photo left, grey panel right - `padding: 40px` not `40px 120px`, CTA is the **dark** `#1E1E1E` pill not the green one. No arrows, no dashes: **static, one panel** | same as #1 | **variant of #1.** Same stripe, carousel off and halves swapped |
| 5 | 3437 | **Product grid** | same heading row as #2, then **four** 325px cards with `flex-grow: 1` filling the row, 20px gaps. No arrows: **static grid** | same as #2 | **variant of #2.** The kit says the grid/carousel swap is free because both control variants emit identical hooks |

**So it is three stripe shapes, two of which appear twice in different variants** -
which is a much better result than five bespoke sections, and means two of the
five are nearly free once the first is built.

Two findings that matter for the build:

- **The product card maps exactly.** `FafCustomRepeaterSplide` emits `Name`,
  `SellPrice`, `RegPrice`, `IsOnSale`, `ImageURL`, `URL` and `uid`. The design's
  title-and-price card needs `Name` and `SellPrice`, both present - so no new
  control and no data problem.
- **`--sale` is therefore not optional.** Because the repeater emits `IsOnSale`
  and `RegPrice`, a discounted product *will* render sale markup on the
  homepage. The design never draws a sale state, so the token has no design
  value - it needs one anyway.

**All four switches the design needs already exist in `01`** - verified, nothing
needs promoting: `--global-buttonRadius` (pill CTAs over square chrome), the four
`--navSolid-*` (a non-default bar colour), `cl-search-exposed` (the exposed
search), and the dashes pagination marker.

### The two product sections are different sets - **confirmed**

The identical heading on sections 2 and 5 is placeholder duplication, not intent.
They are **two separate FAF repeaters** with different products and different
headings. Section 5's heading is still `?` and comes from the repeater, not from
CSS, so it is a CMS field rather than a build value.

This also means the grid variant is genuinely worth building rather than
collapsing into the carousel - the page shows two distinct product sets, one
browsable and one fixed at four.

### What the frame does not contain, and why that is fine

Content stops at ~3887px of the 5594px canvas. That gap is the **existing
standard footer bar**, confirmed, so nothing is missing from the design:

- **footer + newsletter** - `06-CC-Footer.css` framework defaults. The kit's
  footer already renders a newsletter block on every page, so the live site's
  newsletter section is covered without a stripe.
- **brand logo strip** - deliberately dropped from the new homepage.
- **USP / icon strip** - not in the new design. The platform CTA strip switch is
  a separate decision (§6).

**Two separate footer problems. One was fixed; one is accepted and on the QA
list. Do not conflate them.**

**FIXED - the footer was showing the Citrus Lime logo.** `06:468` hardcodes
`url(/layout/generalLyout/logo.png)`, and that path was still the kit's
placeholder, which is *Citrus Lime's own mark*. A client site was going to ship
with another company's logo in its footer. `99` now repoints it at `var(--logo)`,
and `logo.png` itself was replaced with a transparent 1x1 so the failure mode
cannot come back if that rule is ever deleted. Unlike the nav, `06` already
**paints** rather than masks, so the two-tone needed no further work - only the
URL was wrong.

**ACCEPTED, still outstanding - the white half will be invisible.** `06` puts
the wordmark on a **white** ground, and this mark's "bike" half plus its badge
field are `#FFFFFF`. Predicted from the CSS, not suspected. Raised during the
interview and the decision was to **leave it and flag it** rather than fix it
now, so the footer could be looked at as a whole later. Recorded so the next
person does not think it was missed. The two fixes considered, either of which is
cheap later:

1. Take the footer dark - `#11110F` ground, `#FFFFFF` ink - which also bookends
   the page against the bar. WILLCL lists the exact token set for this in its
   `99`. This was the recommendation.
2. Ship a second dark-ink wordmark for the footer. `06` hardcodes the footer
   wordmark path, so this likely needs a `99` rule too.

Same problem WILLCL recorded, for the same reason.

---

## 8. Carousels

| Decision | This client | Source |
|---|---|---|
| Pagination markers | **dashes** | 36.5px x 1px rules, active solid black, inactive `opacity: 0.2`. The kit has a dashes switch, so this is free |
| Arrow hover | **scale bounce** (kit default) | *decided.* A static frame cannot show hover. Circular white buttons over photography have no other affordance cue, so keeping feedback matters |
| Arrow chrome | 50px white circle, `border-radius: 35.5px`, 2px black chevron, sat at the **outer edges** of the stripe rather than inset | may need retuning in `_shared/stripe.css`, or a `--skin-*` in `99` |

---

## 9. Back-office data

### The five ids are SEQUENTIAL GUESSES and **UNCONFIRMED**

| Stripe | Control | Id | Entries needed |
|---|---|---|---|
| 1. `hp-split-hero` carousel | `BannerCollectionSplide` | `bannerid=1` **?** | **4** - matching the four pagination dashes drawn |
| 2. `hp-product-row` carousel | `FafCustomRepeaterSplide` | `repeaterid=1` **?** | 5+ to justify the carousel |
| 3. `hp-cards-4` | `BannerCollectionDisplayGrid` | `bannerid=2` **?** | **exactly 4** |
| 4. `hp-split-hero` static | `BannerCollectionDisplayGrid` | `bannerid=3` **?** | **1** |
| 5. `hp-product-row` grid | `FafCustomRepeaterGrid` | `repeaterid=2` **?** | **exactly 4** |

Assigned sequentially so lint passes and the build completes. **None is
verified against the back office.** This was a conscious choice, and it makes
BREM the **third consecutive site** built this way after JESR and WILLCL -
`SITES.md` already names that as a pattern. Someone has to reconcile all five.

Why it matters more than it looks: a wrong id does not error and does not render
an empty box. The platform hides the control's `<asp:Panel>` when nothing binds,
so the stripe is simply **absent**. Chasing that from the CSS finds nothing,
because nothing is wrong with the CSS.

So: **three banner collections and two FAF repeaters.** The two repeaters are
distinct sets, confirmed - not one read twice.

Also outstanding, and a CMS field rather than a build value: **section 5's
heading**, which comes from repeater B. Section 2's is
"Our Top Picks: Favourite Bikes We Love!"; section 5 currently duplicates it in
the design and needs its own.

Each banner entry needs title, description and link, because all three are drawn
in the design; the product cards need only `Name` and `SellPrice`, both of which
the repeater already emits.

Reminder of what bites: a stripe with no data **does not render at all** - the
platform hides the control's `<asp:Panel>` when nothing binds, so an empty stripe
means unpopulated data, not broken CSS. On the product rows this takes the
heading with it. And any banner acting as a heading still needs a non-empty
`ImagePath`.

---

## 10. Superseded live-site values

Kept only because the design does not supply them. Do **not** use these where
Figma has an answer.

| Live value | Live use | Status |
|---|---|---|
| `#c3193d` | sale / discount price, 15 uses | **candidate for `--sale`**, which Figma omits |
| `#619833` | deeper green, hovers | **candidate for `--brand-focus`**, which Figma omits |
| `#79be40` | brand green | superseded by `#7ABF41` |
| `#232323` | body ink, 73 uses | superseded by `#1E1E1E` |
| Montserrat 400/700 | the only family | superseded by DM Sans + Sentient + Apfel Grotezk |
| radius `4px` | dominant | superseded by 0 / 999px |
| uppercase nav, `.05rem` | nav links | superseded by as-typed, normal tracking |
| `border-bottom:2px solid #79be40` | seam under bar | superseded by no seam |

---

## 11. Build status

**Built 2026-09-08. Lint exits 0 with 6 warnings. NEVER RENDERED IN A BROWSER.**

Seeded from kit `84afd2b` **plus uncommitted working-tree changes** to
`02-CC-Global.css` and `03-CC-NavigationSearch.css`, which is where
`--font-heading` and the entire `--search*` token set live. **This site depends
on those uncommitted changes** - a clean `84afd2b` copied over it would silently
revert the exposed search and the serif headings. Third consecutive site with
this problem after JESR and WILLCL. Commit the kit and re-stamp all three rows.

### What was written

| File | Kind | State |
|---|---|---|
| `01-CC-Brand.css` | CLIENT | complete - palette, type roles, geometry, button ramp, 4 nav colours, and the switches for the seam, CTA strip, exposed search, dash pagination and circle arrows |
| `default.aspx` | CLIENT | complete - 5 stripes, `cl-search-exposed` on `<body>`, 4 control registrations |
| `CC-Home.css` | CLIENT | complete - shared chrome plus 5 sections in page order |
| `99-CC-Custom.css` | CLIENT | 3 `--skin-*` tokens and **two live rules**, both about the wordmark |
| `font/` | CLIENT | **real files installed** - DM Sans 400/500/700, Sentient Light 300 |
| `layout/` | CLIENT | **wordmark installed and cleaned**; kit icons kept; `logo.png` neutralised |
| `CLAUDE.md` | - | written, in the site tree |

Every switch the design needed already existed in `01` - nothing was promoted
into the framework, and `99` holds only three measurements plus one asset
problem. That is the useful headline: the design was almost entirely expressible
in the existing token vocabulary.

### Lint warnings, and why each is acceptable

**5 warnings, 0 errors.**

- **3x `font/<slot>.ttf` has no `.woff2` sibling** (`body`, `bold`, `accent`) -
  DM Sans ships ttf-only from Google and no converter was available. Costs one
  cheap 404 per slot on cold load. `display` has both, so it does not warn.
- **2x hardcoded colour outside 01** (`CC-faf.css:138`,
  `08-CC-MiniBasket.css:34`) - both in **FRAMEWORK** files, pre-existing in the
  kit, not this site's to fix.

### Outstanding, in priority order

Assets and fonts are **done**. What is left is data, other people's tasks, and
one nice-to-have.

1. **Five back-office ids** - all unconfirmed sequential guesses. The highest
   risk item on the list: a wrong id makes a whole section vanish silently.
2. **CMS data** - 3 banner collections (4 / 4 / 1 entries), 2 FAF repeaters
   (5+ / exactly 4). Nothing renders without it.
3. **Section 5's heading** - comes from repeater B, not from CSS.
4. **Favicons** - site root, outside this tree. The wordmark is a wide
   horizontal lockup and will not reduce to a square; a mark needs drawing.
   The badge alone is the obvious candidate.
5. **Real copy** - every design string is placeholder, and from clothing retail.
6. **Convert the three DM Sans faces to woff2** - clears the last three
   warnings, saves ~40% of the bytes and three cold-load 404s. Needs fonttools
   with brotli on a machine that has a working Python.
7. **A real `logo.png`** - would let `99`'s footer rule be deleted, since `06`
   already paints rather than masks. Optional; the SVG override works.

### Departures from the design, all deliberate and all recorded

| Departure | Why |
|---|---|
| Apfel Grotezk dropped; product cards use DM Sans | it appears on two elements that live on the PLP and PDP, so a whole webfont for two lines |
| Product card price renders at 400, not 500 | one `--font-bold` cannot serve 400 nav links and 500 prices; buttons get 500 explicitly, prices do not |
| Product carousel shows 4 cards, not 4 + a clipped 5th | the exact peek needs `fixedWidth`, which is brittle across viewports; the arrows carry the signal |
| Card Add To Basket hidden | the design's card is photograph, name, price only. **Worth challenging** - it moves every homepage purchase to the PDP |
| Product card ink is `--text` (`#1E1E1E`), not the design's `#000000` | every other ink in the file is `#1E1E1E`; the black looked like drift |
| `--black-80` (0.82) for the card gradient, not the design's 0.9 | closest value on `02`'s ramp, and a token beats a literal |
| Footer wordmark left broken | raised and accepted at brief time. See §7 |

### Three things most likely to be wrong on first render

1. **The search bar's horizontal position.** The design's bar is two rows with
   the search pinned beside a 68px icon cluster; the kit's is one row reserving
   `--navIconsWidth: 250px`. `--searchRight` is a reading, not a measurement.
2. **`hp-split-hero`.** A new shape that has never rendered. Its height chain
   and the `min-height`/`height:100%` pair that serves both the carousel and
   static variants are reasoned, not observed.
3. **The wordmark.** Now real, but it is the one place this build fights the
   framework rather than configuring it, and the same element rendered wrong on
   the first pass at WILLCL. Check both ends: the nav (should be two-tone with a
   white cross in the badge) and the footer (will show only the green half on
   the white ground - that is the accepted defect, not a new bug).

### New stripes not yet in the library

None may enter `stripes/` until proven in a browser at 375 / 1024 / 1440, per
`docs/ADDING-A-STRIPE.md`.

- **`hp-split-hero`** - genuinely new. A carousel of 50/50 splits: copy panel on
  a `#F4F4F4` ground beside a full-bleed photograph. Built from `hero-fade`,
  which lays copy *over* the photograph instead. Carries a `--mirror` modifier
  for the flipped static variant.
- **`hp-product-row`** - `product-rail` retuned: text moves from a left rail to
  a heading row above, arrows return to the card row's edges. Carries a `--grid`
  modifier.
- **`hp-cards-4`** - `panels-3` retuned to a 2x2. **WILLCL already has this
  under the same name** - extract once either has rendered.
