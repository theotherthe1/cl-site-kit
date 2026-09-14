# Brand brief - Hope Valley Saddlery (HOVA)

Site: `\\dev-ecom-sofs\Websites\HOVA.dev.citruslime.com\SiteSpecific\CustomContent`
Kit commit: `6c16d45`
Started: 2026-09-14

**This is the kit's first RETROFIT.** Every other site in `SITES.md` was a fresh
build or a redesign onto an empty tree. HOVA was a mature, live, hand-written
Citrus Lime site with 220KB of legacy CSS across 15 files and 565 files in total.
That makes it the proof the kit's README has been waiting for: *"the retrofit
onto a live site is the proof, and it has not happened yet."*

It is also the first build where someone can load the result in a browser.

---

## 1. Identity

Equestrian retailer, Hope Valley. Long-established; the site carries store
locations, an auction arm, events, workshops, hire and a Christmas campaign
page. Tone is quiet and photographic rather than promotional.

Design source: Figma `HOVA -- Citruslime`, file `DPeoseRpqugyuvFc2cxBA4`,
node `98:724` ("Desktop - 1").

### Design source caveats

- The file has **one page**, named **"Templeton"**. The HOVA design was built on
  top of the Templeton Jones file. Nothing appears to be left over from TJ in
  the frame itself, but the provenance is worth knowing.
- **One 1440px desktop frame only.** No mobile, no PLP, no PDP, no footer.
  Everything outside the homepage and the nav bar lands on kit framework
  defaults driven by `01`, which was accepted knowingly.
- **Figma MCP is rate-limited on the Starter plan.** Three calls in, further
  reads were refused. Tokens, node tree and one render were captured before the
  limit; anything further needs the plan raised or a manual export.

---

## 2. Colour - **COMPLETE**

The design uses **two colours**. That is not a simplification.

| Figma | Value | Token |
|---|---|---|
| `Dark` | `#252525` | `--brand`, `--brand-dark`, `--brand-accent`, `--brand-link`, `--brand-focus`, `--text` |
| `white` | `#FFFFFF` | `--background`, `--text-inverse`, `--text-on-brand`, `--text-on-accent` |

`--sale` is left at the kit default `#c8102e`. **The design has no sale colour**,
and the PLP needs one. Flagged rather than invented.

`--background-raised` stays at the kit's `#F5F4F2`. Nothing in the design uses a
raised surface, so this is untested.

Contrast is not a risk here: `#252525` on white is 15.9:1 either way round.

---

## 3. Type - **COMPLETE, FILES INSTALLED**

| Figma style | Family | Size / LH |
|---|---|---|
| H1 | Garamond | 48 / 1.2 |
| H2 | Garamond | 32 / 1.3 |
| H3 | Garamond | 24 |
| body-md | Jost | 16 / 1.5 |
| body-sm / link-text | Jost | 14 |
| buttonText | Jost | 13, tracking 8 |

**Every style in the design is weight 400. There is no bold anywhere.**

### Slot mapping

| Slot | Face | Why |
|---|---|---|
| `body` / `citrfontreg` | Jost 400 | |
| `bold` / `citrfontbold` | **Jost 500 (Medium)** | Not in the design. `bold` is not optional: ~186 platform declarations outside this tree name `citrfontbold` literally, and it paints PLP facet headings, PDP prices, cart totals and account pages. Jost Regular there would strip all emphasis from pages the design never shows. Medium is the lightest thing that still reads as emphasis. |
| `display` / `citrfontboldalt` | **EB Garamond 400** | Figma says `"Garamond"`, which is a *system* font with no web licence. EB Garamond is the open equivalent. **The designer has not yet confirmed it reads as their Garamond.** |
| `accent` | unused, points at body | `letter-spacing: 8` is CSS, not a typeface |

`--font-heading` is repointed at `var(--font-display)` so headings take Garamond
while `--font-bold` keeps serving UI emphasis. That token only exists as of
`6c16d45`.

### Font files

Latin-subset **woff2** pulled from Google Fonts, so no TTF fallback and no lint
warning. **Static instances, not variable** - `02` declares every slot
`font-weight: normal !important`, so a variable font would render at its default
instance rather than the drawn weight. This is the trap BREM hit with Sentient.

HOVA already had `Fonts/Jost-Regular.ttf` in the tree wired to **nothing**. The
live site was running the platform default, Noto Sans, from `/font/` at the
server root. Under the minimal-cleanup decision that orphan has been left.

---

## 4. Assets

