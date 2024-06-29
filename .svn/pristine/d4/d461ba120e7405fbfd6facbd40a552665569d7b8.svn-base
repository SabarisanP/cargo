
<div id="main-content">

    <div class="container">
        <div class="row">
            <div id="content" class="col-lg-12">
                <!-- PAGE HEADER-->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-header">
                            <!-- STYLER -->

                            <!-- /STYLER -->

                            <div class="clearfix">
                                <h3 class="content-title pull-left">Station Points Mapping</h3>
                            </div>

                        </div>
                    </div>
                </div>
                <!-- /PAGE HEADER -->

                <div class="panel panel-default">
                    <div class="panel-body">


                        <div id="result-panel">
                          
                            <div class="row">
                               <div class="col-md-3">
                                    <div class="bold">My Stations</div>
                                    <div class="small">Click any station bellow to get station points to add</div>
                                    <div class="align-center" id="action-status"></div>
                                    <div id="ab-stations">
                                        {if $stations|count==0}
                                            <div> Sorry! No stations were added in your account <a href="{$base_url}config/stations-mapping"> Click here</a> to add stations</div>
                                        {else}
                                        <div class="slider-content">
                                            <ul class="list-unstyled">
                                            {foreach item=alpha from=$atoz}
                                                {if $stations[$alpha]|count>0}    
                                                <li id="{$alpha|lower}"><a name="{$alpha|lower}" class="title">{$alpha|upper}</a>
                                                <ul class="list-unstyled">
                                                {foreach item=station from=$stations[$alpha]}
                                                    <li id="ns-{$station.code}" >
                                                        <div class="fl">
                                                            <a title="View station points" href="javascript:;" onclick='buildStationPointMappingList("{$station.code}")'>{$station.name}</a>
                                                        </div>
                                                    </li>
                                                {/foreach}
                                                </ul>
                                                {/if}
                                            {/foreach}
                                            </ul>
                                        </div>
                                        {/if}    
                                    </div>
                                </div>
                               
                                
                                <div class="col-md-3">
                                    <div class="bold">My Stations Points</div>
                                    <div class="align-center" id="action-status"></div>
                                    <div id="namespace">

                                    </div>
                                </div>
                                <div class="col-md-2">&nbsp;</div>          
                                
                                <div class="col-md-3 hide" id="master-sp-list">    
                                    <div class="bold">Master Station Points List</div>
                                    <div class="align-center" id="action-status"></div>
                                    <div id="address-book">
                                        
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>

            </div><!-- /CONTENT-->
        </div>
    </div>
</div>
<script>
    jQuery(document).ready(function() {
        //App.setPage("address_book");  //Set current page
        App.init(); //Initialise plugins and elements

        //_getNamespaceStation('station-point-list', 'dropdown', 'sel_state_id', '', '');
    });
</script>
