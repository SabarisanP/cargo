<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

// get namespace from session
$CI = &get_instance();
$CI->load->library('session');
$config['namespace_id'] = $namespace = $CI->session->userdata('namespace_id');
$idiom = 'english';

$CI->load->library('lang');
$CI->lang->load('default', $idiom);

if (file_exists(APPPATH . "language/{$idiom}/{$namespace}_lang.php")) {
    $CI->lang->load($namespace, $idiom);
}
function translate($name) {
    $CI = &get_instance();
    return $CI->lang->line($name);
}


$config['ticket_payment_gateway_respone_url'] = $config['base_url'].'#search/confimation-payment';

$config['super_namespace'] = array('cargo', 'rmtcargo', 'citycargo', 'seenucargo');
$config['super_users'] = array('URF2EJ179','URF156142');


$config['environment'] = 'PROD';
$config['product'] = 'cargo';
$config['zone'] = 'rmtcargo';
$config['allow_data_log'] = TRUE;

if($config['environment'] == 'PROD') {   // for production env
    $config['pg_forward_url']['tattravels'] = 'http://payment.tattravels.com/payment/forward';
    $config['pg_forward_url']['sreejothi'] = 'https://payment.sreejothitravels.in/forward';
    $config['pg_forward_url']['parveen'] = 'https://payment.parveentravels.com/forward';
    $config['pg_forward_url']['default'] = 'http://payment.ezeebits.com/forward';
    $config['ns_properties_url'] = 'http://bits.config.ezeebits.com/';
    $config['pdf_generator_url'] = 'https://mailer.ezeebits.com/pdf.php';
    $config['mailer_url'] = 'https://mailer.ezeebits.com/send.php';
    $config['gallery_loc'] = '/gallery';

    if($config['zone'] == 'bits') { // bits
        $config['product_domain']['bits'] = 'https://ticket.ezeebits.com';
        $config['product_domain']['cargo'] = 'https://cargo.ezeebits.com';
        $config['product_domain']['busbuddy'] = 'http://pobapi.ezeebits.com';
    } elseif($config['zone'] == 'r2bits') { // r2 bits
        $config['product_domain']['bits'] = 'https://r2.ezeebits.com';
        $config['product_domain']['cargo'] = 'https://cargo-r2.ezeebits.com';
        $config['product_domain']['busbuddy'] = 'http://pobapi.ezeebits.com';
    } elseif($config['zone'] == 'tatbits') {  // TAT Travels
        $config['product_domain']['bits'] = 'https://tattravels.ezeebits.com';
        $config['product_domain']['cargo'] = 'https://tatcargo.ezeebits.com';
        $config['product_domain']['busbuddy'] = 'http://pobapi.tattravels.com';
    } elseif($config['zone'] == 'ybmbits') {  // YBM Travels
        $config['product_domain']['bits'] = 'https://ybmtravels.ezeebits.com';
        $config['product_domain']['cargo'] = 'https://ybmcargo.ezeebits.com';
        $config['product_domain']['busbuddy'] = 'http://pobapi.ybmtravels.in/';
    } elseif($config['zone'] == 'evacaybits') {   //  Evacay
        $config['product_domain']['bits'] = 'https://evacay.ezeebits.com';
        $config['product_domain']['cargo'] = 'https://evacaycargo.ezeebits.com';
        $config['product_domain']['busbuddy'] = 'http://pobapi.evacaybus.com';
    } elseif($config['zone'] == 'sbltbits') {  //  SBLT
        $config['product_domain']['bits'] = 'https://sblt.ezeebits.com';
        $config['product_domain']['cargo'] = 'https://cargo.ezeebits.com';
        $config['product_domain']['busbuddy'] = 'http://pobapi.sbltbus.com';
    } elseif($config['zone'] == 'svrtbits') {  //  Sri Venkata Ramana
        $config['product_domain']['bits'] = 'https://srivenkataramana.ezeebits.com';
        $config['product_domain']['cargo'] = 'https://cargo.ezeebits.com';
        $config['product_domain']['busbuddy'] = 'http://pobapi.ezeebits.com';
    } elseif($config['zone'] == 'tranzkingbits') {  //  Tranzking
        $config['product_domain']['bits'] = 'https://tranzking.ezeebits.com';
        $config['product_domain']['cargo'] = 'https://tranzking-cargo.ezeebits.com';
        $config['product_domain']['busbuddy'] = 'http://pobapi.tranzking.com';
    } elseif($config['zone'] == 'parveenbits') {  //  Parveen
        $config['product_domain']['bits'] = 'https://parveen.ezeebits.com';
        $config['product_domain']['cargo'] = 'https://parveen-cargo.ezeebits.com';
        $config['product_domain']['busbuddy'] = 'http://pobapi.parveentravels.in';
    } elseif($config['zone'] == 'srmbits') {  //  SRM
        $config['product_domain']['bits'] = 'https://srm.ezeebits.com';
        $config['product_domain']['cargo'] = 'https://srm.ezeecargo.com';
        $config['product_domain']['busbuddy'] = 'http://pobapi.srmtransports.net';
    }

    $config['product_domain']['gps'] = 'https://www.trackbus.in';
    $config['product_domain']['wallet'] = 'https://wallet.ezeebits.com/';
    $config['product_domain']['analytics'] = 'https://analytics.ezeebits.com/';
    $config['product_domain']['trackingui'] = 'https://m.trackbus.in';
} else { // local env
    $config['pg_forward_url']['tattravels'] = 'http://localhost/customerportal/trunk/tattravels/payment/forward';
    $config['pg_forward_url']['sreejothi'] = 'http://payment.sreejothitravels.com/forward';
    $config['pg_forward_url']['default'] = 'http://payment.ezeebits.com/forward';
    $config['ns_properties_url'] = 'http://localhost/customerportal/trunk/namespaceconfig/json/';
    $config['pdf_generator_url'] = 'https://mailer.ezeebits.com/pdf.php';
    $config['mailer_url'] = 'http://localhost/customerportal/trunk/mailer/send.php';
    $config['gallery_loc'] = '/gallery';

    $config['product_domain'] = array(
        'bits' => 'http://localhost/bits',
        'cargo' => 'http://localhost/cargo/trunk/ui',
        'gps' => 'http://localhost/geotrack',
        'wallet' => 'http://localhost/customerportal/trunk/wallet',
        'analytics' => 'https://analytics.ezeebits.com',
        'busbuddy' => 'http://pobapi.ezeebits.com',
        'trackingui' => 'https://m.trackbus.in',
    );
}

