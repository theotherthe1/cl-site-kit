# The intake interview

How to get a complete brief out of a person without handing them a form.

The output is a filled `briefs/<SITECODE>.md`, in the exact shape of
`brand-brief.template.md`. That file remains the schema and the record: it is
what a later reskin, update or handover reads, and it is committed to the kit so
it travels with the repo. The interview changes how it gets filled, not what it
is.

---

## The rules

**1. One question per turn.** Ask, stop, wait. Do not stack a second question
behind the first, do not append "and also", do not ask a question and then
answer it yourself. This is the whole point of the format: a person can answer
one thing accurately and will answer four things vaguely.

**2. One question may still ask for a lot, if one answer naturally carries it.**
A palette is one answer. Eleven colours asked separately is eleven turns of the
same answer, and it makes the interview feel like the form it replaced. Ask for
the whole palette; then, one at a time, chase only what is still missing.

**3. Read the source before you ask.** If there is a Figma file, a mockup, a
brand guide, a screenshot or a live site, go through it first and convert
questions into confirmations. "The mockup gives me `#1E1E1E` for body ink and a
0px radius - right?" is a better question than "what is your body ink?", and it
is far more likely to be correct.

**4. Every question states its default and what it blocks.** The person should
always be able to say "default" and have that be a real answer. If a question
has no sensible default, say that it is blocking and why.

**5. Prefer a choice to a blank.** Use `AskUserQuestion` with real options
whenever the answer is a pick, and put the recommended option first. Reserve
free prose for values only the client has - hex codes, file paths, back-office
ids.

**6. Write the answer down immediately.** After each answer, update
`briefs/<SITECODE>.md`. An interview interrupted at question 9 must resume at
question 10, not at question 1.

**7. Never invent a required value.** Colour, type, assets and stripes block the
build. If the person does not know, record `?` and say plainly at the end that
the build cannot start until it is resolved. A guessed hex is worse than a gap,
because a gap gets chased and a guess ships.

**8. Do not start building mid-interview.** No files are copied, no CSS is
written, until the brief is complete and the person has confirmed it.

---

## Resuming

Before asking anything, look for `briefs/<SITECODE>.md`. If it exists, read it,
say what is already answered, and pick up at the first field still blank or
marked `?`. Do not re-ask what is recorded.

---

## The order

Blocking-first, and the two questions that decide the most downstream work come
before the ones that are merely required. Skip any question the design source has
already answered - confirm it instead.

### Round 0 - orientation

**Q1. Which client, and what is the site called?** Client name plus the site
code / folder name on the share. Blocks the brief filename.

**Q2. Where is the site tree?** The full path to `SiteSpecific\CustomContent`.
Look at it before asking anything else: if it already holds a skinned
`01-CC-Brand.css`, this is a reskin or an update, not a fresh build, and you can
confirm that rather than ask it.

**Q3. Confirm the mode.** `fresh` / `reskin` / `update`, from what you just saw.
State what you observed and let them correct you. Getting this wrong is
expensive: `update` must never touch a CLIENT file, `reskin` must never touch
`default.aspx`.

**Q4. Is there a design source?** Figma link, flat mockup, brand guide PDF, a
screenshot, or a live site to match. Default is no, and the interview simply
gets longer. If there is one, read it now, before Q5 - it will answer a large
part of rounds 2 to 4 and turn them into confirmations.

### Round 1 - the two decisive questions

**Q5. Which homepage stripes, in what order?** Offer the catalogue from
`stripes/README.md`: `hero-fade`, `product-rail`, `panels-3`, `logo-strip`,
`split-feature`, `icon-strip`, `statement`, `cta-close`. Let them multi-select,
then confirm the order in a second turn if the design does not make it obvious.
Everything downstream follows from this list.

If the design needs a shape the library does not have, say so now rather than at
build time, and say which existing stripe is closest and whether it is really
just a retune - a different panel count or aspect ratio usually is, and the
grid/carousel swap is free.

**Q6. Should the nav float transparent over the opening stripe?** Only ask this
if stripe 1 is a full-bleed image. Otherwise state that the default is no, that
no is right here, and move on. Over a light opening stripe it produces an
invisible nav, so a habitual yes is a bug.

