# Brand brief - <CLIENT NAME>

**You do not normally fill this in by hand.** Run `/new-site` and it interviews
you, one question at a time, writing the answers into `briefs/<SITECODE>.md` in
this shape as it goes. This file is the schema, and reading it is a good way to
know what you are about to be asked.

Fill it by hand if you prefer working on paper, or if you are recording a brief
after the fact. Hand a filled copy to `/new-site` and it will only ask about the
gaps. Fill it from a Figma file, a flat mockup, a brand guide or a phone call -
the source does not matter, but the build starts from a completed sheet so that
everything downstream is deterministic.

Finished briefs live in `briefs/` and are committed. They are the only record of
a build that survives the machine it was built on.

Anything left as `?` is a question to resolve before building, not a blank to
skip. Anything marked **required** blocks the build.

---

## 1. Identity

| | |
|---|---|
| Client name | |
| Site code / folder on the share | |
| Dev URL | |
| Design source | Figma link / mockup filename / other |

**Visual language, in two or three sentences.** What the canvas is, what the type
does, what the chrome vocabulary is. This becomes the header of
`99-CC-Custom.css` and is what tells the next person whether a new rule belongs
there. Be concrete - "one white canvas, ink type, hairline rules, ghost
1px-outline chrome" is useful; "clean and modern" is not.

> ...

---

## 2. Colour - **required**

Raw values only. Everything else (shades, borders, overlays, shadows, text
hierarchy) is derived from these with `oklch()` in `02`, so do not supply ramps.

| Token | Value | What it is |
|---|---|---|
| `--brand` | | the primary |
| `--brand-focus` | | the deep/focus shade; `--brand-dark` points at this |
| `--brand-accent` | | used for add-to-cart and emphasis |
| `--brand-link` | | link colour |
| `--sale` | | sale/discount colour |
| `--background` | | the page canvas |
| `--background-raised` | | cards, tiles, raised surfaces |
| `--text` | | body ink |
| `--text-inverse` | | ink on dark surfaces |
| `--text-on-brand` | | ink sitting on `--brand` |
| `--text-on-accent` | | ink sitting on `--brand-accent` |

Contrast check - state the ratio for each pair, or flag it: `--text` on
`--background`, `--text-on-brand` on `--brand`, `--text-on-accent` on
`--brand-accent`. 4.5:1 minimum for body text.

---

## 3. Type - **required**

Three font files minimum. `body` and `bold` are **not optional** - around 186
platform declarations outside our tree name those two families literally, so
both slots must hold a real file. A client with one text face supplies it twice.

| Slot | File supplied | Role |
|---|---|---|
| `font/body.woff2` (+ `.ttf`) | | running text, inputs, CTA labels |
| `font/bold.woff2` (+ `.ttf`) | | headings, bold UI |
| `font/display.woff2` (+ `.ttf`) | | the editorial face - big stripe statements |
| `font/accent.*` | optional | fourth face, if any |

woff2 preferred, ttf accepted, both ideal. Supplying only ttf costs one cheap
404 per slot on cold load until they are converted.

| | |
|---|---|
| Geometry: `--global-radius` | e.g. `3px`, or `0` for hard corners |
| Nav link case | as typed by the CMS author / uppercase |
| Nav link tracking | e.g. normal / `0.1em` |

---

## 4. Assets - **required**

Every SVG is written **inline into `01-CC-Brand.css` as a data URI**, never
referenced as a file: a referenced `.svg` does not display on iPhone, and lint
fails on one. Record the source artwork here.

| Token in 01 | Supplied |
|---|---|
| `--logo` | **required** (single-colour silhouette - it is painted as a **mask** filled with `currentColor`, so it must not carry its own colours). SVG inline, or a transparent `.png` under `layout/generalLyout/` |
| `--icon-bag` | inline SVG, or blank for the kit's glyph |
| `--icon-account` | inline SVG, or blank for the kit's glyph |
| `--icon-search` | inline SVG, or blank for the kit's glyph |
| `favicon.ico`, `favicon-96x96.png`, `apple-touch-icon.png` | at the site root, outside this tree. No `favicon.svg`: an SVG favicon is a referenced SVG |

---

## 5. Copy the stylesheets write

These are strings CSS puts on platform-emitted elements we cannot re-template.
Leave a row blank to accept the neutral default shown.

| Token | Default | This client |
|---|---|---|
| `--copy-newsletterTitle` | "Join Our Newsletter" | |
| `--copy-newsletterBody` | "Sign up for news and offers." | |
| `--copy-statementEyebrow` | *(empty)* | only if using the `statement` stripe |
| `--copy-signature` | *(none - no line rendered)* | optional closing flourish |
| `--copy-addToCart` | "Add To Cart" | |
| `--copy-stockNotification` | "Stock Notification" | |
| `--copy-specialOrder` | "Special Order" | |
| `--copy-comingSoon` | "Coming Soon" | |
| `--copy-search` | "Search" | |
| `--copy-otherColours` | "Other Colours Available" | |
| `--copy-rrp` | "RRP " | |

---

## 6. Nav

| Decision | Options | This client |
|---|---|---|
| Bar floats transparent over the first stripe? | **no (default)** / yes | Special feature. Yes needs a full-bleed opening image dark enough for the wordmark and icons to read against |
| Solid-state bar | light / dark - sets the four `--navSolid-*` | |
| Accent seam under the bar | keep (2px brand-light) / none | |
| Underline-draw hover on nav links | keep / none | |
| Platform CTA strip above the bar | show / hide | |

---

## 7. Homepage stripes - **required**

List the stripes in display order. Catalogue: `stripes/README.md`.
Available: `hero-fade`, `product-rail`, `panels-3`, `logo-strip`,
`split-feature`, `icon-strip`, `statement`, `cta-close`.

| # | Stripe | Back-office id | Entries | Notes |
|---|---|---|---|---|
| 1 | | `bannerid=` / `repeaterid=` | | |
| 2 | | | | |
| 3 | | | | |
| 4 | | | | |
| 5 | | | | |

Reminders that bite: `logo-strip` needs `bannerLimit` = **logos + 1** (entry 1 is
its heading and is dropped client-side). `panels-3` and `split-feature` want
exactly 3 entries. Any banner acting as a heading still needs a **non-empty
ImagePath** or it renders nothing at all, even though its image is hidden.

If the design needs a shape that is not in the library, say so here - it becomes
a new stripe, authored per `docs/ADDING-A-STRIPE.md` and proven in a browser
before it enters the library.

---

## 8. Carousels

| Decision | Options | This client |
|---|---|---|
| Pagination markers | dots (default) / dashes / bars | |
| Arrow hover | scale bounce (default) / no bounce | |

---

## 9. Back-office data

The build cannot create this, and an unpopulated collection makes a stripe vanish
entirely rather than render empty. Confirm each is populated before QA:

- [ ] every banner collection listed in section 7, with images
- [ ] every FAF repeater listed in section 7, including its title / description / link
- [ ] Home Page Text (only if using the `statement` stripe)
- [ ] Delivery description, Returns policy, Privacy policy, opening times,
      address, phone, email - the interior pages read all of these from
      `CitrusStoreConfiguration` and carry no hardcoded prose