$config['dms_domain'] = 'https://dms.eics.in';
$config['web_cdn_url'] = 'https://web.cdn.ezeebus.com';
$config['whatsapp_send_url'] = 'https://api.whatsapp.com/send';
$config['vertex_domain']        = 'https://vertex.ezeeinfo.in';

// for slug detals
$config['access_token'] = 'HXXJFEHP79Q69NZP';

// For Desktop App
$config['operator_dashboard_domain']['cargo']['cargo'] = 'ezeecargo.com';

$config['payment_type_ticket_booking'] = 'TICKBO';
$config['payment_type_ticket_cancel'] = 'TICKCA';
$config['payment_type_recharge'] = 'RECHG';
$config['payment_type_operator_payment'] = 'OPPAY';

$config['ticket_status'] = array(
    'BO' => array('icon-class' => 'fa-ticket', 'name' => 'Confirm Booked', 'icon-bg-class' => 'btn-success'),
    'BL' => array('icon-class' => 'fa-eye-slash', 'name' => 'Temp Blocked Ticket', 'icon-bg-class' => 'btn-primary'),
    'CA' => array('icon-class' => 'fa-times', 'name' => 'Ticket / Seat Cancelled', 'icon-bg-class' => 'btn-danger'),
    'PBL' => array('icon-class' => 'fa-phone', 'name' => 'Phone Booked', 'icon-bg-class' => 'btn-primary'),
    'PBC' => array('icon-class' => 'fa-times', 'name' => 'Phone Book Cancelled', 'icon-bg-class' => 'btn-danger'),
    'TCAI' => array('icon-class' => 'fa-times', 'name' => 'Trip Cancel Initiated', 'icon-bg-class' => 'btn-danger'),
    'TCA' => array('icon-class' => 'fa-ban', 'name' => 'Trip Cancelled', 'icon-bg-class' => 'btn-danger'),
    'PPOH' => array('icon-class' => 'ion-android-timer', 'name' => 'Pending Order put on Hold by Admin', 'icon-bg-class' => 'btn-info'),
    'POCA' => array('icon-class' => 'fa-times', 'name' => 'Pending Order Cancelled by Admin', 'icon-bg-class' => 'btn-danger'),
    'BLCA' => array('icon-class' => 'fa-ban', 'name' => 'Tentative Booking, Force released', 'icon-bg-class' => 'btn-danger'),
);
$config['sms_type'] = array(
    'TCAN' => 'Trip Cancelled',
    'TDELAY' => 'Trip Delay',
    'TEARLY' => 'Trip Early',
    'TBPC' => 'Boarding Point Change',
    'RSNDGPSHJ' => 'Resend : GPS / Happy Journey'
);

$config['api_sms_type'] = array(
    'TCAN' => 'TRIP_CANCEL',
    'TDELAY' => 'TRIP_DELAY',
    'TEARLY' => 'TRIP_EARLY',
    'TBPC' => 'STATION_POINT_CHANGE',
    'RSNDGPSHJ' => 'RESEND_TRACKING'
);

