$(document).on('turbolinks:load', function(){


  var address = $('#googleMap').attr('address');
  console.log(address)

  $.ajax({
    url: 'https://maps.googleapis.com/maps/api/geocode/json?address='+address,
    success: function(response){
      lat = response.results[0].geometry.location.lat;
      lng = response.results[0].geometry.location.lng;
    }
  });

  function initialize() {
    var mapProp = {
      center:new google.maps.LatLng(lat,lng),
      zoom:16,
      mapTypeId:google.maps.MapTypeId.ROADMAP
    }

    var map = new google.maps.Map(document.getElementById("googleMap"),mapProp);

    var owner_address = new google.maps.LatLng(lat, lng);

    var marker = new google.maps.Marker({
        position: owner_address,
        map: map
      });
  };

  google.maps.event.addDomListener(window, 'load', initialize);
});