### Round 2 - colour (blocking)

**Q7. The palette, in one answer.** Ask for whatever they have - a brand guide
extract, a list of hexes, a Figma variables screenshot. Map what you get onto
the eleven tokens yourself; do not make them learn the token names.

**Q8 onward. Chase the gaps, one token per turn.** Only the ones still
unresolved after Q7, and each with the default you would otherwise derive. Do
not ask for ramps, borders, overlays or shadows: `02` derives all of those with
`oklch()` from the raw values, and supplying them by hand is a mistake to catch
here rather than to honour.

**Then: run the contrast check yourself and report it.** `--text` on
`--background`, `--text-on-brand` on `--brand`, `--text-on-accent` on
`--brand-accent`, 4.5:1 minimum for body. If a pair fails, that is a question
back to them with the two options laid out - change the ink, or change the
surface. Do not silently pick one.

### Round 3 - type (blocking)

**Q9. The font files, in one answer.** Where are they, and which face does which
job. Say plainly that `body` and `bold` both need a real file even if it is the
same file twice, because about 186 platform declarations outside our tree name
those two families literally.

**Q10. Corner radius.** Offer `0`, `3px`, `8px`, other. Default `3px`. One value
sets it everywhere.

**Q11. Nav link case and tracking.** Only if the design does not show it.
Default is as typed by the CMS author, normal tracking.

### Round 4 - assets (blocking)

**Q12. Logo and the three nav icons, in one answer.** Paths to `logo.svg`,
`bag.svg`, `account.svg`, `search.svg`. State the constraint before they answer,
not after: the logo is painted as a **mask** filled with `currentColor`, so it
must be a flat single-colour silhouette. A colour SVG with white knockouts goes
solid under a mask - if that is what they have, the answer is a transparent PNG
cutout, and it needs `--logo` repointed.

**Q13. Favicons.** They sit at the site root, outside this tree, so you cannot
place them. One turn to confirm someone will.

### Round 5 - everything that has a default

**Q14. One question, not fifteen.** Say that copy strings, the nav switches and
the carousel markers all have framework defaults, list the three or four this
client is most likely to want changed, and ask whether any need setting. The
ones worth naming: `--copy-newsletterTitle` and `--copy-newsletterBody` (footer,
visible on every page), whether the solid-state bar is light or dark, and the
accent seam under it. Everything else can be left.

### Round 6 - back-office data

**Q15. The ids, in one answer.** For each stripe from Q5, the `bannerid` or
`repeaterid` it reads. If they do not exist yet, record that: sequentially
assigned ids are a guess, and a guess here means a stripe that renders nothing.
Mark them unconfirmed in the brief rather than pretending.

**Q16. Is the data there?** Banner collections with real images, FAF repeaters
with title / description / link, Home Page Text if `statement` is in the list.
This is the most common reason a finished build looks broken: the platform hides
a control's `<asp:Panel>` when nothing binds, so the stripe vanishes entirely
rather than rendering empty.

Remind them of the three that bite: `logo-strip` needs `bannerLimit` = logos
**+ 1**; `panels-3` and `split-feature` want exactly 3 entries; any banner acting
as a heading still needs a non-empty `ImagePath` or it renders nothing at all.

### Close

**Q17. Show the brief and ask for the go-ahead.** Write `briefs/<SITECODE>.md`,
show them the sections still marked `?`, say which of those block the build, and
ask whether to start. Only then begin the work in `SKILL.md`.

---

## The one thing this interview must produce that a form does not

A form records answers. The interview should also record **why** - the visual
language paragraph in section 1, which becomes the header of `99-CC-Custom.css`
and is what tells the next person whether a new rule belongs there.

You cannot ask for it directly; "describe your visual language" gets "clean and
modern", which is useless. Write it yourself from what you heard across the whole
interview, in the concrete register the template asks for - "one white canvas,
ink type, hairline rules, ghost 1px-outline chrome" - and show it back for
correction. That is a confirmation, not a question, so it costs no turn.
