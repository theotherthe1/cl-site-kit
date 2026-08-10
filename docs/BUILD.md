# Building a site

The whole job, in order. `/new-site` automates steps 2–7; this is what it does
and what you check.

Read `CONTRACT.md` first if you have not. Nothing below makes sense without it.

---

## 1. Fill the brief

Copy `brand-brief.template.md`, fill it in, save it beside the project. Sections
2, 3, 4 and 7 (colour, type, assets, stripes) block the build — the rest can
take defaults.

The two questions that actually need answering before anything else:

- **Does the homepage open on a full-bleed image?** If yes, the nav floats
  transparent over it and `<body>` keeps `class="cl-nav-over-hero"`. If no,
  remove that class or the bar will be invisible.
- **Which stripes, in what order?** Everything downstream follows from the list.

## 2. Copy the kit

```
robocopy kit\CustomContent <site>\SiteSpecific\CustomContent /E
```

`VERBATIM` and `FRAMEWORK` files are now final. You will only touch the six
`CLIENT` entries in `MANIFEST.md`.

## 3. Drop in the assets

| Where | What |
|---|---|
| `font/body.woff2` + `.ttf` | text face — **required** |
| `font/bold.woff2` + `.ttf` | bold face — **required**, even if it duplicates body |
| `font/display.woff2` + `.ttf` | editorial face |
| `font/accent.*` | optional |
| `layout/generalLyout/logo.svg` | single-colour silhouette — it is painted as a **mask** |
| `layout/generalLyout/icons/{bag,account,search}.svg` | |

`body` and `bold` are not optional: around 186 platform declarations outside this
tree name `citrfontreg` and `citrfontbold` literally, and we cannot repoint them.
A client with one text face ships it twice.

The logo must be a flat silhouette. It is used as a CSS mask filled with
`currentColor`, so any colour inside the SVG is discarded — which is exactly what
lets one file work over a photo, a white bar and a dark bar.

## 4. Fill `01-CC-Brand.css`

Four blocks, in order. Every `<<< SET THIS` must go — lint fails while one
remains.

1. **TYPE ROLES** — normally leave alone. Only change if a role should point at a
   different slot.
2. **BRAND** — the raw colours, radius and the button ramp. Do not add derived
   values; `02` generates shades, borders, overlays, shadows and the text
   hierarchy from these with `oklch()`.
3. **COPY** — the words CSS writes onto platform elements. Leave a token unset to
   accept its neutral default.
4. **SWITCHES** — ships commented out. Uncomment only what the design asks for.
   Every switch's default lives with the component that owns it (`03` for the
   bar, `05` for carousels) and is documented there.

Check contrast while you are here: `--text` on `--background`, `--text-on-brand`
on `--brand`, `--text-on-accent` on `--brand-accent`. 4.5:1 minimum for body.

## 5. Assemble the homepage

For each stripe in the brief's order:

- paste `stripes/<name>/markup.aspx` into `default.aspx` at the
  `<!-- === STRIPES GO HERE === -->` marker
- paste `stripes/<name>/stripe.css` into `modules/CSS/home/CC-Home.css` after the
  mandatory `_shared` block
- renumber the `N.` in both files so they agree
- replace `__BANNER_ID__` / `__REPEATER_ID__` with the real back-office ids
- keep only the `<%@ Register %>` lines the chosen stripes need

Then fill the two `<...>` prose placeholders — the client's visual language in
`99`'s header and the homepage description in `CC-Home.css`'s preamble. They are
not decoration: they are what tells the next person whether a new rule belongs.

## 6. Write `99-CC-Custom.css`

Only this client's taste. Before every rule, apply the test: *could the next
client want the opposite and get it by editing `01` alone?* If yes, it is a
switch — put the token in the framework instead.

Use `--skin-*` for any local token. Never the client's initials.
`examples/templeton-jones/99-CC-Custom.css` is a fully worked version, including
two blocks that were deliberately **not** promoted and the reasoning for each.

## 7. Populate the back office

The build cannot do this and nothing renders without it.

- each banner collection from the brief, **with images**
- each FAF repeater, including its title / description / link — on
  `product-rail` those are the stripe's own heading
- Home Page Text, if using `statement`
- delivery, returns, privacy, opening times, address, phone, email

`logo-strip` needs `bannerLimit` = **logos + 1**. Any banner acting as a heading
needs a **non-empty ImagePath** even though its image is hidden, or it renders
nothing at all.

## 8. Lint

```
tools\lint.ps1 -Path <site>\SiteSpecific\CustomContent -PreviousClient "<seed client>"
```

Must exit 0. Every failure is something that renders wrong or not at all.
Warnings are worth reading but do not block.

## 9. QA in a browser

`QA-CHECKLIST.md`. Lint cannot see whether it looks right, whether the CMS is
populated, or whether you bumped a `?v`.

---

## Reskinning an existing site

Same job, minus steps 2 and 5. You are replacing `01-CC-Brand.css`, rewriting
`99-CC-Custom.css` from scratch, and swapping the files in `font/` and `layout/`.
Leave `default.aspx` and `CC-Home.css` alone unless the stripe composition
changes.

**`99` is rewritten, not edited.** Stale rules there override the new skin, and
unlike a stray colour a stray rule cannot be found by searching for a token.

## Updating a built site from a newer kit

`MANIFEST.md` is the whole mechanism. Copy every `FRAMEWORK` and `VERBATIM` entry
forward; touch no `CLIENT` entry. That is safe because framework files are
client-neutral by construction — if one ever names a client, the update model is
broken, which is why lint checks for it.

Record the kit commit in the site's `CLAUDE.md` so the next update knows where it
started.
