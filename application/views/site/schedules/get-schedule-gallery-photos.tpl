<div id="gallery_grid" class="freewall_container clearfix">        

    {foreach name=o item=row from=$images} 
        <div class="freewall_item">
            <img src="{$row->imageURL|replace:'[##]':'thumb'}" alt="">
            <div class="item_overlay">            
                <h4>{$row->name}</h4>
                <a href="{$row->imageURL|replace:'[##]':'image'}" class="item_preview"><i class="fa fa-search-plus"></i></a>
            </div>
        </div>            
    {foreachelse}
        <div>
            <div class="well well-large ">No photos found.</div>
        </div>
    {/foreach}

</div>
<script>    
    imagesLoaded('.freewall_item > img', function() {           
        gallery_wall = new freewall("#gallery_grid");
        gallery_wall.reset({
                selector: '.freewall_item',
                animate: true,
                cellW: 220,
                cellH: 'auto',
                onResize: function() {
                    gallery_wall.fitWidth();
                }
        });
        gallery_wall.fitWidth();
        $(window).trigger("resize");

        $('.freewall_item').on('mouseenter', function() {
            if (!$(this).hasClass('.item_selected')) {
                $(this).children('.item_overlay').addClass('show_overlay');
            }
        }).on('mouseleave', function() {
            if (!$(this).hasClass('.item_selected')) {
                $(this).children('.item_overlay').removeClass('show_overlay');
            }
        });
    });
    
    if ($('.freewall_item .item_preview').length) {
        $('.freewall_item .item_preview').magnificPopup({
            type: 'image',
            gallery:{
                enabled: true,
                arrowMarkup: '<i title="%title%" class="glyphicon glyphicon-chevron-%dir% mfp-nav"></i>'
            },
            removalDelay: 500, //delay removal by X to allow out-animation
            callbacks: {
                beforeOpen: function() {
                   // just a hack that adds mfp-anim class to markup 
                   this.st.image.markup = this.st.image.markup.replace('mfp-figure', 'mfp-figure mfp-with-anim');
                   this.st.mainClass = 'mfp-zoom-in';
                }
            },
            closeOnContentClick: true,
            midClick: true // allow opening popup on middle mouse click. Always set it to true if you don't provide alternative source.
        });
    }
                        
</script>    

