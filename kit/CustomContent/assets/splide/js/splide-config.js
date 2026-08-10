/**
 * Splide Banner Manager
 *
 * Config is always set via data-splide-opts on the col-1:
 *   data-splide-opts='{"type":"loop","perPage":1,"cover":false,...}'
 *
 * Optionally alongside it, data-splide-skip="N" drops the first N slides
 * before the carousel mounts - see trimSlides().
 */

class SplideBannerManager {
    constructor() {
        this.instances = [];
        this.init();
    }

    baseConfig() {
        return {
            speed: 400,
            easing: 'cubic-bezier(0.25, 1, 0.5, 1)',
            drag: true,
            snap: true,
            rewind: false,
            waitForTransition: true,
            keyboard: 'focused',
            wheel: false,
            a11y: {
                slideFocus: true,
                focusableNodes: 'a, button, input, textarea, select, iframe',
                focusOnlyActiveSlide: true
            }
        };
    }

    resolveConfig(splideEl) {
        const col = splideEl.closest('[data-splide-opts]') || splideEl.closest('.col-1');

        if (col && col.dataset.splideOpts) {
            try {
                return { ...this.baseConfig(), ...JSON.parse(col.dataset.splideOpts) };
            } catch (e) {
                console.warn('SplideBannerManager: invalid data-splide-opts JSON on', col, e);
            }
        }

        console.warn('SplideBannerManager: no data-splide-opts found on', splideEl);
        return this.baseConfig();
    }

    mount(splideEl) {
        // Avoid double-mounting
        if (splideEl.dataset.splideInitialised) return;
        splideEl.dataset.splideInitialised = '1';

        this.trimSlides(splideEl);

        const config = this.resolveConfig(splideEl);
        const splide = new Splide(splideEl, config);

        splide.on('mounted move', () => {
            this.markSlides(splide);
        });

        splide.on('mounted moved', () => {
            this.manageFocus(splide);
        });

        splide.mount();
        this.instances.push({ element: splideEl, instance: splide });

        // Remeasure after first paint - float-based layouts may report 0-width
        // at DOMContentLoaded but correct dimensions after layout is settled.
        requestAnimationFrame(() => splide.refresh());
    }

    /**
     * data-splide-skip="N" - remove the first N slides before Splide measures
     * the track. This lets one banner collection serve a band twice over:
     * entry 1 bound as the heading (the 1-item BannerCollectionDisplay inside
     * .CC-HomepageTitles), entries 2.. as the carousel itself. The platform
     * banner controls only take bannerid + bannerLimit - there is no
     * server-side offset - so the duplicated first entry has to come out here.
     *
     * It must run pre-mount and it must be a real removal: type:loop clones
     * slides and slide widths are derived from the slide count, so hiding the
     * slot in CSS would leave a gap that drifts through the strip.
     */
    trimSlides(splideEl) {
        const host = splideEl.closest('[data-splide-skip]');
        const skip = parseInt(host?.dataset.splideSkip, 10);
        if (!skip || skip < 1) return;

        const list = splideEl.querySelector(':scope > .splide__track > .splide__list')
            || splideEl.querySelector('.splide__list');
        if (!list) return;

        const slides = [...list.children].filter(el => el.classList.contains('splide__slide'));

        // never empty the track - leave at least one slide standing
        slides.slice(0, Math.min(skip, slides.length - 1)).forEach(el => el.remove());
    }

    markSlides(splide) {
        const slides = splide.Components.Elements.slides;
        const current = splide.index;
        const perPage = splide.options.perPage || 1;

        slides.forEach((slide, i) => {
            slide.classList.toggle('is-current', i >= current && i < current + perPage);
        });
    }

    manageFocus(splide) {
        const track = splide.Components.Elements.track;
        track.querySelectorAll('.splide__slide').forEach(slide => {
            const isVisible = slide.classList.contains('is-visible') || slide.classList.contains('is-active');
            slide.querySelectorAll('a, button, input, select, textarea, iframe').forEach(el => {
                if (isVisible) {
                    el.removeAttribute('tabindex');
                } else {
                    el.setAttribute('tabindex', '-1');
                }
            });
        });
    }

    init() {
        document.querySelectorAll('.splide').forEach(el => this.mount(el));

        // Watch for dynamically injected carousels
        new MutationObserver(mutations => {
            mutations.forEach(m => m.addedNodes.forEach(node => {
                if (node.nodeType !== 1) return;
                if (node.classList?.contains('splide')) this.mount(node);
                node.querySelectorAll?.('.splide').forEach(el => this.mount(el));
            }));
        }).observe(document.body, { childList: true, subtree: true });

        window.addEventListener('resize', this.debounce(() => {
            this.instances.forEach(({ instance }) => instance.refresh());
        }, 250));
    }

    debounce(fn, ms) {
        let t;
        return (...args) => { clearTimeout(t); t = setTimeout(() => fn(...args), ms); };
    }

    getInstance(selector) {
        return this.instances.find(i =>
            i.element === document.querySelector(selector) || i.element.matches(selector)
        )?.instance;
    }
}

document.addEventListener('DOMContentLoaded', () => {
    window.splideBannerManager = new SplideBannerManager();
});
