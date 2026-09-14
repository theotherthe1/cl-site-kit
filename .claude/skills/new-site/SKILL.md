---
name: new-site
description: Build or reskin a Citrus Lime storefront from the cl-sitekit starter kit. Use when the user wants to create a new client site, skin an existing one, retheme a storefront, set up a new CustomContent tree, or mentions cl-sitekit, a brand brief, or homepage stripes.
---

# Build or reskin a Citrus Lime storefront

## Finding the kit

The kit is a git checkout of `cl-sitekit`. Resolve its path in this order:

1. the `CL_SITEKIT` environment variable, set by `tools/bootstrap.ps1`
2. the current repo, if you are already working inside the kit
3. `cl-sitekit` under the user profile, or beside the site folder

If none of those find it, **ask**. Do not improvise a substitute, and do not
work from a half-remembered copy of the rules: this file is short because the
detail lives in the kit's `docs/`.

If the kit is not on this machine at all, that is
`docs/PORTING.md` - clone it, run `tools\bootstrap.ps1`, then come back.

Everything below writes `<kit>` for that path.

## Phase 0: the interview

**Start by interviewing the user. One question at a time.** Read
`INTERVIEW.md`, beside this file, and follow it. It is the intake process:
question order, what each answer blocks, what has a default, and the rules that
keep it from degenerating back into a form.

The interview produces `<kit>\briefs\<SITECODE>.md`, in the shape of
`brand-brief.template.md`. That file is the record and it is committed, so a
later reskin or handover starts from what was actually decided rather than from
someone's memory.

If the user already has a filled brief, read it instead and only interview
around the gaps. Do not make someone answer questions they have already
answered on paper.

Do not copy a file, write a line of CSS, or touch the site tree until the brief
is complete and the user has said to start.

## Then establish the mode

The interview settles this (Q2, Q3), but it governs everything after, so it is
restated here.

| Mode | When | What you touch |
|---|---|---|
| `fresh` | a site with no CustomContent skin yet | copy the kit, then all six CLIENT entries |
| `reskin` | an already-built site getting a new brand | `01-CC-Brand.css`, `99-CC-Custom.css`, `font/`, `layout/`. **Not** `default.aspx` or `CC-Home.css` unless the stripe composition changes |
| `update` | pulling a newer kit into a built site | every FRAMEWORK and VERBATIM entry in `MANIFEST.md`. **No CLIENT entry, ever** |

Read `<kit>\docs\CONTRACT.md` before editing anything. It states what the
platform imposes and what you are not allowed to change.

## Then work through `docs/BUILD.md`

Do not paraphrase it from memory - read it. In outline:

1. `robocopy <kit>\kit\CustomContent <site>\SiteSpecific\CustomContent /E` *(fresh only)*
2. Drop in `font/` and `layout/` assets. `body` and `bold` fonts are **required**
   even if they duplicate each other.
3. Fill `01-CC-Brand.css`: TYPE ROLES, BRAND, COPY, SWITCHES. Clear every
   `<<< SET THIS`. Leave a switch commented out unless the design asks for it.
4. Assemble the homepage from `stripes/` *(fresh, or reskin with a new
   composition)*: markup into `default.aspx`, CSS into `CC-Home.css`, same order,
   numbers agreeing, `__BANNER_ID__` / `__REPEATER_ID__` replaced.
5. Write `99-CC-Custom.css` from scratch. Fill the two `<...>` prose
   placeholders - they are what tells the next person whether a rule belongs.
6. Tell the user exactly which back-office collections and repeaters must be
   populated. You cannot do this, and nothing renders without it.

## Hard rules

**Never edit a FRAMEWORK file to achieve a client look.** If you find yourself
wanting to, you have found either a missing switch or genuine client chrome.
Missing switch -> add the token to the component that owns it (`03` for the bar,
`05` for carousels) with a sensible default, and set the value in `01`. Client
chrome -> `99`. Decide with the test in `99`'s header: *could the next client want
the opposite and get it by editing `01` alone?*

**Never hardcode a colour, radius, shadow or font size** anywhere but `01`.

**`99` is rewritten, not edited.** On a reskin, delete its contents and start
again. Stale rules override the new skin and cannot be found by searching for a
token.

**Use `--skin-*` for client-local tokens.** Never the client's initials.

**`pages/`, `feed/`, `ReturnsPDFs/` are untouchable.** Byte-identical to the
share. They contain two known rough edges that are preserved on purpose - see
`MANIFEST.md`. Do not "fix" them.

**Editing is deploying.** There is no build and no staging. On `reskin` and
`update`, back the tree up first:
`robocopy <site>\SiteSpecific\CustomContent <site>\SiteSpecific\CustomContent.bak /E`

## Finish properly

**Lint until it exits 0:**

```
<kit>\tools\lint.ps1 -Path <site>\SiteSpecific\CustomContent -PreviousClient "<name of the client this tree was seeded from>"
```

Every failure renders wrong or not at all. Pass `-PreviousClient` - it is what
catches a reskin that left the last client's words behind.

**Write the site's `CLAUDE.md`**, at `<site>\SiteSpecific\CustomContent\CLAUDE.md`.
Not a copy of the kit docs - a short orientation for future sessions *in that
site*:

- what this tree is, which client, and that the platform lives outside it
- **the kit commit it was built from** (`git -C <kit> rev-parse --short HEAD`), so
  a later update knows where it started
- which files are CLIENT here and which are framework-and-do-not-edit, pointing
  at the kit's `MANIFEST.md` rather than restating it
- the stripes this homepage uses, in order, and the `bannerid` / `repeaterid`
  each one reads
- anything genuinely surprising about *this* client - a promoted switch that
  needed a non-obvious value, a rule in `99` whose reasoning is not self-evident
- the working constraints: manual cache busting, the 900s homepage output cache,
  editing is deploying

**Commit the brief and stamp `SITES.md`.** `briefs/<SITECODE>.md` and a row in
`<kit>\SITES.md` are the only record that survives the machine you built on.
This matters more than it looks: client sites have no git, and if you are
building over RDP the box you are on is not the box the kit came from.

**Hand over the QA list.** Point the user at `<kit>\docs\QA-CHECKLIST.md` and
tell them which parts you could not verify - you cannot see the rendered site,
and lint cannot see whether it looks right, whether the CMS is populated, or
whether a `?v` was bumped. Say so plainly rather than implying the build is
confirmed.

## If the design needs a shape the library does not have

Say so rather than forcing an existing stripe into the wrong anatomy. Check first
whether it is really a retune - a different panel count or aspect ratio usually
is, and the grid<->carousel swap is free because both control variants emit
identical hooks. If it genuinely is a new shape, follow
`<kit>\docs\ADDING-A-STRIPE.md`: build it in the site, prove it in a browser at
375/1024/1440, and only then extract it into `stripes/` with a row added to the
catalogue. Nothing enters the library unproven.
