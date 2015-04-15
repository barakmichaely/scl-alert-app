
// <script src = javascript_include_tag "//maps.google.com/maps/api/js?sensor=false">

//     function initialize() {
//       var myLatlng = new google.maps.LatLng(-34.397, 150.644);
//       var myOptions = {
//         zoom: 8,
//         center: myLatlng,
//         mapTypeId: google.maps.MapTypeId.ROADMAP
//       }
//       var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
//     }

//     function loadScript() {
//       var script = document.createElement("script");
//       script.type = "text/javascript";
//       script.src = "http://maps.google.com/maps/api/js?sensor=false&callback=initialize";
//       document.body.appendChild(script);
//     }

//     window.onload = loadScript;


// </script>

// In this example, we center the map, and add a marker, using a LatLng object
// literal instead of a google.maps.LatLng object. LatLng object literals are
// a convenient way to add a LatLng coordinate and, in most cases, can be used
// in place of a google.maps.LatLng object.

// var map;
// function initialize() {
//   var mapOptions = {
//     zoom: 8,
//     center: {lat: -34.397, lng: 150.644}
//   };
//   map = new google.maps.Map(document.getElementById('map-canvas'),
//       mapOptions);

//   var marker = new google.maps.Marker({
//     // The below line is equivalent to writing:
//     // position: new google.maps.LatLng(-34.397, 150.644)
//     position: {lat: -34.397, lng: 150.644},
//     map: map
//   });

//   // You can use a LatLng literal in place of a google.maps.LatLng object when
//   // creating the Marker object. Once the Marker object is instantiated, its
//   // position will be available as a google.maps.LatLng object. In this case,
//   // we retrieve the marker's position using the
//   // google.maps.LatLng.getPosition() method.
//   var infowindow = new google.maps.InfoWindow({
//     content: '<p>Marker Location:' + marker.getPosition() + '</p>'
//   });

//   google.maps.event.addListener(marker, 'click', function() {
//     infowindow.open(map, marker);
//   });
// }

// google.maps.event.addDomListener(window, 'load', initialize);

// <!DOCTYPE html>
// <html>
//   <head>
//     <style type="text/css">
//       html, body, #map-canvas { height: 100%; margin: 0; padding: 0;}
//     </style>
//     <script type="text/javascript"
//       src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRy8RCnfNA3jGiktdDJKObuRoHpwZyJ1o">
    
//       function initialize() {
//         var mapOptions = {
//           center: { lat: -34.397, lng: 150.644},
//           zoom: 8
//         };
//         var map = new google.maps.Map(document.getElementById('map-canvas'),
//             mapOptions);
//       }
//       google.maps.event.addDomListener(window, 'load', initialize);
//     </script>
//   </head>
//   <body>
// <div id="map-canvas"></div>
//   </body>
// </html>

<script src="http://maps.googleapis.com/maps/api/js?key="+AIzaSyCRy8RCnfNA3jGiktdDJKObuRoHpwZyJ1o+"&sensor=false"></script>

<script>

    function initialize()
    {
        var laa=-34.397;
        var lonn= 150.644;
        var mapOptions =
        {
            zoom: 7,
            center: new google.maps.LatLng(laa, lonn),
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            maxZoom: 8,
            minZoom:2
        };

        var map = new google.maps.Map(document.getElementById('location-canvas'),
            mapOptions);

        var marker = new google.maps.Marker({
            map: map,
            draggable: false,
            position: new google.maps.LatLng(laa, lonn)
        });

        function bind(eventName)
        {
            google.maps.event.addListener(map, eventName, function ()
            {
                common();

            });
        }

        bind('zoom_changed');
        bind('center_changed');
        bind('tilesloaded');
        bind('idle');

        function common()
        {
            var bounds = map.getBounds();
            var southWest = bounds.getSouthWest();
            var northEast = bounds.getNorthEast();
            var getcentre=bounds.getCenter();
            var ne = map.getBounds().getNorthEast();
            var sw = map.getBounds().getSouthWest();
            var zoom=map.getZoom();
            var centre_lat=getcentre.lat();
            var centre_long=getcentre.lng();
            var myLatlng=new google.maps.LatLng(centre_lat,centre_long);
            var mapProp =
            {
                center: new google.maps.LatLng(centre_lat,centre_long),
                zoom:zoom,
                maxZoom: 8,
                minZoom:2,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

        }
    }

    google.maps.event.addDomListener(window, 'resize', initialize);
    google.maps.event.addDomListener(window, 'load', initialize);
</script>

        <div id='location-canvas' style='width:100%;height:500px;'>

        </div>

var southWest = new google.maps.LatLng(36.90731625763393,-86.51778523864743);
var northEast = new google.maps.LatLng(37.02763411292923,-86.37183015289304);
var bounds = new google.maps.LatLngBounds(southWest,northEast);
myMap.fitBounds(bounds);