$config['sms_type_reasons'] = array(
    'TDELAY' => array(
        '1' => 'Heavy traffic',
        '2' => 'Heavy rain',
        '3' => 'Mechanical problem',
        '4' => 'Unrest situation',
    ),
    'TEARLY' => array(
        '1' => 'Heavy traffic',
        '2' => 'Avoid traffic',
        '3' => 'Unrest situation',
    ),
    'TCAN' => array(
        '1' => 'Vehicle damaged',
        '2' => 'Mechanical problem',
        '3' => 'Unrest situation in state',
        '4' => 'No service',
    ),
    'TBPC' => array(
        '1' => 'Heavy traffic',
        '2' => 'Heavy rain',
        '3' => 'Route change'
    ),
);

$config['transaction_mode'] = array(
    'CASH' => 'Cash Payment',
    'NBK' => 'Netbanking / Bank Transfer',
    // 'CCD' => 'Credit Card',
    // 'PPAID' => 'Pre paid Account',
    'UPI' => 'UPI Payment',
    'CHEQUE' => 'Cheque',
    'CRDT' => 'Credit Payment',
);

$config['transaction_type'] = array(
    'TICKBO' => 'Ticket Booking',
    'TICKCA' => 'Ticket Cancel',
    'CGRECHG' => 'Recharge',
    'RVREPT' => 'Revoke Receipt',
    'OPPAY' => 'Payment to Opeator Account',
    'CGPAVR ' => 'Payment Voucher'
);

$config['sms_notification_type'] = array(
    'CGBOF' => 'Cargo Booking - From',
    'CGBOT' => 'Cargo Booking - To',
    'CGUL' => 'Cargo Unload',
    'CGCA' => 'Cargo Cancel',
    'CGDY' => 'Cargo Delivery',
    'OTP' => 'OTP Message',
    'DYOTP' => 'Delivery OTP Message',
    'ONREC' => 'Online Recharge',
    'CGED' => 'Cargo Edit',
    'FSMS' => 'Failure SMS Notification',
    'OACS' => 'Overall Occupancy Summary',
    'CGBV' => 'Cargo Booking '.translate('Vendor'),
    'CGBVMV' => 'Cargo '.translate('Vendor').' email verificaition',
    'CGSINV' => 'Cargo Subscription Invoice'
);

//vendor Category
$config['vendor_category'] = array(
    'CS' => 'Cash Customer',
    'WK' => 'Walkin Customer',
    'VB' => 'Valuable Customer',
    'RGL' => 'Regular Customer',
    'CRD' => 'Credit Customer',
    'MVB' => 'Most Valuable Customer'
);

$config['acknowledge_status'] = array(
    'INITD' => 'Initiated',
    'ACKED' => 'Acknowledged',
    'PAID' => 'Paid, Waiting for Ack',
    'RJECT' => 'Rejected',
);

$config['cargo_status'] = array(
    'CB' => 'Booked',
    'CL' => 'Loaded',
    'CUL' => 'Unloaded',
    'CD' => 'Delivered',
    'CUD' => 'Unable To Deliver',
    'CR' => 'Return',
    'CA' => 'Cancelled',
    'CMS' => 'Cargo Missing',
);

$config['cargo_prebook_status'] = array(
    'REQST' => 'Requested',
    'ACPTD' => 'Accepted',
    'LOAD' => 'Loaded',
    'UNLD' => 'Unloaded',
    'CNVTD' => 'Converted',
    'CANCL' => 'Cancelled',
);

$config['cargo_remarks_status'] = array(
    'CB' => 'Booking',
    'CL' => 'Loading',
    'CUL' => 'Unloading',
    'CD' => 'Delivering',
    'ADJST' => 'Adjustment Amount',
    'DRDLY' => 'Door Delivery Status',
    'PMRVT' => 'Payment Revert',
);

$config['cargo_payment_status'] = array(
    'PAD' => 'Paid',
    'TOP' => 'ToPay',
    'INP' => translate('INP'),
    'OATP' => translate('OATP'),
    'TPPAD' => 'ToPay then Paid',
    'WTOP' => 'Way To Pay',
    'FS' => 'Free Service'
);
$config['transaction_Mode'] = array(
    'CASH' => 'Cash Payment',
    'NBK' => 'Netbanking',
    'CCD' => 'Credit Card',
    'CHEQUE' => 'Cheque',
    'PGWAY' => 'PG Online',
    'PPAID' => 'Pre paid Account',
    'UPI' => 'UPI Payment',
    'ADV' => 'Advance Payment',
    'CRDT' => 'Credit Payment'
);

if ($config['namespace_id'] == 'rajeshcargo' || $config['namespace_id'] == 'rajeshexpress') {
    $config['cargo_payment_status']['FS'] = 'FOCS';
    $config['cargo_payment_status']['TPPAD'] = 'ToPay';
}
if ($config['namespace_id'] == 'rathimeenaparcel') {
    $config['cargo_payment_status']['TPPAD'] = 'ToPaid';
}

