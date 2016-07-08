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
      zoom:14,
      mapTypeId:google.maps.MapTypeId.ROADMAP
    }
console.log(mapProp)
    var map = new google.maps.Map(document.getElementById("googleMap"),mapProp);
console.log(map)
    var owner_address = new google.maps.LatLng(lat, lng);

    var marker = new google.maps.Marker({
        position: owner_address,
        map: map
      });
  };

  google.maps.event.addDomListener(window, 'load', initialize);


});

$(document).ready(function(){

  // Dashboard Tabs
  $("html").on('click', 'a[href="#"]', function(e) {
    e.preventDefault();
    var i;

    console.log("tab  alert");

    var tabContent = $(".tabContent");
    for (i = 0; i < tabContent.length; i++) {
      tabContent[i].style.display = "none";
    }

    var tabLinks = $(".tabLinks");
    for (i = 0; i < tabLinks.length; i++) {
      tabLinks[i].className = tabLinks[i].className.replace(" active", "");
    }

    tabName = $(this).attr('class').split(" ")[0]
    $('#'+tabName)[0].style.display = "block";
    $(this).className += " active";
  });

  $("html").on('click', "#cost-button", function(event){
    $("#tools-by-cost").show();
    $("#tools-by-distance").hide();
  });
  $("html").on('click', "#distance-button", function(event){
    $("#tools-by-distance").show();
    $("#tools-by-cost").hide();
  });

  // STRIPE JS BELOW ///
  Stripe.setPublishableKey(' pk_test_eNf41km4qob9JPZmiA9C6iyt');

  $('.equal-height-panels .panel').matchHeight();
    
});