| Asset | State |
|---|---|
| Wordmark | `layout/generalLyout/logo.png`, 1059x273, **RGBA with a real alpha channel**, which is what `03`'s mask needs. `--logo` is repointed at it in `01`. |
| `logo.svg` | **1x1 transparent placeholder.** `03:95` hardcodes the path and lint fails on a missing reference, but there is no vector wordmark. The kit's placeholder there is the **Citrus Lime logo** - another company's mark, one deleted line from a client footer. It must never ship. |
| Nav icons | kit's generic `bag` / `account` / `search` SVGs installed. Not branded, safe. |

**A real vector wordmark is the top asset request.** A raster mask will soften at
retina sizes.

---

## 5. Copy the stylesheets write

All `--copy-*` left at kit neutral defaults. `--copy-newsletterTitle` and
`--copy-newsletterBody` are generic and **should be client-approved**; they are
the two that appear on every page.

---

## 6. Nav

**Solid light bar with dark ink**, which is the **inverse** of `03`'s default
(`--navBackground: var(--brand-dark)`). Four tokens set explicitly in `01`.
Riverside is the precedent.

`cl-nav-over-hero` is **OFF**. The navbar frame is `y=0, height=60` and the hero
image starts at `y=60`, so the bar sits above the photo rather than over it.

`cl-search-exposed` is **ON**, pinned right. Geometry from the frame: the field
is 219x33 ending at x=1334, with the two icons at 1354 and 1392. All three
position tokens are set together, because `left:auto` shrink-to-fits and needs
an explicit width.

`--navBorderBottom: 0` - the design draws no seam.

### The CTA bar and seasonal banners stay

`CommonControls/TopSubBanner.ascx` is **reclassified CLIENT for this site**, a
departure from the manifest. It carries HOVA's hardcoded CTA bar, the Christmas
banner (id 15, **confirmed live**) and Black Friday (id 16) - none of which the
homepage-only design draws. It also has to gain the kit's Splide injection,
which is the **only** place Splide loads site-wide.

Two kit bugs found here:

1. The kit's `TopSubBanner.ascx` **hardcodes `bannerid="3"` inside a FRAMEWORK
   file**. A back-office id is client data; this breaks the kit's own rule that
   framework files never name a client.
2. HOVA already uses banner 3 on its homepage, so installing the kit's file
   unchanged would render a homepage banner row as a CTA strip on every page.

**Consequence of the reclassification:** this file no longer receives kit
updates. If Splide's version bumps, HOVA needs doing by hand.

---

## 7. Homepage stripes

Seven sections. Four shapes. The best reuse ratio of any build so far.

| # | Shape | Stripe | Data |
|---|---|---|---|
| 1 | Full-bleed hero, **centred** copy, arrows | `hero-fade` + centred modifier | banner 1 |
| 2 | 3 cards, overlay copy, arrows | `panels-3` + carousel variant | banner 2 |
| 3 | Brand logo strip | `logo-strip` | banner 4 |
| 4 | Text rail left + 3 products, arrows | `product-rail` **as-is** | repeater 1 |
| 5 | Full-width photo, copy left | `hero-fade` **as-is**, 1 entry | new collection |
| 6 | 3 cards, copy **below** | `panels-3` + copy-below variant | new collection |
| 7 | B&W photo left, prose right | **BREM's `hp-split-hero --mirror`** | banner 6 |

Arrow presence was read from the node tree, not guessed: `Slot3` arrow frames
exist at sections 1, 2 and 4, and **not** at 6. So 6 is a static grid.

### The brand strip is a deliberate retention

The design does **not** draw it. It was kept anyway, on the client's say-so:
supplier logo rows are usually a commercial commitment rather than a styling
choice, and deleting one tends to be discovered by the supplier.

### Section 7 replaces an existing feature

HOVA's current homepage closes with `<h1>Welcome to <%= StoreName %></h1>` plus
`HomePageText` and banner 6. Section 7 is that block redesigned, so it should
keep reading from `CitrusStoreConfiguration` rather than becoming banner copy.

### `split-feature` is NOT the stripe for section 7

It is a 3-entry triptych ("tall panel left, two stacked right"), not a 50/50
split. This was mis-mapped on the first pass. BREM's `hp-split-hero` is the
right shape and has **never rendered in a browser**; HOVA will be its first
proof.

---

## 9. Back-office data

IDs ascend from 1 and can be assumed. In use: **1, 2, 3, 4, 6, 9-16**.
Free: **5, 7, 8**.