$config['cargo_payment_status_badge'] = array(
    'PAD' => 'badge-success',
    'TOP' => 'badge-danger',
    'FS' => 'badge-success',
    'INP' => 'badge-danger',
    'OATP' => 'badge-warning',
    'TPPAD' => 'badge-success',
    'WTOP' => 'badge-danger'
);

$config['cargo_edit_events'] = array(
    'CITM' => 'Item Amount Changed',
    'CUST' => 'Customer Edited',
    'STAN' => 'Station Edited',
    'ORGN' => 'Branch Edited',
    'VNDR' => 'On account Edited',
    'CGPMT' => 'Payment Type Edit',
    'PCDL' => 'Pickup / Delivery Edited',
    'CHGE' => 'Hamali / Pass / Docket Charge Edited',
    'GST' => 'GST Edited',
    'EINGST' => 'GST / Invoice / Ewaybill Edited',
    'CGCA' => 'Cancelled '.translate('lr')
);

$config['seat_types'] = array(
    'ABST' => 'All Seat Type',
    'SS' => 'Semi Sleeper',
    'SL' => 'Sleeper',
    'ST' => 'Seater',
    'USL' => 'Upper Sleeper',
    'LSL' => 'Lower Sleeper',
    'PB' => 'Pushback',
    'SUSL' => 'Single Upper Sleeper',
    'SLSL' => 'Single Lower Sleeper'
);

$config['refund_status'] = array(
    'INI' => 'Initiated',
    'REQ' => 'Request to bank',
    'PRO' => 'Processed',
    'RFAC' => 'Credited to account'
);

$config['trip_status'] = array(
    'TPO' => 'Open',
    'TPC' => 'Closed',
    'TPY' => 'Yet To Open',
    'NA' => 'NA'
);

$config['travel_status'] = array(
    'YETBOARD' => 'Yet To Board',
    'BOARDED' => 'Boarded',
    'NOTBOARDED' => 'Not Boarded',
    'TRAVELED' => 'Travelled',
    'NOTTRAVELED' => 'Not Travelled'
);

$config['discount_type'] = array(
    'SHDS' => 'Schedule Discount',
    'DSAMT' => 'Special Discount',
    'COUP' => 'Coupon Discount',
    'OFDS' => 'Walk-in Discount',
    'WACP' => 'Wallet Cash Coupon',
    'WARD' => 'Wallet Redeem'
);

$config['user_payment_type'] = array(
    'PRE' => 'Payment Pre Paid',
    'POT' => 'Payment Post Paid',
    'PGP' => 'Payment Gateway Pay',
    'ULTED' => 'Payment Unlimited'
);

$config['travel_stop_amenities'] = array(
    'Soft Drinks' => 'Soft Drinks',
    'Hot Drinks' => 'Hot Drinks',
    'Snacks' => 'Snacks',
    'Food' => 'Food',
    'Children Play Area' => 'Children Play Area'
);

$config['travel_stop_restroom'] = array(
    'Yes, Free to use',
    'Yes, Pay and use',
    'No'
);

$config['en_route_type'] = array(
    'OPST' => 'Open On Previous Stage Booked',
    'OOTT' => 'Open On Trip Time'
);

$config['addons_type'] = array(
    'TTCA' => 'Ticket Transfer Charges',
);
if($config['zone'] == "parveenbits") {
    $config['addons_type']['GGN'] = 'Go Green Donation';
}

$config['user_tags'] = array(
    'OFFUSR' => 'Offline User',
    'APIAB' => 'Abhibus',
    'APICB' => 'Cobota',
    'APIEZ' => 'EzeeInfo',
    'APIHM' => 'Herms',
    'APIPT' => 'Paytm',
    'APIRB' => 'Redbus',
    'APITG' => 'Ticketgoose',
    'APITY' => 'Travelyaari'
);

$config['article_unit'] = array(
    'NPPKG' => 'Fixed',
    'KG' => 'Kg',
    'VOL' => 'Volumetric',
    'QNTL' => 'Quintal',
    'TON' => 'TON',
);
if ($config['namespace_id'] == 'rajeshcargo' || $config['namespace_id'] == 'rajeshexpress') {
    $config['article_unit'] = array(
        'NPPKG' => 'Fixed Cost',
        'KG' => 'Weight'
    );
}
if ($config['namespace_id'] == 'sssparcel') {
    $config['article_unit'] = array(
        'NPPKG' => 'Nos',
        'KG' => 'Kg',
        'TON' => 'TON'
    );
}
if ($config['namespace_id'] == 'varahi') {
    $config['article_unit'] = array(
        'KG' => 'Kg',
        'VOL' => 'Volumetric',
        'NPPKG' => 'Fixed'
    );
}

$config['credit_debit'] = array(
    'DDr' => 'Direct Expense',
    'Dr' => 'Indirect Expense',
    'DCr' => 'Direct Income',
    'Cr' => 'Indirect Income'
);


