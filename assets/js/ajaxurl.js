$.navAsAjax = true;

$(document).ready(function (e) {

    // checkURL();

});
if ($.navAsAjax)
{
    // fire this on page load if nav exists
    if ($('nav').length) {
        checkURL();
    }
    ;

    $(document).on('click', '.main-nav a[href!="#"]', function (e) {
        e.preventDefault();
        var $this = $(e.currentTarget);

        // if parent is not active then get hash, or else page is assumed to be loaded
        if (!$this.parent().hasClass("active") && !$this.attr('target')) {

            // update window with hash
            // you could also do here:  $.device === "mobile" - and save a little more memory
            if (window.location.search) {
                window.location.href =
                        window.location.href.replace(window.location.search, '')
                        .replace(window.location.hash, '') + '#' + $this.attr('href');
            } else {
                window.location.hash = $this.attr('href');
            }

        }

    });
    $(document).on('click', '.mobile-nav a[href!="#"]', function (e) {
        e.preventDefault();
        var $this = $(e.currentTarget);

        // if parent is not active then get hash, or else page is assumed to be loaded
        if (!$this.parent().hasClass("active") && !$this.attr('target')) {

            // update window with hash
            // you could also do here:  $.device === "mobile" - and save a little more memory



            window.setTimeout(function () {
                if (window.location.search) {
                    window.location.href =
                            window.location.href.replace(window.location.search, '')
                            .replace(window.location.hash, '') + '#' + $this.attr('href');
                } else {
                    window.location.hash = $this.attr('href')
                }
            }, 150);
            // it may not need this delay...
            $('.toggle-mobile').trigger('click');
        }

    });
    // fire links with targets on different window
    $(document).on('click', '.main-nav a[target="_blank"]', function (e) {
        e.preventDefault();
        var $this = $(e.currentTarget);

        window.open($this.attr('href'));
    });

    // fire links with targets on same window
    $(document).on('click', '.main-nav a[target="_top"]', function (e) {
        e.preventDefault();
        var $this = $(e.currentTarget);

        window.location = ($this.attr('href'));
    });

    // all links with hash tags are ignored
    $(document).on('click', '.main-nav a[href="#"]', function (e) {
        e.preventDefault();
    });
    $(document).on('click', '.main-nav a[href="javascript:;"]', function (e) {
        e.preventDefault();
    });
    // DO on hash change
    $(window).on('hashchange', function () {
        checkURL();

    });
    $(document).ajaxComplete(function (event, xhr) {
        xhr.status === 440 && logout();
    });
}

function logout() {
    window.location.href = base_url + 'user/logout';
}

function checkURL() {
    //get the url by removing the hash
    var url = location.hash.replace(/^#/, '');
    
    $('#main_page_content').html('');
    $('.daterangepicker').remove();
    
    container = $('#main_page_content');
    // Do this if url exists (for page refresh, etc...)

    if (url && url != 'undefined') {
        // remove all active class
        $('.main-nav li.active').removeClass("active");
        // match the url and add the active class
        $('.main-nav li:has(a[href="' + url + '"])').addClass("active");
        var brand = $('#brand').text();
        var title = ($('.main-nav a[href="' + url + '"]').attr('title'))

        // change page title from global var
        if(title && title != 'undefined') brand += ' - '+title;
        
        document.title = (brand || document.title);
        container.html('<div class="flex-center wid-p-100"><h1 style="margin-top: -50px;"><i class="fa fa-cog fa-spin"></i> Loading...</h1></div>');
        
         
        // parse url to jquery
        loadURL(url + location.search, container);
    } else {

        // grab the first URL from nav
        var $this = $('.main-nav > ul > li:first-child > a[href!="#"]');
        window.location.hash = '#user/dashboard';
    }

}

// LOAD AJAX PAGES
NProgress.configure({ showSpinner: false });
NProgress.configure({ minimum: 0.3 });
function loadURL(url, container) {    
    ga('send', 'pageview', url); //  track virtual page view
    ga('send', 'event', {        //  track virtual page as event
        eventCategory: 'pages', 
        eventAction: url, 
        eventLabel: ns_name,
    });
    NProgress.start();
    $.ajax({
        type: "GET",
        url: url,
        dataType: 'html',
        cache: true, // (warning: this will cause a timestamp and will call the request twice)
        beforeSend: function () {
            //drawBreadCrumb();
            // scroll up
            $("html, body").animate({
                scrollTop: 0
            }, "fast");            
        },
        statusCode: {
            440: logout
        },
        success: function (data) {            
            NProgress.done();            
            container.css({
                opacity: '0.0'
            }).html(data).delay(50).animate({
                opacity: '1.0'
            }, 500);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            NProgress.done();
            container.html('<h4 style="margin-top:100px; margin-left: 40%; display:block; text-align:left"><i class="fa fa-warning txt-color-orangeDark"></i> Error 404! Page not found.</h4>');
        },
        async: true
    });

    //console.log("ajax request sent");
}
