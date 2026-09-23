---
name: figma-stripe
description: Build one homepage stripe with full fidelity from a Figma frame, on an already-built client site, using cl-sitekit's token system and stripe library. Use when the user wants to turn a Figma design/frame into a stripe, mentions a Figma export bundle or figma-bundle.template.md, or wants pixel-fidelity work against a specific design frame on a live build.
---

# Build a stripe from a Figma frame

This is section-level work on **one already-established client build** - the
site tree exists, `/new-site` has already run, and `briefs/<SITECODE>.md`
exists. If any of that is not true yet, stop and say so: this skill does not
build a whole site, that is `/new-site`.

The whole point of this skill is to spend Figma MCP credits deliberately,
almost never. Everything in here defaults to free, unmetered Figma Dev Mode
export (`figma-bundle.template.md`) and only reaches for the connected
`figma` MCP tools as a named, logged exception.

## Finding the kit

Same resolution order as `/new-site`:

1. the `CL_SITEKIT` environment variable
2. the current repo, if you are already working inside the kit
3. `cl-sitekit` under the user profile, or beside the site folder

If none of those find it, ask. Everything below writes `<kit>` for that path.

Run this skill with Claude Code open against the client's site tree (or pass
its path directly) - the same convention `/new-site` uses, since the actual
edits land in `<site>\SiteSpecific\CustomContent`, not in `<kit>`.

## Invocation

`/figma-stripe <SITECODE> <stripe-name> [bundle path]`

- `<SITECODE>` resolves `<kit>\briefs\<SITECODE>.md` for the site path and
  dev URL. If that brief does not exist, ask for the site path and dev URL
  directly rather than guessing - do not invent them.
- `<stripe-name>` is the shape name if you already know it (`hp-<name>`), or
  a working name if this is new anatomy and naming happens after step 2.
