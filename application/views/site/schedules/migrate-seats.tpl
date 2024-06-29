<div class="row">
    <div class="col-md-5" >
        {if $mismatch|@count > 0}
            <table class="table" id="migrate-mismatch" width="100%">
                <tr>
                    <th align="center">PNR</th>
                    <th align="center">Seat</th>
                    <th align="center"></th>
                </tr>
                {foreach key=key from=$mismatch item=row}
                    <tr id="tr-{$key}">
                        <td>{$key}</td>
                        <td>
                            {foreach from=$row item=pnr}
                                {$pnr->seatName}({$pnr->gender}),
                            {/foreach}
                        </td>
                        <td>
                            <a href="javascript:;" onclick='migratePNRSeats({$row|json_encode|escape},"{$key}");'> <i class="fa fa-pencil fa-lg"></i></a>
                        </td>
                    </tr>
                {/foreach}
            </table>
        {else}
            <div class="well well-large "> No Seats found !</div>
        {/if}
    </div>
    <div class="col-md-7" id="busmap-cont-well">
        <div class="well well-large text-center"> Please click edit to migrate seats to new layout !</div>
    </div>
    <div class="col-md-7 hide" id="busmap-cont"></div>
</div>
<input type="hidden" id="migrate-tripcode" value="{$trip->tripCode}">
