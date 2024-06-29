<table class="" width="99%" border="1">
    <tr>
        <td colspan="2" align="center"><b>Mobile APP Customers</b></td>
    </tr>
</table> 
<br/>
<table border="1">
    <thead>
        <tr style="background-color:#64b92a; color: #fff;">
            <th align="center">Name</th>
            <th align="center">Mobile</th>
        </tr>
    </thead>
    <tbody>
        {foreach item=row from=$result key=t}
            <tr>
                <td align="left">{$row->first_name} {$row->last_name}</td>
                <td align="left">{$row->mobile}</td>
            </tr>
        {foreachelse}
            <tr><td colspan="2" align="center">No data available</td><tr>
        {/foreach}
    </tbody>
</table>