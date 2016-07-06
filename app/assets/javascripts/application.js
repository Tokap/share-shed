// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


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

});
