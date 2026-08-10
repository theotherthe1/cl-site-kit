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
