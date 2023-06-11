/* Display current date and time every second */

function refresh_current_time() {
  var refresh=1000; // Refresh rate in milli seconds
  setTimeout('display_current_time()',refresh)
}

function display_current_time() {
  document.getElementById("clock").innerHTML = new Date().toLocaleString("fr-FR");
  refresh_current_time();
}

