        <!-- === N. LOGO-STRIP - heading row above a drifting logo carousel === -->
        <!-- both halves read collection 3, so the entries divide by position:
             entry 1 is the band heading (bannerLimit="1"), entries 2.. are the
             logos. The carousel control has no server-side offset, so it also
             fetches entry 1 and data-splide-skip="1" drops that slide before
             mount; bannerLimit is 13 to still land 12 logos in the strip. -->
        <div class="wrapper">
            <div class="grid fixed">
                <div class="col-1 hp-logo-strip"
                     data-splide-opts='{ "type":"loop", "perPage":6, "gap":"3rem", "autoplay":true, "interval":3000, "speed":900, "arrows":true, "pagination":true, "cover":false, "breakpoints":{ "1024":{ "perPage":4 }, "640":{ "perPage":2 } } }'
                     data-splide-skip="1"
                     data-animate>
                    <div class="CC-HomepageTitles blk">
                        <uc1:BannerCollectionDisplay ID="LogoStripTitle" runat="server"
                            bannerid="__BANNER_ID__" bannerLimit="1" imageSizing="imgCtr75" />
                    </div>
                    <uc1:BannerCollectionSplideBrands ID="LogoStrip" runat="server"
                        bannerid="__BANNER_ID__" bannerLimit="13" imageSizing="imgCtr75" />
                </div>
            </div>
        </div>
