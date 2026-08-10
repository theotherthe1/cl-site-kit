<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FafCustomRepeater.ascx.vb" Inherits="CitrusStore.CitrusStore.FafCustomRepeater1" %>
<%@ Register TagPrefix="cl" TagName="pricing" Src="/modules/Controls/clPricing-item.ascx" %>

<asp:Panel ID="FAFCustomPanel" runat="server" CssClass="faf-product-carousel faf-product-grid">
    <div class="faf-header">
        <h2 class="faf-title">
            <asp:Label ID="repeaterTitle" runat="server" />
        </h2>
        <p class="faf-description">
            <asp:Label ID="repeaterDesc" runat="server" />
        </p>
        <div class="faf-product-btn-container">
            <a href="<%= detailLink %>" class="faf-view-more">
                Shop All
            </a>
        </div>
    </div>

    <div class="faf-grid-container">
        <ul class="faf-grid__list">
            <asp:Repeater ID="itemRepeater" runat="server">
                <ItemTemplate>
                    <li class="faf-product-slide"
                        data-productuid='<%#DataBinder.Eval(Container.DataItem, "uid") %>'
                        data-colourgroup='<%# DataBinder.Eval(Container.DataItem, "ColourGroupID") %>'
                        data-starbuy='<%# DataBinder.Eval(Container.DataItem, "IsStarBuy") %>'
                        data-localstock='<%# DataBinder.Eval(Container.DataItem, "LocalStock") %>'
                        data-warehousestock='<%# DataBinder.Eval(Container.DataItem, "WarehouseStock") %>'
                        data-prelaunch='<%# DataBinder.Eval(Container.DataItem, "Prelaunch") %>'
                        data-onsale='<%# DataBinder.Eval(Container.DataItem, "OnSale") %>'>

                        <div class="faf-product-card">
                            <a href='<%# Eval("URL") %>' class="faf-product-image-link">
                                <div class="faf-product-image" style="background: url(/<%# Eval("ImageURL") %>) center center"
                                    data-image="/<%# Eval("ImageURL") %>">
                                </div>
                            </a>

                            <div class="faf-product-info">
                                <a class="faf-product-link" href='<%# Eval("URL") %>'>
                                    <cl:pricing ID="pricing1" runat="server" Price='<%# Eval("RegPrice") %>'
                                        SalePrice='<%# Eval("SellPrice") %>' IsOnSale='<%# Eval("IsOnSale") %>'
                                        ProductID='<%#Eval("uid")%>' />
                                    <div class="faf-product-name">
                                        <%# Eval("Name") %>
                                    </div>
                                </a>

                                <button type="button" class="faf-quick-buy-btn"
                                    onclick="loadQuickLookByProductId('<%#Eval("uid") %>')">
                                    Add To Basket
                                </button>
                            </div>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
    </div>
</asp:Panel>
