<%@ Control Language="vb" EnableViewState = False AutoEventWireup="false" Codebehind="TopSubBanner.ascx.vb" Inherits="CitrusStore.CitrusStore.TopSubBanner" TargetSchema="http://schemas.microsoft.com/intellisense/nav4-0" %>

<%@ Register TagPrefix="uc1" TagName="BannerCollectionDisplay" src="/modules/Controls/BannerCollectionDisplayGrid.ascx" %>
<%@ Register TagPrefix="uc1" TagName="BannerCollectionSplide" src="/SiteSpecific/CustomContent/Controls/BannerCollectionSplide.ascx" %>


<link rel="stylesheet" href="/sitespecific/customcontent/assets/splide/css/splide.min.css" />
<script defer src="/sitespecific/customcontent/assets/splide/js/splide.min.js"></script>
<script defer src="/sitespecific/customcontent/assets/splide/js/splide-config.js?v7"></script>


<div class="wrapper">
	<div class="grid fixed">
		<div class="container ctaContainer">
			<uc1:BannerCollectionDisplay ID="BannerCollectionDisplayCTA" runat="server" bannerid="3"
				bannerLimit="12" imageSizing="imgCtr75" />
		</div>
	</div>
</div>
