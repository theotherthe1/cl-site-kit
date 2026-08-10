# Stripe library

A **stripe** is one horizontal full-width section of a homepage. Every stripe is
the same three things: a `<div class="col-1 hp-NAME">` wrapper, one platform
control inside it pulling content from the back office, and a matching
`.hp-NAME` block of CSS.

This folder is a **parts bin**, not a site. Nothing here is served. A build picks
the stripes a design needs and assembles them into the site's single
`default.aspx` and single `modules/CSS/home/CC-Home.css` — the platform bundles
that folder and serves one page, so a real site always ends up with one markup
file and one CSS file.

Stripes are named for their **shape**, not for what a particular client
merchandises in them. `hp-split-feature` tells you it is one tall panel beside
two stacked ones; `hp-seasonal-duo`, which is what it used to be called, told you
only what Templeton Jones happened to put there.

## Assembling

1. `_shared/stripe.css` is **mandatory** — include it first, always.
2. Paste each chosen stripe's `markup.aspx` into `default.aspx` in display order,
   inside `<skm:form>` and after `<uc1:topbanner>`.
3. Paste each chosen stripe's `stripe.css` into `CC-Home.css` in the **same
   order**, after the preamble and after `_shared`.
4. Number the section comments `1.`, `2.`, `3.`… as they now fall. The numbers
   are documentation only — every rule keys off the class name, so renumbering
   can never break styling, but the two files must agree or the next person
   loses the map.
5. Replace every `__BANNER_ID__` and `__REPEATER_ID__` with the real back-office
   id. `tools/lint.ps1` fails while any placeholder remains.
6. Register the controls each stripe uses at the top of `default.aspx` (see the
   Controls column below) and de-duplicate the `<%@ Register %>` lines.

## What's in the bin

| Stripe | Shape | Controls | CMS needs |
|---|---|---|---|
| `_shared` | Carousel chrome — pagination geometry and arrow placement shared by every carousel stripe | — | none |
| `hero-fade` | Full-bleed image carousel, text bottom-left, slow crossfade | `BannerCollectionSplide` | 1 banner collection, 3–5 entries with images |
| `product-rail` | Text rail left, product cards right | `FafCustomRepeaterSplide` | 1 FAF repeater; **title, description and link all come from the repeater** |
| `panels-3` | Full-bleed triptych, gradient overlay, title + CTA per panel | `BannerCollectionDisplay` | 1 collection, exactly 3 entries |
| `logo-strip` | Heading row above a drifting logo carousel | `BannerCollectionDisplay` + `BannerCollectionSplideBrands` | 1 collection: **entry 1 is the heading, entries 2.. are logos** |
| `split-feature` | Tall panel left, two stacked right | `BannerCollectionDisplay` | 1 collection, exactly 3 entries |
| `icon-strip` | Three icons, one line of copy each | `BannerCollectionDisplay` | 1 collection, 3 entries; images are contained icons, not photos |
| `statement` | Eyebrow + hairline + large declaration | none — reads `CitrusStoreConfiguration.HomePageText` | the Home Page Text field |
| `cta-close` | Centred closing call to action, no image | `BannerCollectionDisplay` | 1 collection, 1 entry; its image is deliberately hidden |

## Things that will catch you out

**A stripe with no data does not render.** The platform hides the control's
`<asp:Panel>` when nothing binds, so an empty-looking stripe almost always means
unpopulated back-office data rather than broken CSS. On `product-rail` this takes
the whole stripe with it, heading included, because the repeater's own Panel
*is* the rail grid.

**`logo-strip` needs `bannerLimit` = logos + 1.** Both halves read the same
collection and divide it by position, but the controls take only `bannerid` +
`bannerLimit` with no server-side offset — so the carousel also fetches entry 1
(the heading) and `data-splide-skip="1"` drops that slide before mount. The skip
has to be a removal rather than a CSS hide: `type:loop` clones slides and slide
widths derive from the slide count, so a hidden slot leaves a gap drifting
through the strip.

**A heading banner still needs an image.** `panels-3`, `logo-strip` and
`cta-close` route through `BannerCollectionDisplayGrid.ascx`, which guards on a
non-empty `ImagePath`. A title-only banner with no image renders nothing at all
even though the image slot is hidden by CSS.

**Carousel options live in the markup, never in JS.** Per-carousel settings come
only from the `data-splide-opts` JSON on the `.col-1`. `SplideBannerManager`
auto-mounts every `.splide` on the page and merges that JSON over its base
config. To retune a carousel, edit the JSON.

**Carousel height must be chained.** Splide's flex layout flows top-down, so a
height set on `.splide` has to be passed down to `.splide__track`, `__list` and
`__slide` explicitly. `hero-fade` does this; the content-height stripes
(`product-rail`, `logo-strip`) deliberately do not.

**`hero-fade` expects `cl-nav-over-hero` on `<body>`.** That class is what makes
the nav float transparent over the image and removes the body offset so the photo
runs under the bar. A homepage that does *not* open on a full-bleed image should
omit the class, or it will have an invisible nav over a white stripe.

**`data-animate` drives the scroll reveal.** An `IntersectionObserver` in
`default.aspx` adds `.inView` when a stripe enters the viewport. Keep the
attribute on the `.col-1`, and keep the observer script in the page.

## Adding a stripe

See `../docs/ADDING-A-STRIPE.md`. In short: shape name, tokens only (never a raw
colour, radius or font size), chain the carousel height if it has one, give it a
`:not(:has(...))` fallback for partial content, and prove it in a browser before
it enters this folder. Everything here has rendered correctly on a real site;
that is the only reason it can be trusted.
