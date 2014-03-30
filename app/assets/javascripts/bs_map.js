var rendererOptions = {
  draggable: true
};
var ren,
    ser = new google.maps.DirectionsService(),
    data = {},
    map, marker,
    palmas = new google.maps.LatLng(-10.204164, -48.3332),
    minZoomLevel = 12;

function initialize(edit, lat, lng, title) {
  var mapOptions = {
    center: palmas,
    zoom: 14,
    panControl:false,
    streetViewControl:true,
    maxZoom: 18,
    minZoom: minZoomLevel
  };
  var map = new google.maps.Map(document.getElementById("map-canvas"),
      mapOptions);
  ren = new google.maps.DirectionsRenderer(rendererOptions);
  // Make map shows up
  ren.setMap(map);
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

  // Listen to clicks to create markers
  google.maps.event.addListener(map, 'click', function(event) {
    placeMarker(event.latLng);
  });

  // Used in Busstop controller
  if (lat) {
    var location = new google.maps.LatLng(lat, lng);
    if (edit) {
      var marker = new google.maps.Marker({
      position: location,
      draggable: true,
      title: title,
      map: map
    });
    } else {
      var marker = new google.maps.Marker({
      position: location,
      draggable: false,
      title: title,
      map: map
    });
    }
    map.setCenter(location);
  };

  // Create marker
  function placeMarker(location) {
    if (marker) {
      marker.setPosition(location);
    } else {
      marker = new google.maps.Marker({
        position: location,
        map: map
      });
    }
    $('#busstop_lat').val(marker.position.lat());
    $('#busstop_lng').val(marker.position.lng());
  }

}