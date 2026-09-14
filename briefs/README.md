# Briefs

One file per built site, named for its site code: `TEMP.md`, `RVCL.md`,
`JESR.md`. Each is a filled copy of `../brand-brief.template.md`.

These are committed on purpose. Client sites have no git, and a build server is
not the machine the kit is developed on, so the brief is the only durable record
of what was decided and why. A reskin two years from now starts here.

## How one gets written

`/new-site` interviews you, one question at a time, and writes the file as it
goes - see `.claude/skills/new-site/INTERVIEW.md`. You can also fill the
template by hand and hand it over; the skill reads an existing brief and only
asks about the gaps.

Because it is written incrementally, a half-finished file is normal and useful:
an interrupted interview resumes from the first field still blank or marked `?`.

## What a `?` means

A question that was not resolved, not a blank to skip. Sections 2, 3, 4 and 7
(colour, type, assets, stripes) block the build while any `?` remains in them.
Everything else takes framework defaults.

A guessed value is worse than a `?`, because a gap gets chased and a guess
ships.

## Keep it honest after the build

If something changed during the build - a colour that failed contrast and got
replaced, a stripe swapped, back-office ids that turned out different - update
the brief. A brief that describes the intention rather than the site is a
document that will mislead exactly one person, at the worst possible moment.
