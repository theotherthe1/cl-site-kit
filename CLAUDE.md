# CLAUDE.md

Read this before changing anything in this repository. It is the operating manual
for working on cl-sitekit and for building sections with it.

If you are building or reskinning a whole site, invoke `/new-site`. It interviews
the user one question at a time and writes the brief itself - it does not hand
anyone a form. This file is about working on the kit itself and authoring
sections.

## The mental model

This kit skins a Citrus Lime ASP.NET WebForms storefront. The platform is **not in
this repository**: assemblies, `/modules/`, `/PlatformCommonControls/`,
`Modules/CSS/**` and `citr-*.css` all live in the site tree and are not editable.
You are writing an overlay.

Four layers, and knowing which one you are in is the whole job:

```
01-CC-Brand.css      CLIENT     raw values: type roles, brand, copy, switches
02-CC-Global.css     FRAMEWORK  derived ramps, type scale, font slots, canvas
03..08               FRAMEWORK  per-component structure + tokens
home/CC-Home.css     CLIENT     the homepage, assembled from stripes/
detail/ faf/ misc/   FRAMEWORK  PDP, PLP, interior pages
99-CC-Custom.css     CLIENT     this client's taste. Loads last. Wins everything.
```

`MANIFEST.md` is authoritative on which file is which kind. Do not infer it.

## Non-negotiable rules

**1. Never hardcode a colour, radius, shadow or font size** outside
`01-CC-Brand.css`. If a value is missing, add a token to the component that owns
it. Lint warns on hex outside `01`.

**2. Framework files never name a client** - not their colours, words, assets,
initials or taste, and not in comments either. This is not tidiness: FRAMEWORK
files get copied wholesale onto existing sites without being read, so a client
name in one is a bug that ships to every other site. Lint checks this, including
in comments and in `.js`.

**3. Never edit a FRAMEWORK file to achieve a client look.** If you want to, you
have found one of two things. Either a missing switch, in which case add the token
to the owning component **with a default that preserves current behaviour** and set
the value in `01`. Or genuine client taste, in which case it goes in `99`. There is
no third option, and editing the framework directly means no other site inherits
the fix and it gets wiped on the next kit update.

**4. `99` is rewritten per client, never edited.** Anything reusable that lands
there is lost work.

**5. Pure ASCII everywhere**, including comments. No em dashes, en dashes, arrows,
ellipses or box-drawing. The whole repo is audited for this.

**5b. Every SVG is written into the file, never referenced.** A `url(...)`,
`src` or `href` pointing at an `.svg` does not display on iPhone. Inline it as
`url("data:image/svg+xml,...")` - in `01` for brand art (`--logo`, `--icon-*`),
in the owning component for a framework glyph. No `.svg` files in the tree, no
`favicon.svg`. Lint fails on a referenced `.svg` and on an unset `--logo`;
`update-site.ps1` refuses to push `03` to a site whose artwork is still in files.

**6. `pages/`, `feed/`, `ReturnsPDFs/` are untouchable** and byte-identical across
sites. They contain two deliberately-preserved rough edges. Do not "fix" them, do
not normalise them, do not lint them.

## The decision procedure

Run this before writing anything. Getting it wrong is expensive both ways.

```
Do I want a value that does not exist?
  -> add a token to the component that owns it, default = current behaviour,
     document the default there, set the client value in 01

Do I want a rule that only this client would want?
  -> 99-CC-Custom.css. Ask: would copying this to another client look wrong?
     If yes, it belongs here. If no, it is a switch.

Do I want a homepage shape that does not exist?
  -> is the ANATOMY different, or just the count / aspect ratio / grid-vs-carousel?
     count or ratio  -> retune an existing stripe
     grid vs carousel -> swap which control is registered; hooks are identical
     genuinely new anatomy -> new stripe, per docs/ADDING-A-STRIPE.md

Am I about to write CSS I have written before?
  -> it is mechanism. Promote it, but only on the SECOND occurrence.
     One client wanting something is a preference; two is a pattern.
```

**Promote on the second occurrence.** Promoting on a sample of one is how a
framework becomes one client's site with the serial numbers filed off.

## Building a section (stripe)

A stripe is one horizontal band of a homepage: a `.col-1` wrapper, one platform
control inside it, and a `.hp-NAME` block of CSS.

### Rules specific to stripes

- **Name it for its shape, not its content.** `split-feature` still describes
  itself for the next client; `seasonal-duo` did not, and was renamed.
- **Rules key off the class name only**, never a position or a numbered section.
  This is what makes stripes reorderable, and it is load-bearing.
- **No hardcoded copy, ever.** Every word comes from the CMS via a banner
  collection or an FAF repeater. If the design has a heading you cannot bind, use
  a 1-item banner collection wrapped in `.CC-HomepageTitles`. Do not type it in.
- **Vertical rhythm from `--section-padding-sm` / `-lg`.** A full-bleed opening
  hero carries none, so the image runs flush to the nav.
- **Horizontal inset from `--gutter`.** Do not retype the clamp; it was duplicated
  eight times before it was a token.
- **Chain a carousel's height explicitly.** Splide's flex layout flows top-down:

  ```css
  .hp-yourstripe .splide { height: clamp(320px, 60vh, 780px); }
  .hp-yourstripe .splide__track,
  .hp-yourstripe .splide__list,
  .hp-yourstripe .splide__slide { height: 100%; }
  ```

  Content-height stripes omit the chain deliberately.
- **Give it a `:not(:has(...))` fallback** for partial CMS content. A stripe that
  collapses badly on incomplete data will look broken on someone's launch day.
- **Carousel options live in markup**, in `data-splide-opts` JSON on the `.col-1`.
  Never add per-carousel JS.
