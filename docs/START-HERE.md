# How to use this

Start here. This is the walkthrough. Everything else in `docs/` is reference you
can read later, or never.

## What this is

A box of parts for building Citrus Lime client sites. The plumbing is already
written and tested. You supply the look: colours, fonts, a logo, and which
homepage sections you want.

You should not be writing CSS from scratch. If you are, something has gone wrong
and there is a section at the bottom about that.

## Five words you need

| Word | Means |
|---|---|
| **stripe** | One horizontal band of the homepage. A hero, a row of product cards, three panels. Your homepage is five to eight of them stacked. |
| **the kit** | This folder. You copy part of it into a new site. |
| **framework** | Files you never edit. Most of them. |
| **client files** | The six things you do edit. Listed below. |
| **token** | A named value, like `--brand: #1E1E1E`. You set them in one file and the whole site follows. |

## What you need before you start

`/new-site` asks for all of these, one at a time, so you do not have to remember
the list. But get them together first anyway - chasing them mid-interview is
what makes builds slow.

- [ ] **Colours.** About ten of them: primary, accent, sale, background, text.
      Everything else is worked out from those automatically.
- [ ] **Three font files.** A body face, a bold face, a display face for big
      headings. If the client only has two faces, supply the text one twice.
- [ ] **A logo, as a flat single-colour SVG.** No colours inside it. It gets
      recoloured automatically so one file works on a white bar and a dark one.
- [ ] **Three icon SVGs:** bag, account, search.
- [ ] **A list of homepage sections, in order.** Pick from `stripes/README.md`.
- [ ] **Back-office data.** Banner collections with real images, and a product
      repeater if you want a product row. Nothing appears without this.

---

# The easy way

**1. Run the command.** In the new site's folder:

```
/new-site
```

**2. Answer the questions.** It interviews you, one question at a time, and
writes the brief itself. There is no form to fill in. It asks the things that
block the build first - which homepage sections, then colours, fonts, logo - and
takes sensible defaults for everything else unless you say otherwise.

If you have a Figma file, a mockup or a brand guide, give it that at the start
and most of the interview turns into "I read this from your mockup, right?"

If you would rather work on paper, `brand-brief.template.md` is the same sheet
in form shape. Fill it in, hand it over, and it will only ask about the gaps.

**3. It builds.** Copies the kit, sets everything up, assembles the homepage,
writes notes for the next person, and checks its own work.

**4. Do the two things it cannot.** Put the real data in the back office, and look
at the site in a browser.

That is it. The rest of this page is what `/new-site` is doing, in case you want to
do it by hand or need to fix something.

**First time on this machine?** `docs/PORTING.md` - clone the kit and run
`tools\bootstrap.ps1` once, which is what puts `/new-site` on the machine at all.

---

# By hand

## Step 1: copy the kit

```
robocopy kit\CustomContent <site>\SiteSpecific\CustomContent /E
```

## Step 2: drop in the files

| Put this here | |
|---|---|
| `font/body.ttf` | the body face. **Required.** |
| `font/bold.ttf` | the bold face. **Required** even if it is the same file as body. |
| `font/display.ttf` | the big-headings face |
| `layout/generalLyout/logo.svg` | flat single-colour logo |
| `layout/generalLyout/icons/bag.svg` | |
| `layout/generalLyout/icons/account.svg` | |
| `layout/generalLyout/icons/search.svg` | |

Keep the filenames exactly as shown. The CSS looks for those names.

`.woff2` versions are better if you have them, but `.ttf` works fine.

## Step 3: set the colours and fonts

Open **`modules/CSS/global/01-CC-Brand.css`**. This is the file that makes the
site look like the client.

It has four sections in the order you fill them:

1. **TYPE ROLES** - leave alone unless a font should do a different job.
2. **BRAND** - the colours, the corner radius, the button styling.
3. **COPY** - a dozen bits of text the CSS writes onto the page, like the footer
   newsletter heading. Leave one blank to get a sensible default.
4. **SWITCHES** - on/off choices. Ships switched off. Turn on only what you need.

