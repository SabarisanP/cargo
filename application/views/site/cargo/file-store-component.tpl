{* OPTIONS *}
{* id="ie-fileupload" axis="vertical"|"horizontal" [vertical]yaxisheight="300px" *}
<div id="{$id}">
    <div class="file-upload-gallery file-input-gallery {$axis}"></div>
    <div class="file-upload-buttons">
        <a href="javascript:;" class="btn btn-info btn-sm file-upload-choose">Select files</a>
    </div><br />
    <div class="file-upload-alert alert hide"></div>
    <div class="file-upload-container hide"></div>
    <div class="file-upload-image-tpl hide">
        <div class="file-upload-image file-upload-file">
            <div class="file-placeholder">
                <img class="file" src="" alt="">
            </div>
            <span class="filename"></span>
            <a href="javascript:;" class="fileremove" title="Delete"><i class="fa fa-times fa-fw"></i></a>
            <small class="fileuploadstatus"></small>
        </div>
    </div>
    <div class="file-upload-doc-tpl hide">
        <div class="file-upload-doc file-upload-file">
            <div class="file-placeholder">
                <span class="filetype badge"></span>
            </div>
            <span class="filename"></span>
            <a href="javascript:;" class="fileremove" title="Delete"><i class="fa fa-times fa-fw"></i></a>
            <small class="fileuploadstatus"></small>
        </div>
    </div>
    <div class="hide file-upload-gallery-dialog">
        <div class="clearfix gallery-dialog-close">
            <a class="pull-right gallery-dialog-close-btn" href="javascript:;" title="click or press ESC to close">
                <i class="fa fa-times-circle fa-2x"></i>
            </a>
        </div>
        <div class="file-upload-gallery dialog-gallery"></div>
    </div>
</div>

<link rel="stylesheet" href="{$base_url}assets/lib/magnific-popup/magnific-popup.css?{$asset_ver}">
<script type="text/javascript" src="{$base_url}assets/lib/magnific-popup/jquery.magnific-popup.min.js?{$asset_ver}"></script>

