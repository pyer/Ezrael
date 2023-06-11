
/* Icons */
const faces = ["\u{2680}","\u{2681}","\u{2682}","\u{2683}","\u{2684}","\u{2685}","\u{2686}"];

/* Main entry */
document.getElementById("dice").addEventListener("click", function() {
  const s = Date.now();
  var x = s%10;
  if (x > 5) {
    x-= 5;
  }
  console.log("dice: " + s + " -> " + (x+1));

  document.getElementById("dice").innerHTML = faces[x];
});
