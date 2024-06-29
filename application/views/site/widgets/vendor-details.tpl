<div>
    <div><b>Company Name : </b> {$vendor->companyName}</div>
    <div><b>Contact Person : </b> {$vendor->name}</div>
    <div class="no-wrap"><b>Mobile Number : </b> {$vendor->mobileNumber}</div>
    <div class="no-wrap"><b>Email : </b> {$vendor->email}</div>
    <div class="no-wrap"><b>Vendor Branch : </b> {$vendor->responsibleOrganization->name}</div>
    <div><b>Address : </b> {$vendor->vendorAddress->address1}, {$vendor->vendorAddress->address2}, {$vendor->vendorAddress->landmark}, {$vendor->vendorAddress->station->name} - {$vendor->vendorAddress->pincode}</div>

    <hr>

    <div><b>Advance Balance</b> <i class="fa fa-inr"></i> {$vendor_balance->advanceAmountBalance|inr_format}</div>
    <div><b>Balance</b> <i class="fa fa-inr"></i> {$vendor_balance->currentBalance|inr_format}</div>
</div>
