<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="CitrusStore.CitrusStore.DefaultPage" EnableViewState="True" TargetSchema="http://schemas.microsoft.com/intellisense/nav4-0"%>
<%@ OutputCache Duration="900" VaryByCustom="homepage" VaryByParam="none" %>
<%@ Register TagPrefix="uc1" TagName="TopBanner" Src="/modules/CommonControls/TopBanner.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Footer" Src="/PlatformCommonControls/Footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="CSSFacetNavsub" Src="/SiteSpecific/CustomContent/CommonControls/TopSubBanner.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="CitrusStore.UITools" Assembly="UITools" %>
<%@ Register TagPrefix="skm" Namespace="ActionlessForm" Assembly="ExtendedControls"%>
<%@ Register TagPrefix="uc1" TagName="BannerCollectionDisplay" Src="/SiteSpecific/CustomContent/Controls/BannerCollectionDisplayGrid.ascx" %>
<%@ Register TagPrefix="uc1" TagName="BannerCollectionSplide" Src="/SiteSpecific/CustomContent/Controls/BannerCollectionSplide.ascx" %>
<%@ Register TagPrefix="uc1" TagName="BannerCollectionSplideBrands" Src="/SiteSpecific/CustomContent/Controls/BannerCollectionSplideBrands.ascx" %>
<%@ Register TagPrefix="uc2" TagName="FafCustomRepeaterSplide" Src="/SiteSpecific/CustomContent/Controls/FafCustomRepeaterSplide.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<HEAD runat="server">
    <title runat="server"><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName() %></title>
    <meta name="description" content="<%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName() %>" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <link rel="icon" type="image/png" href="/favicon-96x96.png" sizes="96x96" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png" />
    <meta name="apple-mobile-web-app-title" content="<%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName() %>" />