<script>
    function fileUpload(rootSelector, options = {}) {
        const rootNode = document.querySelector(rootSelector);
        this.getRootNode = () => rootNode;

        this.initUpload(options);
        this.initGallery();
    }

    fileUpload.prototype.initUpload = function(options = {}) {
        const rootNode = this.getRootNode();
        const self = this;

        const defaults = {
            resize: { width: 1000, height: 1000, quality: 100 },
            filters: { max_file_size: '2mb', prevent_duplicates: true },
        };
        const settings = {
            runtimes: 'html5',
            browse_button: rootNode.querySelector('.file-upload-choose'),
            drop_element: rootNode.querySelector('.file-input-gallery'),
            container: rootNode.querySelector('.file-upload-container'),
            url: function() {},
            init: {
                PostInit: function() {
                    self.clearFiles();
                },
                FilesAdded: function(up, files) {
                    var imagetpl = $('.file-upload-image-tpl').html();
                    var doctpl = $('.file-upload-doc-tpl').html();
                    plupload.each(files, function(file) {
                        var isImage = new RegExp('^image/*').test(file.type);
                        var $tpl = $(isImage ? imagetpl : doctpl);
                        $tpl.attr('id', file.id);
                        $tpl.find('.filename').html(file.name).attr('title', file.name);
                        $tpl.find('.fileremove').on('click', function(e) {
                            e.stopPropagation();
                            uploader.removeFile(file);
                            $tpl.remove();
                        });

                        var reader = new FileReader();
                        if (isImage) {
                            reader.onload = function(event) {
                                $tpl.find('.file').attr('src', event.target.result);
                            };
                        } else {
                            var ext = file.name.replace(/(.*)\./g, '').trim().toLowerCase();
                            var badge;
                            if (/^xls/.test(ext)) {
                                badge = 'badge-success';
                            } else if (/^pdf/.test(ext)) {
                                badge = 'badge-danger';
                            } else if (/^doc/.test(ext)) {
                                badge = 'badge-primary';
                            }
                            $tpl.find('.filetype').html(ext).addClass(badge);
                            reader.onload = function(event) {
                                $tpl.on('click', function() {
                                    window.open(event.target.result);
                                });
                            };
                        }
                        reader.readAsDataURL(file.getNative());

                        $('.file-input-gallery', rootNode).append($tpl);
                    });
                },
                FileUploaded: function(up, file, res) {
                    var response = JSON.parse(res.response);

                    if (response.status == 1) {
                        $('#' + file.id, rootNode)
                            .data('slug', response.data.slug)
                            .find('.fileuploadstatus').html('Upload Complete')
                            .addClass('text-success');
                    } else {
                        $('#' + file.id, rootNode)
                            .data('slug', null)
                            .find('.fileuploadstatus').html(response.errorDesc)
                            .addClass('text-danger');
                    }
                },
                UploadProgress: function(up, file) {
                    $('#' + file.id, rootNode).find('.fileuploadstatus').html('Uploading ' + file.percent + '%').addClass('text-primary')
                },
                Error: function(up, err) {
                    $('.file-upload-alert', rootNode).html('Error #' + err.code + ': ' + err.message)
                        .addClass('alert-danger').removeClass('alert-success alert-info hide')
                        .delay(3000).queue(function() {
                            $(this).remove();
                        });
                }
            }
        };

        const config = $.extend(true, defaults, options, settings);
        const uploader = new plupload.Uploader(config);
        uploader.init();

        this.startUpload = (param) => {
            if (!uploader.files.length) {
                self.saveImageDetails(param);
                return;
            }
            uploader.setOption('url', 'config/store-upload-files');
            uploader.setOption('multipart_params', $.extend(true, {}, param.data));
            if (uploader.files.length) {
                uploader.start();
                uploader.unbind('UploadComplete');
                uploader.bind('UploadComplete', function() {
                    self.saveImageDetails(param);
                });
            }
        }

        this.clearFiles = () => {
            uploader.files.clear();
            $('.file-upload-gallery', rootNode).empty();
            $('.file-upload-alert', rootNode)
                .removeClass('alert-success alert-danger alert-info')
                .addClass('hide')
                .html('');
        }

        this.loadFiles = self.loadFiles
    }

    fileUpload.prototype.initGallery = function(rootNode) {
        if (!rootNode) {
            rootNode = this.getRootNode();
        }

        $('.file-upload-gallery', rootNode).magnificPopup({
            items: [],
            type: 'image',
            delegate: '.file-upload-image .file-placeholder',
            removalDelay: 500,
            closeOnContentClick: true,
            mainClass: 'mfp-zoom-in',
            gallery: {
                enabled: true,
                navigateByImgClick: false,
                arrowMarkup: '<i title="%title%" class="glyphicon glyphicon-chevron-%dir% mfp-nav"></i>'
            },
            image: {
                markup: $.magnificPopup.defaults.image.markup.replace('mfp-figure', 'mfp-figure mfp-with-anim')
            },
            callbacks: {
                beforeOpen: function() {
                    this._onFocusIn = function() {};
                    var $holder = $(event.target).closest('.file-placeholder');
                    var $images = $(':not(.file-upload-image-tpl) .file-upload-image img', rootNode);
                    this.items = $images.map((i, img) => ({ src: img.src })).get();
                    var index = $images.index($holder.find('img'));
                    this.goTo(index > 0 ? index : 0);
                }
            }
        });
    }

    fileUpload.prototype.saveImageDetails = function(param) {
        const rootNode = this.getRootNode();

        var data = $.extend(true, {}, param.data);

        data.imageDetails = [];

        $('.file-input-gallery .file-upload-file', rootNode).each(function() {
            var slug = $(this).data('slug');

            if (slug) {
                data.imageDetails.push({ imageUrlSlug: slug });
            }
        });

        if (!data.imageDetails.length || param.data.imageCategoryCode == 'PODDELIVERY') {
            param.onComplete();
            return;
        }

        $('.file-upload-alert', rootNode)
            .removeClass('alert-success alert-danger hide')
            .addClass('alert-info')
            .html(loading_popup +'&emsp; File(s) Uploading. Please wait...' );

        $.ajax({
            type: 'POST',
            url: base_url + 'config/save-image-details',
            data: data,
            dataType: 'json',
            success: function(response) {
                if (response.status == 1) {
                    $('.file-upload-alert', rootNode)
                        .removeClass('alert-info')
                        .html('Image uploaded successfully')
                        .addClass('alert-success');
                    setTimeout(param.onComplete, 2000)
                } else {
                    $('.file-upload-alert', rootNode)
                        .removeClass('alert-info')
                        .html(response.errorDesc)
                        .addClass('alert-danger');
                }
            }
        });
    }

    fileUpload.prototype.loadFiles = function(param, gallerynode) {
        this.clearFiles();
        const rootNode = this.getRootNode();
        const self = this;

        var data = $.extend(true, {}, param.data);
        data.imageCategoryCode = param.imageCategoryCode;

        if (!gallerynode) {
            gallerynode = $('.file-input-gallery', rootNode);
        }

        gallerynode.html(loading_popup);
        $('.file-upload-alert', rootNode)
            .removeClass('alert-success alert-danger alert-info hide')
            .addClass('hide').html('');

        $.ajax({
            type: 'POST',
            url: base_url + 'config/get-image-details',
            data: data,
            dataType: 'json',
            success: function(response) {
                if (response.status == 1) {
                    gallerynode.empty();
                    $.each(response.data || [], function(i, row) {
                        self.renderfile(row, gallerynode);
                    });
                    $('.file-upload-alert', rootNode).html('').addClass('hide');
                } else {
                    $('.file-upload-alert', rootNode)
                        .html(response.errorDesc)
                        .addClass('alert-danger');
                }
            }
        });
    }

    fileUpload.prototype.renderfile = function(file, gallerynode) {
        var imagetpl = $('.file-upload-image-tpl').html();
        var doctpl = $('.file-upload-doc-tpl').html();
        var filename = file.filename;
        var filetype = file.filetype;
        var isImage = new RegExp('^image/*').test(filetype);

        var $tpl = $(isImage ? imagetpl : doctpl);

        $tpl.attr('id', filename);
        $tpl.data('slug', file.imageUrlSlug);
        $tpl.find('.filename').html(filename).attr('title', filename);
        $tpl.find('.fileremove').on('click', function(e) {
            e.stopPropagation();
            $tpl.remove();
        });

        if (isImage) {
            $tpl.find('.file').attr('src', file.imageUrlSlug);
        } else {
            var ext = filename.replace(/(.*)\./g, '').trim().toLowerCase();
            var badge;
            if (/^xls/.test(ext)) {
                badge = 'badge-success';
            } else if (/^pdf/.test(ext)) {
                badge = 'badge-danger';
            } else if (/^doc/.test(ext)) {
                badge = 'badge-primary';
            }
            $tpl.find('.filetype').html(ext).addClass(badge);
            $tpl.on('click', function() {
                window.open(file.imageUrlSlug);
            });
        }

        gallerynode.append($tpl);
    }

    fileUpload.prototype.showGalleryDialog = function(param) {
        const rootNode = this.getRootNode();
        const self = this;
        
        $('.file-upload-gallery-dialog', rootNode)
            .clone().removeClass('hide')
            .dialog({
                autoOpen: true,
                height: 460,
                width: 650,
                modal: true,
                closeOnEscape: true,
                resizable: false,
                open: function (e, ui) {
                    $('.gallery-dialog-close-btn', e.target).one('click', function () {
                        $(e.target).dialog('close');
                    });
                    self.loadFiles(param, $('.dialog-gallery', e.target));
                    self.initGallery(e.target);
                }
            });
    }
