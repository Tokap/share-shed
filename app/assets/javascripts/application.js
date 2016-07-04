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

  // Dashboard owner renter buttons
  $("hgroup.dashboard").on("click", "#dashboard_button_owner", function() {
    $("main.dashboard").find("article").addClass('hidden');
    $("main.dashboard").find("section").removeClass('hidden');
  });

  $("hgroup.dashboard").on("click", "#dashboard_button_renter", function() {
    $("main.dashboard").find("section").addClass('hidden');
    $("main.dashboard").find("article").removeClass('hidden');
  });

  $("hgroup.dashboard").on("click", "#dashboard_button_summary", function() {
    $("main.dashboard").find("section").removeClass('hidden');
    $("main.dashboard").find("article").removeClass('hidden');
  });

  $("main.dashboard").on("click", "#dashboard_all_tools", function() {
    $(this).next().toggleClass('hidden');
  });

  // Dashboard tabs
  $('a.tabLinks').on('click', function(e) {
    e.preventDefault();

    var tabName = $(this).attr('href');
    var tabContent = $(".tabContent");
    var tabLinks = $(".tabLinks");

    var i;
    for (i = 0; i < tabContent.length; i++) {
      tabContent[i].style.display = "none";
    }

    $('#'+tabName)[0].style.display = "block";
    $(this).className += " active";
  });

});
