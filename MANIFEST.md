# Manifest

Every file in `kit/CustomContent/` is one of three kinds. This is what makes
updating a built site safe: framework files are client-neutral by construction,
so they can be copied forward wholesale without reading them.

`tools/lint.ps1` parses the table below. Keep the format - one entry per line,
`KIND` then whitespace then a path or glob, inside the fenced block.

| Kind | Meaning | On update |
|---|---|---|
| `FRAMEWORK` | Client-neutral. Contains no client's colours, words, assets or taste. | **Overwrite wholesale.** |
| `CLIENT` | This client's skin. Authored per build. | **Never overwrite.** |
| `VERBATIM` | Declared untouchable. Byte-identical to the source share, including CRLF and BOMs. Not linted, not normalised, not edited. | **Overwrite wholesale** (identical everywhere). |

```manifest
FRAMEWORK  modules/CSS/global/02-CC-Global.css
FRAMEWORK  modules/CSS/global/03-CC-NavigationSearch.css
FRAMEWORK  modules/CSS/global/04-CC-BannerCollections.css
FRAMEWORK  modules/CSS/global/05-CC-SplideBanners.css
FRAMEWORK  modules/CSS/global/06-CC-Footer.css
FRAMEWORK  modules/CSS/global/07-CC-QuickLook.css
FRAMEWORK  modules/CSS/global/08-CC-MiniBasket.css
FRAMEWORK  modules/CSS/detail/CC-detail.css
FRAMEWORK  modules/CSS/faf/CC-faf.css
FRAMEWORK  modules/CSS/faf/CC-alps.css
FRAMEWORK  modules/CSS/misc/CC-Contact.css
FRAMEWORK  modules/CSS/misc/CC-Misc.css
FRAMEWORK  controls/BannerCollectionDisplayGrid.ascx
FRAMEWORK  controls/BannerCollectionDisplayGridBrands.ascx
FRAMEWORK  controls/BannerCollectionSplide.ascx
FRAMEWORK  controls/BannerCollectionSplideBrands.ascx
FRAMEWORK  controls/FafCustomRepeaterGrid.ascx
FRAMEWORK  controls/FafCustomRepeaterSplide.ascx
FRAMEWORK  CommonControls/TopSubBanner.ascx
FRAMEWORK  assets/splide/**
FRAMEWORK  modules/JS/homepage-nav.js
FRAMEWORK  modules/JS/splide-config.js

CLIENT     modules/CSS/global/01-CC-Brand.css
CLIENT     modules/CSS/global/99-CC-Custom.css
CLIENT     modules/CSS/home/CC-Home.css
CLIENT     default.aspx
CLIENT     font/**
CLIENT     layout/**

VERBATIM   pages/**
VERBATIM   feed/**
VERBATIM   ReturnsPDFs/**
VERBATIM   sitemap.xml
VERBATIM   google*.html
```

## Notes on specific entries

**`modules/JS/homepage-nav.js` is FRAMEWORK**, but it is referenced from
`default.aspx` (a CLIENT file) with a `?v` cache-bust. If you change the JS, bump
the `?v` in the page or browsers serve stale code. There is no build step to do
this for you.

**`modules/JS/splide-config.js` is dead code, declared FRAMEWORK so that it is
classified rather than unclassified.** Nothing references it. Its original header
claimed to reinitialise a brands carousel with a capped `perPage`, which the code
has never done: it is a third copy of the scroll-reveal observer, and the one that
actually runs is inline in `default.aspx`. It also named the client it was written
for, which would have put a previous client's name inside a FRAMEWORK file and
broken the invariant the whole update model rests on. The header is corrected; the
file is kept only because this tree ports its rough edges rather than pruning them.

Deleting it is still the better answer and costs nothing. It is easily confused
with the LIVE `assets/splide/js/splide-config.js`, which is the real Splide
manager, is loaded site-wide from `TopSubBanner.ascx`, and must not be touched.

**`font/**` and `layout/**` are CLIENT** - they are the client's typefaces and
raster images. The kit ships working fonts so a fresh xcopy renders rather than
half-failing, but every one of these files is meant to be replaced.
`font/body.*` and `font/bold.*` must always exist: ~186 platform declarations
outside this tree name `citrfontreg` and `citrfontbold` literally.

**`layout/` holds no `.svg` files.** The wordmark and nav icons are inline data
URIs on the `--logo` / `--icon-*` tokens (defaults in `03`, the client's in
`01`), because a referenced `.svg` does not display on iPhone. The kit's old
`logo.svg` (the Citrus Lime mark) and `icons/*.svg` were removed for that reason;
sites built before then still carry their own copies, and lint and
`update-site.ps1` both catch a site whose artwork is still only in those files.

**`layout/generalLyout/` is misspelled** and is deliberately left that way. It is
the established folder name across existing sites and is baked into asset URLs
in `03`.

**`pages/**` is VERBATIM, which includes two known rough edges** that are
therefore preserved on purpose, not overlooked:

- `pages/contact/default.aspx` links `.../modules/CSS/contact/CC-Contact.css`,
  but the file lives at `modules/CSS/misc/CC-Contact.css`. The `<link>` 404s. The
  page works anyway because the platform bundles the `misc/` folder regardless.
  Left alone: deleting the link preserves current behaviour exactly, while
  *fixing* the path would newly load the file a second time later in the cascade
  - the change with a rendering risk is the one that looks like a fix.
- `pages/finance/` carries `default-hitachi.aspx` and `default-v12.aspx`
  (876 lines between them) for other finance providers. They pull `/framework.css`
  and `/mobile.css` directly and are not on the token system. Only
  `default.aspx` is a live route.

`lint.ps1` does not scan `VERBATIM` paths, so neither of the above is reported.
That is deliberate: a lint with permanently-failing entries is a lint people stop
reading.

**Nothing outside `SiteSpecific/CustomContent/` is in scope.** `DetailFast.aspx`
and `FacetResults.aspx` at the site root were checked and are byte-identical to
the platform reference site - clients do not customise platform pages. The PDP
and PLP are re-skinned entirely through `modules/CSS/detail/` and
`modules/CSS/faf/`, styling markup we do not own.
