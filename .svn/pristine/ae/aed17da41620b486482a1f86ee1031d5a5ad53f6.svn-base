<div class="btn-group pull-right">
    <a href="javascript:;" class="btn btn-default edt" title="Upload images" data-toggle="tooltip" id="upl-img">
        <i class="fa fa-upload igreen"></i>
    </a>
    <a href="javascript:;" class="btn btn-default edt" title="Edit gallery" data-toggle="tooltip" onclick="saveDialogGallery('{$gallery[0]->code}', '{$gallery[0]->name}')">
        <i class="fa fa-pencil igreen"></i>
    </a>
    <a href="javascript:;" class="btn btn-default edt" title="Delete gallery" data-toggle="tooltip" onclick="deleteGallery('{$gallery[0]->code}', '{$gallery[0]->name}')">
        <i class="fa fa-times igreen"></i>
    </a>    
</div>
        
<input type="hidden" id="gal_id" value="{$gallery[0]->code}">
<input type="hidden" id="gal_name" value="">         
<br /><br /><br />

<span id="img">
    <div id="gallery_grid" class="freewall_container clearfix">  
        {if $image|count > 0}
            {foreach name=o item=row from=$image} 
                <div class="freewall_item image_{$row->code}" >
                    <img src="{$row->imageURL|replace:'[##]':'thumb'}" alt="">
                    <div class="item_overlay">            
                        <h4>{$row->name}</h4>                       
                        <a href="javascript:;" class="item_edit" onclick="deleteGalleryImages('{$gallery[0]->code}', '{$row->code}','{$row->imageURL}')"><i class="fa fa-trash"></i></a>
                        <a href="{$row->imageURL|replace:'[##]':'image'}" class="item_preview"><i class="fa fa-search-plus"></i></a>
                    </div>
                </div> 

            {/foreach}
        {else}
            <div>
                <div class="well well-large "> No images found.</div>
            </div>
        {/if}
    </div>
</span>

<span id="uploads">         
    <div id="container">
        <a id="pickfiles" class="btn btn-info  btn-sm"  href="javascript:;">Select files</a>
        <a id="uploadfiles" class="btn btn-success  btn-sm" href="javascript:;">Upload files</a>
    </div>
    <br />
    <div id="filelist"></div>
</span>
    
{literal}
<script type="text/javascript">
// Custom example logic
    $('#uploads').hide(); 

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


$('#upl-img').click(function(){
   uploader.init(); 
   $('#uploads').show();
   $('#img').hide();
});
function do_click(){
    $('#gall-viw-'+$('#gal_id').val()).trigger('click');
}
var uploader = new plupload.Uploader({
	runtimes : 'html5,html4',
	browse_button : 'pickfiles', // you can pass an id...
	container: document.getElementById('container'), // ... or DOM Element itself
	url : base_url + "config/upload-gallery?id="+$('#gal_id').val(),
	resize : { width : 1000, height : 1000, quality : 100 },
	filters : {
		max_file_size : '10mb',
	},
	init: {
		PostInit: function() {
			document.getElementById('filelist').innerHTML = '';

			document.getElementById('uploadfiles').onclick = function() {
				uploader.start();
				return false;
			};
                        
                        
		},

		FilesAdded: function(up, files) {
			plupload.each(files, function(file) {
				document.getElementById('filelist').innerHTML += '<div id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b></div>';
			});
		},
                
                FileUploaded: function(up, files, res) {
                     if(up.total.queued == 0) {
                         do_click();
                     }
                },

		UploadProgress: function(up, file) {
			document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";
		},

		Error: function(up, err) {
			document.getElementById('console').appendChild(document.createTextNode("\nError #" + err.code + ": " + err.message));
		}
                 
	}
        
       

  
});

function deleteGalleryImages(gall_code,img_code,img_url){
     if (confirm('Do you want to delete this image?')) {
        var data = {};
        data.activeFlag = 2;
        data.img_code = img_code;
        data.gall_code = gall_code;
        data.img_url = img_url;

        var loading_overlay = iosOverlay({
            text: "Loading",
            icon: "fa fa-spinner fa-spin"
        });
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: base_url + "config/delete-gallery-image",
            data: data,
            success: function(response) {
                if (response.status == 1) {
                    $('.image_' + img_code).animate({backgroundColor: '#1AA1E1'}, 2000, function() {
                        $(this).remove();
                        gallery_wall.fitWidth();
                    });
                    loading_overlay.update({
                        icon: "fa fa-check",
                        text: "Success!"
                    });
                } else {
                    loading_overlay.update({
                        icon: "fa fa-times",
                        text: "Sorry!"
                    });
                }
                window.setTimeout(function() {
                    loading_overlay.hide();
                    //window.location.reload();
                }, 2000);
            }
        })
    }
}


 
</script>
{/literal}