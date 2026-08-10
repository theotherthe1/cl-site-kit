/* ===================================================================
   splide-config.js - Ardent Bicycles / homepage overrides
   Runs after SplideBannerManager (via setTimeout) to reinit the brands
   carousel with a perPage capped to actual slide count, preventing
   Splide showing all slides when perPage exceeds the available items.
   =================================================================== */

document.addEventListener('DOMContentLoaded', function () {
    var reveal = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
            if (entry.isIntersecting) { entry.target.classList.add('inView'); reveal.unobserve(entry.target); }
        });
    }, { threshold: 0.15 });
    document.querySelectorAll('[data-animate]').forEach(function (el) { reveal.observe(el); });
});
