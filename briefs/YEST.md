# Brand brief - Yester Equestrian

Interview completed and confirmed 2026-10-16; built the same day (fresh, kit
`e94af47`). Remaining `?` items are listed under "Open items" at the end.

---

## 1. Identity

| | |
|---|---|
| Client name | Yester Equestrian |
| Site code / folder on the share | YEST |
| Site tree | `\\man-ecom-sofs.citruslime.com\Websites\www.yesterequestrian.com\SiteSpecific\CustomContent` |
| Mode | `fresh` (confirmed 2026-10-16) - tree holds only 5 platform files, stock `default.aspx`, no `01-CC-Brand.css` |
| Dev URL | ? |
| Design source | `yester-design-pack` (Downloads, 2026-10-16): `DESIGN.md`, `tokens.css`, `tokens.json`, `reference/homepage.html`, `assets/logos/` |

**Visual language, in two or three sentences.** (confirmed at close)

> One White canvas, deep Ink type and chrome, square corners everywhere, hairline
> sand-coloured rules instead of shadows. Cormorant Garamond serif for headings
> only, Jost uppercase-tracked labels for everything functional. Crest gold is a
> signature used sparingly and only on dark grounds; photography leads and the
> interface stays thin.

---

## 2. Colour - **required** (confirmed 2026-10-16)

| Token | Value | What it is |
|---|---|---|
| `--brand` | `#1C1A17` ink | primary buttons, headings, footer |
| `--brand-focus` | `#3A3632` charcoal | button hover per pack |
| `--brand-accent` | `#1C1A17` ink | pack makes "Add to bag" the ink primary button |
| `--brand-link` | `#8C6B3E` gold-deep | pack: link hover and focus ring |
| `--sale` | `#6E2A2E` oxblood | sale only |
| `--background` | `#FFFFFF` | page canvas throughout |
| `--background-raised` | `#FFFFFF` | cards are white with a `--line` hairline |
| `--text` | `#1C1A17` ink | |
| `--text-inverse` | `#FAF7F2` ivory | |
| `--text-on-brand` | `#FAF7F2` ivory | |
| `--text-on-accent` | `#FAF7F2` ivory | |

Pack colours with no kit token yet (candidates for `--skin-*` in `99`):
`--gold #C89D67` (footer headings, on dark only), `--paddock #3F4F47`
(announcement bar, collection banner), `--line #E3DCD0`, `--stone #5E574E`,
`--mist #77706A`, `--gold-tint #EFE3D1`, `--success #2F5D43`, `--error #A3342F`.

Contrast (computed 2026-10-16): ink on white 17.36:1, ivory on ink 16.25:1,
ivory on charcoal 11.21:1, white on gold-deep 4.90:1, oxblood on white 10.33:1,
stone on white 7.12:1, mist on white 4.87:1, white on paddock 8.68:1, gold on
ink 7.01:1. **Fails:** gold on white 2.48:1 - never use gold text on light.

---

## 3. Type - **required** (fonts decided 2026-10-16)

| Slot | File supplied | Role |
|---|---|---|
| `font/body.woff2` (+ `.ttf`) | Jost 400 - downloaded from Google Fonts (OFL) at build time | running text, inputs, labels |
| `font/bold.woff2` (+ `.ttf`) | Jost 500 - downloaded from Google Fonts at build time (600 is only used for prices) | bold UI, labels |
| `font/display.woff2` (+ `.ttf`) | Cormorant Garamond 500 - downloaded from Google Fonts at build time | all headings |
| `font/accent.*` | Cormorant Garamond 500 italic - downloaded from Google Fonts at build time | |

| | |
|---|---|
| Geometry: `--global-radius` | `0` (pack: square everywhere; 999px only on arrows, swatches, icon buttons) |
| Nav link case | uppercase (pack: 13px, 0.14-0.16em) |
| Nav link tracking | `0.14em` |

---

## 4. Assets - **required** (decided 2026-10-16)

| Path | Supplied |
|---|---|
| `layout/generalLyout/logo.svg` | not used: `yester-wordmark-ink.png` (1119x365, transparent, single colour) copied as `logo.png`, `--logo` repointed (decided 2026-10-16) |
| `layout/generalLyout/icons/bag.svg` | from `reference/homepage.html` inline SVG (24 box, 1.4 stroke) |
| `layout/generalLyout/icons/account.svg` | from `reference/homepage.html` inline SVG |
| `layout/generalLyout/icons/search.svg` | from `reference/homepage.html` inline SVG. Wishlist icon: no kit slot, not added |
| favicons (site root) | generated from `yester-stacked-gold.png` into the scratchpad at build time, for someone to place at the site root (decided 2026-10-16) |

Footer logo per pack: `yester-horizontal-gold.png` on ink, 220px.

---

## 5. Copy the stylesheets write (confirmed 2026-10-16)

| Token | Default | This client |
|---|---|---|
| `--copy-newsletterTitle` | "Join Our Newsletter" | "Join the Yester list" |
| `--copy-newsletterBody` | "Sign up for news and offers." | "New arrivals, private events and early access to the sale." |
| `--copy-addToCart` | "Add To Cart" | "Add to bag" |
| others | defaults | |

---

## 6. Nav

| Decision | Options | This client |
|---|---|---|
| Bar floats transparent over the first stripe? | no / yes | no - solid White header with a hairline |
| Solid-state bar | light / dark | light: white, ink type, `--line` bottom border (confirmed) |
| Accent seam under the bar | keep / none | none (confirmed) |
| Underline-draw hover on nav links | keep / none | none - colour shift to gold-deep instead (confirmed) |
| Platform CTA strip above the bar | show / hide | show - the Paddock announcement bar, banner 3 |

---

## 7. Homepage stripes - **required**