- `[bundle path]`, if given, is a folder in the shape of
  `figma-bundle.template.md` (typically `_figma-import\<stripe-name>\`). If
  omitted, ask for the bundle content pasted into chat instead - screenshot
  plus the Copy as CSS dump and variable names. Either input form is fine;
  read whichever you get.

## Step 1: read the bundle

Work through `figma-bundle.template.md`'s checklist against whatever you were
given. If something load-bearing is missing - no PNG, no CSS dump for a layer
whose values matter, an asset at the wrong width - ask for it. Do not guess a
spacing value or a hex from the screenshot alone when Dev Mode could have
supplied it exactly; that is what the checklist exists to prevent.

Do not touch the `figma` MCP tools in this step. If the bundle is genuinely
insufficient to resolve the layout (not just tedious to eyeball), that is
Step 3, not this one.

## Step 2: classify the anatomy before writing anything

Compare the frame against:

- `<kit>\stripes\README.md` - shapes already promoted into the library
- `<kit>\SITES.md` - other clients' rows that mention a "NEW stripe... not
  yet in the library" with a similar anatomy (the WILLCL/BREM `hp-cards-4`
  cross-reference is exactly this kind of match, done by hand today)

Classify as one of:

- **retune** - same anatomy, different count/aspect ratio/entries. Reuse the
  existing stripe's markup and CSS, adjust the values.
- **grid/carousel swap** - same anatomy, different control registered. Free;
  both control variants emit identical class hooks.
- **genuinely new anatomy** - different arrangement or relationship of
  image/text/CTA. Follow `docs/ADDING-A-STRIPE.md` from scratch.
- **cross-client match** - looks like the same new anatomy another client
  already built and did not promote. Flag this to the user by name (which
  site, which stripe) before building. This is a candidate for the promotion
  mode below, but do not promote unprompted.

State the classification and wait for the user to confirm before writing any
markup or CSS - the same "do not start building mid-flow" discipline
`/new-site`'s interview uses, for the same reason: this judgment call is
cheap to get wrong quietly and expensive to unpick later.

## Step 3: the MCP escape hatch (exception, not the default)

Only when Step 1's bundle cannot resolve the layout - overlapping elements,
unclear stacking order, an auto-layout direction the PNG does not make
obvious. Not for "this would be faster to confirm via API."

1. Invoke the `figma:figma-design-to-code` skill first - it is a mandatory
   prerequisite before calling `get_design_context` and must not be skipped.
2. Call `get_design_context` once, against the specific ambiguous frame only.
3. Do not call `get_screenshot` - the bundle already has a PNG.

Say plainly, in the same turn, that the escape hatch was used and why. This
is the one thing in this skill that costs the user's Figma plan credits, and
it should never be quiet about it.

## Step 4: build it

Work directly in `<site>\SiteSpecific\CustomContent`, per
`docs/ADDING-A-STRIPE.md`'s "build it in a real site first" rule - not in
`<kit>` and not in the parts bin.

**Markup**, in `default.aspx`: one `.col-1` wrapper carrying `hp-<name>`,
`data-animate`, and `data-splide-opts` if it is a carousel. The platform
control(s) inside it, registered at the top of the file if not already. No
hardcoded copy - every word comes from a banner collection or FAF repeater;
if the bundle's PNG shows a heading you cannot bind, that is a 1-item banner
collection wrapped in `.CC-HomepageTitles`, not typed-in text.

**CSS**, in `CC-Home.css`, keyed off the class name only. For every value the
bundle gave you (Copy as CSS dump, variable names), run it through
`CLAUDE.md`'s decision procedure before it touches the stylesheet:

```
value matches an existing token          -> reuse the token
genuinely new brand value                -> new CLIENT token in 01-CC-Brand.css
one-off taste, would look wrong elsewhere -> 99-CC-Custom.css
```

Never write a raw px/hex/shadow straight from the Copy as CSS output into
`CC-Home.css` or a FRAMEWORK file - that is the violation this whole
procedure exists to prevent, and "the design says so" is not an exception to
it. A variable name from Step 1.3 is a strong hint the value belongs as a
token rather than one-off taste.

Apply the rest of `docs/ADDING-A-STRIPE.md`'s mechanical rules: vertical
rhythm from `--section-padding-sm`/`-lg`, horizontal inset from `--gutter`
(never a retyped clamp), the explicit carousel height chain if it is a
carousel, a `:not(:has(...))` fallback for partial CMS content, carousel
options in `data-splide-opts` markup rather than new JS, and the fixed
back-office field names and shared control IDs.

**Responsive behaviour**: the bundle's desktop frame is authoritative. If the
bundle includes a mobile PNG, that frame is authoritative for that breakpoint
too. If it does not, apply the kit's existing responsive conventions (the
type scale in `02-CC-Global.css`, how other stripes collapse their grids) and
say so explicitly in Step 5 - this is a place fidelity is deliberately
kit-convention, not designer-specified.

## Step 5: verify

- `<kit>\tools\lint.ps1 -Path <site>\SiteSpecific\CustomContent` exits 0.
- Load the dev URL from `briefs\<SITECODE>.md` in the browser and screenshot
  the built stripe at 375, 1024 and 1440. Put these next to the bundle's PNG
  for an actual side-by-side, not a description of one.
- State plainly what you did not or could not verify: whether the CMS
  collection/repeater is populated, whether a `?v` cache-bust needs bumping,
  whether the 900s homepage output cache means the dev URL has not picked up
  a markup change yet, and - if there was no mobile PNG - that the 375
  breakpoint is kit-convention rather than designer-verified.

## Step 6: close out

- Update this client's row in `<kit>\SITES.md`: name the stripe, its shape,
  and whether Step 2 flagged it as a cross-client promotion candidate. This
  is not optional bookkeeping - it is the record the next `/figma-stripe`
  run's Step 2 reads to catch the next match.
- If a `<script>`/`<link>` changed, remind the user to bump its `?v`.
- The bundle folder (if one was used) is disposable working material, not a
  record - leave it out of any commit. Nothing under `_figma-import\` belongs
  in `<kit>` or the site tree.
- Do not touch `<kit>\stripes\`, `stripes/README.md`, or Atlas's
  `stripe-catalogue.json` here. That is promotion, below, and only happens
  when asked.

## Promoting a stripe into the library

A separate, deliberate action - triggered by the user, whether because Step 2
or Step 6 flagged a likely second occurrence, or because they say so
directly. Never run this as part of a single-client build.

Follow `docs/ADDING-A-STRIPE.md`'s "Extracting it into the library" section:
neutralise control IDs (no client prefixes), replace back-office ids with
`__BANNER_ID__`/`__REPEATER_ID__`, number the section headers `N.`, add a row
to `stripes/README.md` (and a "Things that will catch you out" entry for any
non-obvious trap this build hit), add the matching axes entry to Atlas's
`stripe-catalogue.json` if the shape genuinely fits one of the shared styling
axes, and verify the split round-trips into the `CC-Home.css` it came from.

## Hard rules restated

Everything `CLAUDE.md` already says still applies. The ones a Figma-driven
build makes easiest to break by accident:

- **Never hardcode a colour, radius, shadow or font size** outside
  `01-CC-Brand.css` - not even when Copy as CSS handed you the exact value.
- **Never edit a FRAMEWORK file to achieve this client's look.** A missing
  switch gets a token with a default that preserves current behaviour; taste
  goes in `99`.
- **Pure ASCII**, including in any comment explaining why a value came from
  the design.
- **Promote on the second occurrence, not the first.** Step 2/6 flagging a
  match is not itself permission to promote.
