<%@ Page Language="vb" AutoEventWireup="false" Codebehind="default.aspx.vb" Inherits="CitrusStore.CitrusStore.DefaultPage" EnableViewState="True" TargetSchema="http://schemas.microsoft.com/intellisense/nav4-0"%>

<%@ Register TagPrefix="uc1" TagName="TopBanner" Src="/SiteSpecific/CustomContent/CommonControls/TopBanner.ascx" %>
<%@ Register TagPrefix="uc1" TagName="LeftColumnNav" Src="/SiteSpecific/CustomContent/CommonControls/LeftColumnNav.ascx" %>
<%@ Register TagPrefix="uc1" TagName="RightColumnNav" Src="/SiteSpecific/CustomContent/CommonControls/RightColumnNav.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Footer" Src="/PlatformCommonControls/Footer.ascx" %>
	<%@ Register TagPrefix="cl" TagName="clFinance" Src="/SiteSpecific/CustomContent/Controls/clFinanceCalculator.ascx" %>
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
			bindFinanceControl();
			tabs();
			zestyProductAccordion();
			financeAutohide();
		}
        function localAjaxStartPostback() {
        }
	</script>
    
    <uc1:topbanner id="TopBanner1" runat="server"></uc1:topbanner>
    
    <div class="wrapper background4">
        <div class="grid fixed">
            <div class="container">
				<div class="col-1">
					<div class="col-1 ctrPad32">
					<p>Select your finance option</p>
						
					<div class="col-1 tabs zflex">
						<li data-tab="1">Interest Free Credit Options</li>
						<li data-tab="2">Credit Options</li>
					</div>
					
					<div class="tabsContent">
						<div id="1">
							<div class="col-1 financeUk">
								<div class="col-1">
									<div class="col-20p financeOption">
									   <div class="zflex-v">
										<div class="transition">
											<img src="/layout/finance/Hitachi-logo.png" width="75" alt="">
											<div class="financeservice">0% APR Finance</div>
											<div class="financePrice">
												<span class="financetextMain">30<br>MONTHS</span>
												<span class="financetextSub">0% APR FINANCE</span>
											</div>
											<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;1700*</div>
										</div>
										</div>
									</div>
									<div class="col-20p financeOption">
									   <div class="zflex-v">
										<div class="transition">
											<img src="/layout/finance/Hitachi-logo.png" width="75" alt="">
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
												<img src="/layout/finance/Hitachi-logo.png" width="75" alt="">
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
												<img src="/layout/finance/Hitachi-logo.png" width="75" alt="">
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
												<img src="/layout/finance/Hitachi-logo.png" width="75" alt="">
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
						<div id="2">
							<div class="col-1">
								<div class="financeUk col-1">
									<div class="col-3 financeOption">
										<div class="zflex-v">
											<div class="transition">
												<img src="/layout/finance/Hitachi-logo.png" width="75" alt="">
												<div class="financeservice">9.9% APR Finance</div>
												<div class="financePrice">
													<span class="financetextMain">48<br>MONTHS</span>
													<span class="financetextSub">9.9% APR FINANCE</span>
												</div>
												<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;250*</div>
											</div>
										</div>
									</div>
									<div class="col-3 financeOption">
										<div class="zflex-v">
											<div class="transition">
												<img src="/layout/finance/Hitachi-logo.png" width="75" alt="">
												<div class="financeservice">9.9% APR Finance</div>
												<div class="financePrice">
													<span class="financetextMain">36<br>MONTHS</span>
													<span class="financetextSub">9.9% APR FINANCE</span>
												</div>
												<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;250*</div>
											</div>
										</div>
									</div>
									<div class="col-3 financeOption">
										<div class="zflex-v">
											<div class="transition">
												<img src="/layout/finance/Hitachi-logo.png" width="75" alt="">
												<div class="financeservice">9.9% APR Finance</div>
												<div class="financePrice">
													<span class="financetextMain">24<br>MONTHS</span>
													<span class="financetextSub">9.9% APR FINANCE</span>
												</div>
												<div class="financeTimescale">&pound;0 deposit required<br>Spend over &pound;250*</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
				
					
					
				<div class="col-1" style="display: none">
					<div class="col-1 ctrPad16 centralise">
						<h2>12 months Buy Now, Pay Later</h2>
						<p>With pay later, you only pay a deposit and get 6 months deferred payment</p>
					</div>
					<div class="col-1">
						<div class="financeUk col-1 ctrPad16">
							<div class="col-1 financeOption">
								<div class="zflex-v">
									<div class="transition">
										<img src="/layout/finance/Hitachi-logo.png" width="75" alt="">
										<div class="financeservice">0% APR Finance</div>
										<div class="financePrice">
											<span class="financetextMain"><span>PAY NOTHING FOR</span><br>6 MONTHS</span>
											<span class="financetextMain2"><span>12 MONTHS</span><br>0% APR FINANCE</span>
										</div>
										<div class="financeTimescale">Minimum deposit required</div>
									</div>
								</div>
							</div>
                    	</div>
					</div>
               
                </div>
				
				<div class="gutter32">
					<div class="col-2">
						<h3>HOW TO APPLY - ONLINE</h3>
						<ul class="financeApply">
							<li>
								<div class="newpip">1</div>
								<h4>SHOP ONLINE</h4>
								<p>Buy anything online*, it doesn't just have to be a bike to apply for finance<br><small>* Minimum spend required</small></p>
							</li>
							<li>
								<div class="newpip">2</div>
								<h4>SHOP ONLINE</h4>
								<p>Click 'checkout with finance' at the checkout. Select your finance term and deposit.Please note: all finance orders online need to be delivered to the same address as your billing address.</p>
							</li>
							<li>
								<div class="newpip">3</div>
								<h4>QUICK DECISION</h4>
								<p>Once completing your details, you will get a finance decision- this typically happens in a few minutes</p>
							</li>
							<li>
								<div class="newpip">4</div>
								<h4>HOME DELIVERY</h4>
								<p>If your finance application is accepted we will dispatch your order to your billing address using the delivery method of your choice!</p>
							</li>
						</ul>
					</div>
					<div class="col-2">
						<h3>HOW TO APPLY - INSTORE</h3>
						<ul class="financeApply">
							<li>
								<div class="newpip">1</div>
								<h4>SHOP IN STORE</h4>
								<p>Buy anything instore*, it doesn't just have to be a bike to apply for finance<br><small>* Minimum spend required</small></p>
							</li>
							<li>
								<div class="newpip">2</div>
								<h4>APPLY IN STORE</h4>
								<p>A member of staff will take you through the application! Please note you will need: photoID, account number, bank sortcode, address details for the last3 years, full time employment details (salary)</p>
							</li>
							<li>
								<div class="newpip">3</div>
								<h4>QUICK DECISION</h4>
								<p>You will get a decision on your finance application whilst in store!</p>
							</li>
							<li>
								<div class="newpip">4</div>
								<h4>COLLECT YOUR ITEMS</h4>
								<p>If your items aren't ready to be taken away that day, then we will arrange a time for you to come back and collect!</p>
							</li>
						</ul>
					</div>
				</div>
						
						
				<div class="col-1 ctrPad32 gutter32">
                       	<div class="col-2">
                        	<h3>How do I choose to PaybyFinance?</h3>
							<p>Just select the finance option on the checkout page or let the sales consultant know if you're buying in our store.</p>
							<h3>Who is eligible to apply for online finance?</h3>
							<p>To apply for online finance, you must be over the age of 18, work at least 16 hours a week, or be retired with an income. You must also be a resident of the United Kingdom and have lived in the UK for the last 12 months or more.</p>
							<p>Unfortunately, we are unable to offer online finance to residents of Eire. Homemakers aren't excluded from applying under their own names; however the employment details of your spouse / partner will be required in order to process your application</p>.
							<h3>When do my repayments start?</h3>
							<p>Your monthly repayments will begin one month after your purchase has been delivered.</p>
							<h3>Are there any arrangement fees or hidden extras for credit?</h3>
							<p>No. There are no arrangement fees or hidden extras.</p>
							<h3>Applying for online finance</h3>
							<p>Applying for online finance couldn't be easier or more convenient. When you buy online from <span class="FCAregister"></span> trading as <%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> you have the choice of applying for finance by adding your purchase to the shopping basket, selecting the finance option, and completing an online application form. Just follow the simple instructions, entering your personal details as required and we'll do the rest.</p>
							<p>The whole process only takes a few minutes and is simple and secure. Once your finance application is approved, you will then be advised of how to sign the finance agreement and you will also receive an email confirming these details.</p>
							<p>Please read the agreement carefully checking that all the details are correct, then either electronically sign the agreement or print and sign the agreement in both boxes. Post the signed agreement to the address shown on the covering letter of the agreement.</p>
							<p>Following receipt of your finance agreement and a few additional checks, your goods will be dispatched.</p>
							
							
							
							<h2>Your questions answered</h2>
							<p>Here's some of the most commonly asked questions regarding online finance.</p>
							<div class="productAccordian">
								<div class="accordianBox">
									<div class="accordianHeader">Once my application is approved, what happens next?<span class="fa fa-angle-up"></span></div>
									<div class="accordianCtn" style="display: none;">
									<p>Within minutes of your application being approved, you will be presented with the options to either e-sign or print and return your finance agreement.</p>
									If you choose to e-sign your agreement, a PDF of your agreement will be displayed on screen. You should read the agreement carefully before clicking all the relevant sections agreeing to its terms.</p>
									
									Once you have agreed to the terms of the finance agreement <span class="FCAregister"></span> trading as <%= CitrusStore.SystemBase.CitrusStoreConfiguration.StoreName().ToString%> will be notified and you need do nothing more.
									</p>
									<p>If you choose to print and return your agreement you should print the agreement, read it carefully and then sign the document following the instructions on the covering letter. This signed document should then be posted to the address shown on the covering letter of the finance agreement.</p>
									<p>Note that products will not be allocated to your order until your completed and signed agreement is returned and received by Hitachi Personal Finance. Shipment of your goods will follow soon after your agreement has been returned and received.</p>
									</div>
								</div>

								<div class="accordianBox">
									<div class="accordianHeader">Will you credit score me and if so, what does this mean? <span class="fa fa-angle-up"></span></div>
									<div class="accordianCtn" style="display: none;">
										<p>Credit scoring is the process used by financial services companies to evaluate the credit risk of new applicants. This technique will be applied to your application for online finance. Credit scoring works by awarding points for each answer given on the application form such as age, income and occupation, together with information obtained from credit reference agencies.</p>
										<p>This information allows consistent decisions to be provided, ensuring all applicants are treated fairly. Credit scoring does not discriminate on the grounds of sex, race, religion or disability.</p>
									</div>
								</div>
								
								<div class="accordianBox">
									<div class="accordianHeader">If you decline my application, what is the reason? <span class="fa fa-angle-up"></span></div>
									<div class="accordianCtn" style="display: none;">
										<p>In addition to credit scoring, Hitachi also takes into account confirmation of your identity, validation of certain application details, existing commitments and information held at the credit reference agencies. Though Hitachi is unable to provide you with a main reason for the decline of your application, it is usually based on one, or a combination of the following:</p>
										<ul>
											<li>Your credit score (please note that every finance company will score you differently)</li>
											<li>Adverse credit reference agency information</li>
											<li>You are considered to be overcommitted</li>
											<li>You are aged under 18</li>
											<li>Your existing account performance with other lenders</li>
										</ul>
									</div>
								</div>
								<div class="accordianBox">
									<div class="accordianHeader">What type of information do credit reference agencies hold about me?<span class="fa fa-angle-up"></span></div>
									<div class="accordianCtn" style="display: none;">
										<p>Some of the information is public information, for example electoral roll, County Court Judgements and bankruptcies. Other lenders may also file information about accounts you hold with them for instance this could include your payment history and outstanding balance on these accounts. Any requests for credit, where a credit reference search has been undertaken, will also be filed, although the result of the request is not recorded.</p>
									</div>
								</div>
								<div class="accordianBox">
									<div class="accordianHeader">How do I obtain a copy of this information?<span class="fa fa-angle-up"></span></div>
									<div class="accordianCtn" style="display: none;">
										<p>You should send a cheque for &pound;2.00 made payable to the relevant credit reference agency, together with details of all addresses at which you have lived over the last 6 years:</p>
										<ul>
											<li>Experian Limited, Customer Support Centre, PO Box 9000, Nottingham, NG80 7WF</li>
											<li>Equifax Ltd., Customer Service Centre, PO Box 10036, Leicester, LE3 4FS</li>
											<li>Callcredit Limited, Consumer Services, PO Box 491, Leeds, LS3 1WZ</li>
										</ul>
										<p>The above listed agencies will provide details of information relating to these addresses. If you believe that the information is incorrect, you can ask the agency to correct it.</p>
									</div>
								</div>
								<div class="accordianBox">
									<div class="accordianHeader">If my application is not successful, can I re-apply? <span class="fa fa-angle-up"></span></div>
									<div class="accordianCtn" style="display: none;">
										<p>Yes. We acknowledge that circumstances change and just because a previous application has been refused, it does not mean that a further request will automatically be turned down. We do suggest however, that you leave at least 6 months between applications.</p>
									</div>
								</div><div class="accordianBox">
									<div class="accordianHeader">Can I request delivery to an address other than my home? <span class="fa fa-angle-up"></span></div>
									<div class="accordianCtn" style="display: none;">
										<p>In order to safeguard against fraudulent applications, we regret that we're able only to deliver goods to the home address of the applicant.</p>
										<p>Hitachi Personal Finance will normally provide a final decision within the next 24 hours.</p>
									</div>
								</div>
							</div>
							
						</div>	
                        <div class="col-2 ">
							<div class="ctrPadLeft32">
								<h2>Demo of Finance calculator</h2>
								<p>This demo is based on product thats costs &pound;1,582.00 (not on sale).</p>
								<div class="financeCalcOveride"><cl:clFinance id="clFinance1" runat="server" IsOnSale='false' SalePrice='1520.00' Price='1520.00' /></div>
								
								<div class="productAccordian">
									<div class="accordianBox">
										<div class="accordianHeader">Buy Now Pay Later Finance / Countdown Interest Bearing Credit Example<span class="fa fa-angle-up"></span></div>
										<div class="accordianCtn" style="display: none;">
											<p>Buy now pay later with payments deferred for up to 12 months</p>
										<p>Spread the cost with our buy now pay later finance available online and in store.</p>
										<p>Our simple buy now pay later finance options allow you to spread the cost of your purchase over <48> months with an agreed deferral period.</p>
										<p>Monthly repayments will start 6 months after signing your finance agreement. Settle your agreement within the agreed deferral period and pay just an early settlement fee of &pound;29.00.</p>
										</div>
									</div>
									<div class="accordianBox">
										<div class="accordianHeader">Interest Bearing Finance Example<span class="fa fa-angle-up"></span></div>
										<div class="accordianCtn" style="display: none;">
											<p>Up to 36 months 9.9% APR representative interest bearing finance</p>
											<p>Spread the cost with our interest bearing finance available online and in store.</p>
											<p>Our simple finance options allow you to spread the cost of your purchase over 36 months.</p>
											<h3>All you need to do is:</h3>
											<ol>
												<li>Spend a minimum &pound;250 and above</li>
												<li>No minimum deposit</li>
											</ol>
											<p>We offer 4 simple finance options to help you spread the cost of your purchases.</p>
											<ul>
												<li>24 months interest bearing finance on orders of &pound;250 and above</li>
												<li>36 months interest bearing finance on orders of &pound;250 and above</li>
												<li>48 months interest bearing finance on orders of &pound;250 and above</li>
												<li>60 months interest bearing finance on orders of &pound;250 and above</li>
											</ul>
											
										</div>
									</div>
									<div class="accordianBox">
										<div class="accordianHeader">Interest Free Finance Example<span class="fa fa-angle-up"></span></div>
										<div class="accordianCtn" style="display: none;">
											<p>Up to 30 months 0% APR representative interest free finance</p>
											<p>Spread the cost with our interest free finance available online and in store.</p>
											<p>Minimum finance amount after deposit &pound;250 and above</p>
											<h3>All you need to do is:</h3>
											<ol>
												<li>Spend a minimum &pound;250 and above</li>
												<li>No minimum deposit</li>
											</ol>
											<p>We offer 4 simple finance options to help you spread the cost of your purchases.</p>
											<ul>
												<li>6 months interest bearing finance on orders of &pound;250 and above</li>
												<li>12 months interest bearing finance on orders of &pound;250 and above</li>
												<li>18 months interest bearing finance on orders of &pound;500 and above</li>
												<li>24 months interest bearing finance on orders of &pound;1000 and above</li>
												<li>30 months interest bearing finance on orders of &pound;2000 and above</li>
											</ul>
										</div>
									</div>
								</div>
											
								<p>If you require any further information about finance please call <%= CitrusStore.SystemBase.CitrusStoreConfiguration.MainDespatchTelephoneNumber%></p>
								
							</div>
                        </div>
                    </div>
					
                </div>
			</div>
		</div>
    </div>
    

    <uc1:footer id="Footer1" runat="server"></uc1:footer>
	
    </skm:form>
	</body>
</HTML>






