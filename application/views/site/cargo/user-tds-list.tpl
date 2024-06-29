<div class="table-responsive">
    <table id="usr_tds_table" class="table table-striped">
        <thead>
            <tr>
                <th>Effective From</th>
                <th>TDS</th>
                <th>PAN Number</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody class="tds body_table">
            {if $tds->tdsTaxValue}
                <tr>
                    <td>{$tds->fromDate|date_format:$ns_date_format}</td>
                    <td>{$tds->tdsTaxValue}</td>
                    <td>{$tds->panCardCode}</td>
                    <td>
                        <a class='btn btn-default btn-xs'  title='delete' onclick="deleteUserTds('{$tds->user->code}')">
                            <i class='fa fa-trash'></i>
                        </a>
                    </td>
                </tr>
            {else}
                <tr>
                    <td colspan="4" align="center">No TDS configured</td>
                </tr>
            {/if}
        </tbody>
    </table>
</div>

<script>
    var userTDSData = {$tds|json_encode}
</script>
