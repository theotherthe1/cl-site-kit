<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="CitrusStore.CitrusStore.DefaultPage" EnableViewState="True" TargetSchema="http://schemas.microsoft.com/intellisense/nav4-0"%>

<%@ Register TagPrefix="uc1" TagName="TopBanner" Src="/SiteSpecific/CustomContent/CommonControls/TopBanner.ascx" %>
<%@ Register TagPrefix="uc1" TagName="LeftColumnNav" Src="/SiteSpecific/CustomContent/CommonControls/LeftColumnNav.ascx" %>
<%@ Register TagPrefix="uc1" TagName="RightColumnNav" Src="/SiteSpecific/CustomContent/CommonControls/RightColumnNav.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Footer" Src="/PlatformCommonControls/Footer.ascx" %>
<%@ Register TagPrefix="cl" TagName="clCategoryDropDown" Src="/SiteSpecific/CustomContent/Controls/clCategoryDropDown.ascx" %>
<%@ Register TagPrefix="uc1" TagName="ProductRepeater" Src="/SiteSpecific/CustomContent/Controls/clProductRepeaterNew.ascx" %>
<%@ Register TagPrefix="uc1" TagName="TopSellers" Src="/SiteSpecific/CustomContent/Controls/clGetTopSellers.ascx" %>
<%@ Register TagPrefix="uc1" TagName="clCSSNavBanner" Src="/SiteSpecific/CustomContent/Controls/clCSSNavBanner.ascx" %>
<%@ Register TagPrefix="uc1" TagName="clCSSNavBanner50" Src="/SiteSpecific/CustomContent/Controls/clCSSNavBanner50.ascx" %>
<%@ Register TagPrefix="uc1" TagName="clCSSNavBannerHm" Src="/SiteSpecific/CustomContent/Controls/clCSSNavBannerHm.ascx" %>
<%@ Register TagPrefix="uc1" TagName="clCSSNavBanner75" Src="/SiteSpecific/CustomContent/Controls/clCSSNavBanner75.ascx" %>
<%@ Register TagPrefix="uc1" TagName="clCSSNavBanner150" Src="/SiteSpecific/CustomContent/Controls/clCSSNavBanner150.ascx" %>
<%@ Register TagPrefix="uc1" TagName="clCSSNavBanner200" Src="/SiteSpecific/CustomContent/Controls/clCSSNavBanner200.ascx" %>
<%@ Register TagPrefix="uc1" TagName="clCSSNavBannerHome" Src="/SiteSpecific/CustomContent/Controls/clCSSNavBannerHome.ascx" %>
<%@ Register TagPrefix="cl" TagName="clCategoryDetails" Src="/SiteSpecific/CustomContent/Controls/clCategoryDetailsMP.ascx" %>
<%@ Register TagPrefix="uc1" TagName="clCSSNavStartShopping" Src="/SiteSpecific/CustomContent/Controls/clCSSNavStartShopping.ascx" %>
<%@ Register TagPrefix="uc1" TagName="clLocations" Src="/location/controls/clLocations.ascx" %>
<%@ Register TagPrefix="uc1" TagName="clQuickQuestions" Src="/SiteSpecific/CustomContent/Controls/clQuickQuestions.ascx" %>
<%@ Register TagPrefix="uc1" TagName="CSContentOnlyTitle " Src="/SiteSpecific/CustomContent/Controls/CSContentOnlyTitle.ascx" %>
<%@ Register TagPrefix="uc1" TagName="CSContentOnlyCopy " Src="/SiteSpecific/CustomContent/Controls/CSContentOnlyCopy.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="CitrusStore.UITools" Assembly="UITools" %>
<%@ Register TagPrefix="skm" Namespace="ActionlessForm" Assembly="ExtendedControls"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<HEAD runat="server">
		<title>0% Bike Finance | <%= writeTitle().ToString %></title>
    	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		<meta name="description" content="Leisure Lakes Bikes offer 0% finance on all orders over &#163;300 so you can split your payments hassle free!" />
		<meta name="keywords" content="0% Finance, bike finance, 0% bike finance, sale bike finance" />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <LINK href="/framework.css" type="text/css" rel="stylesheet" />
        <LINK href="/mobile.css" type="text/css" rel="stylesheet" />
	</HEAD>
	<body runat="server">
    <skm:form id="form2" method="post" runat="server">	
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>
    <script language="javascript" type="text/javascript">
		function bindHandler() {
			zestyProductAccordion();
		}
        function localAjaxStartPostback() {
        }
	</script>
    
    <uc1:topbanner id="TopBanner1" runat="server"></uc1:topbanner>
    
    <div class="wrapper finance background4">
        <div class="grid fixed">
            <div class="container">
               <div class="col-1 ctrPad32 centralise">
                    <h2>0% APR FINANCE</h2>
                    <p>Your dream bike and accessories could be closer than you think when you spread your cost with our range of finance options.