</script>

<style>
    .file-upload-gallery {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
        grid-gap: 15px;
        align-items: stretch;
    }

    .file-upload-gallery:not(:empty) {
        margin: 15px 0;
    }

    .file-upload-gallery.horizontal {
        overflow-x: auto;
        grid-auto-flow: column;
        padding: 16px;
    }

    .file-upload-gallery.horizontal::after {
        content: '';
        width: 5px;
    }

    .file-upload-gallery.vertical {
        max-height: {$yaxisheight|default:'400px'};
        overflow: auto;
    }

    .file-upload-gallery-dialog.ui-dialog-content .file-upload-gallery {
        overflow-x: hidden;
        grid-auto-flow: unset;
        max-height: 400px;
        overflow-y: auto;
        padding: 0 16px;
    }

    .file-upload-gallery-dialog.ui-dialog-content .fileremove {
        display: none;
    }

    .file-upload-gallery .file-upload-image,
    .file-upload-gallery .file-upload-doc {
        position: relative;
        user-select: none;
        width: 100px;
    }

    .file-upload-gallery .file-placeholder {
        width: 100%;
        height: 100px;
        display: flex;
        align-items: center;
        overflow: hidden;
        background: #fbfbfb;
        border-radius: 6px;
    }

    .file-upload-gallery .file-upload-image .file-placeholder {
        cursor: zoom-in;
    }

    .file-upload-gallery .file {
        width: 100%;
    }

    .file-upload-gallery .filename {
        display: block;
        font-weight: bold;
        width: 100px;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }

    .file-upload-gallery .fileremove,
    .file-upload-gallery .fileremove:focus {
        position: absolute;
        top: 5px;
        right: 5px;
        font-size: 14px;
        width: 22px;
        height: 22px;
        color: #a94442;
        text-align: center;
        padding: 0px;
        border-radius: 50%;
        background: #ffffff;
        -webkit-box-shadow: 0 3px 1px -2px rgba(0, 0, 0, .2), 0 2px 2px 0 rgba(0, 0, 0, .14), 0 1px 5px 0 rgba(0, 0, 0, .12);
        box-shadow: 0 3px 1px -2px rgba(0, 0, 0, .2), 0 2px 2px 0 rgba(0, 0, 0, .14), 0 1px 5px 0 rgba(0, 0, 0, .12);
    }

    .file-upload-gallery .fileremove:hover {
        background: #d0d0d0;
    }

    .file-upload-gallery .filetype {
        margin: auto;
    }

    .file-upload-gallery-dialog .gallery-dialog-close {
        display: none;
    }

    .file-upload-gallery-dialog.ui-dialog-content .gallery-dialog-close {
        display: block;
    } 
</style>