$config['vehicle_brand'] = array(
    'Ashok Leyland',
    'BMW',
    'Bharat Benz',
    'Caravan',
    'Chevrolet',
    'Corona',
    'Eicher',
    'Elecher',
    'Fiat Ducato',
    'Force Motors',
    'Ford',
    'Honda',
    'Hyundai',
    'Indian Limouzines',
    'Innova',
    'Isuzu',
    'Jaguar',
    'Mahindra',
    'Maruti Suzuki',
    'Merceds Benz',
    'Mitsubishi',
    'Nissan',
    'PKN',
    'Renault',
    'SML',
    'Scania',
    'Sedan',
    'Sutluj',
    'Swaraj Mazda',
    'TATA',
    'Toyota',
    'Volkswagen',
    'Volvo',
    'Zire'
);

$config['visibility_type'] = array(
    'ACAT' => array('name' => 'Allocate', 'bg-class' => 'label-warning'),
    'HIDE' => array('name' => 'Block', 'bg-class' => 'label-danger'),
    'REL'  => array('name' => 'Release', 'bg-class' => 'label-success'),
    'EXPN' => array('name' => 'Exception', 'bg-class' => 'label-default')
);

if($config['zone'] == 'parveenbits') {
    $config['pb_release'] = array(
        '120' => 'Cancel 2 hrs before trip time',
        '180' => 'Cancel 3 hrs before trip time',
        '240' => 'Cancel 4 hrs before trip time',
        '300' => 'Cancel 5 hrs before trip time',
    );
} else {
    $config['pb_release'] = array(
        '0'   => 'Never Release',
        '-10' => 'Cancel in next 10 mins',
        '-20' => 'Cancel in next 20 mins',
        '180' => 'Cancel 3 hrs before trip time',
        '240' => 'Cancel 4 hrs before trip time',
        '300' => 'Cancel 5 hrs before trip time',
    );
}

$config['pay_type'] = array(
    'PAD' => 'Paid',
    'TOP' => 'ToPay',
    'INP' => translate('INP'),
    'OATP' => translate('OATP'),
    'WTOP' => 'Way To Pay',
    'FS' => 'Free Service'
);

if ($config['namespace_id'] == 'rajeshcargo' || $config['namespace_id'] == 'rajeshexpress') {
    $config['pay_type']['FS'] = 'FOCS';
}
$config['cargo_short_payment_status'] = array(
    'TOP' => 'TP',
    'TPPAD' => 'TPP',
    'INP' => 'IP',
    'OATP' => 'IPT',
    'PAD' => 'PD',
    'FS' => 'FS',
    'WTOP' => 'WP',
);

$config['alert_nitify_channel'] = array(
    'SMS' => 'SMS',
    'APP' => 'APP'
);

$config['breakeven_setting_type'] = array(
    'NA' => 'Day',
    'KM' => 'Kilometer',
    'SEAT' => 'Seat'
);

$config['branch_stock_status'] = array('CB', 'CL', 'CUL', 'INW', 'CMS'); // in lang

$config['user_accountable_type'] = array(
    'DEFAULT' => 'Default',
    'LOAD' => 'On loading',
    'DELIVERY' => 'On Delivery',
);

$config['delivery_type_codes'] = array(
    'DYSE' => 'Self Pickup',
    'DYDO' => 'Door Delivery',
    'PUSE' => 'Self Pickup',
    'PUDO' => 'Door Pickup',
    'PDDO' => 'Door Pickup and Delivery',
    'WAYDY' => 'Way Delivery',
);

$config['prebook_status'] = array(
    'REQST' => 'Requested',
    'ACPTD' => 'Accepted',
    'LOAD' => 'Loaded',
    'UNLD' => 'Unloaded',
    'CNVTD' => 'Converted',
    'CANCL' => 'Cancelled'
);

$config['billing_events'] = array(
    'load' => array('name' => 'Load Cargo', 'event' => '', 'menu' => 'MNI1UH3738'),
    'unload' => array('name' => 'UnLoad Cargo', 'event' => '', 'menu' => 'MNI3AF5444'),
    'local_transit' => array('name' => 'Local Transit', 'event' => '', 'menu' => 'MNJ5BE4181'),
    'delivery' => array('name' => 'Delivery', 'event' => '', 'menu' => 'MNK8G7J118'),
    'accounts' => array('name' => 'Accounts', 'event' => '', 'menu' => 'MNI4F8M54'),
    'find_lr' => array('name' => 'Find '.translate('lr'), 'event' => '', 'menu' => 'MNI3AF5343'),
    'new_booking' => array('name' => 'New Booking', 'event' => '', 'menu' => 'MNFCQK529'),
    'reports' => array('name' => 'Report', 'event' => '', 'menu' => 'MNFCR3311'),
    'privilege' => array('name' => 'Privilege', 'event' => '', 'menu' => 'MNE5VD45'),
    'disable_sms' => array('name' => 'Disable SMS', 'event' => '', 'menu' => 'MNL62IC132'),
    'disable_email' => array('name' => 'Disable Email', 'event' => '', 'menu' => 'MNL62ID133'),
    'disable_whatsapp' => array('name' => 'Disable Whatsapp', 'event' => '', 'menu' => 'MNL62IE134'),
    'disable_ezeebot' => array('name' => 'Disable EzeeBot', 'event' => '', 'menu' => 'MNL62IF135'),
);