We don't require a deposit, and you can choose a finance option to suit you whether you shop online or in any of our 10 UK stores.</p>
              <p>Just spend &pound;250 on any items with us (that's includes sale items too) then apply online or in store with the finance option of your choice!</p>
               </div>
               <div class="financeUk">
                <div class="col-1">
                    <div class="col-20p financeOption">
                       <div class="zflex-v">
                        <div class="transition">
                            <img src="/layout/finance.png" width="75" alt="">
                            <div class="financeservice">0% APR Finance</div>
                            <div class="financePrice">
                                <span class="financetextMain">30<br>MONTHS</span>
                                <span class="financetextSub">0% APR FINANCE</span>
                            </div>
                            <div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;1000*</div>
                        </div>
                        </div>
                    </div>
                    <div class="col-20p financeOption">
                       <div class="zflex-v">
                        <div class="transition">
                			<img src="/layout/finance.png" width="75" alt="">
                            <div class="financeservice">0% APR Finance</div>
                            <div class="financePrice">
                                <span class="financetextMain">24<br>MONTHS</span>
                                <span class="financetextSub">0% APR FINANCE</span>
                            </div>
                            <div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;1000*</div>
                        </div>
						</div>
                    </div>
                    <div class="col-20p financeOption">
                       	<div class="zflex-v">
							<div class="transition">
								<img src="/layout/finance.png" width="75" alt="">
								<div class="financeservice">0% APR Finance</div>
								<div class="financePrice">
									<span class="financetextMain">18<br>MONTHS</span>
									<span class="financetextSub">0% APR FINANCE</span>
								</div>
								<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;500*</div>
							</div>
						</div>
                    </div>
                    <div class="col-20p financeOption">
                       	<div class="zflex-v">
							<div class="transition">
								<img src="/layout/finance.png" width="75" alt="">
								<div class="financeservice">0% APR Finance</div>
								<div class="financePrice">
									<span class="financetextMain">12<br>MONTHS</span>
									<span class="financetextSub">0% APR FINANCE</span>
								</div>
								<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;250*</div>
							</div>
						</div>
                    </div>
                
                    <div class="col-20p financeOption">
                       	<div class="zflex-v">
							<div class="transition">
								<img src="/layout/finance.png" width="75" alt="">
								<div class="financeservice">0% APR Finance</div>
								<div class="financePrice">
									<span class="financetextMain">6<br>MONTHS</span>
									<span class="financetextSub">0% APR FINANCE</span>
								</div>
								<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;250*</div>
							</div>
						</div>
                    </div>
            	</div>
    		</div>
    	</div>
    </div>
    
    
    <div class="wrapper finance">
        <div class="grid fixed">
            <div class="container">
				<div class="col-1 background1">
					<div class="col-1 ctrPad16 financeOptionBike centralise">
						<h2>WANT LOWER MONTHLY PAYMENTS?</h2>
						<p>If you want to keep your monthly repayments to a minimum then our 15.9% APR finance is perfect for you.
We don't require a deposit, and the longer repayments at a lower cost makes these our most affordable monthly packages.</p>
					</div>
					<div class="col-1">
						<div class="financeUk col-1 ctrPad16">
							<div class="col-3 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<img src="/layout/finance.png" width="75" alt="">
										<div class="financeservice">15.9% APR Finance</div>
										<div class="financePrice">
											<span class="financetextMain">48<br>MONTHS</span>
											<span class="financetextSub">15.9% APR FINANCE</span>
										</div>
										<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;250*</div>
									</div>
								</div>
							</div>
							<div class="col-3 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<img src="/layout/finance.png" width="75" alt="">
										<div class="financeservice">15.9% APR Finance</div>
										<div class="financePrice">
											<span class="financetextMain">36<br>MONTHS</span>
											<span class="financetextSub">15.9% APR FINANCE</span>
										</div>
										<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;250*</div>
									</div>
								</div>
							</div>
							<div class="col-3 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<img src="/layout/finance.png" width="75" alt="">
										<div class="financeservice">15.9% APR Finance</div>
										<div class="financePrice">
											<span class="financetextMain">24<br>MONTHS</span>
											<span class="financetextSub">15.9% APR FINANCE</span>
										</div>
										<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;250*</div>
									</div>
								</div>
							</div>
                    	</div>
					</div>
               
                </div>
            </div>
		</div>
    </div>
    
    
    <div class="wrapper finance">
        <div class="grid fixed">
            <div class="container">
				<div class="col-1">
					<div class="col-1 ctrPad16 centralise">
						<h2>BUY NOW - PAY LATER </h2>
						<p>With our buy now pay - later finance you can <strong>pay nothing for up to 12 months</strong> with our 0% APR deferred finance options. That means you don't pay anything (not even a deposit) until you chosen 0% APR period begins!</p>
					</div>
					<div class="col-1">
						<div class="financeUk col-1 ctrPad16">
							<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<img src="/layout/finance.png" width="75" alt="">
										<div class="financeservice">0% APR Finance</div>
										<div class="financePrice">
											<span class="financetextMain"><span>PAY NOTHING FOR</span><br>12 MONTHS</span>
											<span class="financetextMain2"><span>12 MONTHS</span><br>0% APR FINANCE</span>
										</div>
										<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;2000*</div>
									</div>
								</div>
							</div>
							<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<img src="/layout/finance.png" width="75" alt="">
										<div class="financeservice">0% APR Finance</div>
										<div class="financePrice">
											<span class="financetextMain"><span>PAY NOTHING FOR</span><br>6 MONTHS</span>
											<span class="financetextMain2"><span>18 MONTHS</span><br>0% APR FINANCE</span>
										</div>
										<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;1500*</div>
									</div>
								</div>
							</div>
							<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<img src="/layout/finance.png" width="75" alt="">
										<div class="financeservice">0% APR Finance</div>
										<div class="financePrice">
											<span class="financetextMain"><span>PAY NOTHING FOR</span><br>6 MONTHS</span>
											<span class="financetextMain2"><span>12 MONTHS</span><br>0% APR FINANCE</span>
										</div>
										<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;1500*</div>
									</div>
								</div>
							</div>
                   			<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<img src="/layout/finance.png" width="75" alt="">
										<div class="financeservice">0% APR Finance</div>
										<div class="financePrice">
											<span class="financetextMain"><span>PAY NOTHING FOR</span><br>3 MONTHS</span>
											<span class="financetextMain2"><span>12 MONTHS</span><br>0% APR FINANCE</span>
										</div>
										<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;850*</div>
									</div>
								</div>
							</div>
                    	</div>
					</div>
               
                </div>
                <div class="col-1 ctrPad32 centralise">
            		<p>*finance is subject to change at any time. Finance options may vary for bikes and sale bikes based on margin calculations. Finance provider is different in our 10 UK stores. Full terms for store finance can be found in store.</p>
            	</div>
            </div>
		</div>
    </div>
 
    <div class="wrapper finance">
        <div class="grid fixed">
            <div class="container">
				<div class="col-1 background1">
					<div class="col-1 ctrPad16 financeOptionBike centralise">
						<h2>HOW TO APPLY - ONLINE</h2>
						<p>Applying for finance online has never been easier - simply follow the easy steps below!</p>
					</div>
					<div class="col-1">
						<div class="financeUk col-1 ctrPad16 onlineFinace">
							<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<div class="financeservice">Step 1</div>
										<div class="financePrice">
											<span class="financetextMain"><i class="fa fa-hand-o-up"></i><br><span>SHOP ONLINE</span></span>
										</div>
										<div class="financeTimescale">Spend &pound;250 on anything online<br> (it doesn't just have to be a bike) to apply for finance</div>
									</div>
								</div>
							</div>
							<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<div class="financeservice">Step 2</div>
										<div class="financePrice">
											<span class="financetextMain"><i class="fa fa fa-sliders"></i><br><span>APPLY ONLINE</span></span>
										</div>
										<div class="financeTimescale">Click 'checkout with finance' at the checkout. Select your finance term and deposit.<br>
<small>Please note: all finance orders online need to be delivered to the same address as your billing address.</small></div>
									</div>
								</div>
							</div>
							<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<div class="financeservice">Step 3</div>
										<div class="financePrice">
											<span class="financetextMain"><i class="fa fa-check-square-o"></i><br><span>QUICK DECISION</span></span>
										</div>
										<div class="financeTimescale">Once completing your details, you will get a finance decision- this typically happens in a few minutes</div>
									</div>
								</div>
							</div>
                   			<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<div class="financeservice">Step 4</div>
										<div class="financePrice">
											<span class="financetextMain"><i class="fa fa fa-truck"></i><br><span>HOME DELIVERY</span></span>
										</div>
										<div class="financeTimescale">If your finance application is accepted we will dispatch your order to your billing address using the delivery method of your choice!</div>
									</div>
								</div>
							</div>
                    	</div>
					</div>
               
                </div>
            </div>
		</div>
    </div>
    
    
    <div class="wrapper finance">
        <div class="grid fixed">
            <div class="container">
				<div class="col-1">
					<div class="col-1 ctrPad16 centralise">
						<h2>HOW TO APPLY - INSTORE</h2>
						<p>Applying for finance online has never been easier - simply follow the easy steps below!</p>
					</div>
					<div class="col-1">
						<div class="financeUk col-1 ctrPad16 onlineFinace">
							<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<div class="financeservice">Step 1</div>
										<div class="financePrice">
											<span class="financetextMain"><i class="fa fa fa-home"></i><br><span>SHOP IN STORE</span></span>
										</div>
										<div class="financeTimescale">Spend &pound;250 on anything online (it doesn't just have to be a bike) to apply for finance</div>
									</div>
								</div>
							</div>
							<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<div class="financeservice">Step 2</div>
										<div class="financePrice">
											<span class="financetextMain"><i class="fa fa fa-sliders"></i><br><span>APPLY IN STORE</span></span>
										</div>
										<div class="financeTimescale">A member of staff will take you through the application!<br><small>Please note you will need: photoID, account number, bank sortcode, address details for the last3 years, full time employment details (salary)</small></div>
									</div>
								</div>
							</div>
							<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										
										<div class="financeservice">Step 3</div>
										<div class="financePrice">
											<span class="financetextMain"><i class="fa fa-check-square-o"></i><br><span>QUICK DECISION</span></span>
										</div>
										<div class="financeTimescale">You will get a decision on your finance application whilst in store!</div>
									</div>
								</div>
							</div>
                   			<div class="col-4 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<div class="financeservice">Step 4</div>
										<div class="financePrice">
											<span class="financetextMain"><i class="fa fa-cubes"></i><br><span>COLLECT YOUR ITEMS</span></span>
										</div>
										<div class="financeTimescale">If your items aren't ready to be taken away that day, then we will arrange a time for you to come back and collect!</div>
									</div>
								</div>
							</div>
                    	</div>
					</div>
               
                </div>
            </div>
		</div>
    </div>
    
    
    <div class="wrapper background4">
        <div class="grid fixed">
            <div class="container">
    			<div class="col-1 ctrPad32">
                    <h2>Finance FAQ</h2>
                    <ol>
                    	<li>
                    		<h4>Am I eligible?</h4>
                    		<p>To apply for finance you must be: At least 18 years old. A permanent UK resident. In regular employment (minimum of 16 hours per week) including self-employed, or living with your spouse/partner who is in regular employment. In receipt of a pension if you are retired. Able to confirm sufficient income if you are registered disabled.</p>
                    	</li>
                    	<li>
                    		<h4>Who provides your finance?</h4>
                    		<p>Our online finance provider is V12 Retail Finance. Our in-store finance provider is Hitachi Capital (UK) PLC.</p>
                    	</li>
                    	<li>
                    		<h4>Can I get my finance order delivered to an alternative address?</h4>
                    		<p>Finance orders can only be shipped to your billing address for security reasons. We have a range of delivery options online to allow flexible times and dates (so you don't have worry about missing it). Alternatively you can apply for finance in-store to collect at a time convienient to you.</p>
                    	</li>
                    	<li>
                    		<h4>Is there a limit to the amount I can spend?</h4>
                    		<p>The maximum you can spend when applying for finance is &pound;15,000 per order.</p>
                    	</li>
                    	<li>
                    		<h4>When is my first finance payment taken?</h4>
                    		<p>Your first finance payment will be taken 1 month after we dispatch your item(s) to you.</p>
                    	</li>
                    	<li>
                    		<h4>Can I pay the remainder of the loan off early?</h4>
                    		<p>Yes you can. You will need to call V12 on 02920 468900.</p>
                    	</li>
                    	<li>
                    		<h4>Can I return an item I bought using finance for a refund?</h4>
                    		<p>You can return any item, even if purchasing using finance. Follow our normal returns procedure (see here) and we will notify V12 finance. It will then take V12 between 3-5 days to cancel your finance and refund your deposit plus any previous payment.</p>
							<p>Please note: you can't return an item on finance if it reduces the value of your basket to below &pound;250 or if muliple items were purchased using the same finance.</p>
                    	</li>
                    	<li>
                    		<h4>Can I return an item I bought using finance for an exchange?</h4>
                    		<p>We can an exchange a like-for-like item or a different product of the same value. Or, we can offer you a voucher of the same value as the item(s) you are returning. This voucher can be used for any item</p>
                    	</li>
                    </ol>
                </div>
    		</div>
    	</div>
    </div>
    

    <uc1:footer id="Footer1" runat="server"></uc1:footer>
	
    </skm:form>
	</body>
</HTML>






