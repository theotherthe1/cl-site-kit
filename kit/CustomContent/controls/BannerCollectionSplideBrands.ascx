<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BannerCollectionDisplay.ascx.vb" Inherits="CitrusStore.CitrusStore.BannerCollectionDisplay" %>
<asp:Panel ID="bannerCollectionPanel" runat="server" CssClass="cc-collection">
    <section class="splide" aria-label="Brand carousel">
        <div class="splide__track">
            <ul class="splide__list">
                <asp:Repeater ID="bannerEntriesRepeater" runat="server">
                    <ItemTemplate>
                        <li class="splide__slide">
                            <a href='<%# Eval("NavigateLink") %>' class="cc-brand cc-brand--<%# Eval("DisplayOrder") %>">
                                <img class="cc-brand__img"
                                     src="/images/<%# Eval("ImagePath") %>?width=300&quality=80&mode=crop&format=png"
                                     alt="<%# Eval("Title") %>"
                                     loading="lazy">
                            </a>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </section>
</asp:Panel>
