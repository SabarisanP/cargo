<input type="hidden" id="gal_id" value="{$attender_code}">
<input type="hidden" id="gal_name" value="{$attender_name}">

<div class="col-md-4">
    <div id="uploads" class="ht_auto">
        <div id="container">
            <label>Profile</label>
            <a id="pickfiles" class="btn btn-info  btn-sm"  href="javascript:;">Select files</a>
        </div>
        <br/>
        <div id="filelist"></div>
    </div>
</div>

<div class="col-md-4">
    <span id="img">
        <div id="gallery_grid" class="freewall_container clearfix">
            <div class="ht_auto" style="position: absolute;top: 10px;">
                {if $image['profile']}
                    {assign var=row value=$image['profile']}
                    <div class="freewall_item image_profile w-auto">
                        <img src="{$base_url}{$row->image_url}" height="120" class="w-auto">
                        <div class="item_overlay">
                            <h4>{$row->file_name}</h4>
                            <a href="javascript:;" class="item_edit" onclick="deleteGalleryImages('{$row->folder_path}', '{$row->file_name}', 'profile');"><i class="fa fa-trash"></i></a>
                            <a href="{$base_url}{$row->image_url}" class="item_preview"><i class="fa fa-search-plus"></i></a>
                        </div>
                    </div>
                {else}
                    <div class="well well-large"> No image found.</div>
                {/if}
            </div>
        </div>
    </span>
</div>
<div class="clear_fix_both"></div><br/>

{literal}
    <script type="text/javascript">
        imagesLoaded('.freewall_item > img', function () {
            $('.freewall_item').on('mouseenter', function () {
                if (!$(this).hasClass('.item_selected')) {
                    $(this).children('.item_overlay').addClass('show_overlay');
                }
            }).on('mouseleave', function () {
                if (!$(this).hasClass('.item_selected')) {
                    $(this).children('.item_overlay').removeClass('show_overlay');
                }
            });
        });

        if ($('.freewall_item .item_preview').length) {
            $('.freewall_item .item_preview').magnificPopup({
                type: 'image',
                gallery: {
                    enabled: true,
                    arrowMarkup: '<i title="%title%" class="glyphicon glyphicon-chevron-%dir% mfp-nav"></i>'
                },
                removalDelay: 500, //delay removal by X to allow out-animation
                callbacks: {
                    beforeOpen: function () {
                        // just a hack that adds mfp-anim class to markup
                        this.st.image.markup = this.st.image.markup.replace('mfp-figure', 'mfp-figure mfp-with-anim');
                        this.st.mainClass = 'mfp-zoom-in';
                    }
                },
                closeOnContentClick: true,
                midClick: true // allow opening popup on middle mouse click. Always set it to true if you don't provide alternative source.
            });
        }

        function pluploadOptions(obj) {
            return {
                runtimes: 'html5,html4',
                browse_button: obj.browse, // you can pass an id...
                container: document.getElementById('container'), // ... or DOM Element itself
                url: base_url + "config/upload-attender-image?code=" + $('#gal_id').val() + '&name=' + obj.nameprefix,
                multi_selection: false,
                resize: {width: 1000, height: 1000, quality: 100},
                filters: {
                    mime_types : [
                        { title : "Image files", extensions : "jpg,png" }
                    ],
                    max_file_size: '2mb'
                },
                init: {
                    PostInit: function (ul) {
                        document.getElementById(obj.filelist).innerHTML = '';
                        //document.getElementById(obj.uploadfiles).onclick = function () {
                        //    ul.start();
                        //    return false;
                        //};
                    },
                    FilesAdded: function (up, files) {
                        if (up.files.length > 1) {
                            up.splice(0, up.files.length);
                            up.addFile(files[0])
                        }
                        plupload.each(files, function (file) {
                            document.getElementById(obj.filelist).innerHTML = '<div id="' + file.id + '">' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b></div>';
                        });
                        up.start();
                    },
                    FileUploaded: function (up, files, res) {
                        if (up.total.queued == 0) {
                            setTimeout(function () {
                                getAttenderGallery(false);
                            }, 1000);
                        }
                    },
                    UploadProgress: function (up, file) {
                        document.getElementById(file.id).getElementsByTagName('b')[0].innerHTML = '<span>' + file.percent + "%</span>";
                    },
                    Error: function (up, err) {
                        err.code == -600 && alert('File should be less than 2MB of size');
                    }
                }
            }
        }

        var uploader = new plupload.Uploader(pluploadOptions({
            'browse': 'pickfiles',
            'filelist': 'filelist',
            'uploadfiles': 'uploadfiles',
            'nameprefix': 'profile'
        }));
        uploader.init();

        function deleteGalleryImages(img_path, img_name, img_code) {
            if (confirm('Do you want to delete this image?')) {
                var data = {};
                data.img_path = img_path;
                data.img_name = img_name;

                var loading_overlay = iosOverlay({
                    text: "Loading",
                    icon: "fa fa-spinner fa-spin"
                });
                $.ajax({
                    type: "POST",
                    dataType: 'json',
                    url: base_url + "config/delete-attender-image",
                    data: data,
                    success: function (response) {
                        if (response.status == 1) {
                            setTimeout(function () {
                                getAttenderGallery(false);
                            }, 100);
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
                        window.setTimeout(function () {
                            loading_overlay.hide();
                        }, 2000);
                    }
                })
            }
        }
    </script>
{/literal}