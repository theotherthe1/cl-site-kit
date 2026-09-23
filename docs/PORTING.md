# Working on another machine

Builds happen on a build server over RDP; the kit is developed somewhere else.
This page is how the kit, and everything you need alongside it, gets from one to
the other and back.

The rule that makes this work: **anything a build depends on lives in this
repository.** If you find yourself needing a file that only exists on your own
machine, that is the bug - move it in here rather than copying it across.

---

## What has to travel

| | Where it lives | Travels how |
|---|---|---|
| the kit tree, stripes, docs, tools | this repo | `git clone` |
| the skills (`/new-site`, `/figma-stripe`) | `.claude/skills/` in this repo | `git clone`, then `bootstrap.ps1` installs them for use outside the kit folder |
| `figma-bundle.template.md` | this repo, at the root | `git clone` |
| the operating manual | `CLAUDE.md` in this repo | loaded automatically when Claude Code starts in the kit |
| filled briefs | `briefs/` in this repo | `git clone`, and commit new ones |
| which site is on which commit | `SITES.md` in this repo | `git clone`, and stamp it after every push |
| what a given site is | that site's own `SiteSpecific/CustomContent/CLAUDE.md` | already on the share, reachable from both machines |

Nothing else. There is deliberately no machine-local state: no config file to
copy, no environment to reproduce beyond a git checkout and PowerShell.

---

## First time on a new machine

```powershell
git clone <remote-url> C:\path\to\cl-sitekit
cd C:\path\to\cl-sitekit
.\tools\bootstrap.ps1
```

`bootstrap.ps1` sets `CL_SITEKIT` to the checkout, installs the repo's skills
into your user skill directory, and then checks that git is present, that
`MANIFEST.md` parses and that `lint.ps1` exits 0 against the kit's own copy. It
prints a `FAIL` for anything that would break a build later and exits non-zero.

Then restart the terminal, and Claude Code, so `CL_SITEKIT` is actually in the
process environment.

To find out why something is not working without changing anything:

```powershell
.\tools\bootstrap.ps1 -Check
```

**Why the skill is installed rather than left in the repo.** A project-scoped
skill only loads when Claude Code is started inside that project, and `/new-site`
is run in the *site* folder, not in the kit. So the repo holds the source of
truth and `bootstrap.ps1` copies it to user scope. Re-running bootstrap
overwrites the installed copy from the repo every time, which is what stops the
two drifting - and `-Check` tells you if they already have.

---

## Setting up the remote

The kit had no remote for its first three builds, which meant the only copy of
the version history was one laptop. Do not repeat that.

**GitHub**, private:

```powershell
# create the empty repo in the browser or with `gh repo create`, then:
git remote add origin https://github.com/<org>/cl-sitekit.git
git push -u origin master
```

**Azure DevOps**:

```powershell
git remote add origin https://dev.azure.com/<org>/<project>/_git/cl-sitekit
git push -u origin master
```

Either way, check the build server can actually reach it before you rely on it -
outbound access from a locked-down server is not a given. If it cannot, a bare
repo on a share both machines can write to does the same job:

```powershell
git init --bare \\some-share\git\cl-sitekit.git
git remote add origin \\some-share\git\cl-sitekit.git
git push -u origin master
```

The site trees themselves are already on shares (`\\dev-ecom-sofs\...`, `Z:\...`),
so they need no transport - both machines edit the same files. That is also why
editing is deploying, on either machine.

---

## The working loop

**On the build server, before you start:**

```powershell
git -C $env:CL_SITEKIT pull
.\tools\bootstrap.ps1 -Check
```

Pull first, always. Building a site from a stale kit produces a site that
`SITES.md` will describe wrongly, and the commit stamped into that site's
`CLAUDE.md` then points at a version that never built it.

**While building:** run `/new-site`. It interviews you one question at a time
and writes `briefs/<SITECODE>.md` as it goes.

**When you finish a site:**

```powershell
git -C $env:CL_SITEKIT add briefs SITES.md
git -C $env:CL_SITEKIT commit -m "Brief and SITES row for <CLIENT>"
git -C $env:CL_SITEKIT push
```

The brief and the `SITES.md` row are the only things that survive the machine.
A site built on the server whose brief never got committed is a site nobody can
reskin later without redoing the interview from memory.

**If you improved the kit while building** - promoted a switch, added a stripe,
fixed a framework bug - that is `EVOLVING-THE-KIT.md`, and it needs pushing too,
or the next site relearns the same lesson.

---

## Traps

**A stale skill.** If `/new-site` behaves like an older version, the installed
copy is behind the repo. `bootstrap.ps1 -Check` says so; re-running bootstrap
fixes it.

**`CL_SITEKIT` set on the wrong machine's path.** Bootstrap warns when the
variable points somewhere other than the checkout it was run from. This is the
usual result of copying a profile between machines.

**Two checkouts, both being edited.** The kit and the build server are separate
working trees; a change made on one is invisible to the other until it is pushed
and pulled. If you cannot remember whether you pushed, `git -C $env:CL_SITEKIT
status` on both is faster than reasoning about it.

**A site built from a working tree, not a clean checkout.** If the kit had
uncommitted changes at build time, the commit recorded in the site's `CLAUDE.md`
is a lie by omission - the site's framework is that commit *plus* whatever was
uncommitted. This has already happened once; see the JESR row in `SITES.md`.
Commit before you build, or record the discrepancy in the row.

**robocopying the kit instead of cloning it.** You get the files and lose the
history, which is the one thing that makes `SITES.md` and the per-site commit
stamps mean anything. Clone.
