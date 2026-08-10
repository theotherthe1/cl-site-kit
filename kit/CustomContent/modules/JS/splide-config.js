/* ===================================================================
   splide-config.js - DEAD CODE. Nothing references this file.

   Do not confuse it with assets/splide/js/splide-config.js, which IS the
   real Splide manager, is loaded site-wide from TopSubBanner.ascx, and
   must not be touched.

   The code below is a third copy of the scroll-reveal IntersectionObserver.
   The one that actually runs is inline in default.aspx. The original header
   here claimed to reinitialise a brands carousel with a perPage capped to
   the slide count, which this code has never done, and it named the client
   the file was first written for.

   Kept only because this tree ports its rough edges rather than pruning
   them. Safe to delete. See MANIFEST.md.
   =================================================================== */

document.addEventListener('DOMContentLoaded', function () {
    var reveal = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) { entry.target.classList.add('inView'); reveal.unobserve(entry.target); }
        });
    }, { threshold: 0.15 });
    document.querySelectorAll('[data-animate]').forEach(function (el) { reveal.observe(el); });
});
