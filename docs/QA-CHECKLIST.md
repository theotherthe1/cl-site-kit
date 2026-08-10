# QA checklist

`tools/lint.ps1` covers what a machine can see. This is the rest - and it is the
only verification that exists, because there is no build and no test suite.

Work through it in a browser at **375, 1024 and 1440**. Those are the widths the
type scale is anchored to: every display ramp hits its floor at 375 and its
ceiling at 1440.

## Before you trust what you are looking at

- [ ] **Hard-refresh.** Manual cache busting means a stale `?v` shows you old
      code. If something looks unchanged, check the `?v` before debugging.
- [ ] **The homepage is output-cached for 900 seconds.** Markup changes may take
      up to 15 minutes. CSS changes are not affected. If a stripe you just added
      is missing, wait before investigating.
- [ ] **Did you bump every `?v` you needed to?** `homepage-nav.js` in
      `default.aspx`, `splide-config.js` in `TopSubBanner.ascx`.

## Homepage

- [ ] Stripes appear in the intended order, and the section numbers in
      `default.aspx` and `CC-Home.css` agree.
- [ ] **No stripe is missing.** An absent stripe is almost always an unpopulated
      banner collection or FAF repeater, not broken CSS - the platform hides the
      control's Panel when nothing binds. On `product-rail` this takes the
      heading with it, because the repeater's Panel *is* the rail grid.
- [ ] Every stripe scroll-reveals once (`data-animate` -> `.inView`).
- [ ] Carousels: autoplay, arrows, pagination, keyboard arrows, and that the
      loop has no drifting gap. A gap means a slide was hidden with CSS instead
      of removed with `data-splide-skip`.
- [ ] `logo-strip`: the heading is *not* also showing as the first logo slide,
      and you get the number of logos you expected (`bannerLimit` = logos + 1).
- [ ] Banner images are sharp on a retina screen. Blurry means a missing `2x`
      `srcset` tier or a `mode=crop` that has made source height the binding
      dimension.
- [ ] Nothing scrolls horizontally at 375.

## Navigation

- [ ] **Default case - no `cl-nav-over-hero` on `<body>`**: the bar is solid in
      every state and the first stripe starts below it. Nothing should look
      transparent. This is what most sites get.
- [ ] **Only if you opted in**: the bar is transparent at rest, the image runs
      under it, and there is no body offset gap. Check the wordmark and icons are
      legible against the actual image, not just against a mockup - an invisible
      nav over a light image is the failure this feature causes.
- [ ] **If you opted in, note there is no scroll shadow when solid-only.** The
      scroll blur/shadow is gated on the same class, so a default site gets none.
      That is consistent, but confirm it is what the design expects.
- [ ] The bar turns solid on scroll past 20px, and **stays legible** - links,
      icons and the masked wordmark should all flip together, since they read one
      `--navSolid-*` set.
- [ ] The bar is solid whenever a panel is open: dropdown, mobile hamburger,
      account, search. An open menu hanging off an invisible bar is the specific
      bug the panel-open triggers exist for. Test **all four**.
- [ ] The wordmark is the right colour in every state, and the three masked icons
      (bag, account, search) render - not as solid blocks, and not missing.
- [ ] The basket pip and logged-in pip are visible and not clipped by the icon
      masks.
- [ ] Interior pages have a solid bar in every state.
- [ ] Mobile hamburger opens, closes, and the overlay works.

## PLP (product listing)

- [ ] Cards, prices, sale prices and RRP render; stock-state labels read
      correctly for in-stock, out-of-stock, special order and coming soon.
- [ ] Filters, sticky filter bar, and the search control.
- [ ] Add-to-cart uses the accent colour and its hover state works.

## PDP (product detail)

- [ ] Gallery, price, RRP prefix, colour picker header, add to cart.
- [ ] Quick look opens and closes.
- [ ] Mini basket opens, updates and closes.

## Interior pages

Each reads its content from the back office, so an empty section means an
unpopulated field, not broken code.

- [ ] delivery, returns, privacy policy, click and collect, brands
- [ ] contact - including the form actually submitting
- [ ] finance (`pages/finance/default.aspx` is the live route)

## Footer

- [ ] Newsletter heading and body show **this client's** copy, not a neutral
      default and definitely not another client's.
- [ ] Newsletter submits.
- [ ] Social icons, payment icons, column headings, the wordmark.

## Type and colour

- [ ] All three font faces are actually loading - check the network tab, not your
      eyes. A missing file falls back to a system font that can look plausible.
- [ ] Display headings are comfortable at 375 and match the design at 1440.
- [ ] Body text is 4.5:1 against its background. Check ink on brand surfaces and
      on accent surfaces too.
- [ ] No element shows a raw fallback colour or a bland default string - both
      mean a token was never set.

## Accessibility, briefly

- [ ] Keyboard: tab through the nav, a carousel and the footer form. Off-screen
      carousel slides should not be focusable.
- [ ] Visible focus states.
- [ ] Browser zoom to 200% - the type scale uses `rem + vw`, never bare `vw`, so
      zoom must still work.

## Before calling it done

- [ ] `tools/lint.ps1` exits 0.
- [ ] The site's `CLAUDE.md` records the kit commit it was built from.
- [ ] `99-CC-Custom.css` contains nothing that a token could have expressed.
      Worth one last read: it is the file that decides whether the *next* build
      is fast.
