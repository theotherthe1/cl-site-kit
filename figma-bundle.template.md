# Figma bundle - <STRIPE NAME>

**You do not normally fill this in by hand for /figma-stripe to read it back
word for word.** This is the checklist for what to pull out of Figma before you
invoke `/figma-stripe <SITECODE> <stripe-name>` - either save it as
`notes.txt` inside a bundle folder, or paste the same content straight into
chat. Either works; the skill reads whichever you give it.

The point of this file is to make the free, unmetered parts of Figma Dev Mode
do the work that would otherwise cost an MCP call against your AI-feature
credits. Nothing here touches the `figma` MCP server.

---

## 1. The frame

- [ ] **PNG export of the full frame**, at the zoom Figma exports by default.
      This is the ground truth Claude builds against and later compares the
      live render to.
- [ ] **A mobile frame's PNG, only if you actually designed one.** Most
      stripes are desktop-only; when there is no mobile frame, the stripe
      gets the kit's standard responsive collapse instead, and the build will
      say so plainly rather than claim a mobile design was followed.

## 2. Exact values - "Copy as CSS"

Select each of these layers in Dev Mode and copy its CSS, pasted here as-is:

- [ ] the outer container / section wrapper
- [ ] each distinct text style (heading, body, eyebrow, CTA label)
- [ ] any card, panel or tile that repeats
- [ ] anything with a shadow, radius or border that is not obviously zero

Auto-layout frames give clean flex/gap output here - that is most of the
spacing and sizing fidelity work done for free.

```
<paste Copy as CSS output>
```

## 3. Variable names

Where a fill, stroke or effect resolves to a Figma **variable** rather than a
raw value, Dev Mode's inspect panel shows the variable's name instead of a
hex/px. Note those names here, even for values already covered by the CSS
dump above - a named variable tells Claude this is meant to be a brand token,
not an incidental choice:

```
<layer> -> <variable name> (e.g. "CTA background" -> "brand/accent")
```

## 4. Assets

- [ ] real images/icons the stripe uses, exported at the widths the site's
      image resizer will actually serve (see `CLAUDE.md`: width only, no
      `height` + `mode=crop` - the resizer's `object-fit: cover` already crops)
- [ ] anything that is not a photograph a `<BannerCollectionSplide>` or
      `<FafCustomRepeaterSplide>` will serve - i.e. a genuinely static asset

## 5. Anything Copy as CSS cannot tell Claude

- [ ] which text is meant to bind to which CMS field (title / description /
      link) - Figma has no concept of this, and the stripe's markup has no
      hardcoded copy regardless of what the layer names say
- [ ] whether this anatomy already exists as a stripe - if you know it is a
      retune of an existing shape, say so; it saves the classification step

---

**What this bundle is not for:** a layout so ambiguous (overlapping
elements, unclear stacking order, a component whose auto-layout direction
isn't obvious from the PNG) that no amount of manual export resolves it. That
is what the skill's MCP escape hatch is for - one `get_design_context` call,
spent deliberately, not a reason to skip this checklist.
