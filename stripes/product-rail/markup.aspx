        <!-- === N. PRODUCT-RAIL - text rail left, product cards right === -->
        <div class="wrapper">
            <div class="grid fixed">
                <div class="col-1 hp-product-rail"
                     data-splide-opts='{ "type":"loop", "perPage":3, "gap":"1.5rem", "speed":700, "trimSpace":true, "arrows":true, "pagination":true, "cover":false, "breakpoints":{ "1024":{ "perPage":2 }, "640":{ "perPage":1 } } }'
                     data-animate>
                    <!-- the whole band is this one control: FafCustomRepeaterSplide's
                         Panel IS the .faf-product-carousel rail grid, and it emits the
                         text rail (title / description / Shop All link) alongside the
                         product carousel — all four bound from repeater 1, so nothing
                         here is hardcoded. -->
                    <uc2:FafCustomRepeaterSplide ID="ProductRail" runat="server"
                        numberofitems="12" repeaterid="__REPEATER_ID__" />
                </div>
            </div>
        </div>
