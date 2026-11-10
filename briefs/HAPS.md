# Brand brief - Hatton Park Saddlery

Built 2026-11-04 from a design export, without the interview: every value
below was read from the design and is recorded as decided by the build, not
confirmed by the client. Kit `cf4069b`, clean checkout. Open items at the end.

---

## 1. Identity

| | |
|---|---|
| Client name | Hatton Park Saddlery |
| Site code | HAPS |
| Live tree | `\\CITRMANWEB26\websites\citruslime.com\HAPS\www.hattonparksaddlery.co.uk\SiteSpecific\CustomContent` - a MATURE live tree on an old theme (33 stylesheets in `modules\CSS\`, own `pages\`, controls, fonts) |
| Mode | `fresh` build into a STAGING copy, for a later retrofit onto live (HOVA's situation). Staged at `C:\Users\theo.fapohunda\HAPS-staging` on the build server, with a local preview harness and a report-first `transfer.ps1` |
| Design source | "Homepage (applied)" design export (Downloads, 2026-11-04): `Homepage.dc.html` (1440) and `Homepage-Mobile.dc.html` (390), plus 17 assets |

**Visual language.** A White canvas with Ink type and one Navy brand colour;
square corners, hairline rules, no shadows. Cormorant Garamond headings,
light and often with one italic word; Inter Tight for everything functional
(12px uppercase-tracked nav, 12px underlined text links, 300-weight copy).
Photography leads under flat Ink scrims.

---

## 2. Colour (from the design)

| Token | Value | What it is |
|---|---|---|
| `--brand` / `--brand-accent` / `--brand-link` | `#193050` Navy | offers bar, filled button, link hover |
| `--brand-focus` | `#0E1D33` | button hover (not in the design - a darker Navy) |
| `--sale` | `#C62828` | the nav's Sale item |
| `--background` / `--background-raised` | `#FFFFFF` / `#F4F5F7` Mist | page / image wells, brand tiles, Ludlow panel |
| `--text` / `--text-inverse` | `#14181F` Ink / `#FFFFFF` | |

`--skin-*`: Slate `#5A6676` (secondary text), Line `#E4E7EB`, Line-strong
`#C3C9D1`, Well `#E8EBEF`, Bullet `#788698`, Navy-soft `#3A5070`; scrims Ink
at 28 / 30 / 20%. Contrast: White on Navy 13.4:1, Ink on White 17.9:1, Slate
on White 5.9:1 and on Mist 5.4:1, Sale on White 5.6:1.

## 3. Type

| Slot | File | Role |
|---|---|---|
| body | Inter Tight 400 | text, nav, links |
| bold | Inter Tight 500 | buttons, platform citrfontbold |
| display | Cormorant Garamond 400 | headings (`--font-heading`) |
| accent | Cormorant Garamond 300 | hero, feature banner, shop the look |
| 99 extras | Inter Tight 300; Cormorant 400 italic and 300 italic | running copy; the italic word |

Static Google Fonts, latin woff2 + full ttf. Radius 0; the search field is
the one pill (999px).

## 4. Assets

Wordmark: the design's PNG (453x170, Navy, transparent knockout) as
`layout/generalLyout/logo.png`, IMAGE mode. Icons: the design's 1.4px line
icons inline in 01. Brand logos for preview were cut from the design's
composite strip into 14 files (preview only).

## 5. Copy

Newsletter "Stay in the know" / "Be the first to hear about new arrivals and
members-only offers."; add to cart "Add to bag".

## 6. Nav

Solid White bar, 80px, Line hairline, no seam, no underline device, 12px
uppercase at 0.1em; `cl-search-exposed` pinned right (280 x 40 pill); Sale as
red text (03's Outlet button device cancelled in 99). CTA strip = Navy offers
MARQUEE (99), banner 3.

## 7. Homepage stripes

| # | Design section | Stripe | Id (provisional) |
|---|---|---|---|
| 1 | Hero carousel | `hero-fade --centreCentre` | banner 11 |
| 2 | Brand ticker | `logo-strip --ticker` (no heading) | banner 12 |
| 3 | Category tiles x4 | `panel-grid --tiles` | banner 13 |
| 4 | Statement line | `cta-close` | banner 14 |
| 5 | Christmas Gifting | `hero-fade --bottomCentre --feature` | banner 15 |
| 6 | New in | `product-rail --stacked` | repeater 11 |
| 7 | Shop the look | `split-list` (YEST's, 2nd occurrence) | banner 16 + repeater 12 |
| 8 | Visit us in Ludlow | `split-panel --image-left --centreCentre` | banner 17 |
| 9 | Shop by brand | `logo-strip --tiles` | banner 18 |
| 10 | SEO block | `statement --seo` | Home Page Text |

Ids skip banners 1-7 and repeater 1, which the old live homepage uses.

## 8. Carousels

Hairline dashes (32 x 1px), bare 1.2px chevrons; rail arrows are 44px
bordered squares in the heading row.

## 10. Build record (2026-11-04)

- Lint PASSED, 0 errors, 4 warnings (2 framework colours; 2 false-positive
  `data-animate` on the logo strips, as MRGL).
- Rendered in a LOCAL harness: the staged CSS in bundle order over the
  platform's own CSS (cut from live `Modules/CSS/global.css` and `home.css` at
  the seam where the site's files begin), the live site's real masthead and
  footer markup, and mocked control markup. Headless Edge at 1440 and at 390
  (via an iframe - headless Edge on Windows will not go below ~500px).
- No new stripe shapes. `split-list` now has two clients (YEST, HAPS).

## 11. PDP (2026-11-04)

From the "Product Page" design export (1440 + 390). No FRAMEWORK file was
changed except one marked local edit (below). CSS: a `#webdes_pdp`-scoped
section in 99 (99 loads before the platform detail CSS and CC-detail on the
PDP, so the id carries it) plus `--skin-pdp*` / icon / `--detail-*` tokens in
01. Three helper scripts in `assets/`, all reused from other estate sites:
`pdpAttributeButtons` + `pdpQtyStepper` (TALE), `pdp-imageLayout` (Trekitt),
made ASCII, retokened, and taught HAPS's word sizes ("Extra Extra Extra Lg").
Previewed in the local harness on the live PDP's rendered markup at 1440 and
390; lint PASSED, 0 errors, 4 warnings (unchanged).

**Kit gap found:** the kit has no hook for a client's own scripts. HAPS's
live `TopSubBanner.ascx` loaded `js/sitelocal.js` (builds the PDP "Why buy"
list) and the kit's replacement does not, so a plain transfer would have
silently dropped it site-wide. HAPS carries a marked local edit of the
framework `TopSubBanner.ascx`; a kit update will overwrite it. Promotion
candidate: a client-scripts include (e.g. a CLIENT `assets/js/client.ascx`
or a `--` token-driven loader) that the framework control renders.

Other promotion candidates (1st occurrence each): a PDP stripe of CSS in the
kit's `detail/` driven by tokens (the 99 section is mostly client-neutral
mechanics); the three PDP helper scripts as kit assets (now on 3 sites).

## Open items

- [ ] Client sign-off on everything above (no interview was held).
- [ ] Back office: banners 11-18, repeaters 11-12, Home Page Text; confirm ids.
- [ ] Banner 3 is used by the old live homepage AND read by the kit's CTA strip.
- [ ] Retrofit: move 33 old-theme stylesheets out of `modules\CSS\`; the kit's
      CSS is site-wide and only the homepage has been previewed.
- [ ] Not built: hero counter, "New in" badge, wishlist hearts, card brand
      names, colour line in shop the look, "Our story" link, "Read more".
- [ ] Promotion candidates: the CTA-strip marquee (1st occurrence), extra
      faces per slot (2nd, after MRGL), `split-list` extraction (2nd).
- [ ] PDP on the platform: add to basket, Click & Collect unlock after a
      size, a product in a range, a product with sibling colours.
- [ ] TopSubBanner.ascx local edit (sitelocal.js + 3 PDP scripts) - re-add
      after any kit update until the kit has a client-scripts hook.
- [ ] PDP not built: AW24 season badge, "Colour: X" line, brand logo beside
      the brand link, wishlist hearts, brand line on related cards.
- [ ] Add a SITES.md row when it goes onto a real tree.
