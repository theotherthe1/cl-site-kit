<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BannerCollectionDisplay.ascx.vb" Inherits="CitrusStore.CitrusStore.BannerCollectionDisplay" %>
<asp:Panel ID="bannerCollectionPanel" runat="server" CssClass="cc-collection">
    <section class="splide" aria-label="Banner carousel">
        <div class="splide__track">
            <ul class="splide__list">
                <asp:Repeater ID="bannerEntriesRepeater" runat="server">
                    <ItemTemplate>
                        <li class="splide__slide">
                            <a href='<%# Eval("NavigateLink") %>' class="cc-banner cc-banner--<%# Eval("DisplayOrder") %>">
                            
                                <picture class="cc-banner__img">
                                    <source media="(max-width: 480px)"
                                            srcset="/images/<%# Eval("ImagePath") %>?width=640&quality=85&format=webp 1x,
                                                    /images/<%# Eval("ImagePath") %>?width=1280&quality=78&format=webp 2x">
                                    <source media="(max-width: 1024px)"
                                            srcset="/images/<%# Eval("ImagePath") %>?width=1200&quality=85&format=webp 1x,
                                                    /images/<%# Eval("ImagePath") %>?width=2048&quality=75&format=webp 2x">
                                    <img src="/images/<%# Eval("ImagePath") %>?width=1920&quality=85&format=webp"
                                         srcset="/images/<%# Eval("ImagePath") %>?width=1920&quality=85&format=webp 1x,
                                                 /images/<%# Eval("ImagePath") %>?width=2880&quality=72&format=webp 2x"
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
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </section>
</asp:Panel>
