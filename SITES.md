# Sites

Which site is on which kit commit. Update the row after every
`tools/update-site.ps1` run.

Without this you cannot answer "who needs this fix?", and a fix nobody can find
their way to is not really fixed.

Each site also records its own kit commit in its
`SiteSpecific/CustomContent/CLAUDE.md`. `update-site.ps1` reads that line and
rewrites it on a successful push, so the two should agree. If they disagree, the
site's own file is the truth and this table is stale.

| Site | Path | Kit commit | Last pushed | Notes |
|---|---|---|---|---|
| Templeton Jones | `\\dev-ecom-sofs\Websites\TEMP.dev.citruslime.com\SiteSpecific\CustomContent` | `a3a91e0` | 2026-08-10 | The site the kit was extracted from, and the only one on it so far. Opts in to the transparent nav, so it is the worked example of that switch. Two blocks in its `99` are deliberately not promoted (single-row nav, search pill). Banner `ImagePath` values point at files that are not in `/images/`, and FAF repeater 1 is empty, so `hp-product-rail` does not render and every image-dependent QA check is still outstanding. Lint passes; browser QA not yet done. |
| Riverside (RVCL) | `Z:\RVCL\RVCL.dev.citruslime.com\SiteSpecific\CustomContent` | partial | 2026-08-11 | IN PROGRESS, and being actively edited - do not push to it without checking first. Light nav bar with dark ink, the inverse of the framework default, so all four nav colour tokens are set in its `01`. Uses a PNG wordmark: it is painted as a mask, so only the alpha channel is used and it must be a transparent cutout. Has a NEW stripe, `hp-accent-split`, not yet in the library. Still carries local framework edits in `03` (`--navMenuPosition`, nav menu `top: 76px`, `padding-inline: 1.5rem`, removed `.logo` max-width) which a kit push WILL wipe - promote them before updating. `01` section labels and the `99`/`CC-Home` prose are not yet filled. |

## Adding a site

```
tools\update-site.ps1 -Site <path> -DryRun     # always first
tools\update-site.ps1 -Site <path>
tools\lint.ps1 -Path <path>                     # must exit 0
```

Then add a row above, and QA in a browser. A correct framework change can still
move layout.

## Reading the table

**Kit commit** is what the site's framework files came from, not when it was
built. A site built long ago but updated last week shows last week's commit.

**Notes** is the place for anything that would surprise the next person: switches
set to non-obvious values, blocks in `99` that look promotable but are not,
outstanding data problems, or a reason the site is deliberately held back from
HEAD.

## Sites deliberately not on HEAD

If a site is held back, say so here and say why. A site that is behind by accident
and a site that is behind on purpose look identical in a table, and the difference
matters when someone is deciding whether to push a fix.