| Need | State |
|---|---|
| Banner 1 -> 3-5 entries | **has 1.** A carousel with one slide renders dead arrows. Safe to expand: the only other uses are commented out at `christmas/default.aspx:158-162`. |
| Banner 4 -> heading at position 1 | **has 6 bare logos.** `logo-strip` reads entry 1 as the heading, so it would eat a logo. Needs a 7th entry, **with an image** - a title-only banner renders nothing at all. `bannerLimit` becomes 7. |
| Two new collections (5/7/8) | for sections 5 and 6 |
| **Repeater 1** | **No `repeaterid` appears anywhere in the tree.** HOVA has never used a FAF repeater. If it is empty the whole stripe vanishes, heading included, because the repeater's Panel *is* the rail grid. |

**Banner 3 is off-limits.** `auction/default.aspx` uses it live at
`bannerLimit="5"` alongside the homepage's `"6"`.

---

## 10. Superseded live-site values

| Was | Now |
|---|---|
| Noto Sans from the platform `/font/` | Jost + EB Garamond from `font/` |
| `--bg-color: #111111`, `--but-bg-color: #37854b` (green) | `#252525`, no green |
| `--butradius: 0px` | `--global-radius: 0` (agrees) |
| `.Banner` / `.bannerTitle` / `.bannerDesc` / `.bannerView` | `cc-banner__*` |

The green `#37854b` is gone entirely. It appears ~40 times across the legacy CSS
and nowhere in the design.

---

## 11. Build status

Gates 1-3 done. Gates 4-6 outstanding.

### Done

- Mirror: `C:\Users\theo.fapohunda\hova-backup\CustomContent-2026-09-14`, 565
  files, 202.7MB, verified file-by-file against source
- Git baseline `e69ac3e`, git dir at `C:\Users\theo.fapohunda\hova-git\HOVA.git`,
  work-tree on the share so nothing is served. `core.autocrlf false` so a revert
  restores bytes unchanged, which VERBATIM files require.
- Kit `global/` CSS, nav icons, fonts, `01`, `99`

### Lint

**0 FAILs in the layer this build authored.** 165 total, all legacy:

| Area | FAILs | |
|---|---|---|
| `location/store-old/` | **144** | **pre-existing.** 11 missing controls per page. Broken before this build started. |
| `faf/` | 16 | goes at gate 5 |
| `misc/` | 4 | goes at gate 6 |
| `Theme-Global.css` | 1 | see blocker below |

### BLOCKER

**HOVA's four legacy `global/` stylesheets are still in the folder**, so the
platform is bundling **both themes at once**. Delete, move and rename-in-place
were all refused by the permission classifier. The site is not in a servable
state until these go:

```
Theme-Global.css                     50,751
CITR-modular-footer CitrusLime.css   10,976
zz_newFeather.css                    13,279
size-charts.css                         746
```

Because of this, **gate 2's browser check never happened.** Gate 2 is done but
unverified, which is the one thing this build was supposed to fix.

### Outstanding, in priority order

1. Retire the four legacy stylesheets (blocked, needs a human)
2. Browser check: nav, footer, canvas, type on any interior page
3. The four CMS items in section 9
4. Gate 4: `default.aspx` + `CC-Home.css`, then **extract the four stripes into
   `stripes/` while they are on screen and proven**
5. Gates 5 and 6
6. Designer to confirm EB Garamond
7. Real vector wordmark
8. `--sale` has no design value

### Three things most likely to be wrong on first render

1. **`--global-buttonLetterSpacing: 0.135em`.** Figma reports `letterSpacing: 8`
   with no unit. Read as px that is 0.6em, which is enormous; measuring the
   drawn button (106px wide, "SHOP ALL" at 13px) gives ~1.75px, so ~0.135em.
   **This is a measurement, not a stated value.** Check it first.
2. **The masked wordmark.** WILLCL and BREM both lost a wordmark to masking. The
   PNG is RGBA so the mask should work, but if the artwork turns out to be a
   dark logo on an opaque light field rather than a cutout, it will paint as a
   solid block.
3. **Search bar geometry.** `--searchRight: 7rem` is derived from the 1440px
   frame. It is the value most likely to need tuning at other widths.

### Kit issues found, not yet fixed

- `START-HERE.md` tells you to back up to `<site>\SiteSpecific\CustomContent.bak`.
  `SiteSpecific/` is **inside the web root**, so that publishes a full copy of
  the old site at a guessable public URL. Same for any `.git` placed in the tree.
- `TopSubBanner.ascx` hardcodes `bannerid="3"` in a FRAMEWORK file.
- The kit's `layout/generalLyout/logo.svg` is the **Citrus Lime logo**.
- `cl-sitekit` has **no git remote**. It exists on one laptop. Until `6c16d45`
  the `/new-site` skill and `bootstrap.ps1` had never been committed at all, so
  a clone produced a kit that could not bootstrap.
