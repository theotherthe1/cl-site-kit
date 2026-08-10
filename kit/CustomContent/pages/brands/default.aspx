<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="CitrusStore.CitrusStore.DefaultPage" EnableViewState="True" TargetSchema="http://schemas.microsoft.com/intellisense/nav4-0"%>
<%@ Register TagPrefix="uc1" TagName="TopBanner" Src="/modules/CommonControls/TopBanner.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Footer" Src="/PlatformCommonControls/Footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="BrandListTxt" Src="/modules/Controls/brandcontrols/BrandListLanding.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="CitrusStore.UITools" Assembly="UITools" %>
<%@ Register TagPrefix="skm" Namespace="ActionlessForm" Assembly="ExtendedControls"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<HEAD runat="server">
		<title><%= writeTitle().ToString %> | All Brands</title>
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
			brandPageSorting()
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
                        <a class="leaf" href="#"><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> All Brands</a>
                    </div>
                    <h1><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> All Brands</h1>
					<div class="col-1 brandPageBoxNew zflex-w hoverHref">
                        <div id="brand09">
                            <strong>0-9</strong>
                        </div>
                        <div id="brandA">
                            <strong>A</strong>
                        </div>
                        <div id="brandB">
                            <strong>B</strong>
                        </div>
                        <div id="brandC">
                            <strong>C</strong>
                        </div>
                        <div id="brandD">
                            <strong>D</strong>
                        </div>
                        <div id="brandE">
                            <strong>E</strong>
                        </div>
                        <div id="brandF">
                            <strong>F</strong>
                        </div>
                        <div id="brandG">
                            <strong>G</strong>
                        </div>
                        <div id="brandH">
                            <strong>H</strong>
                        </div>
                        <div id="brandI">
                            <strong>I</strong>
                        </div>
                        <div id="brandJ">
                            <strong>J</strong>
                        </div>
                        <div id="brandK">
                            <strong>K</strong>
                        </div>
                        <div id="brandL">
                            <strong>L</strong>
                        </div>
                        <div id="brandM">
                            <strong>M</strong>
                        </div>
                        <div id="brandN">
                            <strong>N</strong>
                        </div>
                        <div id="brandO">
                            <strong>O</strong>
                        </div>
                        <div id="brandP">
                            <strong>P</strong>
                        </div>
                        <div id="brandQ">
                            <strong>Q</strong>
                        </div>  
                        <div id="brandR">
                            <strong>R</strong>
                        </div>
                        <div id="brandS">
                            <strong>S</strong>
                        </div>
                        <div id="brandT">
                            <strong>T</strong>
                        </div>
                        <div id="brandU">
                            <strong>U</strong>
                        </div>  
                        <div id="brandV">
                            <strong>V</strong>
                        </div>  
                        <div id="brandW">
                            <strong>W</strong>
                        </div>
                        <div id="brandX">
                            <strong>X</strong>
                        </div>
                        <div id="brandY">
                            <strong>Y</strong>
                        </div>
                        <div id="brandZ">
                            <strong>Z</strong>
                        </div>    
                    </div>             
                    <div class="brandPageSortMe" style="display:none;"><uc1:BrandListTxt runat="server" Rewrite="true" id="BrandListTxt" /></div>
                </div>
           	</div>
        </div>
    </div>


    <!--Footer Column -->
    <uc1:footer id="Footer1" runat="server"></uc1:footer>


	</skm:form>
	</body>
</HTML>
