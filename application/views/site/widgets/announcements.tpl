<div>
    <div id="advertisement-panel">
        <div id="carousel-advertisement" class="carousel slide" data-ride="carousel">
            {assign var="slidecount" value=0}
            <div class="carousel-inner" role="listbox">
                {foreach from=$banners item=$banner}
                    {if $banner->displayModel != 'A'}
                        {continue}
                    {/if}
                    {foreach from=$banner->bannerDetails item=detail key=k}
                        <div class="item {if $slidecount == 0}active{/if}">
                            <a href="{$detail->redirectUrl|default:'javascript:;'}" target="_blank">
                                <img src="{$detail->url|replace:'[##]':'image'}" alt="{$detail->alternateText}" width="100%">
                            </a>
                        </div>
                        {assign var="slidecount" value=($slidecount + 1)}
                    {/foreach}
                {/foreach}
            </div>

            {* {if $slidecount > 1}
                <a class="left carousel-control" href="#carousel-advertisement" role="button" data-slide="prev">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="30" height="30" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 20 20"><path d="M13.891 17.418a.697.697 0 0 1 0 .979a.68.68 0 0 1-.969 0l-7.83-7.908a.697.697 0 0 1 0-.979l7.83-7.908a.68.68 0 0 1 .969 0a.697.697 0 0 1 0 .979L6.75 10l7.141 7.418z" fill="#000"/></svg>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel-advertisement" role="button" data-slide="next">
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="30" height="30" style="-ms-transform: rotate(180deg); -webkit-transform: rotate(180deg); transform: rotate(180deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 20 20"><path d="M13.891 17.418a.697.697 0 0 1 0 .979a.68.68 0 0 1-.969 0l-7.83-7.908a.697.697 0 0 1 0-.979l7.83-7.908a.68.68 0 0 1 .969 0a.697.697 0 0 1 0 .979L6.75 10l7.141 7.418z" fill="#000"/></svg>
                    <span class="sr-only">Next</span>
                </a>               
            {/if} *}
        </div>

        <script>
            $(function () {
                $('#carousel-advertisement').carousel({ interval: 5000 });
            });
        </script>
        <br>
        <br>
    </div>

    <div id="announcement-panel" class="panel panel-default">
        <div id="carousel-announcement" class="carousel slide" data-ride="carousel">
            {assign var="slidecount" value=0}
            <div class="carousel-inner" role="listbox">
                {foreach from=$banners item=$banner}
                    {if $banner->displayModel != 'N'}
                        {continue}
                    {/if}
                    <div class="item {if $slidecount == 0}active{/if}">
                        <div class="title label label-danger bold" style="background-color: #{$banner->color}!important">{$banner->name}</div>
                        <div class="pull-right text-muted">{date('jS F Y h:i A', strtotime($banner->updatedAt))}</div>
                        <div class="body-panel">
                            {foreach from=$banner->bannerDetails item=detail key=k}
                                
                                    <div class="subtext" type="button" data-toggle="modal" data-target="#modal-{$detail->code}" title="Click to view more details" style="cursor: pointer;">
                                        {if $detail->messageType->code == 'IMAGE'}
                                            <img class="dash-announcement-image" src="{$detail->url|replace:'[##]':'image'}" alt="{$detail->alternateText}" height="150px">
                                        {else}                                                
                                            {$detail->alternateText}
                                        {/if}
                                    </div>

                                    <div class="modal modal-announcement fade" id="modal-{$detail->code}" tabindex="-1" data-keyboard="false" data-backdrop="static" aria-labelledby="myModalLabel">
                                        <div class="modal-dialog modal-centered modal-lg" style="padding-top: 5%;">
                                            <div class="modal-content  last-active" style="    border-radius: 12px;">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times-circle fa-lg"></i></button>
                                                    <span class="label label-danger bold">{$banner->name}</span>
                                                </div>
                                                <div class="modal-body" style="white-space: normal;">
                                                    {if $detail->messageType->code == 'IMAGE'}
                                                        <img class="dash-announcement-image1" src="{$detail->url|replace:'[##]':'image'}" alt="{$detail->alternateText}">
                                                    {else}                                                
                                                        {$detail->alternateText}
                                                    {/if}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                
                                {assign var="slidecount" value=($slidecount + 1)}
                            {/foreach}
                        </div>
                    </div>
                {/foreach}
            </div>

            {if $slidecount > 1}
                <a class="left carousel-control" href="#carousel-announcement" role="button" data-slide="prev">
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="30" height="30" style="-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); transform: rotate(360deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 20 20"><path d="M13.891 17.418a.697.697 0 0 1 0 .979a.68.68 0 0 1-.969 0l-7.83-7.908a.697.697 0 0 1 0-.979l7.83-7.908a.68.68 0 0 1 .969 0a.697.697 0 0 1 0 .979L6.75 10l7.141 7.418z" fill="#999"/></svg>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel-announcement" role="button" data-slide="next">
                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" focusable="false" width="30" height="30" style="-ms-transform: rotate(180deg); -webkit-transform: rotate(180deg); transform: rotate(180deg);" preserveAspectRatio="xMidYMid meet" viewBox="0 0 20 20"><path d="M13.891 17.418a.697.697 0 0 1 0 .979a.68.68 0 0 1-.969 0l-7.83-7.908a.697.697 0 0 1 0-.979l7.83-7.908a.68.68 0 0 1 .969 0a.697.697 0 0 1 0 .979L6.75 10l7.141 7.418z" fill="#999"/></svg>
                    <span class="sr-only">Next</span>
                </a>                
            {/if}
        </div>

        <script>
            $(function () {

                $('#carousel-announcement, #carousel-advertisement').on('slide.bs.carousel', function (e) {
                    if ($('.modal-announcement').hasClass('in')) {
                        e.preventDefault();
                        return;
                    }
                    $('.modal-announcement.in').modal('hide')
                })
            });
        </script>
    </div>
</div>