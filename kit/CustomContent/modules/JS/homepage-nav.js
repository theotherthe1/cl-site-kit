/* ============================================================
   homepage-nav.js — masthead scroll state

   Toggles .is-scrolled on .wrapper.masthead once the page has
   scrolled past 20px. The styling for both states lives in
   modules/CSS/global/03-CC-NavigationSearch.css
   (.wrapper.masthead / .wrapper.masthead.is-scrolled).

   The class sits on .wrapper.masthead — the OUTERMOST masthead
   layer — not on the inner .navIcons row, so the scrolled fill
   covers the whole bar instead of just the icon strip. The icon
   row's own ink is still keyed off it, via
   .wrapper.masthead.is-scrolled .navIcons.

   Loaded explicitly (deferred) from default.aspx — nothing under
   modules/JS/ is picked up automatically, and the querystring
   version there is the cache buster. Bump it when editing this file.

   .wrapper.masthead is emitted by the platform's TopBanner control,
   so the null guard keeps this quiet if the page ever renders
   without a masthead.
   ============================================================ */

const nav = document.querySelector('.wrapper.masthead');

if (nav) {
    const updateNav = () => {
        nav.classList.toggle('is-scrolled', window.scrollY > 20);
    };

    window.addEventListener('scroll', updateNav, { passive: true });

    updateNav();
}
