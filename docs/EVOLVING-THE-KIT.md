# Evolving the kit

The kit gets better by being used. Every client build teaches you something; this
is how that gets back in, and back out to the sites already built.

Two directions, and both matter:

```
   client build  --- upstream --->  the kit  --- downstream --->  every other site
   (you learn something)                          (they get the fix)
```

Skip the upstream half and you relearn the same lesson on every site. Skip the
downstream half and 200 sites slowly drift apart until "the framework" means
nothing.

---

## Upstream: getting an improvement into the kit

### 1. Notice it

The signal is almost always one of these while building a client:

- you are about to write CSS that you remember writing before
- you want to edit a FRAMEWORK file to get a client look
- you hit a trap that cost you an hour and is not written down anywhere
- a stripe needs a shape the library does not have

### 2. Decide what kind of thing it is

This is the only decision that really matters, and getting it wrong is expensive
in both directions.

| If it is | It goes | Test |
|---|---|---|
| Mechanism every client needs | a FRAMEWORK file | can you name what it does without naming a client? |
| A choice between known options | a **switch**: token in the owning component, value in `01` | could the next client want the opposite? |
| This client's taste | `99-CC-Custom.css`, and nowhere else | would copying this to another client look wrong? |
| A new homepage shape | a new stripe in `stripes/` | is the *anatomy* different, or just the count/ratio? |
| A trap | a comment where it bites, plus the relevant doc | would a competent person hit this again? |

**Promote on the second occurrence, not the first.** One client wanting something
is a preference; two is a pattern. The single-row nav in
`examples/templeton-jones/99-CC-Custom.css` is deliberately still client chrome
with a note saying to promote it whole when a second client wants the same bar.
Promoting on a sample of one is how a framework quietly becomes one client's site
with the serial numbers filed off.

**Never promote taste.** It is the failure mode that matters most, because it is
invisible: nothing breaks, the framework just starts imposing a look, and every
site after it needs `99` to fight back.

### 3. Make the change in the kit

Work in `C:\Users\theo.fapohunda\cl-sitekit`, not in a client site.

- adding a switch: declare the token **with a sensible default** in the component
  that owns it (`03` nav, `05` carousels, `06` footer), document the default right
  there, and consume it. Existing sites must render identically if they set
  nothing. That is what makes the change safe to push.
- adding a stripe: `docs/ADDING-A-STRIPE.md`. Build and prove it in a real site
  first, then extract.
- fixing a bug: fix it, and if a check could have caught it, add the check to
  `tools/lint.ps1`. Both bugs found so far were mechanically detectable.

### 4. Prove it

There is no test suite, so proof is deliberate:

- **`tools/lint.ps1` exits 0**, on the kit and on a real site.
- **A new switch defaults to current behaviour.** State how you know: the
  computed value, the specificity, the rule order. `CHANGELOG.md` has a
  "verified how" table; add your row to it.
- **Preserve rule order when moving rules between files.** Load order within
  `global/` is the numeric prefix, and `99` loads after everything. Moving a rule
  earlier can hand a fight to a file that used to lose. Check what else touches
  those selectors before you move anything.
- **Look at it in a browser** at 375, 1024 and 1440.

### 5. Commit so the next person can read it

One commit per idea. The message should say what changed, why, what you checked,
and what you deliberately did **not** do. `git log` is the design record here;
there is nowhere else for it to live.

### 6. Update the paperwork

- `CHANGELOG.md` - what changed and how it was verified
- `MANIFEST.md` - if you added a file. `update-site.ps1` **refuses to run** while
  any file is unclassified, on purpose
- `docs/` - if the process changed
- `stripes/README.md` - if you added a stripe

---

## Downstream: pushing it to sites already built

### The mechanism

`MANIFEST.md` is the whole thing. FRAMEWORK and VERBATIM files copy forward
wholesale; CLIENT files are never touched. That is safe **because** framework
files contain no client's colours, words, assets or taste, which is the property
`lint.ps1` exists to keep true. If a framework file ever names a client, the
update model is broken, not just untidy.

### Doing it

```
tools\update-site.ps1 -Site <site>\SiteSpecific\CustomContent -DryRun
tools\update-site.ps1 -Site <site>\SiteSpecific\CustomContent
```

Dry run first, always. There is no undo on the share: saving a file publishes it.
The tool backs up by default, reads the site's recorded kit commit, lists exactly
what it would change, and refuses to proceed if any file is unclassified.

Then, and do not skip these:

1. `tools\lint.ps1 -Path <site>...` must exit 0
2. QA in a browser. A correct framework change can still move layout
3. Update the site's row in `SITES.md`

### Which sites need it

`SITES.md` records what each site is on. Without it you cannot answer "who needs
this fix?", and a fix nobody can find their way to is not really fixed.

Each site also records its kit commit in its own `CLAUDE.md`; `update-site.ps1`
reads it and rewrites it after a successful push.

### When a change cannot be pushed silently

Most can. These cannot, and want a note in `CHANGELOG.md` saying so:

- **a token was renamed** - a site setting the old name silently loses the value
- **a default changed** - a site that never set the switch now looks different
- **a stripe's class name changed** - the site's `CC-Home.css` and `default.aspx`
  are CLIENT files and will not be updated, so they still use the old name

For these, either keep the old name working, or list the sites and fix each by
hand. Do not push and hope.

---

## When not to touch the framework at all

- **One client wants it.** Wait for the second.
- **You cannot state the default that preserves current behaviour.** You do not
  understand it well enough yet.
- **It is taste.** `99` exists for this and is not a lesser place to put things.
- **You cannot check it in a browser today.** An unproven framework change is
  worse than a client-level workaround, because it spreads.

---

## A worked example

The transparent nav shipped **enabled** in the page template. On the second client
whose homepage did not open on a full-bleed image, that would have produced an
invisible nav and a confused hour.

What happened:

1. **Noticed** as a wrong default, not a bug. The mechanism was right.
2. **Decided**: a switch, already tokenised. Only the default was wrong.
3. **Changed**: template ships without the class; `03` states OPT-IN and OFF BY
   DEFAULT; `01` marks the four `--navSolid-*` tokens inert unless you opt in;
   the brief defaults the answer to no; `BUILD`, `QA-CHECKLIST`, the stripe
   catalogue and the skill all inverted.
4. **Proved**: mechanism untouched, 21 rules still gated on the same class, lint
   passing both trees. Templeton Jones opts in, so it became the worked example.
5. **Recorded**, including something found while writing it up: the scroll shadow
   is gated on the same class, so a default site gets none. Consistent, but a
   client wanting a shadow on a solid bar needs a new switch. Written down rather
   than guessed at.
6. **Pushed**: `update-site.ps1` reported exactly one framework file to change.

The lesson worth copying is step 5. Documenting a change is when you find the next
thing, and writing that down is most of what makes a framework improve rather than
merely change.
