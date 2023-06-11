
/* Icons */
const closedFolderIcon = "\u{01F4C1}";
const openedFolderIcon = "\u{01F4C2}";
const closedArrowIcon  = "\u{0021E8}";
const openedArrowIcon  = "\u{0021E9}";
//const openedArrowIcon  = "\u{002B07}";
//const openedArrowIcon  = "\u{0025BC}";
//const closedArrowIcon  = "\u{0025B6}";
//const closedArrowIcon  = "\u{0027A4}";
//const documentIcon     = "\u{01F5CE}";
const documentIcon     = "\u{01F5D2}";


/* Open and close folder */
function changeOpened(event) {
  const header = event.target;
  const folder = header.firstElementChild;
  try {
    const folderName = header.firstChild.nodeValue.substring(1);
    if (folder.classList.contains("hide")) {
      folder.classList.remove("hide");
      header.firstChild.nodeValue = openedArrowIcon + folderName;
    } else {
      folder.classList.add("hide");
      header.firstChild.nodeValue = closedArrowIcon + folderName;
    }
  } catch (e) {
    console.warn("Folder is empty");
  }
}

/* Parsing the branches of the tree */
function to_ul(branches) {
  var ul = document.createElement("ul");
  for (var i = 0, n = branches.length; i < n; i++) {
    var li = document.createElement("li");
    var branch = branches[i];
    if (branch.branches) {
      li.classList.add("folder");
      li.addEventListener("click", changeOpened);
      li.appendChild(document.createTextNode(openedArrowIcon + closedFolderIcon + branch.name));
      li.appendChild(to_ul(branch.branches));
    } else {
      li.classList.add("file");
      li.appendChild(document.createTextNode(documentIcon + branch.name));
    }
    ul.appendChild(li);
  }
  return ul;
}

/* Get JSON data from server */
const getJSON = async url => {
  const response = await fetch(url);
  if(!response.ok) // check if response worked (no 404 errors etc...)
    throw new Error(response.statusText);
  const data = response.json(); // get JSON from the response
  return data; // returns a promise, which resolves to this data value
}

/* Main entry */
console.log("Start");
getJSON(location.href + "files").then(result => {
      console.log("Parsing data...");
      console.log(result);
      const app = document.getElementById("treeView");
      app.appendChild(to_ul(result.branches));
      console.log("Done");
  }).catch(error => {
    console.error(error);
  });
console.log("End");

