# Brand brief - The Bye Cycle Co. (MRGL)

Site: `\\man-ecom-sofs.citruslime.com\Websites\www.byecycle.co.nz\SiteSpecific\CustomContent`
(production domain, not live yet - confirmed 2026-10-16. Editing is deploying.)
Kit commit: `6393dbf` + uncommitted working tree (2026-10-16 kit copy, no .git history)
Started: 2026-10-12. Revised 2026-10-16 against the Claude Design homepage build pack.
Mode: **fresh** (confirmed). The tree is a bare platform seed: stock `default.aspx`
(bannerid 1/2/3, platform CTA grid), `CommonControls/TopSubBanner.ascx`, `Feed/`,
`ReturnPDFs/`, `ReturnsPDFs/`, `download/`, `layout/generalLyout/logo.png`,
`sitemap.xml`. No skin, no kit files.
Interview status: COMPLETE. Built 2026-10-16; lint 0 errors; platform browser QA outstanding.

History: the 2026-10-12 interview targeted the dev site
`\\dev-ecom-sofs\Websites\MRGL.dev.citruslime.com` (unreachable from the build
machine on 2026-10-16) and a "Lean" 4-stripe composition from the brand book
alone. The 2026-10-16 revision supersedes it: the client now has an approved
homepage design, and it is the source of truth. Where a 10-12 decision was
overridden, the row says so.

---

## 1. Identity

| | |
|---|---|
| Client name | The Bye Cycle Co. (multi-brand bike shop, Grey Lynn, Auckland, NZ) |
| Site code / folder on the share | `MRGL` - `www.byecycle.co.nz` on `man-ecom-sofs` |
| Dev URL | none used - built on the production domain before launch |
| Design source | **`bye-cycle-co-homepage-build-pack`** (Claude Design, Oct 2026): `DESIGN.md` (source of truth), `HOMEPAGE-SPEC.md`, `CONTENT.md`, `tokens/`, reference HTML at 1440 and 390, screenshots, assets. Brand basis: Bye Cycle Co. Brand Identity Guidelines V1, Sept 2026 (McFarlane Brand Studio). Pack kept at `C:\Users\theo.fapohunda\Desktop\bye-cycle-co-homepage-build-pack` on the build machine |

### Design source notes

- The pack resolves the guide's gaps: Forest is `#2E4F3D`; derived UI colours
  are given (`stone #9E9B95`, `ash-border #CFCBC2`, `paper #F4F2EE`,
  `body-text #3A3A3A`, `neon-hover #B8E600`, `error #B42318`).
- Neon is never text on a light ground (1.05:1 on Ash, 1.17:1 on White).
- Every `[bracketed]` placeholder in the design is back-office content, not code
  (see section 9).

**Visual language.** Draft, for confirmation:

> Ash canvas with white cards and full-width colour blocks - graphite, olive -
> as the only separators: no shadows, 1px hairline borders, square corners
> everywhere except round icon buttons and badges. Young Serif carries
> personality (headings, product and category names, sentence case); IBM Plex
> Mono does the practical work (nav, labels, prices, buttons, uppercase and
> tracked). Neon is a fill or ink-on-graphite only, and the topographic map is
> the one texture.

---

## 2. Colour - **required**

| Token | Value | What it is |
|---|---|---|
| `--brand` | `#191919` Graphite | the primary |
| `--brand-focus` | `#191919` Graphite | `--brand-dark` points at this; nothing in the palette is deeper |
| `--brand-accent` | `#CEFF00` Neon | add-to-cart and emphasis |
| `--brand-link` | `#191919` Graphite | links; olive hover is a 99 rule (olive text fails on Ash at 4.22:1, but the pack uses it for hover only) |
| `--sale` | `#B42318` pack `error` | **changed 2026-10-16** from kit red `#C8102E`, to stay in the pack's palette. 5.33:1 on Ash, 6.57:1 on White |
| `--background` | `#EAE7E1` Ash | the page canvas (DESIGN.md; unchanged from 10-12) |
| `--background-raised` | `#FFFFFF` White | cards, tiles, raised surfaces |
| `--text` | `#191919` Graphite | body ink |
| `--text-inverse` | `#EAE7E1` Ash | **changed 2026-10-16** from White: the pack sets Ash as text on dark |
| `--text-on-brand` | `#CEFF00` Neon | ink on Graphite |
| `--text-on-accent` | `#191919` Graphite | ink on Neon |