$config['vertex_invoice_status'] = array(
    '1' => array('name' => 'Draft', 'bg_class' => ' badge badge-default'),
    '2' => array('name' => 'Pending Proforma', 'bg_class' => 'badge badge-secondary'),
    '3' => array('name' => 'Proforma', 'bg_class' => 'badge badge-warning'),
    '4'  => array('name' => 'Approved', 'bg_class' => 'badge badge-primary'),
    '5' => array('name' => 'Paid', 'bg_class' => 'badge badge-success'),
    '6' => array('name' => 'Void', 'bg_class' => 'badge badge-info')
);


$config['smtp_details'] = array(
    'protocol' => 'smtp',
    'smtp_host' => 'ssl://email-smtp.us-west-2.amazonaws.com',
    'smtp_user' => 'AKIAJI3RUEFCD3MPZS7Q',
    'smtp_pass' => 'Ao/PZzU82f5GO4ym/F4BgZ77O7auygIM+Nh49ed1RA/G',
    'smtp_port' => 465,
    'mailtype' => 'html'
);

$config['expense_category_type'] = array(
    'VEH' => 'Vehicle',
    'TRN' => 'Transit',
    'BRN' => 'Branch',
    'LR' => translate('lr'),
    'OT' => 'Others',
);

$config['addon_charges_type'] = array(
    'PODCH' => 'POD Charge',
    'DYCH' => 'Delivery Charge',
    'DMRCH' => 'Demurrage Charge',
    'RNDF' => 'Round Off',
    'TDSTAX' => 'TDS Tax',
    'INSUR' => 'Insurance Charge',
    'RFLAG' =>'Referral Agent',
);

$config['proof_document_type'] = array(
    'ADHR' => 'Aadhaar Card',
    'VTR' => 'Voter ID',
    'PAN' => ' PAN Card',
    'RTN' => 'Ration Card',
    'DRVLIC' => 'Driving License',
    'PSPRT' => 'Passport',
);

$config['ewaybill_supply_type'] = array(
    'I' => 'Inward',
    'O' => 'Outward'
);

$config['ewaybill_sub_supply_type'] = array(
    '1' => 'Supply',
    '2' => 'Import',
    '3' => 'Export',
    '4' => 'Job Work',
    '5' => 'For Own Use',
    '6' => 'Job work Returns',
    '7' => 'Sales Return',
    '8' => 'Others',
    '9' => 'SKD/CKD',
    '10' => 'Line Sales',
    '11' => 'Recipient Not Known',
    '12' => 'Exhibition or Fairs',
);

$config['ewaybill_document_type'] = array(
    'INV' => 'Tax Invoice',
    'BIL' => 'Bill of Supply',
    'BOE' => 'Bill of Entry',
    'CHL' => 'Delivery Challan',
    'CNT' => 'Credit Note',
    'OTH' => 'Others',
);

$config['ewaybill_transportation_mode'] = array(
    '1' => 'Road',
    '2' => 'Rail',
    '3' => 'Air',
    '4' => 'Ship',
    '5' => 'inTransit',
);

$config['ewaybill_transaction_type'] = array(
    '1' => 'Regular',
    '2' => 'Bill To - Ship To',
    '3' => 'Bill From - Dispatch From',
    '4' => 'Combination of 2 and 3',
);

$config['payment_receipt_type'] = array(
    'COLN' => 'Inward Receipt',
    'CRNT' => 'Credit Note',
    'PAY' => 'Debit Note',
    'RVRCPT' => 'Revert Receipt',
);

$config['delivery_report_type'] = array(
    'WI_OTP' => 'With OTP',
    'WI_POD' => 'With POD',
    'WI_OTP_POD' => 'With OTP & POD',
    'WI_OTP_WO_POD' => 'With OTP & without POD',
    'WO_OTP_WI_POD' => 'Without OTP & with POD',
    'WO_OTP_POD' => 'Without OTP & POD',
    'DR_DLRY_STS' => 'Door Delivery Status',
);

$config['delivery_filter_type_seenu'] = array(
    'WI_POD' => 'With POD',
    'WO_OTP_POD' => 'Without POD',
    'DR_DLRY_STS' => 'Door Delivery Status',
);

$config['gstin_status'] = array(
    'ACT' => 'Active',
    'CNL' => 'Cancelled',
    'INA' => 'Inactive',
    'PRO' => 'Provision',
);

