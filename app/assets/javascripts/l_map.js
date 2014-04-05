var rendererEditOptions = {
  draggable: true
};
var rendererOptions = {
  draggable: false,
  suppressMarkers: true
};
var ren,
    ser = new google.maps.DirectionsService(),
    data = {},
    map, marker,
    palmas = new google.maps.LatLng(-10.204164, -48.3332),
    minZoomLevel = 12;

function initialize(edit, busstops, startline, endline) {
  var mapOptions = {
    center: palmas,
    zoom: 14,
    panControl:false,
    streetViewControl:false,
    maxZoom: 18,
    minZoom: minZoomLevel
  };
  var map = new google.maps.Map(document.getElementById("map-canvas"),
      mapOptions);
  if (edit) {
    ren = new google.maps.DirectionsRenderer(rendererEditOptions);
  } else {
    ren = new google.maps.DirectionsRenderer(rendererOptions);
  };
  ren.setMap(map); // Make map shows up
  google.maps.event.addListener(ren, 'directions_changed', function() {
    computeTotalDistance(ren.getDirections());
  });

  // Limit bounds to Palmas
  var limitBounds = new google.maps.LatLngBounds(
    new google.maps.LatLng(-13.2906, -51.0310167),
    new google.maps.LatLng(-4.6734667, -45.2803667)
  );

  // Listen for the dragend event
   google.maps.event.addListener(map, 'drag', function() {
     if (limitBounds.contains(map.getCenter())) return;
     // When on the bound limit - Move the map back within the bounds
     var c = map.getCenter(),
         x = c.lng(),
         y = c.lat(),
         maxX = limitBounds.getNorthEast().lng(),
         maxY = limitBounds.getNorthEast().lat(),
         minX = limitBounds.getSouthWest().lng(),
         minY = limitBounds.getSouthWest().lat();

     if (x < minX) x = minX;
     if (x > maxX) x = maxX;
     if (y < minY) y = minY;
     if (y > maxY) y = maxY;

     map.setCenter(new google.maps.LatLng(y, x));
   });
   // Limit the zoom level
  google.maps.event.addListener(map, 'zoom_changed', function() {
    if (map.getZoom() < minZoomLevel) map.setZoom(minZoomLevel);
  });

  // Used in Busstop controller
  if (busstops) {
    for (i in busstops){
      for (j in busstops[i]) {
        if (j == 0) {
          var location = new google.maps.LatLng(busstops[i][0], busstops[i][1]);
          if (busstops[i][2] == 0) {
            var busmarker = new google.maps.Marker({
              position: location,
              icon: '/assets/busstop.png',
              map: map
            });
          } else {
            var busmarker = new google.maps.Marker({
            position: location,
            icon: '/assets/busstation.png',
            map: map
          });
          }
        };
      }
    }
  };

// Start/End markers
  var l_start = new google.maps.LatLng(startline[0], startline[1]);
  var l_end = new google.maps.LatLng(endline[0], endline[1]);
  // Start
  var marker = new google.maps.Marker({
    position: l_start,
    map: map,
    icon: '/assets/linestart.png',
  });
  // End
  var marker = new google.maps.Marker({
    position: l_end,
    map: map,
    icon: '/assets/lineend.png',
  });

}

function calcRoute() {
  var request = {
      origin: "Quadra 101 Norte, Av. Teotônio Segurada, Palmas - TO",
      destination: "Quadra 1102 Sul, Av. Teotônio Segurada, Palmas - TO",
      travelMode: google.maps.TravelMode.DRIVING
  };
  ser.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) { ren.setDirections(response) }
  });
}

function loadRoute(os){
  var wp = [];
    for(var i=0;i<os.waypoints.length;i++)
        wp[i] = {'location': new google.maps.LatLng(os.waypoints[i][0], os.waypoints[i][1]),'stopover':false }
    ser.route({'origin':new google.maps.LatLng(os.start.lat,os.start.lng),
    'destination':new google.maps.LatLng(os.end.lat,os.end.lng),
    'waypoints': wp,
    'travelMode': google.maps.DirectionsTravelMode.DRIVING},function(res,sts) {
        if(sts=='OK')ren.setDirections(res);
    })
}

function saveWaypoints(way){
  var w=[],wp;
  var rleg = ren.directions.routes[0].legs[0];
  data.start = {'lat': rleg.start_location.lat(), 'lng':rleg.start_location.lng()}
  data.end = {'lat': rleg.end_location.lat(), 'lng':rleg.end_location.lng()}
  var wp = rleg.via_waypoints
  for(var i=0;i<wp.length;i++)w[i] = [wp[i].lat(),wp[i].lng()]
  data.waypoints = w;

  var str = JSON.stringify(data);
  // Send data to fields
  if (way == 'g') {
    $('#going_start_location').val(data.start.lat+','+data.start.lng);
    $('#going_waypoints').val(JSON.stringify(w));
    $('#going_end_location').val(data.end.lat+','+data.end.lng);
  } else {
    $('#return_start_location').val(data.start.lat+','+data.start.lng);
    $('#return_waypoints').val(JSON.stringify(w));
    $('#return_end_location').val(data.end.lat+','+data.end.lng);
  };
}

$(function(){
  $('#save_going').click(function(e) { saveWaypoints("g") });
  $('#save_return').click(function(e) { saveWaypoints("r") });
});