Off-token pack colours used only by stripes (as `--skin-*` in `01`): Olive
`#657324` (Services ground, USP icons, link hover), Forest `#2E4F3D`, Grey
`#5F5F60`, Stone `#9E9B95`, Ash-border `#CFCBC2`, Paper `#F4F2EE`, body-text
`#3A3A3A`, Neon-hover `#B8E600`, graphite-raised `#242424`, graphite-border `#333333`.

Contrast (WCAG 2, computed 2026-10-16):

- `--text` on `--background`: **14.25:1** pass (17.58:1 on White).
- `--text-on-brand` on `--brand`: **15.01:1** pass.
- `--text-on-accent` on `--brand-accent`: **15.01:1** pass.
- `--sale` on Ash **5.33:1**, on White **6.57:1** pass.

---

## 3. Type - **required**

| Slot | File supplied | Role |
|---|---|---|
| `font/body.woff2` | **Inter Regular 400** (Fontsource static latin, to fetch) | running text on interior pages (PLP/PDP/checkout), inputs |
| `font/bold.woff2` | **Inter SemiBold 600** (to fetch) | platform `citrfontbold` furniture on interior pages |
| `font/display.woff2` | **Young Serif 400** (pack) | `--font-heading` -> display. All headings, product and category names |
| `font/accent.woff2` | **IBM Plex Mono 400** (pack) | nav links, every button/CTA label, and **all homepage text** |
| `font/accent-bold.woff2` | **IBM Plex Mono 600** (pack) | labels, eyebrows, prices, buttons (bold mono) |

**Decision 2026-10-16:** mono on the homepage, Inter elsewhere. The design sets
Plex Mono for all text; the client's 10-12 decision moved running text to Inter
because mono read wide across PLP/PDP/checkout. Both kept: the homepage stripes
set their text in the accent face; interior pages keep Inter.

woff2 only (the pack supplies no ttf). **QA risk:** another site on this share
(UTEC) had woff2 not served by IIS. If fonts fail to load, add ttf copies.

| | |
|---|---|
| Geometry: `--global-radius` | **`0`** - **changed 2026-10-16** from 3px (pack: radius 0 for buttons, inputs, cards, images). 999px only for round icon buttons, chips, badges |
| Nav link case | uppercase, Plex Mono 600 13px |
| Nav link tracking | `0.06em` (pack button/nav tracking; was 0.05em) |

No shadows anywhere.

---

## 4. Assets - **required**

| Path | Supplied |
|---|---|
| `layout/generalLyout/logo.svg` | pack `logos/logo-hrz-graphite.svg` - single fill `#191919`, masks cleanly |
| footer wordmark | pack `logos/logo-hrz-ash-neon.svg` - **two-tone**, so it cannot go through the mask; a 99 override on the footer wordmark |
| `layout/generalLyout/icons/bag.svg` | extracted from `reference/homepage-desktop.html` (24px grid, 1.5px stroke, square caps) |
| `layout/generalLyout/icons/account.svg` | extracted from the reference HTML |
| `layout/generalLyout/icons/search.svg` | extracted from the reference HTML |
| backgrounds, badges, bike illustrations | pack `assets/` - topo maps and illustrations are **content** (banner images uploaded in the back office), not tree assets |
| `favicon.ico`, `favicon.svg`, `favicon-96x96.png`, `apple-touch-icon.png` | from `badges/badge-circle-neon.svg`; site root, outside this tree - **someone else places these** |

---

## 5. Copy the stylesheets write

| Token | Default | This client |
|---|---|---|
| `--copy-newsletterTitle` | "Join Our Newsletter" | "Rides, releases and workshop news." (design) |
| `--copy-newsletterBody` | "Sign up for news and offers." | ? - design placeholder `[Newsletter frequency and offer.]` |
| `--copy-statementEyebrow` | *(empty)* | n/a |
| `--copy-signature` | *(none)* | none |
| `--copy-addToCart` | "Add To Cart" | default |
| `--copy-stockNotification` | "Stock Notification" | default |
| `--copy-specialOrder` | "Special Order" | default |
| `--copy-comingSoon` | "Coming Soon" | default |
| `--copy-search` | "Search" | default |
| `--copy-otherColours` | "Other Colours Available" | default |
| `--copy-rrp` | "RRP " | default |

