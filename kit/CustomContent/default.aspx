<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="CitrusStore.CitrusStore.DefaultPage" EnableViewState="True" TargetSchema="http://schemas.microsoft.com/intellisense/nav4-0"%>
<%@ OutputCache Duration="900" VaryByCustom="homepage" VaryByParam="none" %>
<%@ Register TagPrefix="uc1" TagName="TopBanner" Src="/modules/CommonControls/TopBanner.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Footer" Src="/PlatformCommonControls/Footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="CSSFacetNavsub" Src="/SiteSpecific/CustomContent/CommonControls/TopSubBanner.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="CitrusStore.UITools" Assembly="UITools" %>
<%@ Register TagPrefix="skm" Namespace="ActionlessForm" Assembly="ExtendedControls"%>
<%-- Stripe controls. Keep the ones your chosen stripes use; unused
     registrations are harmless but delete them to keep the page readable. --%>
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
<!-- OPT-IN: add class="cl-nav-over-hero" to float the nav transparent over the
     first stripe, removing the body offset so a full-bleed image runs under the
     bar. It is OFF by default because it only works over a full-bleed image - on
     a light opening stripe it produces an invisible nav.

     Add it only when ALL of these are true:
       - the homepage opens on a full-bleed image or video stripe
       - that image is dark enough, or carries enough overlay, for the wordmark
         and icons to read against it
       - the four --navSolid-* tokens in 01 are set for the scrolled/panel-open
         state, which is what the bar changes to


     A SECOND, INDEPENDENT OPT-IN lives on the same element:
     class="cl-search-exposed" lays the search input out inline in the bar and
     hides the magnifier toggle. The two are unrelated - use either, both or
     neither. See 03, "Search Bar (Exposed)", and the --search* tokens in 01.

     Interior pages never carry it. -->
<body runat="server">
    <skm:form id="form2" method="post" runat="server">
        <%-- Platform scaffolding. Every .aspx must keep all of this: both
             ScriptManagers, the two AJAX stubs (the platform's AJAX layer calls
             them; page-specific init goes inside bindHandler), and the
             TopBanner / Footer includes. --%>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>
        <script language="javascript" type="text/javascript">
            function bindHandler() { }
            function localAjaxStartPostback() { }
        </script>
        <uc1:topbanner id="TopBanner1" runat="server"></uc1:topbanner>

        <!-- === HOMEPAGE SECTIONS ===

             Paste each chosen stripe's markup.aspx here, in display order, and
             number the section comments 1., 2., 3.. as they fall. The numbers
             are documentation only - every rule keys off the class name - but
             they must match the section order in CC-Home.css.

             Replace every __BANNER_ID__ and __REPEATER_ID__ with the real
             back-office id. lint.ps1 fails while any placeholder remains.

             See ../../stripes/README.md for the catalogue.
        -->

        <!-- === 1. HERO GOES HERE ===
             Outside the container on purpose: an opening hero is normally
             full-bleed and runs edge to edge under the nav. Paste it here. -->


        <!-- === CONTAINED REGION - everything between the hero and the footer ==
             .cc-container holds this run to --container-maxWidth and centres it.
             The token is declared in 02 and DEFAULTS TO `none`, so this div does
             nothing at all until a client sets a width in 01's switches block -
             an edge-to-edge design can leave it exactly as it is, or delete it.

             --container-gutter (also 02, default 0) is the inset the container
             itself carries. Stripes already inset their own content by --gutter,
             so leave it at 0 unless you want the measure held off the edge too.

             To keep one stripe full-bleed inside a contained page, close this
             div before it and open a new one after. There is no breakout class;
             02's .cc-container comment says why. -->
        <div class="cc-container">

            <!-- === STRIPES GO HERE === -->

        </div>
        <!-- === END CONTAINED REGION === -->

        <%-- Scroll reveal. Adds .inView to any [data-animate] stripe as it
             enters the viewport. Keep this, and keep data-animate on each
             stripe's .col-1. --%>
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

        <%-- Bump the ?v when this file changes or browsers serve stale code. --%>
        <script defer src="/sitespecific/customcontent/modules/JS/homepage-nav.js?v2"></script>

        <uc1:footer id="Footer1" runat="server"></uc1:footer>
    </skm:form>
</body>
</html>
