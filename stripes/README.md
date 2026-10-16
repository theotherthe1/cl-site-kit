# Stripe library

A **stripe** is one horizontal full-width section of a homepage. Every stripe is
the same three things: a `<div class="col-1 hp-NAME">` wrapper, one platform
control inside it pulling content from the back office, and a matching
`.hp-NAME` block of CSS.

This folder is a **parts bin**, not a site. Nothing here is served. A build picks
the stripes a design needs and assembles them into the site's single
`default.aspx` and single `modules/CSS/home/CC-Home.css` - the platform bundles
that folder and serves one page, so a real site always ends up with one markup
file and one CSS file.

Stripes are named for their **shape**, not for what a particular client
merchandises in them. `hp-split-feature` tells you it is one tall panel beside
two stacked ones; `hp-seasonal-duo`, which is what it used to be called, told you
only what Templeton Jones happened to put there.

## Assembling

1. `_shared/stripe.css` is **mandatory** - include it first, always.
2. Paste each chosen stripe's `markup.aspx` into `default.aspx` in display order,
   inside `<skm:form>` and after `<uc1:topbanner>`.
3. Paste each chosen stripe's `stripe.css` into `CC-Home.css` in the **same
   order**, after the preamble and after `_shared`.
4. Number the section comments `1.`, `2.`, `3.`... as they now fall. The numbers
   are documentation only - every rule keys off the class name, so renumbering
   can never break styling, but the two files must agree or the next person
   loses the map.
5. Replace every `__BANNER_ID__` and `__REPEATER_ID__` with the real back-office
   id. `tools/lint.ps1` fails while any placeholder remains.
6. Register the controls each stripe uses at the top of `default.aspx` (see the
   Controls column below) and de-duplicate the `<%@ Register %>` lines.

## What's in the bin

| Stripe | Shape | Controls | CMS needs |
|---|---|---|---|
| `_shared` | Carousel chrome - pagination geometry and arrow placement shared by every carousel stripe | - | none |
| `hero-fade` | Full-bleed image carousel, text bottom-left, slow crossfade | `BannerCollectionSplide` | 1 banner collection, 3-5 entries with images |
| `product-rail` | Text rail left, product cards right | `FafCustomRepeaterSplide` | 1 FAF repeater; **title, description and link all come from the repeater** |
| `panels-3` | Full-bleed triptych, gradient overlay, title + CTA per panel | `BannerCollectionDisplay` | 1 collection, exactly 3 entries |
| `panels-carousel` | Full-bleed panel carousel, gradient overlay, title + CTA per panel, drag/arrows/dots, no autoplay | `BannerCollectionSplide` | 1 collection, 2+ entries (no fixed cap) |
| `panel-grid` | Configurable-column card grid, gradient overlay or text below, title + description + CTA per card | `BannerCollectionDisplay` | 1 collection, no fixed cap |
| `panel-grid-carousel` | Full-bleed panel-grid carousel, gradient overlay or text below, title + description + CTA per panel, drag/arrows/dots, no autoplay | `BannerCollectionSplide` | 1 collection, 2+ entries (no fixed cap) |
| `logo-strip` | Heading row above a drifting logo carousel | `BannerCollectionDisplay` + `BannerCollectionSplideBrands` | 1 collection: **entry 1 is the heading, entries 2.. are logos** |
| `split-feature` | Tall panel left, two stacked right | `BannerCollectionDisplay` | 1 collection, exactly 3 entries |
| `split-panel` | Image panel one side, text panel with CTA the other | `BannerCollectionDisplay` | 1 collection, 1 entry |
| `icon-strip` | Three icons, one line of copy each | `BannerCollectionDisplay` | 1 collection, 3 entries; images are contained icons, not photos |
| `statement` | Eyebrow + hairline + large declaration | none - reads `CitrusStoreConfiguration.HomePageText` | the Home Page Text field |
| `cta-close` | Centred closing call to action, no image | `BannerCollectionDisplay` | 1 collection, 1 entry; its image is deliberately hidden |

## Styling axes

Some stripes optionally support a small set of **styling modifiers** - CSS-only
variants that change layout/spacing but never the `markup.aspx` structure
itself (same control, same `.hp-NAME` wrapper; only an extra `.hp-NAME--value`
class gets added). Which stripes support which axes/values is tracked
per-stripe in Atlas's `stripe-catalogue.json` (`axes` field) - this file is the
canonical definition of the axes themselves:

| Axis | Values | Applies to |
|---|---|---|
| `shape` | `split-50-50`, `split-30-70` | stripes built as a two-column split (e.g. `split-feature`, `split-panel`) |
| `imageSide` | `left`, `right` | alongside `shape` - which column the dominant/image panel sits in |
| `position` | `bottomLeft`, `centreLeft`, `topLeft`, `centreCentre`, `bottomRight`, `bottomCentre` | stripes with a single full-bleed image + one text overlay (e.g. `hero-fade`) |
| `spacing` | `compact`, `comfortable`, `spacious` | any stripe; tightens/loosens internal gap and body padding |
| `count` | `2`, `3`, `4`, `4-2x2`, `5` | stripes rendering a symmetric grid of equal, identically-treated panels (today, only `panels-3`) |
| `layout` | `below` | stripes whose base look overlays text+CTA on the image; `below` moves them into normal flow underneath it instead (today, `panels-3`, `panel-grid`, `panel-grid-carousel`) |
| `layout` | `stacked` | stripes whose base look is a two-column text+content split; `stacked` collapses them into a single column, text on top, content filling the width below (today, only `product-rail`) |
| `align` | `center` | any stripe with a left-aligned text rail; centers its title/description/CTA instead (today, only `product-rail`) |

