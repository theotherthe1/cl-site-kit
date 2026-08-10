<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="CitrusStore.CitrusStore.DefaultPage" EnableViewState="True" TargetSchema="http://schemas.microsoft.com/intellisense/nav4-0"%>
<%@ Register TagPrefix="uc1" TagName="TopBanner" Src="/modules/CommonControls/TopBanner.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Footer" Src="/PlatformCommonControls/Footer.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="CitrusStore.UITools" Assembly="UITools" %>
<%@ Register TagPrefix="skm" Namespace="ActionlessForm" Assembly="ExtendedControls"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<HEAD runat="server">
		<title><%= writeTitle().ToString %> | Returns Policy</title>
    	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<meta name="description" content="" />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	</HEAD>
	<body runat="server">
    <skm:form id="form2" method="post" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>
    <script language="javascript" type="text/javascript">
		function bindHandler() {
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
                        <a class="leaf" href="#"><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> Returns Policy</a>
                    </div>
                    <h1><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> Returns Policy</h1>
                	<div style='display:<%= CitrusStore.SystemBase.CitrusStoreConfiguration.checkReturnsPolicy("", "none")%>'>
						<%= CitrusStore.SystemBase.CitrusStoreConfiguration.ReturnsPolicy%>
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






