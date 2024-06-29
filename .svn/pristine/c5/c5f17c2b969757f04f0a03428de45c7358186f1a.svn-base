<div class="newRow">
    <div class="row altrow">
        {if count($final) == 0}
            <div class ="col-md-12">
                <div class = "bg-white">
                    <div class ="image-center">
                        <image src="assets/img/svg/Empty Message.svg" width = "300px" height= "350px">
                    </div>
                    <div class ="image-center">
                        <h1><span class="text-primary">Message's</span> Not Found!</h1>
                    </div>
                </div>
            </div>
        {else}
            <div class="col-md-7">
                <div class="bg-white">
                    <table id="datatable" class="table">
                        <thead>
                            <tr>
                                <th>
                                    <div class="row d-flex search-row justify-content-end altrow">
                                        <div class="col-md-6 book-group book-group-border d-conts">
                                            <div class="search-icon-outter">
                                                <input type="text" id="search" placeholder="Search">
                                                <div class="search-icon-inner" title="Search"> </div>
                                            </div>
                                        </div>
                                    </div><br>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $final as $t => $row}
                                <tr>
                                    <td class="message-box">
                                        <div class="row align-items-center altrow">
                                            <div class="col-md-auto">
                                                <div class="message-icon">
                                                    {assign var="messageIcon" value=true}
                                                    {assign var="WhatsAppIcon" value=true}
                                                    {assign var="mailIcon" value=true}

                                                    {foreach $row as $item}
                                                        {if $item->notification_mode =='SMS'}
                                                            {$WhatsAppIcon = false}
                                                            {$mailIcon = false}
                                                        {elseif $item->notification_mode =='WAPP'}
                                                            {$messageIcon = false}
                                                            {$mailIcon = false}
                                                        {else}
                                                            {$WhatsAppIcon = false}
                                                            {$messageIcon = false}
                                                        {/if}
                                                    {/foreach}

                                                    {if $messageIcon}
                                                        <i title="sms"><img class="image-moves" src="assets/img/svg/msg-icon.svg" width="24px" height="24px"></i>
                                                    {elseif $WhatsAppIcon}
                                                        <i title="whatsapp"><img class="image-moves" src="assets/img/svg/whatsapp-icon.svg" width="24px" height="24px"></i>
                                                    {elseif $mailIcon}
                                                        <i title="mail"><img class="image-moves" src="assets/img/svg/mail-icon.svg" width="24px" height="24px"></i>
                                                    {else}
                                                        <i title="sms/whatsapp"><img class="image-moves" src="assets/img/svg/merge-icon_1.svg" title="sms/whatsapp" width="24px" height="24px"></i>
                                                    {/if}
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="timeCount">
                                                    <div class="inner-h6">
                                                        <h6>{$t}</h6>
                                                        <span class="badge badge-color" title="message count">{count($row)}</span>
                                                    </div>
                                                    {assign var=lastKeyIndex value=(count($row)-1)}
                                                    <div class="inner-span">
                                                        <span>{capture assign=timestamp}{$row[$lastKeyIndex]->fired_date|strtotime}{/capture}{$timestamp|date_format:"%d %b %Y %I:%M %p"}</span>
                                                    </div>
                                                </div>
                                                <p>{$row[$lastKeyIndex]->message|substr:0:80}....</p>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="col-md-5">
                <div class="message-text">
                    <div class="messages">
                    </div>
                </div>
            </div>
        {/if}
    </div>
</div>

