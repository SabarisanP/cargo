<table class="" width="99%" border='1'>
    <tr>
        <td colspan="4" align="center"><span style="font-weight:bold">Cargo Items List</span></td>
    </tr>
    <tr>
        <td width="50%" align="right" colspan="2"><span style="font-weight:bold">Report At : </span> {$smarty.now|date_format:$ns_datetime_format}</td>
        <td width="50%" align="right" colspan="2"><span style="font-weight:bold">Report By : </span> {$usr_login_name} </td>
    </tr>
</table>
<br />
<div class="table-responsive col-md-5 p_l_n">
    <table border='1'>
        <thead>
            <tr style="background-color: #64b92a; color: #fff;">
                <th>S.No</th>
                <th>Name</th>
                <th>Description</th>
                <th>Default Handling Rate</th>
                <th>Default Rate</th>
                <th>Minimum Freight Amount</th>
            </tr>
        </thead>
        <tbody>
            {foreach item=row from=$items key=i}
                <tr>
                    <td align="left">{$i+1}</td>
                    <td align="left">{$row->name}</td>
                    <td align="left">
                        {if $row->description|count > 0}
                            {foreach from=$row->description item=desc key=k}
                                {$k+1}.&nbsp;{$desc}<br/>
                            {/foreach}
                        {else}
                        -
                        {/if}
                    </td>
                    <td align="right">{$row->defaultHandlingRate|inr_format}</td>
                    <td align="right">{$row->defaultRate|inr_format}</td>
                    <td align="right">{$row->minFreightAmount|inr_format}</td>
                </tr>
            {foreachelse}
                <tr>
                    <td colspan="5" align="center">No Records Found</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
</div>