**`count` is not purely cosmetic like the others.** Picking a value also
determines the real `bannerLimit` the control fetches (Atlas's
`server/assemble.js`, `countToBannerLimit` - the value's leading digit, so
`4-2x2` still means 4), overriding the plain banner-limit field, which the
Site Builder UI hides wherever this axis is present. A stripe only gets this
axis if its anatomy is a genuinely symmetric grid (no single dominant panel -
that's `split-feature`'s territory, which does not use `count`).

**`product-rail`'s product quantity is not this axis.** Its own free-range
"products to show" field (Site Builder only, `supportsItemCount` /
`defaultItemCount` in `stripe-catalogue.json`) overrides `numberofitems` the
same "replace the literal default" way `bannerLimit` works, but as a plain
number field rather than a fixed-preset styling axis - see Atlas's
`server/data/README.md`.

**No axis has an explicit "default" value.** An instance with nothing selected
gets no modifier class at all, which is exactly today's unmodified look
(`comfortable` spacing, `bottomLeft`/`left`-side positioning where relevant) -
this is what keeps every existing site non-breaking. A stripe that supports an
axis still only needs modifier-class CSS for the values that actually change
something versus the base rules; a value that's identical to the base (e.g.
`split-50-50` on a stripe whose base is already an even split) can restate the
base rule for clarity, or be left out of `axes` entirely if it would be a pure
no-op.

**Adding axis support to a stripe** means: decide which axis/values genuinely
make sense for that stripe's shape (don't force `shape`/`imageSide` onto a
stripe with more than two visual columns, don't force `position` onto a stripe
with no single text overlay to reposition), add the matching
`.hp-NAME--value` rules to its `stripe.css`, and add the matching `axes` entry
to `stripe-catalogue.json` on the Atlas side - see `../docs/ADDING-A-STRIPE.md`.

## Things that will catch you out

**A stripe with no data does not render.** The platform hides the control's
`<asp:Panel>` when nothing binds, so an empty-looking stripe almost always means
unpopulated back-office data rather than broken CSS. On `product-rail` this takes
the whole stripe with it, heading included, because the repeater's own Panel
*is* the rail grid.

**`logo-strip` needs `bannerLimit` = logos + 1.** Both halves read the same
collection and divide it by position, but the controls take only `bannerid` +
`bannerLimit` with no server-side offset - so the carousel also fetches entry 1
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
`__slide` explicitly. `hero-fade` and `panels-carousel` do this; the
content-height stripes (`product-rail`, `logo-strip`) deliberately do not.

**Any `BannerCollectionDisplay`-based stripe loses its image aspect ratio the
moment it becomes a carousel.** `04-CC-BannerCollections.css` forces
`aspect-ratio: unset; height: 100%` on `.splide__slide .cc-banner__img img` -
a `.cc-banner` sizes itself off the image's own aspect only when it has no
`.splide` ancestor. `panels-3`'s grid and `panels-carousel`'s Splide version
share the same panel CSS otherwise, but only the carousel needs an explicit
stage-height clamp for exactly this reason.

**`panels-carousel`'s `fixedWidth` sets how many panels show at once**, not
`perPage` - Splide ignores `perPage`/`perMove` whenever `fixedWidth` (or
`autoWidth`) is set. A fractional panel count (e.g. showing 2.5 panels, with
the next one peeking in) is a real percentage like `"41.67%"` - Splide has no
literal fractional `perPage`.

**`panel-grid-carousel`'s `below` layout can't just copy `panel-grid`'s.** The
carousel's slide height is a fixed chain (see above), so simply un-absolutely-
positioning `.cc-banner__body` the way `panel-grid`/`panels-3` do would push
the body past the slide's fixed height instead of shrinking the image to make
room. `.cc-banner` becomes a flex column instead, so the image and the text
body genuinely divide the fixed height between them.

**`hero-fade` can pair with a transparent nav, but does not need one.** Adding
`class="cl-nav-over-hero"` to `<body>` floats the nav over the image and removes
the body offset so the photo runs under the bar. It is **off by default** - a
special feature, not a house style. Opt in only if the opening image is dark
enough, or carries enough overlay, for the wordmark and icons to read against it.
Without it `hero-fade` renders perfectly normally: a full-bleed image carousel
sitting below a solid bar.

**`data-animate` drives the scroll reveal.** An `IntersectionObserver` in
`default.aspx` adds `.inView` when a stripe enters the viewport. Keep the
attribute on the `.col-1`, and keep the observer script in the page.

## Adding a stripe

See `../docs/ADDING-A-STRIPE.md`. In short: shape name, tokens only (never a raw
colour, radius or font size), chain the carousel height if it has one, give it a
`:not(:has(...))` fallback for partial content, and prove it in a browser before
it enters this folder. Everything here has rendered correctly on a real site;
that is the only reason it can be trusted.
