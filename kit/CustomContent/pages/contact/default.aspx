<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="CitrusStore.CitrusStore.DefaultPage" EnableViewState="True" TargetSchema="http://schemas.microsoft.com/intellisense/nav4-0"%>
<%@ Register TagPrefix="uc1" TagName="TopBanner" Src="/modules/CommonControls/TopBanner.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Footer" Src="/PlatformCommonControls/Footer.ascx" %>
<%@ Register TagPrefix="uc1" TagName="ContactForms" Src="/modules/Controls/ContactForms.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="CitrusStore.UITools" Assembly="UITools" %>
<%@ Register TagPrefix="skm" Namespace="ActionlessForm" Assembly="ExtendedControls"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<HEAD runat="server">
<title><%= writeTitle().ToString %>| Contact us</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
<meta name="description" content="" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="/sitespecific/customcontent/modules/CSS/contact/CC-Contact.css" type="text/css" />
</HEAD>
<body runat="server" class="contact">
<skm:form id="form2" method="post" runat="server">
  <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
  <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>
  <script language="javascript" type="text/javascript">
		function bindHandler() {
			contactFormStandard();
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
          <nav class="contact-breadcrumbs" itemscope="" itemtype="http://schema.org/WebPage">
            <p class="sr-only">Breadcrumb navigation</p>
            <a class="breadcrumb-link breadcrumb-home" href="/">Home</a> 
            <span class="breadcrumb-separator">/</span>
            <a class="breadcrumb-link breadcrumb-current" href="#:;">Contact <%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%></a> 
          </nav>
          
          <header class="contact-header">
            <h1 class="contact-title">Contact <%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%></h1>
            <p class="contact-subtitle">Get in touch with us - we'd love to hear from you!</p>
          </header>

          <!-- Map Section -->
          <section class="contact-map-section">
            <div class="contact-map-container">
              <iframe 
            src="https://maps.google.com/maps?q=<%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreAddress1() %>,<%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreCity() %>,<%= CitrusStore.SystemBase.CitrusStoreConfiguration.StorePostCode() %>&t=&z=15&ie=UTF8&iwloc=&output=embed" 
            class="contact-map-iframe"
            style="border:0; width:100%; height:450px;"
            allowfullscreen="">
          </iframe>
            </div>
          </section>

          <!-- Contact Content Grid -->
          <div class="contact-content-grid">
            <!-- Contact Form Section -->
            <div class="contact-form-section">
              <div class="contact-form-container">
                <header class="contact-form-header">
                  <h2 class="contact-form-title">Send us a Message</h2>
                  <p class="contact-form-description">Fill out the form below and we'll get back to you as soon as possible.</p>
                </header>
                <div class="contact-form-wrapper">
                  <uc1:ContactForms runat="server" id="ContactForms" />
                </div>
              </div>
            </div>
            
            <!-- Contact Info Section -->
            <aside class="contact-info-section">
              <div class="contact-info-container">
                <!-- Store Information -->
                <div class="contact-info-block">
                  <header class="contact-info-header">
                    <h2 class="contact-info-title"><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%></h2>
                  </header>
                  <div class="contact-info-content">
                    <div class="contact-info-item" style='display:<%= CitrusStore.SystemBase.CitrusStoreConfiguration.checkMainDespatchTelephone("", "none")%>'>
                      <span class="contact-info-label">Phone:</span>
                      <a href="tel:<%= CitrusStore.SystemBase.CitrusStoreConfiguration.MainDespatchTelephoneNumber%>" class="contact-info-value contact-phone">
                        <%= CitrusStore.SystemBase.CitrusStoreConfiguration.MainDespatchTelephoneNumber%>
                      </a>
                    </div>
                    <div class="contact-info-item" style='display:<%= CitrusStore.SystemBase.CitrusStoreConfiguration.checkMainDespatchEmail("", "none")%>'>
                      <span class="contact-info-label">Email:</span>
                      <a href="mailto:<%= CitrusStore.SystemBase.CitrusStoreConfiguration.MainDespatchEmailAddress%>" class="contact-info-value contact-email">
                        <%= CitrusStore.SystemBase.CitrusStoreConfiguration.MainDespatchEmailAddress%>
                      </a>
                    </div>
                    <div class="contact-info-item contact-address" style='display:<%= CitrusStore.SystemBase.CitrusStoreConfiguration.checkStoreAddress1("", "none")%>'>
                      <span class="contact-info-label">Address:</span>
                      <div class="contact-info-value contact-address-content">
                        <span><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreAddress1()%></span>
                        <span style='display:<%= CitrusStore.SystemBase.CitrusStoreConfiguration.checkStoreAddress2("", "none")%>'><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreAddress2()%></span>
                        <span><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreCity()%>,  <%= CitrusStore.SystemBase.CitrusStoreConfiguration.StorePostCode()%></span>
                      </div>
                    </div>
                  </div>
                </div>
                
                <!-- Opening Hours -->
                <div class="contact-hours-block" style='display:<%= CitrusStore.SystemBase.CitrusStoreConfiguration.checkOpeningTimes("", "none")%>'>
                  <header class="contact-hours-header">
                    <h2 class="contact-hours-title">Opening Hours</h2>
                  </header>
                  <div class="contact-hours-content">
                    <div class="contact-hours-list"><%= CitrusStore.SystemBase.CitrusStoreConfiguration.OpeningTimes()%></div>
                  </div>
                </div>
              </div>
            </aside>
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






