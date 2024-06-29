<link rel="stylesheet" href="assets/lib/magnific-popup/magnific-popup.css">    
<div class="row">
    <div class="col-md-2">
        <select id="sch-gal-id" class="form-control" onchange="getScheduleGalleryPhotos();">
            <option value="">Select a gallery</option>
            {foreach from=$gallery item=row}
                <option value="{$row->code}" {if $schgal[0]->code==$row->code} selected="" {/if}>{$row->name}</option>
            {/foreach}    
        </select>
    </div>
    <div class="col-md-2">
        <a href="javascript:;" class="btn btn-sm btn-success" onclick="saveScheduleGallery({});" >Assign</a>
    </div>
     <div class="col-md-3">
         <div id="save-gallery-state"></div>
    </div> 
    <input type="hidden" value="" />
</div>
<br>     
<div class="row">
    <div id="sch-gallery-photos" class="col-md-12">
        <div class="well well-sm">Please select a gallery to view photos</div>
    </div>
</div>
    