Pack order (DESIGN.md section 7). Ids assigned by the user on 2026-10-16:
"starting from 1 and ascending per stripe". Read as two id spaces, banner
collections and FAF repeaters, each ascending in stripe order. Banner 3 is
skipped: the FRAMEWORK `CommonControls/TopSubBanner.ascx` CTA strip (the
announcement bar) already reads `bannerid="3"`. **None exist in
the back office yet** - they must be created to match these numbers, or the
stripe renders nothing.

| # | Pack section | Stripe | Back-office id | Entries | Notes |
|---|---|---|---|---|---|
| 1 | Hero carousel | `hero-fade` | `bannerid=1` | 3 | bars pagination, text bottom-left |
| 2 | Category tiles | `panels-3` | `bannerid=2` | exactly 3 | |
| 3 | "Discover what's new" | `product-rail` `--stacked` | `repeaterid=1` | 8-12 products | title, description, link from the repeater |
| 4 | Shop the look | **NEW** | `bannerid=4` + `repeaterid=2` | 1 banner; 3-5 products | image + look copy from the banner, pieces from the repeater |
| 5 | Collection banner | `hero-fade` 1-up, `--centreLeft` | `bannerid=5` | 1 | retune, not a new shape |
| 6 | Shop by brand | `logo-strip`, retuned to step 6-up | `bannerid=6` | logos + 1 | entry 1 = heading |
| 7 | Brand story | **NEW** | `bannerid=7` | 1 | ImagePath = stacked gold crest, Title = headline, Description = paragraphs, link = dash link. Whether Description keeps paragraph breaks is unverified |
| 8 | Reviews | **NEW** | `bannerid=8` | 1 + 3 | entry 1 = heading + rating line, 2-4 = cards (Title = quote, Description = name / product). Real reviews only. Every entry needs a non-empty ImagePath |
| 9 | Newsletter band | platform footer newsletter | - | - | copy from section 5 |

New stripes are built in this site, proven in a browser at 375/1024/1440 per
`docs/ADDING-A-STRIPE.md`, and only then extracted into `stripes/`.

---

## 8. Carousels

| Decision | Options | This client |
|---|---|---|
| Pagination markers | dots / dashes / bars | bars - 16px inactive, 32px active |
| Arrow hover | scale bounce / no bounce | no bounce |

---

## 9. Back-office data

None of this exists yet (2026-10-16). The build cannot create it.

- [ ] banner collections 1, 2, 4-8, with images, entry counts as section 7
- [ ] banner collection 3: announcement bar messages (read by TopSubBanner, bannerLimit 12)
- [ ] FAF repeaters 1-2, with title / description / link
- [ ] Delivery, Returns, Privacy, opening times, address, phone, email

---

## 10. Build record (2026-10-16)

- Fresh build from `kit/CustomContent` at `e94af47`, robocopy excluding the
  kit's `google54a34bbb51446c1b.html` (another site's Search Console
  verification file - copying it would let that property verify this domain)
  and `sitemap.xml` (the site's own was content-identical). Pre-build backup of
  the 5 original files is in the build session's scratchpad only.
- Fonts: static latin woff2 + ttf from Google Fonts (Jost 400, Jost 500,
  Cormorant Garamond 500, Cormorant Garamond 500 italic), checked for no
  `fvar`/`gvar` tables. The default modern-UA response is a VARIABLE Jost
  (one file for 400 and 500), which 02's weight-normal slots would flatten.
- Assets: `logo.png` (pack ink wordmark, mask), `logo.svg` (wraps the same
  PNG so 03's default path resolves), `logo-footer.png` (gold horizontal,
  660px), `crest-gold.png` (stacked, 288px, for banner 7), icons from the
  reference page's inline SVGs. Favicons generated from the crest on an Ink
  tile, NOT placed (site root is outside the tree) - see Open items.
- Lint: PASSED, 0 errors, 2 warnings, both in kit framework files
  (`CC-faf.css:138`, `08-CC-MiniBasket.css:34`).
- Rendering: the domain serves a parked `/lander` redirect and no dev URL is
  known, so the real page was never rendered. All eight stripes were rendered
  in a LOCAL harness (site CSS + Splide + the controls' markup with sample
  data, headless Edge at 1440 / 1024 / 390). Two bugs found and fixed there:
  review cards left an empty fourth column at 1440 (now flex-wrap), hero
  arrows sat on the headline at 390 (now hidden under 640px). The harness has
  no platform CSS (Modules/CSS, citr-*.css), header or footer.

## Open items

- [ ] Dev URL: unknown.
- [ ] Back office: create banner collections 1-8 and FAF repeaters 1-2 with
      exactly the ids in section 7, with images. Banner 7's ImagePath is the
      crest; every entry of banner 8 needs an ImagePath; banner 6 needs
      bannerLimit 13 worth (heading + up to 12 logos).
- [ ] Favicons: place the four generated files at the site root.
- [ ] Browser QA on the real platform at 375 / 1024 / 1440
      (`docs/QA-CHECKLIST.md`), especially: header height against the
      design's ~77px (03's bar is 115px on desktop and was left as is), nav
      link gap (28px in the design, not set), the footer logo/columns row, the
      newsletter band, and the three NEW stripes.
- [ ] Hero links: the design allows 1-2 links per slide; a banner entry has
      one link, so slides carry one.
- [ ] Not built from the design: wishlist icon (no kit slot), "New" badge
      (no data on the FAF item), colour swatches on product cards (no data),
      review stars (cannot be bound).
- [ ] Promotion candidates (second client after MRGL): wordmark ink and the
      3-column / fixed-mobile-bar masthead, currently in 99.
- [ ] Extract `split-list`, `story-column`, `review-cards` into `stripes/`
      once proven on the platform.
