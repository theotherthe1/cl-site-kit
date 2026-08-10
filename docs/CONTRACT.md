# The contract

What each layer owns, and what you are allowed to change. This is the document
to read before editing anything in a built site.

## The platform you are sitting on

`SiteSpecific/CustomContent/` is an **overlay** on a Citrus Lime ASP.NET
WebForms storefront. The platform - `CitrusStore.*` assemblies, `/modules/`,
`/PlatformCommonControls/`, `Modules/CSS/**`, `citr-*.css` - lives outside this
tree and is not editable. There is **no build, no test suite, no package
manager**. Files are served straight from the share by IIS: **editing a file is
deploying it.**

Consequences you cannot design around:

- **Cache busting is manual.** Anything referenced with an explicit
  `<link>`/`<script>` carries a `?v` querystring. Bump it when you change the
  file, or browsers serve stale code.
- **The homepage is output-cached for 900 seconds.** Markup changes may not
  appear for 15 minutes. CSS changes are not affected.
- **CSS is bundled per folder** under `modules/CSS/`, and load order within
  `global/` comes from the numeric prefix. Order between folders is *not*
  guaranteed - `CC-Home.css` wins over `05` by specificity, never by order.
- **`.ascx` files here are markup-only re-templates.** Each declares a
  `CodeBehind`/`Inherits` pointing at a platform class whose `.vb` is not in this
  tree. You can restructure the emitted HTML and rename your own classes freely,
  but you **cannot add control properties, change data-binding fields, or alter
  server-side behaviour**.
- **Several controls share one code-behind**, so these server IDs must not be
  renamed: `bannerCollectionPanel`, `bannerEntriesRepeater`, `FAFCustomPanel`,
  `itemRepeater`, `repeaterTitle`, `repeaterDesc`.
- **Bound fields are fixed.** Banners: `NavigateLink`, `NavigateLinkText`,
  `Title`, `Description`, `ImagePath`, `DisplayOrder`. Products: `uid`, `URL`,
  `ImageURL`, `Name`, `RegPrice`, `SellPrice`, `IsOnSale`, plus the `data-*`
  stock attributes.
- **Every `.aspx` must keep the platform scaffolding**: the `skm:form`, both
  `ScriptManager`s, the `bindHandler()` / `localAjaxStartPostback()` stubs (the
  platform's AJAX layer calls them - page-specific init goes *inside*
  `bindHandler`), and the `TopBanner` / `Footer` includes.

## The CSS layers

| File | Kind | Owns |
|---|---|---|
| `01-CC-Brand.css` | **CLIENT** | The reskin surface: type roles, brand values, copy, switches. Raw values only, no rules. |
| `02-CC-Global.css` | FRAMEWORK | Font slots, derived `oklch()` ramps, the type scale, `--gutter`, section rhythm, the `.grirow*` grid, the page canvas. **Depends on 01 loading first.** |
| `03`-`08` | FRAMEWORK | Per-component structure and tokens: nav/search, banner collections, splide chrome, footer, quick look, mini basket. |
| `home/CC-Home.css` | **CLIENT** | The homepage, assembled from `stripes/`. |
| `detail/CC-detail.css` | FRAMEWORK | The **PDP** - product detail page template. |
| `faf/CC-faf.css`, `CC-alps.css` | FRAMEWORK | The **PLP** - product listing page template. |
| `misc/` | FRAMEWORK | Contact and other interior pages. |
| `99-CC-Custom.css` | **CLIENT** | Loads last, wins everything. This client's taste, and nothing else. |

## The three rules that hold it together

**1. Never hardcode a colour, radius, shadow or font size.** If a value is
missing, add a token to the component that owns it - not a literal, and not a
token in `01`. `01` holds raw brand values; components declare their own
namespaced tokens (`--nav*`, `--footer-*`, `--faf-*`, `--detail-*`, `--splide*`)
that resolve to the global ones, then use only those.

**2. Framework files never name a client.** No client's colours, words, assets,
initials or taste. This is what makes `FRAMEWORK` files safe to copy forward onto
an existing site without reading them, which is the entire update mechanism.

**3. `99` is for taste, not mechanism.** The test: *could the next client want
the opposite of this rule and get it by editing `01` alone?* If yes, it is a
switch - add the token to the framework instead. `99` gets rewritten from
scratch per client, so anything genuinely reusable that lands there is lost work.

## Two things that are easy to get wrong