Search the file for `<<< SET THIS`. Every one of those must be replaced. The
checker in step 6 fails while any remain.

## Step 4: build the homepage

For each section you want, in order:

- open `stripes/<name>/markup.aspx`, copy the contents, paste it into
  `default.aspx` where it says `<!-- === STRIPES GO HERE === -->`
- open `stripes/<name>/stripe.css`, copy the contents, paste it into
  `modules/CSS/home/CC-Home.css` at the bottom
- number them `1.`, `2.`, `3.` in both files so they match
- replace `__BANNER_ID__` and `__REPEATER_ID__` with the real back-office numbers

Then fill in the two `<...>` gaps: a sentence about the client's look in
`99-CC-Custom.css`, and one about the homepage in `CC-Home.css`. A future you will
be glad of them.

## Step 5: add anything unique to this client

Open **`modules/CSS/global/99-CC-Custom.css`**. This is for things that are
genuinely this client's taste and nothing else.

Before you add a rule, ask: **could the next client want the opposite of this, and
get it just by editing `01`?** If yes, it belongs in `01` as a switch, not here.
There is a fully worked example in `examples/templeton-jones/99-CC-Custom.css`.

## Step 6: check it

```
tools\lint.ps1 -Path <site>\SiteSpecific\CustomContent
```

Keep going until it says `PASSED`. Every failure is something that will not
render, not a style opinion.

## Step 7: look at it

Open the site at three window widths: narrow phone, tablet, wide desktop.
`QA-CHECKLIST.md` has the full list. Two traps before you start debugging:

- **Hard-refresh.** Old files get cached.
- **The homepage is cached for 15 minutes.** A change to `default.aspx` may
  genuinely not show up yet. Wait before investigating.

---

# When something looks wrong

**A whole section is missing.**
Almost always empty back-office data, not broken code. The platform hides a
section entirely when there is nothing to show. Check the banner collection or
product repeater has content.

**Images are not appearing.**
The image paths in the back office point at files that are not there. Nothing to
fix in the code.

**The logo strip shows its own heading as the first logo.**
Set `bannerLimit` to the number of logos **plus one**. That section uses entry one
as its heading and drops it from the carousel.

**A section with just a heading shows nothing at all.**
Even when the design hides the image, the banner still needs an image attached in
the back office. Add any image.

**The nav bar is invisible.**
Remove `class="cl-nav-over-hero"` from `<body>` in `default.aspx`. That makes the
bar transparent, which only works over a large dark photo.

**Nothing changed after I edited a file.**
Hard-refresh. If it is a `.js` file, bump the `?v` number next to it in the page.
If it is the homepage, wait 15 minutes.

**I want to change a framework file.**
Don't, yet. It means one of two things. Either the thing you want should be a
switch, in which case add the token to the file that owns it (`03` for the nav bar,
`05` for carousels) and set the value in `01`. Or it is genuinely this client's
taste, in which case it goes in `99`. Editing a framework file directly means the
next site cannot inherit your fix, and your change gets wiped the next time the kit
is updated.

---

# Reskinning a site that already exists

Steps 2, 3 and 5 only. Replace the fonts and logo, rewrite `01`, and **delete the
contents of `99` and start it again** rather than editing it. Old rules left in
there will fight the new look in ways that are very hard to find.

Back it up first:

```
robocopy <site>\SiteSpecific\CustomContent <site>\SiteSpecific\CustomContent.bak /E
```

There is no undo. Saving a file on the share publishes it immediately.

---

# Where to go next

| | |
|---|---|
| `stripes/README.md` | what each homepage section looks like, and what data it needs |
| `docs/QA-CHECKLIST.md` | the full checking list |
| `docs/BUILD.md` | the same job as this page, in more detail |
| `docs/CONTRACT.md` | how the whole thing works and what the platform will not let you do. Read it before doing anything unusual |
| `docs/ADDING-A-STRIPE.md` | when a design needs a section shape the kit does not have |
| `docs/PORTING.md` | setting the kit up on another machine, and keeping the two in step |
