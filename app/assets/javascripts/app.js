


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

});
