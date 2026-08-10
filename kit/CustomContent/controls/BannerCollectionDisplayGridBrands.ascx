<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BannerCollectionDisplay.ascx.vb" Inherits="CitrusStore.CitrusStore.BannerCollectionDisplay" %>
<asp:Panel ID="bannerCollectionPanel" runat="server" CssClass="cc-collection">
    <asp:Repeater ID="bannerEntriesRepeater" runat="server">
        <ItemTemplate>
            <a href='<%# Eval("NavigateLink") %>' class="cc-brand cc-brand--<%# Eval("DisplayOrder") %>">
                <img class="cc-brand__img"
                     src="/images/<%# Eval("ImagePath") %>?width=300&quality=80&mode=crop&format=png"
                     alt="<%# Eval("Title") %>"
                     loading="lazy">
            </a>
        </ItemTemplate>
    </asp:Repeater>
</asp:Panel>
