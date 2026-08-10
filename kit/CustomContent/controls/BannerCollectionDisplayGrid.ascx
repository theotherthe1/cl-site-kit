<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BannerCollectionDisplay.ascx.vb" Inherits="CitrusStore.CitrusStore.BannerCollectionDisplay" %>
<asp:Panel ID="bannerCollectionPanel" runat="server" CssClass="cc-collection">
    <asp:Repeater ID="bannerEntriesRepeater" runat="server">
        <ItemTemplate>
            <asp:PlaceHolder runat="server" Visible='<%# Not String.IsNullOrEmpty(Convert.ToString(Eval("ImagePath"))) %>'>
            <a href='<%# Eval("NavigateLink") %>' class="cc-banner cc-banner--<%# Eval("DisplayOrder") %>">
                <picture class="cc-banner__img">
                    <source media="(max-width: 480px)"
                            srcset="/images/<%# Eval("ImagePath") %>?width=640&quality=82&format=webp 1x,
                                    /images/<%# Eval("ImagePath") %>?width=1280&quality=78&format=webp 2x">
                    <source media="(max-width: 1024px)"
                            srcset="/images/<%# Eval("ImagePath") %>?width=1200&quality=82&format=webp 1x,
                                    /images/<%# Eval("ImagePath") %>?width=1800&quality=76&format=webp 2x">
                    <img src="/images/<%# Eval("ImagePath") %>?width=1440&quality=85&format=webp"
                         srcset="/images/<%# Eval("ImagePath") %>?width=1440&quality=85&format=webp 1x,
                                 /images/<%# Eval("ImagePath") %>?width=2160&quality=75&format=webp 2x"
                         alt="<%# Eval("Title") %>"
                         loading="lazy">
                </picture>
                <div class="cc-banner__body">
                    <div class="text-wrap">
                        <span class="cc-banner__desc"><%# Eval("Description") %></span>
                        <span class="cc-banner__title"><%# Eval("Title") %></span>
                    </div>
                    <span class="cc-banner__cta"><%# Eval("NavigateLinkText") %></span>
                </div>
            </a>
            </asp:PlaceHolder>
        </ItemTemplate>
    </asp:Repeater>
</asp:Panel>
