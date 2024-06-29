var myRouter = {
    map_: null,
    directionsHelper_: null,
    calcRoute: function () {

        var waypts = [];

        for (var i in this.stores) {
            waypts.push({
                location: new google.maps.LatLng(this.stores[i].latitude, this.stores[i].longitude),
                stopover: true
            });
        }
        //  assign last point
        var request = {
            origin: new google.maps.LatLng(this.startpoint.latitude, this.startpoint.longitude),
            destination: new google.maps.LatLng(this.endpoint.latitude, this.endpoint.longitude),
            waypoints: waypts,
            optimizeWaypoints: true,
            travelMode: google.maps.DirectionsTravelMode.DRIVING
        };        
        
        var _SELF = this;
        this.directionsHelper_.route(request, function (response, status) {
            if (status == google.maps.DirectionsStatus.OK) {
                _SELF.directionsDisplay_.setDirections(response);
                return;
            }
        });
        
        //  add markers
        this.stores.push(this.startpoint);
        this.stores.push(this.endpoint);
        var infowindow = new google.maps.InfoWindow();
        for (var i in this.stores) {    
            var zindex = this.stores.length-i;
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng(this.stores[i].latitude, this.stores[i].longitude),
                zIndex: zindex,
                map: this.map_
            });
            google.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {                    
                  infowindow.setContent(
                      '<div style="width: 250px;"> <span class="bold">'+ _SELF.stores[i].name +' : '+  _SELF.stores[i].time +'</span> <br> '+                      
                      '<span class="text-danger">'+ _SELF.stores[i].landmark +'</span> </div>'                      
                  );
                  infowindow.open(marker.get('map'), marker);
                };
            })(marker, i));
        }
    },
    init: function (opt) {
        this.stores = opt.source;
        this.startpoint = opt.startpoint;
        this.endpoint = opt.endpoint;
        this.directionsHelper_ = new google.maps.DirectionsService();
        this.directionsDisplay_ = new google.maps.DirectionsRenderer({
            suppressMarkers: true,
        });

        var center = new google.maps.LatLng(opt.center.lat, opt.center.lang);
        var myOptions = {
            zoom: 7,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            center: center
        }
        this.map_ = new google.maps.Map(document.getElementById(opt.element), myOptions);
        this.directionsDisplay_.setMap(this.map_);

        this.calcRoute();
    }
};