$config['gstin_block_status'] = array(
    'U' => 'Unblocked',
    'B' => 'Blocked',
);

$config['gstin_taxpayer_type'] = array(
    'REG' => 'Regular',
    'COM' => 'Composite',
    'EXE' => 'Exempted',
);

$config['cheque_status'] = array(
    'NEW' => 'New',
    'DPST' => 'Deposit',
    'CRDT' => 'Credit / Realize',
    'HOLD' => 'Hold',
    'BNCE' => 'Bounce / Return',
    'REPST' => 'Represent',
);

$config['bank_names_list'] = array(
    // List of Scheduled Public Sector Banks
    'Bank of Baroda',
    'Bank of India',
    'Bank of Maharashtra',
    'Canara Bank',
    'Central Bank of India',
    'Indian Bank',
    'Indian Overseas Bank',
    'Punjab & Sind Bank',
    'Punjab National Bank',
    'State Bank of India',
    'UCO Bank',
    'Union Bank of India',

    // List of Scheduled Private Sector Banks
    'Axis Bank Ltd.',
    'Bandhan Bank Ltd.',
    'CSB Bank Ltd.',
    'City Union Bank Ltd.',
    'DCB Bank Ltd.',
    'Dhanlaxmi Bank Ltd.',
    'Federal Bank Ltd.',
    'HDFC Bank Ltd',
    'ICICI Bank Ltd.',
    'Induslnd Bank Ltd',
    'IDFC First Bank Ltd.',
    'Jammu & Kashmir Bank Ltd.',
    'Karnataka Bank Ltd.',
    'Karur Vysya Bank Ltd.',
    'Kotak Mahindra Bank Ltd',
    'Nainital Bank Ltd.',
    'RBL Bank Ltd.',
    'South Indian Bank Ltd.',
    'Tamilnad Mercantile Bank Ltd.',
    'YES Bank Ltd.',
    'IDBI Bank Ltd.',
);
sort($config['bank_names_list']);

$config['delivery_acknowledgement_status'] = array(
    'INIT' => 'Initial',
    'SENT' => 'Sent',
    'RCVD' => 'Received',
    'MSNG' => 'Missing',
    'CNCL' => 'Cancel'
);
$config['agent_collection_filtertype'] = array(
    'BOOK' => 'Booking',
    'TRANSIT' => 'Delivery'
);

$config['invoice_acknowledgement_status'] = array(
    'CRT' => 'Created',
    'SBMT' => 'Submitted',
    'PMRC' => 'Payment Received',
    'CMPLT' => 'Completed',
    'MSNG' => 'Missing',
    'CNCL' => 'Cancel'
);

$config['namespace_status'] = array(
    'DISABLED' => 'Disabled',
    'NOT_CONFIG' => 'Not Configured',
    'DISABLE_SOON' => 'Disable Soon'
);

$config['free_service_addon'] = array(
    'FR' => 'Freight',
    'LC' => 'Loading Charges',
    'HC' => 'Hamali Charges',
    'DC' => 'Docket Charges',
    'OC' => 'Other Charges',
    'DP' => 'Door Pickup Charges',
    'DD' => 'Door Delivery Charges',
    'MC' => 'Machine Handling Charges',
);

$config['machine_handling_tariff'] = array(
    (object) array(
        'unitCode' => 'KG',
        'fromUnitValue' => 100,
        'toUnitValue' => 250,
        'amount' => 200
    ),
    (object) array(
        'unitCode' => 'KG',
        'fromUnitValue' => 250,
        'toUnitValue' => 500,
        'amount' => 300
    ),
    (object) array(
        'unitCode' => 'KG',
        'fromUnitValue' => 500,
        'toUnitValue' => 1000,
        'amount' => 400
    ),
    (object) array(
        'unitCode' => 'KG',
        'fromUnitValue' => 1000,
        'toUnitValue' => 1500,
        'amount' => 600
    )
);

$config['perrmission_severity'] = array(
    'DEFAULT' => 'Default',
    'MAJOR' => 'Major',
    'CRITICAL' => 'Critical',
    'BLOCKER' => 'Blocker'
);

$config['billing_conf_pricing_model'] = array(
    'LRCNT' => translate('lr').' Count',
    'LRVOL' => translate('lr').' Volume'
);

$config['contact_category_action_codes'] = array(
    'TRANS' => 'Transporter',
    'DRVR' => 'Driver',
    'NMSP' => 'Namespace',
    'SPLR' => 'Supplier',
    'BRCH' => 'Branch',
    'RAC' => 'Registered Account Customer',
    'RC' => 'Retail Customer',
    'BANK' => 'Bank',
    'TDS' => 'Tds',
    'VEH' => 'Vehicle',
    'VOD' => 'Vehicle Ownership',
    'EXP' => 'Overall Expense',
    'INCM' => 'Overall Income',
    'STWF' => 'Staff Welfare',
);