- **Keep `data-animate`** on the `.col-1` or the stripe will not scroll-reveal.
- **To beat `05`'s Splide chrome**, use the `[data-splide-opts].hp-yourstripe`
  compound for `(0,3,0)`. `.hp-yourstripe` alone ties and then depends on which
  bundle loads last, which is not guaranteed between folders.

### Things that will catch you out

- **An empty stripe means empty CMS data, not broken CSS.** The platform hides the
  control's `<asp:Panel>` when nothing binds, so the stripe vanishes entirely. On a
  product rail that takes the heading with it, because the repeater's Panel *is*
  the rail grid.
- **A heading banner still needs a non-empty `ImagePath`**, even when CSS hides
  the image, or it renders nothing at all.
- **A logo strip needs `bannerLimit` = logos + 1.** Entry 1 is its heading, and
  `data-splide-skip="1"` drops that slide pre-mount. The skip must remove rather
  than hide: `type:loop` clones slides and widths derive from slide count, so a
  hidden slot leaves a drifting gap.
- **Ask the image resizer for width only.** No `height` + `mode=crop`: one control
  serves several aspect ratios and `object-fit: cover` already crops. A
  server-side crop re-cropped makes source height the binding dimension and
  upscales. Keep the 480/1024/full breakpoints and the `1x`/`2x` pair on each.
- **Server IDs cannot be renamed**, because several controls share one code-behind:
  `bannerCollectionPanel`, `bannerEntriesRepeater`, `FAFCustomPanel`,
  `itemRepeater`, `repeaterTitle`, `repeaterDesc`.
- **Bound fields are fixed.** Banners: `NavigateLink`, `NavigateLinkText`, `Title`,
  `Description`, `ImagePath`, `DisplayOrder`.

### Extracting it into the library

Build and prove it in a real site first. Then: neutralise control IDs (no client
prefixes), replace back-office ids with `__BANNER_ID__` / `__REPEATER_ID__`, use
`N.` in the section headers, add a row to `stripes/README.md`, and verify the
split round-trips into the `CC-Home.css` you built.

Nothing enters `stripes/` unproven. Everything in there has rendered correctly on
a live site, and that is the only reason it can be trusted.

## Specificity is hand-tuned here

The nav has documented `(0,3,1)` vs `(0,4,1)` relationships where a rule wins by
exactly one class, plus `!important` ladders that depend on them. **Read the
comment before changing a selector.** Useful fact: `:has()` contributes its
argument's specificity, so `body:has(.foo)` and `body.foo` are both `(0,1,1)`.

**Moving a rule between files changes its order.** Load order in `global/` is the
numeric prefix; `99` loads after everything. A rule moved earlier can lose a fight
it used to win. Before moving anything, check what else touches those selectors.

`!important` is heavy in `02`, `03` and `CC-faf.css` because they fight platform
stylesheets. Reach for specificity scoping first.

## Before you say it is done

- **`tools/lint.ps1` exits 0.** Not "mostly passes".
- **A new switch defaults to current behaviour**, and you can state how you know:
  the computed value, the specificity, the rule order.
- **You have said what you did not verify.** You cannot see the rendered page.
  Lint cannot see whether it looks right, whether the CMS is populated, or whether
  a `?v` was bumped. Say so plainly rather than implying the work is confirmed.
  Structural checks are not visual proof, and claiming otherwise is the worst
  failure mode available here, because there is no build to catch it.
- **`CHANGELOG.md` has a row** in the "verified how" table naming your method.
- **`MANIFEST.md` lists any file you added.** `update-site.ps1` refuses to run
  while anything is unclassified.

## Environment facts

- **No build, no tests, no package manager.** Editing a file on the share deploys
  it. Back up before touching a live tree.
- **Cache busting is manual.** Bump the `?v` on any `<script>`/`<link>` you change.
- **The homepage is output-cached for 900 seconds.** Markup changes can take 15
  minutes; CSS is unaffected. Wait before debugging.
- **This repo is the only version history in the ecosystem.** Client sites have no
  git. Commit messages are the design record; write them for the next reader.
- **Builds happen on a build server over RDP, so the kit lives in two working
  trees.** Everything a build depends on is therefore in this repo, including the
  `/new-site` skill (`.claude/skills/`) and every filled brief (`briefs/`). Pull
  before you build, push what you learned, and never leave a build artefact on
  one machine. `tools/bootstrap.ps1` sets a machine up; `docs/PORTING.md` is the
  loop.
- **Resolve the kit path from `$env:CL_SITEKIT`, never a literal.** A hardcoded
  `C:\Users\<someone>\cl-sitekit` in a doc or a skill is wrong on the other
  machine, which is where the building actually happens.

## Where the rest lives

| | |
|---|---|
| `docs/START-HERE.md` | the plain walkthrough |
| `docs/CONTRACT.md` | full architecture and platform constraints |
| `docs/ADDING-A-STRIPE.md` | authoring a new section |
| `docs/EVOLVING-THE-KIT.md` | upstreaming improvements, pushing to built sites |
| `docs/PORTING.md` | setting up another machine, and keeping the two in step |
| `.claude/skills/new-site/INTERVIEW.md` | how `/new-site` conducts the intake |
| `.claude/skills/figma-stripe/SKILL.md` | building one stripe with fidelity from a Figma frame |
| `figma-bundle.template.md` | what to pull out of Figma Dev Mode before running `/figma-stripe` |
| `briefs/` | one filled brief per built site |
| `docs/QA-CHECKLIST.md` | what to check in a browser |
| `MANIFEST.md` | which files are which kind |
| `SITES.md` | which site is on which kit commit |
| `examples/templeton-jones/` | a finished skin, including two blocks deliberately not promoted |
