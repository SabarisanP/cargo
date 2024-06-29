<div class="table-responsive">
    <table id="dt_basic" class="table table-striped">
        <thead>
            <tr>
                <th>#</th>
                <th>Stations</th>
                <th>Station Code</th>
                <th>API Enabled</th>
                <th>Status</th>
                <th class="t_a_c">Action</th>
            </tr>
        </thead>
        <tbody>

            {foreach item=station name=l from=$stations}
                <tr id='st-{$station.code}'>
                    <td>{$smarty.foreach.l.index+1}</td>
                    <td>{$station.name}</td>
                    <td>{$station.code}</td>
                    <td>
                        {if $station.apiFlag==1}Yes{else}No{/if}
                    </td>
                    <td>{if $station.activeFlag==1}<span class="label label-success" id="lb-{$station.code}">Active</span>{else}<span id="lb-{$station.code}" class="label label-danger">Disable</span>{/if}</td>
                    <td align="center"> 
                        <div class="btn-group btn-group-xs">
                            {if $station.latitude != ''}
                                <a title="Map" class="btn btn-default btn-sm" id='station-map-{$station.code}'  href="https://maps.google.com/?q={$station.latitude},{$station.longitude}" target="_blank"><i class="fa fa-map-marker" aria-hidden="true"></i></a>
                            {/if}
                            {if $action_rights['SM-DISABLE']>0}  <a  class="btn btn-default btn-sm"  href="javascript:;" {if $action_rights['SM-DISABLE']!=2}onclick='editStationStatus({$station|json_encode})'{/if}>
                                    {if $station.activeFlag==1}
                                        <i class="fa fa-times" id="sta-{$station.code}" data-status="0" title="Click to disable"></i>
                                    {else}
                                        <i class="fa fa-check" id="sta-{$station.code}" data-status="1" title="Click to enable"></i>
                                    {/if}
                                </a>{/if}
                                {if $action_rights['SM-EDIT']>0}    <a title="Edit" class="btn btn-default btn-sm" {if $station.activeFlag==0}style='display:none'{/if} id='station-edit-list-{$station.code}'  href="javascript:;" {if $action_rights['SM-EDIT']!=2}onclick='editStation({$station|json_encode})'{/if}><i class="fa fa-pencil igreen"></i></a>{/if}
                                {if $action_rights['SM-DELETE']>0}   <a title="Delete" class="btn btn-default btn-sm" href="javascript:;" {if $action_rights['SM-DELETE']!=2}onclick='deleteStation({$station|json_encode})'{/if}><i class="fa fa-trash-o ired"></i></a>{/if}
                            </div>
                        </td>
                    </tr>
                    {/foreach}    
                    </tbody>
                </table>
            </div>

            <script>
                var table = $('#dt_basic').dataTable({
                    "aaSorting": [[1, "asc"]]
                });

            </script>