$config['manage_expense_type'] = array(
    'BRN' => 'Branch',
    'VEH' => 'Vehicle',
    'TRN' => 'Transit',
    'LR' => translate('lr'),
    'OT' => 'Other'
);

$config['mandate_manage_expense_fields'] = array(
    'STAFF' => 'Staff',
    'DRIVER' => 'Driver'
);

$config['contact_category_tags'] = array(
    'EXPLGR' => 'Expense Ledger',
    'INVADJ' => 'Invoice Adjustment',
    'DRVPMT' => 'Driver Payment'
);

$config['import_fields_map_citytravels'] = array(
    "v_lrno" => translate('lr')." No.",
    "v_from_station" => "From",
    "v_to_station" => "To",
    "v_sender_name" => "C/nor",
    "v_receiver_name" => "C/nee",
    "v_sender_mobile" => "",
    "v_receiver_mobile" => "",
    "v_booked_date" => "Bk Dt",
    "v_unloaded_date" => "Unload Date",
    "v_article_count" => "Art",
    "v_actual_weight" => "Act Wght",
    "v_total_freight" => "Amt",
    "v_payment_type" => translate('lr')." Type",
    "v_invoice_value" => "Declared Value",
    "v_door_pickup" =>"Door Pickup",
    "v_door_pickup_charges" => "Door Pickup charges",
    "v_door_delivery" => "Door Delivery ",
    "v_door_delivery_charges" => "Door Delivery Charges",
    "v_loading_charges" =>"Loading Charges",
    "v_articles"=>"Articls",
    "v_remarks"=>"Remarks",
    "e_from_station_code" => "",
    "e_to_station_code" => "",
    "e_payment_type" => ""
);

$config['excel_import_payment_status'] = array(
    'paid' => 'PAD',
    'topay' => 'TOP',
    'onaccount' => 'INP',
    'onaccounttopay' => 'OATP',
    'topaythenpaid' => 'TPPAD',
    'waytopay' => 'WTOP',
    'freeservice' => 'FS'
);

$config['notification_mode'] = array(
    'WAPP' => 'Whatsapp',
    'SMS' => 'SMS'
);

$config['cargo_additional'] = array(
    'EXPDL' => array(
        'name' => 'Express Delivery',
        'code' => 'ED',
        'color' => 'orange'
    ),
    'HDLWC' => array(
        'name' => 'Handle With Care',
        'code' => 'HC',
        'color' => 'danger'
    ),
);
$config['notification_mode'] = array(
    'SMS' => 'SMS',
    'WAPP' => 'Whatsapp',
    'APP' => 'Ezee Bot',
    'MAIL' => 'E-mail',
);

$config['get_gst_state'] = array(
    '35' => 'Andaman and Nicobar Islands',
    '28' => 'Andhra Pradesh',
    '37' => 'Andhra Pradesh (new)',
    '12' => 'Arunachal Pradesh',
    '18' => 'Assam',
    '10' => 'Bihar',
    '4' => 'Chandigarh',
    '22' => 'Chattisgarh',
    '26' => 'Dadra and Nagar Haveli',
    '25' => 'Daman and Diu',
    '7' => 'Delhi',
    '30' => 'Goa',
    '24' => 'Gujarat',
    '6' => 'Haryana',
    '2' => 'Himachal Pradesh',
    '1' => 'Jammu and Kashmir',
    '20' => 'Jharkhand',
    '29' => 'Karnataka',
    '32' => 'Kerala',
    '38' => 'Ladakh',
    '31' => 'Lakshadweep Islands',
    '23' => 'Madhya Pradesh',
    '27' => 'Maharashtra',
    '14' => 'Manipur',
    '17' => 'Meghalaya',
    '15' => 'Mizoram',
    '13' => 'Nagaland',
    '21' => 'Odisha',
    '34' => 'Pondicherry',
    '3' => 'Punjab',
    '8' => 'Rajasthan',
    '11' => 'Sikkim',
    '33' => 'Tamil Nadu',
    '36' => 'Telangana',
    '16' => 'Tripura',
    '9' => 'Uttar Pradesh',
    '5' => 'Uttarakhand',
    '19' => 'West Bengal',
);
$config['activityType'] = array(
    'TRNT' => array(
        'name' => 'Direct Transit',
        'code' => 'TRNT',
        'color' => 'primary',
        'short_name' => 'Direct'
        
    ),
    'HBTRNT' => array(
        'name' => translate('hub').' load',
        'code' => 'HBTRNT',
        'color' => 'primary',
        'short_name' => translate('hub')
    ),
    'INTRNT' => array(
        'name' => 'Local Transit',
        'code' => 'INTRNT',
        'color' => 'info',
        'short_name' => 'Local'
    ),
    'OTFD' => array(
        'name' => 'Out For Delivery',
        'code' => 'OTFD',
        'color' => 'info',
        'short_name' => 'OFD'
    ),
);