</HEAD>
<body runat="server" class="cl-nav-over-hero">
    <skm:form id="form2" method="post" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>
        <script language="javascript" type="text/javascript">
            function bindHandler() { }
            function localAjaxStartPostback() { }
        </script>
        <uc1:topbanner id="TopBanner1" runat="server"></uc1:topbanner>

        <!-- === HOMEPAGE SECTIONS === -->

        <!-- === 1. HERO (hero-fade: full-bleed editorial photo, text bottom-left, dash pagination bottom-right, slow quiet crossfade) === -->
        <div class="wrapper">
            <div class="grid">
                <div class="col-1 hp-hero-fade"
                     data-splide-opts='{ "type":"fade", "rewind":true, "autoplay":true, "interval":6000, "speed":1400, "arrows":true, "pagination":true, "cover":false }'
                     data-animate>
                    <uc1:BannerCollectionSplide ID="TjHero" runat="server"
                        bannerid="1" bannerLimit="4" imageSizing="imgCtr75" />
                </div>
            </div>
        </div>

        <!-- === 2. NEW IN (product-carousel: FAF header as the left text rail, 3-up cards on grey tiles, arrows live in the rail) === -->
        <div class="wrapper">
            <div class="grid fixed">
                <div class="col-1 hp-product-rail"
                     data-splide-opts='{ "type":"loop", "perPage":3, "gap":"1.5rem", "speed":700, "trimSpace":true, "arrows":true, "pagination":true, "cover":false, "breakpoints":{ "1024":{ "perPage":2 }, "640":{ "perPage":1 } } }'
                     data-animate>
                    <!-- the whole band is this one control: FafCustomRepeaterSplide's
                         Panel IS the .faf-product-carousel rail grid, and it emits the
                         text rail (title / description / Shop All link) alongside the
                         product carousel - all four bound from repeater 1, so nothing
                         here is hardcoded. -->
                    <uc2:FafCustomRepeaterSplide ID="FAFNewIn" runat="server"
                        numberofitems="12" repeaterid="1" />
                </div>
            </div>
        </div>

        <!-- === 3. COLLECTIONS (grid-3: full-bleed triptych, gradient overlay, serif H2 + ghost CTA bottom-left per panel) === -->
        <div class="wrapper">
            <div class="grid">
                <div class="col-1 hp-panels-3" data-animate>
                    <uc1:BannerCollectionDisplay ID="TjCollections" runat="server"
                        bannerid="2" bannerLimit="3" imageSizing="imgCtr75" />
                </div>
            </div>
        </div>

        <!-- === 4. BRANDS (brand-carousel: label + hairline + serif H2 left / VIEW ALL right, greyscale logo drift beneath) === -->
        <!-- both halves read collection 3, so the entries divide by position:
             entry 1 is the band heading (bannerLimit="1"), entries 2.. are the
             logos. The carousel control has no server-side offset, so it also
             fetches entry 1 and data-splide-skip="1" drops that slide before
             mount; bannerLimit is 13 to still land 12 logos in the strip. -->
        <div class="wrapper">
            <div class="grid fixed">
                <div class="col-1 hp-logo-strip"
                     data-splide-opts='{ "type":"loop", "perPage":6, "gap":"3rem", "autoplay":true, "interval":3000, "speed":900, "arrows":true, "pagination":true, "cover":false, "breakpoints":{ "1024":{ "perPage":4 }, "640":{ "perPage":2 } } }'
                     data-splide-skip="1"
                     data-animate>
                    <div class="CC-HomepageTitles blk">
                        <uc1:BannerCollectionDisplay ID="TjBrandsTitle" runat="server"
                            bannerid="3" bannerLimit="1" imageSizing="imgCtr75" />
                    </div>
                    <uc1:BannerCollectionSplideBrands ID="TjBrands" runat="server"
                        bannerid="3" bannerLimit="13" imageSizing="imgCtr75" />
                </div>
            </div>
        </div>

        <!-- === 5. SEASONAL SPLIT (three full-bleed panels on a two-column split:
             entry 1 is the tall feature down the left, entries 2-3 stack right;
             same gradient/H2/ghost-CTA anatomy as the triptych, taller) === -->
        <div class="wrapper">
            <div class="grid">
                <div class="col-1 hp-split-feature" data-animate>
                    <uc1:BannerCollectionDisplay ID="TjSeasonalDuo" runat="server"
                        bannerid="4" bannerLimit="3" imageSizing="imgCtr75" />
                </div>
            </div>
        </div>

        <!-- === 6. USP STRIP (grid-3: icon above one small sans line, three across, pure whitespace) === -->
        <div class="wrapper">
            <div class="grid fixed">
                <div class="col-1 hp-icon-strip" data-animate>
                    <uc1:BannerCollectionDisplay ID="TjUsp" runat="server"
                        bannerid="5" bannerLimit="3" imageSizing="imgCtr75" />
                </div>
            </div>
        </div>

        <!-- === 7. ABOUT (required: label + hairline + serif declaration over a wide measure) === -->
        <div class="wrapper">
            <div class="grid fixed">
                <div class="col-1 hp-statement" data-animate>
                    <div class="hp-statement__body">
                        <p><%= CitrusStore.SystemBase.CitrusStoreConfiguration.HomePageText%></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- === 8. STAY INSPIRED (cta-fullwidth: centered serif H2 + one sans line, no image, hands off to footer signup) === -->
        <div class="wrapper">
            <div class="grid fixed">
                <div class="col-1 hp-cta-close" data-animate>
                    <uc1:BannerCollectionDisplay ID="TjStayInspired" runat="server"
                        bannerid="6" bannerLimit="1" imageSizing="imgCtr75" />
                </div>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => { 
                        if (entry.isIntersecting) {
                            entry.target.classList.add('inView');
                            observer.unobserve(entry.target);
                        }
                    });
                }, { threshold: 0.1 });
                document.querySelectorAll('[data-animate]').forEach(el => observer.observe(el));
            });
        </script>

        <script defer src="/sitespecific/customcontent/modules/JS/homepage-nav.js?v2"></script>

        <uc1:footer id="Footer1" runat="server"></uc1:footer>
    </skm:form>
</body>
</html>