<script>
    var dataum = {$final|json_encode};
    var icon = {$notification_mode_code|json_encode};

    $(document).ready(function() {
        
        $('[data-toggle="tooltip"]').tooltip();

        setTimeout(function() {
            $('.message-box:first').trigger('click');
        }, 100);

        var scrollUp = $.scrollUp({
            scrollName: 'scrollUp',
            topDistance: 300,
            topSpeed: 300,
            animation: 'none',
            animationInSpeed: 200,
            animationOutSpeed: 200,
            scrollText: '<i class="fas fa-arrow-up"></i>',
            activeOverlay: false,
        });
      
        $("#search").on("input", function () {
            $(this).css('border', '');
            var searchTerm = $(this).val().toLowerCase();

            $(".message-box").each(function () {
                var isVisible = $(this).text().toLowerCase().includes(searchTerm);
                $(this).closest('tr').toggle(isVisible);
            });
        });

        $('.message-box').click(function() {
            $('.message-box').removeClass('clicked-message');

            $(this).toggleClass('move-text');
            $(this).addClass('clicked-message');

            $('.message-box').not(this).find('.message-icon').removeClass('clicks');

            $(this).find('.message-icon').toggleClass('clicks');

            var h6Value = $(this).find('h6').text();

            $('.title-box').each(function() {
                $(this).find('h5').text(h6Value);
            });

            $.each(dataum, function(key, value) {
                if (key == h6Value) {
                    addMessages(0, (value.length - 1), value);
                }
            });
        });

        function createMessage(messageText, date, modeOfNotification, typeOfNotification) {
            var messagePop = '';
            var actualDay = '';
            var stringWithCurlyBrace = `{ `;
            var messagenotificationType = '';
            var messagenotificationTitle ='';
            var cleanedMessageText = messageText.replace(/\n/g, "");
            var characterCount = cleanedMessageText.length;
            var newMessageText = messageText.replace("\n", "<br>");

            var currentDate = new Date();
            currentDate.setUTCHours(currentDate.getUTCHours() + 5);
            currentDate.setUTCMinutes(currentDate.getUTCMinutes() + 30);

            var arrayDate = new Date(date);
         
            var hours = arrayDate.getHours();
            var minutes = arrayDate.getMinutes();
            var meridiem = hours >= 12 ? "PM" : "AM";
            if (hours > 12) {
                hours = hours - 12;
            }
            if (minutes < 10) {
                minutes = 0 + "" + minutes;
            }
            var time = hours + ":" + minutes + " " + meridiem;
            var timeDifference = currentDate - arrayDate;

            if (currentDate.toDateString() === arrayDate.toDateString()) {
                actualDay = 'Today';
            } else if (isYesterday(currentDate, arrayDate)) {
                actualDay = 'Yesterday';
            } else {
                var day = ("0" + arrayDate.getDate()).slice(-2); 
                var month = arrayDate.toLocaleString('default', { month: 'short' }); 
                var year = arrayDate.getFullYear(); 
                var hours = ("0" + arrayDate.getHours() % 12 || 12).slice(-2);
                var minutes = ("0" + arrayDate.getMinutes()).slice(-2);
                var period = arrayDate.getHours() >= 12 ? 'PM' : 'AM';
                var formattedDate = day + ' ' + month + ' ' + year + ' ' + hours + ':' + minutes + ' ' + period;

                actualDay = formattedDate;
            }

            if (typeOfNotification == 'TCKBO') {
                messagenotificationType = 'BO';
                messagenotificationTitle = "Confirm Booking";
             
            } else if (typeOfNotification == 'TCKCA') {
                messagenotificationType = 'CA';
                messagenotificationTitle = "Confirm Cancel";
            } else if (typeOfNotification == 'TRPTN') {
                messagenotificationType = 'TN';
                messagenotificationTitle = "Trip Notification";
            }
            else if (typeOfNotification == 'GPSTK') {
                messagenotificationType = 'GPS';
                messagenotificationTitle = "GPS Tracking";
            }
            else if (typeOfNotification == 'FGPWD') {
                messagenotificationType = 'FP';
                messagenotificationTitle = "Forget password";
            }
            else if (typeOfNotification == 'USRREG') {
                messagenotificationType = 'USRREG';
                messagenotificationTitle = "User Register";
            }
            else if (typeOfNotification == 'HPYJY') {
                messagenotificationType = 'HPJ';
                messagenotificationTitle = "Happy Journey";
            }
            else if (typeOfNotification == 'TPHBO') {
                messagenotificationType = 'PBO';
                messagenotificationTitle = "Phone Booked Ticket";
            }
            else if (typeOfNotification == 'TINFO') {
                messagenotificationType = 'TDI';
                messagenotificationTitle = "Trip Driver Informations";
            }
            else if (typeOfNotification == 'FEDBK') {
                messagenotificationType = 'FDB';
                messagenotificationTitle = "Customer Feedback";
            }
            else if (typeOfNotification == 'OTP') {
                messagenotificationType = 'OTP';
                messagenotificationTitle = "OTP Message";
            }
            else if (typeOfNotification == 'ONREC') {
                messagenotificationType = 'OR';
                messagenotificationTitle = "Online Recharge";
            }
            else if (typeOfNotification == 'FEBK') {
                messagenotificationType = 'FBAT';
                messagenotificationTitle = "Feedback After Travel Date";
            }
            else if (typeOfNotification == 'SEVI') {
                messagenotificationType = 'SEVI';
                messagenotificationTitle = "Seat Visibility";
            }
            else if (typeOfNotification == 'SASU') {
                messagenotificationType = 'SASU';
                messagenotificationTitle = "Sales Summary";
            }
            else if (typeOfNotification == 'BBDY') {
                messagenotificationType = 'BB';
                messagenotificationTitle = "Bus Buddy";
            }
            else if (typeOfNotification == 'FLTKBO') {
                messagenotificationType = 'FLBO';
                messagenotificationTitle = "Failure Ticket Booking Notification";
            }
            else if (typeOfNotification == 'VANPC') {
                messagenotificationType = 'VPU';
                messagenotificationTitle = "Van Pickup";
            }
            else if (typeOfNotification == 'FBRP') {
                messagenotificationType = 'FBR';
                messagenotificationTitle = "Customer Feedback Reply";
            }
            else if (typeOfNotification == 'BVCH') {
                messagenotificationType = 'BVC';
                messagenotificationTitle = "Bus Vehcile Change";
            }
            else if (typeOfNotification == 'NAEVAL') {
                messagenotificationType = 'NEAL';
                messagenotificationTitle = "Namespace Event Alert";
            }
            else if (typeOfNotification == 'FLTCK') {
                messagenotificationType = 'FTN';
                messagenotificationTitle = "Failure Ticket Booking Notification";
            }
            else if (typeOfNotification == 'TCKEV') {
                messagenotificationType = 'TEN';
                messagenotificationTitle = "Ticket Event Notification";
            }
            else if (typeOfNotification == 'TATT') {
                messagenotificationType = 'TATT';
                messagenotificationTitle = "Ticket After Trip Time Notification";
            }
            else if (typeOfNotification == 'TKUP') {
                messagenotificationType = 'TUN';
                messagenotificationTitle = "Ticket Update Notification";
            }
            else if (typeOfNotification == 'SCHUP') {
                messagenotificationType = 'SHUP';
                messagenotificationTitle = "Schedule Update Notification";
            }
            else if (typeOfNotification == 'FSMS') {
                messagenotificationType = 'FSMS';
                messagenotificationTitle = "Failure SMS Notification";
            }
            else if (typeOfNotification == 'TPHCA') {
                messagenotificationType = 'PBC';
                messagenotificationTitle = "Phone Book Confirm Cancel";
            }
            else if (typeOfNotification == 'OACS') {
                messagenotificationType = 'OACS';
                messagenotificationTitle = "Overall Occupancy Summary";
            }
            else if (typeOfNotification == 'TAXINV') {
                messagenotificationType = 'TXIN';
                messagenotificationTitle = "Tax Invoice";
            }
            else if (typeOfNotification == 'FRTMPLT') {
                messagenotificationType = 'FRTMPLT';
                messagenotificationTitle = "Free Template";
            }
            else if (typeOfNotification == 'LIPBO') {
                messagenotificationType = 'LNPY';
                messagenotificationTitle = "LinkPay Ticket";
            }
            else if (typeOfNotification == 'POCA') {
                messagenotificationType = 'POC';
                messagenotificationTitle = "Pending Order Cancel";
            }
            else if (typeOfNotification == 'TCKRL') {
                messagenotificationType = 'TKRL';
                messagenotificationTitle = "Ticket Release";
            }
            else if (typeOfNotification == 'PYMNT') {
                messagenotificationType = 'PYMT';
                messagenotificationTitle = "Payment Notification";
            }
            else if (typeOfNotification == 'BUSCHG') {
                messagenotificationType = 'BTCN';
                messagenotificationTitle = "Bus Type Change Notification";
            }
            else if (typeOfNotification == 'CDIS') {
                messagenotificationType = 'CDIS';
                messagenotificationTitle = "Customer Discount";
            }
            else if (typeOfNotification == 'TRPCNL') {
                messagenotificationType = 'TCNL';
                messagenotificationTitle = "Trip Cancel Notification";
            }
            else if (typeOfNotification == 'TRPDLY') {
                messagenotificationType = 'TDLY';
                messagenotificationTitle = "Trip Delay Notification";
            }
            else if (typeOfNotification == 'TRPERY') {
                messagenotificationType = 'TERY';
                messagenotificationTitle = "Trip Early Notification";
            }
            else if (typeOfNotification == 'TRPSPC') {
                messagenotificationType = 'TSP';
                messagenotificationTitle = "Trip Station Point Change Notification";
            }
            else if (typeOfNotification == 'TRPVNP') {
                messagenotificationType = 'TVP';
                messagenotificationTitle = "Trip Van Pickup";
            }
            else if (typeOfNotification == 'FLRBO') {
                messagenotificationType = 'FLBO';
                messagenotificationTitle = "Failure Booking Notification";
            }
            else if (typeOfNotification == 'BBDAT') {
                messagenotificationType = 'BBAN';
                messagenotificationTitle = "Bus Buddy Alert Notification";
            }
            else if (typeOfNotification == 'TBOTP') {
                messagenotificationType = 'TBOTP';
                messagenotificationTitle = "Tablet OTP";
            }
            else if (typeOfNotification == 'WAPV') {
                messagenotificationType = 'WAV';
                messagenotificationTitle = "Whatsapp Verification Notification";
            }
            else if (typeOfNotification == 'EPASS') {
                messagenotificationType = 'EPASS';
                messagenotificationTitle = "Covid Epass Notification";
            }
            else if (typeOfNotification == 'VHNF') {
                messagenotificationType = 'VNF';
                messagenotificationTitle = "Vehicle Number Notification";
            }
            else if (typeOfNotification == 'CMNFN') {
                messagenotificationType = 'CMN';
                messagenotificationTitle = "Common Notification";
            }
            else if (typeOfNotification == 'APLGY') {
                messagenotificationType = 'APG';
                messagenotificationTitle = "Apology Notification";
            }
            else if (typeOfNotification == 'TATCNL') {
                messagenotificationType = 'TCNL';
                messagenotificationTitle = "Ticket After Trip Time Cancel Notification";
            }
            else if (typeOfNotification == 'PNRUD') {
                messagenotificationType = 'POR';
                messagenotificationTitle = "Pending Order Refund";
            }
            else if (typeOfNotification == 'DRIAL') {
                messagenotificationType = 'DRAL';
                messagenotificationTitle = "Driver Alert Message";
            }

            messagePop += '<small class="text-secondary">' + actualDay + '</small><br><br>';
            messagePop += '<div class="row d-flex altrow"><div class = "col-md"><div class="message-content">'

            if(modeOfNotification == "MAIL" || messageText.charAt(0) === stringWithCurlyBrace.trim()){
                messagePop += '<p>' +newMessageText + '</p>'
            }else{
            messagePop += '<pre class="pre">' + newMessageText + '</pre>'
            }
           
            messagePop += '<div class= "timeCount" ><small class ="text-secondary" title="Character Count">' + characterCount + '</small>'
            messagePop +='<small class="text-secondary">'+time+'<i class = "paperocket"><img src="assets/img/svg/paperRocket.svg"  width="18px" height= "19px"></i></small></div></div><br><br></div>'
            messagePop +='<div class="col-md-auto" >'
            messagePop += '<div class = "type-icon"><span data-toggle="tooltip" data-placement="top"  title="'+messagenotificationTitle+'" class="label label-success booking">'+messagenotificationTitle +'</span></div><br>'
            if (modeOfNotification == 'SMS') {
                messagePop +=
                '<div class ="display-icons" title = "SMS"><svg xmlns="http://www.w3.org/2000/svg"  viewBox="0 0 24 24" id="message"><g data-name="Layer 2"><path fill="none" d="M0 0h24v24H0z"></path><path fill="#0076f4" d="M1 12C1 4 4 1 12 1s11 3 11 11-3 11-11 11S1 20 1 12"></path><path fill="#005cc9" fill-rule="evenodd" d="M16.27 16.48H9a1.72 1.72 0 0 1-1.7-1.72v-3.95L6.08 8.72a.58.58 0 0 1 .5-.87h9.69A1.72 1.72 0 0 1 18 9.58v5.18a1.72 1.72 0 0 1-1.73 1.72Z"></path><path fill="#fff" fill-rule="evenodd" d="M16.27 16.15H9a1.72 1.72 0 0 1-1.7-1.73v-3.95L6.08 8.38a.57.57 0 0 1 .5-.86h9.69A1.72 1.72 0 0 1 18 9.24v5.18a1.72 1.72 0 0 1-1.73 1.73Z"></path><rect width="7.73" height=".92" x="8.79" y="9.41" fill="#00b7ff" rx=".46"></rect><rect width="7.73" height=".92" x="8.79" y="11.24" fill="#00b7ff" rx=".46"></rect><rect width="5.88" height=".92" x="8.79" y="13.11" fill="#00b7ff" rx=".46"></rect></g></svg></div></div></div>'
            } else if (modeOfNotification == 'MAIL') {
                messagePop +=
                    '<div class ="display-mail" title = "MAIL" ><img src="assets/img/svg/mail_3.svg"   width="25px" height="25px"></div></div></div>'
            } else {
                messagePop +=
                    '<div class ="display-icons"  title = "WHATSAPP" ><svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="100" height="100" viewBox="0 0 48 48"><path fill="#fff" d="M4.9,43.3l2.7-9.8C5.9,30.6,5,27.3,5,24C5,13.5,13.5,5,24,5c5.1,0,9.8,2,13.4,5.6	C41,14.2,43,18.9,43,24c0,10.5-8.5,19-19,19c0,0,0,0,0,0h0c-3.2,0-6.3-0.8-9.1-2.3L4.9,43.3z"></path><path fill="#fff" d="M4.9,43.8c-0.1,0-0.3-0.1-0.4-0.1c-0.1-0.1-0.2-0.3-0.1-0.5L7,33.5c-1.6-2.9-2.5-6.2-2.5-9.6	C4.5,13.2,13.3,4.5,24,4.5c5.2,0,10.1,2,13.8,5.7c3.7,3.7,5.7,8.6,5.7,13.8c0,10.7-8.7,19.5-19.5,19.5c-3.2,0-6.3-0.8-9.1-2.3	L5,43.8C5,43.8,4.9,43.8,4.9,43.8z"></path><path fill="#cfd8dc" d="M24,5c5.1,0,9.8,2,13.4,5.6C41,14.2,43,18.9,43,24c0,10.5-8.5,19-19,19h0c-3.2,0-6.3-0.8-9.1-2.3	L4.9,43.3l2.7-9.8C5.9,30.6,5,27.3,5,24C5,13.5,13.5,5,24,5 M24,43L24,43L24,43 M24,43L24,43L24,43 M24,4L24,4C13,4,4,13,4,24	c0,3.4,0.8,6.7,2.5,9.6L3.9,43c-0.1,0.3,0,0.7,0.3,1c0.2,0.2,0.4,0.3,0.7,0.3c0.1,0,0.2,0,0.3,0l9.7-2.5c2.8,1.5,6,2.2,9.2,2.2	c11,0,20-9,20-20c0-5.3-2.1-10.4-5.8-14.1C34.4,6.1,29.4,4,24,4L24,4z"></path><path fill="#40c351" d="M35.2,12.8c-3-3-6.9-4.6-11.2-4.6C15.3,8.2,8.2,15.3,8.2,24c0,3,0.8,5.9,2.4,8.4L11,33l-1.6,5.8	l6-1.6l0.6,0.3c2.4,1.4,5.2,2.2,8,2.2h0c8.7,0,15.8-7.1,15.8-15.8C39.8,19.8,38.2,15.8,35.2,12.8z"></path><path fill="#fff" fill-rule="evenodd" d="M19.3,16c-0.4-0.8-0.7-0.8-1.1-0.8c-0.3,0-0.6,0-0.9,0	s-0.8,0.1-1.3,0.6c-0.4,0.5-1.7,1.6-1.7,4s1.7,4.6,1.9,4.9s3.3,5.3,8.1,7.2c4,1.6,4.8,1.3,5.7,1.2c0.9-0.1,2.8-1.1,3.2-2.3	c0.4-1.1,0.4-2.1,0.3-2.3c-0.1-0.2-0.4-0.3-0.9-0.6s-2.8-1.4-3.2-1.5c-0.4-0.2-0.8-0.2-1.1,0.2c-0.3,0.5-1.2,1.5-1.5,1.9	c-0.3,0.3-0.6,0.4-1,0.1c-0.5-0.2-2-0.7-3.8-2.4c-1.4-1.3-2.4-2.8-2.6-3.3c-0.3-0.5,0-0.7,0.2-1c0.2-0.2,0.5-0.6,0.7-0.8	c0.2-0.3,0.3-0.5,0.5-0.8c0.2-0.3,0.1-0.6,0-0.8C20.6,19.3,19.7,17,19.3,16z" clip-rule="evenodd"></path></svg></div></div></div>'
            }

            const newMessage = $(messagePop);
            return newMessage;
        }

        function addMessages(start, end, arr) {
            const messagePad = $('.messages');
            const prepad = $('.messagecontent');
            messagePad.empty();
            for (let i = arr.length - 1; i >= start; i--) {
                messagePad.append(createMessage(arr[i].message, arr[i].fired_date, arr[i].notification_mode,
                    arr[i].notification_type));
            }

            messagePad.animate({ scrollTop: 0 }, 500, function() {
                prepad.css('overflow-y', 'hidden');
            });
        }

        function isYesterday(date1, date2) {
            var yesterday = new Date(date1);
            yesterday.setDate(yesterday.getDate() - 1);
            return yesterday.toDateString() === date2.toDateString();
        }

    });
</script>