**Specificity here is hand-tuned, and the comments are load-bearing.** The nav
in particular has documented relationships - `(0,3,1)` vs `(0,4,1)` at `03:107`
and in the Transparent-over-hero block - where a rule wins by exactly one class,
and `!important` ladders that depend on it. Read the comment before changing a
selector. When a mode is gated on a body class, note that `:has()` contributes
its argument's specificity, so `body:has(.foo)` and `body.foo` are both `(0,1,1)`
- that equivalence is why the `cl-nav-over-hero` migration was safe.

**Images go through the platform resizer**: `/images/<ImagePath>?width=&quality=&format=webp`.
Ask for **width only** on banner images. Do not add `height`+`mode=crop`: one
banner control serves several aspect ratios, and `.cc-banner__img img` already
crops with `object-fit: cover`. A server-side landscape crop re-cropped into a
portrait box makes the source *height* the binding dimension and upscales the
image. Keep the responsive `<picture>` breakpoints (480 / 1024 / full) and the
`1x`/`2x` `srcset` pair on each tier - the `media` queries key off *viewport*
width, so without a DPR tier every retina screen upscales.

## Control variants: grid <-> carousel

`controls/` holds paired re-templates of the same platform controls, one per
layout mode:

| Grid | Carousel (Splide) |
|---|---|
| `BannerCollectionDisplayGrid.ascx` | `BannerCollectionSplide.ascx` |
| `BannerCollectionDisplayGridBrands.ascx` | `BannerCollectionSplideBrands.ascx` |
| `FafCustomRepeaterGrid.ascx` | `FafCustomRepeaterSplide.ascx` |

Both variants of a pair emit **the same `cc-banner__*` / `cc-brand__*` /
`faf-product-*` hooks**; the Splide variant just wraps them in
`section.splide > .splide__track > ul.splide__list > li.splide__slide`. That
symmetry is deliberate - a stripe can be switched between grid and carousel by
changing which control the `<%@ Register %>` points at, and the CSS follows.
Preserve it when adding hooks.

## Splide is configured from markup, never JS

`assets/splide/js/splide-config.js` defines `SplideBannerManager`, which
auto-mounts **every** `.splide` on the page. Per-carousel options come
exclusively from a `data-splide-opts` JSON attribute on the wrapping `.col-1`,
merged over a base config. **To retune a carousel, edit that JSON** - never add
per-carousel JS.

`data-splide-skip="N"` removes the first N slides *before* mount. It has to be a
removal rather than a CSS hide, and it has to happen pre-mount: `type:loop`
clones slides and slide widths derive from the slide count, so a hidden slot
leaves a gap drifting through the strip.

The manager also watches for injected `.splide` nodes, refreshes on debounced
resize and after first paint (float-based platform layouts report zero width at
`DOMContentLoaded`), toggles `.is-current`, and manages `tabindex` on off-screen
slide focusables.

Splide's three assets are injected site-wide from `CommonControls/TopSubBanner.ascx`,
which the platform renders on every page. That is the only place they load.

`data-splide-opts` doubles as a **CSS scoping hook**: `05` styles
`[data-splide-opts] .splide__*`, reaching `(0,2,0)` and beating Splide's own
`(0,1,0)` selectors without `!important`. Keep new Splide chrome under that
prefix.

## Where `!important` is acceptable

It is heavy in `02`, `03` and `CC-faf.css` because those fight platform
stylesheets (`citrusstyles-unity`, `framework.css`, `mobile.css`). It is near
absent in `CC-Home.css` and `01`. Reach for specificity scoping -
`[data-splide-opts]`, `.cc-collection`, direct-child selectors - before
`!important` in new work.

## Content is CMS-driven

Banner copy, images, links and CTA text come from banner collections in the
Citrus Lime back office, selected per stripe by `bannerid` + `bannerLimit`.
Product carousels come from FAF repeaters selected by `repeaterid` +
`numberofitems`. None of it is in this tree. **An empty-looking stripe usually
means unpopulated CMS data, not broken code** - and the platform hides the
control's `<asp:Panel>` when nothing binds, so the stripe disappears entirely
rather than rendering empty.

Interior pages carry **no hardcoded prose at all** - delivery, returns, privacy,
click-and-collect and contact all read from `CitrusStoreConfiguration`
(`DeliveryDescription`, `ReturnsPolicy`, `PrivacyPolicy`, `OpeningTimes()`,
`StoreAddress1()`, and so on). That is why they are framework files and ship
untouched.
