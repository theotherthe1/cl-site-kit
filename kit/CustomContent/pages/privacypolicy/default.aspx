<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="CitrusStore.CitrusStore.DefaultPage" EnableViewState="True" TargetSchema="http://schemas.microsoft.com/intellisense/nav4-0"%>
<%@ Register TagPrefix="uc1" TagName="TopBanner" Src="/modules/CommonControls/TopBanner.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Footer" Src="/PlatformCommonControls/Footer.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="CitrusStore.UITools" Assembly="UITools" %>
<%@ Register TagPrefix="skm" Namespace="ActionlessForm" Assembly="ExtendedControls"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<HEAD runat="server">
		<title><%= writeTitle().ToString %> | Privacy Policy & Cookies</title>
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
                        <a class="leaf" href="#"><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> Privacy Policy & Cookies</a>
                    </div>
                    <h1><%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> Privacy Policy & Cookies</h1><div style='display:<%= CitrusStore.SystemBase.CitrusStoreConfiguration.checkPrivacyPolicy("", "none")%>'><%= CitrusStore.SystemBase.CitrusStoreConfiguration.PrivacyPolicy%></div>

                    <h3>Our Website Cookies Policy</h3>
                    <p>A cookie is a small file of text which we transfer to your hard drive through your web browser, as with most websites, when you visit our website and use certain pages or features on the site, especially when placing an order. It enables our own system to recognise you when you visit our website again and improve our service to you. This information can be used to enhance the content of our website and make your use of it easier. For more information about cookies please visit <a target="_blank" href="http://www.allaboutcookies.org">www.allaboutcookies.org</a></p>
                    <h3>Cookies</h3>
                    <p>
                    When we provide services, we want to make them easy, useful and reliable. Where services are delivered on the internet, this sometimes involves placing small amounts of information on your device, for example, computer or mobile phone. These include small files known as cookies. They cannot be used to identify you personally.
                    <br /><br />
                    These pieces of information are used to improve services for you through, for example:
                    <br /><br />
                    - enabling a service to recognise your device so you don't have to give the same information several times during one task<br />
                    - recognising that you may already have given a username and password so you don't need to do it for every web page requested<br />
                    - measuring how many people are using services, so they can be made easier to use and there's enough capacity to ensure they are fast
                    <br /><br />
                    You can manage these small files yourself and learn more about them through Internet browser cookies - what they are and how to manage them.
                    </p>
                    <br />
                    <h3>Our use of cookies</h3>
                    <p>
                    When we provide services, we want to make them easy, useful and reliable. Where services are delivered on the internet, this sometimes involves placing small amounts of information on your device, for example, your computer or mobile phone. These include small files known as cookies. They cannot be used to identify you personally.
                    <br /><br />
                    These pieces of information are used to improve services for you through, for example:
                    <br /><br />
                    - recognising that you may already have given a username and password so you don't need to do it for every web page requested<br />
                    - measuring how many people are using services, so they can be made easier to use and there's enough capacity to ensure they are fast<br />
                    - analysing anonymised data to help us understand how people interact with govt services so we can make them better
                    <br /><br />
                    You can manage these small files and learn more about them from the article, Internet Browser cookies- what they are and how to manage them.
                    <br /><br />
                    Learn how to <a href="http://www.aboutcookies.org/Default.aspx?page=1'Our%20use%20of%20cookies'">remove cookies set on your device.</a>
                    <br /><br />
                    There are two types of cookie you may encounter when using <%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> :
                    <br /><br />
                    <strong>First party cookies:</strong> these are our own cookies, controlled by us and used to provide information about usage of our site.
                    <br /><br />
                    <strong>Third party cookies:</strong> these are cookies found in other companies' internet tools which we are using to enhance our site, for example Facebook or Twitter have their own cookies, which are controlled by them.
                    </p>
                    <br />
                    <h3>First party cookies</h3>
                    <p>
                    *<%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> uses cookies in several places - we've listed each of them below with more details about why we use them and how long they will last.
                    <br /><br />
                    We will endeavour to let you know before we store a cookie on your computer.
                    </p>
                    <p><strong>Our Own PERSISTANT cookies</strong></p>
                    <table id="cookies" cellspacing="4" cellpadding="10">
                        <tbody>
                            <tr>
                                <th><strong>Name</strong></th>
                                <th><strong>Purpose</strong></th>
                                <th><strong>Typical content</strong></th>
                            </tr>
                            <tr>
                                <td>_Session</td>
                                <td>
                                This cookie speeds up your experience on our website if you visit us more than once by remembering key information if you have set your browser to allow it. For example your username when logging in, or your preferences when browsing our website.
                                </td>
                                <td>It is an anonymous customer ID cookie, <strong>so we do not save any specific data about you at all</strong>, just a unique _Session reference number</td>
                          </tr>
                        </tbody>
                    </table>
                    <p><strong>Cookies set by <%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> website</strong></p>
                    <table id="cookies" cellspacing="4" cellpadding="10">
                        <tbody>
                            <tr>
                                <th><strong>Name</strong></th>
                                <th><strong>Purpose</strong></th>
                                <th><strong>Expires</strong></th>
                            </tr>
                            <tr>
                                <td>
                                ASP.NET_SessionId<br />
                                HttpReferer<br />
                                Referer<br />
                                dd_object
                                </td>
                                <td>
                                These only last for the session (visit) to our website, and help with your movement through the website, and also let us know if you have visited from a 'Referer' i.e. another website where we may have a link, or an article about us.
                                </td>
                                <td>Expires on exit</td>
                            </tr>
                        </tbody>
                    </table>
                    <p><strong>Third party cookies</strong></p>
                    <p>We use a number of suppliers who may also set cookies on their websites' on its behalf. <%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> do not control the dissemination of these cookies. You should check the third party websites for more information about these.</p>
                    <table id="cookies" cellspacing="4" cellpadding="10">
                        <tbody>
                            <tr>
                                <th><strong>Provider</strong></th>
                                <th><strong>Name</strong></th>
                                <th><strong>Purpose</strong></th>
                                <th><strong>More Info</strong></th>
                            </tr>
                            <tr>
                                <td>Google Analytics</td>
                                <td>
                                _utma<br />
                                _utmb<br />
                                _utmc<br />
                                _utmz
                                </td>
                                <td>
                                These cookies are used to collect information about how visitors use our site. We use the information to compile reports and to help us improve the site. The cookies collect information in an anonymous form, including the number of visitors to the site, where visitors have come to the site from and the pages they visited. They do not contain any personally identifiable information.
                                </td>
                                <td>
                                <a href="http://www.google.com/intl/en_uk/policies/privacy/">Google Privacy policy</a>
                                </td>
                            </tr>
                            <tr>
                                <td>Add This</td>
                                <td>_atuvc</td>
                                <td>
                                The _atuvc cookie is created and read by our JavaScript on the client side in order to make sure the user sees the updated count if they share a page and return to it before our share count cache is updated. No data from that cookie is sent back to AddThis.
                                </td>
                                <td>
                                <a href="http://www.addthis.com/privacy/#.T8T3jdXUOUI">Add This privacy</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <h3>Changes to this privacy policy</h3>
                    <p>If this privacy policy changes in any way, we will place an updated version on this page. Regularly reviewing this page ensures that you are always aware of what information we collect, how we use it and under what circumstances, if any, we will share it with other parties.
                    <br /><br />
                    You can use the settings of your browser to block, or delete cookies as you wish. Do please note that blocking cookies may slow down your experience on our website, or cause issues with placing an order, as cookies are often required to help with a smooth checkout process!
                    <br /><br />
                    If you have any questions about our cookies policy or feedback please contact us on <%= CitrusStore.SystemBase.CitrusStoreConfiguration.MainDespatchTelephoneNumber%> or via our contact us page link at the top of the page.
                    </p>
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






