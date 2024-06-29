<div class="table-responsive">
<table id="cargo_vendor_table" class="table table-bordered table-hover" width="100%" border="1">
     <thead >
         <tr class="success">
             <th>#</th>
             <th >Company Name</th>
             <th >Contact Person</th>
             <th>Mobile Number</th>
             <th>Email</th>
             <th>City</th>
             <th>Vendor Branch</th>
             <th>GST</th>
             <th>Organization</th>
         </tr>
     </thead>
     <tbody class="body_table">
         {foreach item=row from=$vendors key=k}
             <tr id='item_{$row->code}' class="point_cur" onclick="view('{$row->code}')">
                 <td>{$k+1}</td>
                 <td>
                     {if $row->shortCode !='NA'}
                         {$row->companyName}&nbsp;
                     {else}
                         {$row->companyName}&nbsp;&nbsp;&nbsp;
                     {/if}
                 </td>
                 <td>{$row->name}</td>
                 <td>{$row->mobileNumber}</td>
                 <td>
                    {$row->email}
                </td>
                 <td>{$row->station->name}</td>
                 <td>{$row->responsibleOrganization->name}</td>
                 <td align="left">{$row->gst}</td>
                 <td>
                     <a id="popup_msg" data-content='<ul class="p_l_15">
                         {foreach from=$row->organization item=desc}
                             <li>{$desc->name|replace:"'":'"'}</li>
                         {/foreach}
                         </ul>'
                         {if $row->organization}
                             {foreach from=$row->organization item=desc}
                                 {$desc->name}
                                 {break}
                             {/foreach}
                             <span class="badge badge-info">{$row->organization|@count}</span>
                         {else}
                             All Branch
                         {/if}
                     </a>
                 </td>
                
             </tr>
         <div id="notify_mes_{$row->code}" style="display:none">{$row->description}</div>
         {/foreach}
    </tbody>
 </table>
</div>