---

## 6. Nav

| Decision | Options | This client |
|---|---|---|
| Bar floats transparent over the first stripe? | **no** | no - solid bar above the hero (10-12, still true) |
| Solid-state bar | light / dark | **light**: White bar, graphite links/icons, 1px Ash-border bottom (design). **Changed 2026-10-16** - the 10-12 brief let it default to graphite |
| Accent seam under the bar | keep / none | none - replaced by the 1px Ash-border hairline |
| Underline-draw hover on nav links | keep / none | none - hover is Olive colour (design) |
| Platform CTA strip above the bar | show / hide | **show** - **changed 2026-10-23 to a USP bar** (kit `9d22270`, first used on YEST): icon + uppercase Mono 600 title + Grey line per entry, White under a 2px Neon rule; it replaced the design's Graphite one-line announcement bar. Rendered sitewide by the framework `TopSubBanner.ascx` from **`bannerid=3`** (hardcoded there), so the homepage skips id 3 |

Desktop layout: logo left, links centred, icons right (3-column). Mobile: menu
left, logo centred, search + cart right.

---

## 7. Homepage stripes - **required**

**Changed 2026-10-16:** the 10-12 "Lean" set is replaced by the design's 7
homepage stripes (announcement bar, newsletter and footer are chrome).

| # | Design section | Stripe | Back-office id | Entries | Notes |
|---|---|---|---|---|---|
| 1 | Hero carousel | `hero-fade`, position bottomLeft | `bannerid=1` (unconfirmed) | 3 | Ash 90% panel, bar pagination as slide buttons, 6s autoplay |
| 2 | Fresh off the truck | `product-rail`, layout stacked | `repeaterid=1` (unconfirmed) | FAF repeater, 8 products; title/link from repeater | Graphite band, white round arrows, neon progress bar |
| 3 | Shop by category | `split-feature`, **retuned** | `bannerid=2` (unconfirmed) | 5: heading + featured + 3 rows | entry 1 = section heading; 4 panels not 3; right side becomes horizontal rows |
| 4 | Find your ride | `panel-grid`, 4 cols, layout below | `bannerid=4` (unconfirmed) | 5: heading (+ "Shop all" link) + 4 tiles | mobile horizontal scroll-snap |
| 5 | USPs | `icon-strip`, **retuned** | `bannerid=5` (unconfirmed) | 4 | 4 not 3; 2x2 on mobile |
| 6 | Services | **NEW `services-list`** | `bannerid=6` (unconfirmed) | heading + N services | built in-site, proven in a browser before extraction |
| 7 | About (long-form) | **NEW `about-longform`** | `bannerid=7` (unconfirmed) + Home Page Text | photo/headline entry + Visit card entry | long copy from Home Page Text |
| - | Newsletter | footer `06` newsletter | - | copy tokens | |
| - | Footer | `06` | - | platform columns | |

Headings for 3 and 4 use the entry-1-is-the-heading pattern, so that entry still
needs a non-empty ImagePath. Services prices have no banner field; the proposal
is to carry the price in `NavigateLinkText`.

---

## 8. Carousels

| Decision | Options | This client |
|---|---|---|
| Pagination markers | dots / dashes / **bars** | bars - hero: 3px progress bars (active Graphite, inactive `#CFCBC2`); product rail: neon progress bar |
| Arrow hover | scale bounce / **no bounce** | no bounce (kit default is now HOVA's disc, no bounce); discs White with graphite arrow, 48px (44 mobile) |

---

## 9. Back-office data

- [ ] every banner collection in section 7, with images
- [ ] the FAF repeater, with title / link and 8 products
- [ ] Home Page Text (About long copy)
- [ ] platform CTA strip message (announcement bar)
- [ ] Delivery, Returns, Privacy, opening times, address, phone, email
- [ ] all `CONTENT.md` placeholders from the pack: hero slide 3, USP lines,
      service descriptions and prices, About copy, newsletter line, footer
      address/hours/policies, every photo and link
