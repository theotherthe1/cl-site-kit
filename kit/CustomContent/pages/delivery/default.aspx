<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="CitrusStore.CitrusStore.DefaultPage" %>
<%@ Register TagPrefix="uc1" TagName="TopBanner" Src="/modules/CommonControls/TopBanner.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Footer" Src="/PlatformCommonControls/Footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="ShippingChartCourierIntegration" Src="/modules/Controls/ShippingChartCourierIntegration.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="CitrusStore.UITools" Assembly="UITools" %>
<%@ Register TagPrefix="skm" Namespace="ActionlessForm" Assembly="ExtendedControls"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<HEAD runat="server">
		<title><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> | Shipping</title>
    	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<meta name="description" content="" />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	</HEAD>
	<body runat="server">
    <skm:form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>
    <script language="javascript" type="text/javascript">
		function bindHandler() {
			courierfilter();
		}
		function localAjaxStartPostback() {
		}
	</script>

    <!--Top Banner -->
    <uc1:topbanner id="TopBanner1" runat="server"></uc1:topbanner>


    <!--Main  Content -->
    <div class="wrapper">
    	<div class="grid fixed">
        	<div class="container">
            	<div class="col-1 maxInner ctrPad32">
                    <!--breadcrumbs -->
                    <div itemscope="" itemtype="http://schema.org/WebPage" class="breadcrumbs">
                        <p class="none"></p>
                        <a class="root" href="/">Home</a>
                        <a class="leaf" href="#"><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> Shipping Details</a>
                    </div>
                    <h1><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> Shipping Details</h1>
                    <div class="col-1" style='display:<%= CitrusStore.SystemBase.CitrusStoreConfiguration.checkDeliveryDescription("", "none")%>'><%= CitrusStore.SystemBase.CitrusStoreConfiguration.DeliveryDescription%></div>
               	    <div class="col-1">

						<!-- Country select CTA -->
						<div class="courierCountrySearch">
							<span>Showing prices for</span>
							<li class="country-GB" data-iso="iso-GB"><span class="loctitle">United Kingdom (Great Britain)</span></li>
							<span class="courierCountrySearch-select">Select Country for delivery <i class="fa fa-angle-right"></i></span>
						</div>

                  		<!-- Country List -->
                   		<div class="courierCountrySelection zflex-v ctrPad32 hideme">
                   			<div class="courierCountrySelection-inner">
								<div class="col-1 courierCountrySelection-head ctrPad16 centralise">
									Select country for delivery
									<span class="courierCountrySelection-close fa fa-close"></span>
								</div>
								<div class="col-1 courierCountrySelection-search ctrPad16">
									<span class="emptysearch fa fa-close"></span>
									<input type="search" placeholder="Start typing to search ...">
								</div>
								<div class="col-1 courierCountrySelection-body ctrPad16">
								</div>
							</div>
						</div>

                   		<!-- Chart information -->
                    	<uc1:ShippingChartCourierIntegration runat="server" id="ShippingChartCourierIntegration" />
                    </div>
                </div>
           	</div>
        </div>
    </div>


    <!--Footer Column -->
    <uc1:footer id="Footer1" runat="server"></uc1:footer>


	</skm:form>
	</body>
</HTML>






