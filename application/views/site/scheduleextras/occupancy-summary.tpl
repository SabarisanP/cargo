<style>
    .DTFC_LeftBodyLiner table { background-color: #ffffff;}
    .DTFC_LeftBodyLiner table thead tr { height:4px !important; }
    .DTFC_LeftBodyLiner table thead tr th{ display: none; }
    .dataTables_wrapper .well{ display: none; }
    .dayhighlight { background-color: #e6edf3; }
</style>
<table class="table table-hover nowrap" id='sch-occupancy-table'>
    <thead>
        <tr class="success1">
            <th>Schedule</th>  
            {foreach from=$meta[$schedulecode]['trips'] item=trip key=date}            
            <th nowrap='nowrap' align="center">
                {$date|date_format:"%d %b"} <br>
                <span {if $trip['hg']==1}class="warning-text" {/if} >{$date|date_format:"%a"}</span>
            </th>
            {/foreach}
        </tr>   
    </thead>
    <tbody>
        {foreach from=$meta item=sch key=schcode}                       
            <tr>
                <td nowrap='nowrap'>
                    {$sch['nm']} <br>
                    <span class="warning-text">{$sch['sn']}</span>, {$sch['ts']} seats
                </td>
                {foreach from=$meta[$schedulecode]['trips'] item=trip key=date}
                    <td align="center" style="border-left: {if $sch['trips'][$date]['ddif']==0} 3px solid #368ee0 !important;{else}1px dashed #ccc;{/if} " {if $sch['trips'][$date]['hg']==1} class="dayhighlight" {/if} >
                        {if $sch['trips'][$date]['cnt'] !== '-'}
                        <a href="javascript:;" class="trip-popover" data-tripcode="{$sch['trips'][$date]['tc']}"> 
                        {/if}
                            <span class="
                              {if $sch['trips'][$date]['ro'] > 0 && $sch['trips'][$date]['ro'] <= 19} 
                                  badge badge-default 
                              {else if $sch['trips'][$date]['ro'] >= 20 && $sch['trips'][$date]['ro'] <= 50}
                                  badge badge-warning 
                              {else if $sch['trips'][$date]['ro'] >= 51 && $sch['trips'][$date]['ro'] <= 70}
                                  badge badge-info 
                              {else if $sch['trips'][$date]['ro'] >= 71}
                                  badge badge-success
                              {/if}
                              " title="{$sch['trips'][$date]['ro']}%"> {$sch['trips'][$date]['cnt']} </span>
                        {if $sch['trips'][$date]['cnt'] != '-'}      
                        </a>
                        {/if}
                    </td>
                {/foreach}
            </tr>
        {/foreach}
    </tbody>
</table>
    
<script>
    var responsetime = "{$response_datetime}";
    $('#responsetime').html('(As on ' + responsetime + ')');        
    $(document).ready(function () {
        var table = $('#sch-occupancy-table').DataTable({            
            scrollY: "550px",
            scrollX: true,
            scrollCollapse: true,
            searching: false,
            paging: false,
            ordering: false,
            info: false
        });
        
        new $.fn.dataTable.FixedColumns( table, {
            leftColumns: 1
	} );
    });
    
    $('.trip-popover').each( function(){
        $(this).popover({
            container:'body',
            content:loading_popup,
            html:true,
            placement:'auto right',
            trigger:'click',
        });

        $(this).on('show.bs.popover', function () {
            var ele = this;
            var data = {};
            data.tc = $(this).attr('data-tripcode');
            $.ajax({
                type: "POST",
                dataType: 'html',
                url: base_url + "scheduleextras/get-occupancy-trip-fare",
                data: data,
                success: function (response) {
                    $(ele).popover('destroy').popover({
                        container:'body',
                        content:response,
                        html:true,
                        placement:'auto right',
                        trigger:'focus',
                    }).popover('show');
                    
                    ga_track_event('All Schedule Trends', 'View Trip Fare', "View single trip fare");
                }
            });
        })
    });
</script>    