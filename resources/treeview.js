
/* Icons */
const closedFolderIcon = "\u{01F4C1}";
//const openedFolderIcon = "\u{01F4C2}";
const openedFolderIcon = "\u{01F5C2}";

//const closedArrowIcon  = "\u{0021E8}";
//const openedArrowIcon  = "\u{0021E9}";
//const openedArrowIcon  = "\u{002B07}";
const openedArrowIcon  = "\u{0025BC}";
const closedArrowIcon  = "\u{0025BA}";

const deleteFileIcon  = "\u{01F5D1}";

/* Open and close folder */
function changeOpened(event) {
  const span = event.target.firstChild;
  const folder = event.target.nextSibling;
  try {
    if (folder.classList.contains("hide")) {
      folder.classList.remove("hide");
      const folderName = span.nodeValue.substring(closedArrowIcon.length+closedFolderIcon.length);
      span.nodeValue = openedArrowIcon + openedFolderIcon + folderName;
    } else {
      folder.classList.add("hide");
      const folderName = span.nodeValue.substring(openedArrowIcon.length+openedFolderIcon.length);
      span.nodeValue = closedArrowIcon + closedFolderIcon + folderName;
    }
  } catch (e) {
    console.warn("Folder is null");
  }
}

/* Parsing the branches of the tree */
function createFolderName(name) {
  const displayName = closedArrowIcon + closedFolderIcon + name;
  const span = document.createElement("span");
  span.classList.add("folder-name");
  //span.setAttribute("path", "/"+name);
  span.appendChild(document.createTextNode(displayName));
  span.addEventListener("click", changeOpened);
  return span;
}

function fileSize(s) {
  var size="0 B";
  if (s>1073741824)
    size=(s/1073741824).toFixed(3).toString()+" GB";
  else if (s>1048576)
    size=(s/1048576).toFixed(3).toString()+" MB";
  else if (s>1024)
    size=(s/1024).toFixed(3).toString()+" kB";
  else
    size=s.toString()+" B";
  return size;
}

function deleteFile(evt) {
  var file = evt.target.parentNode;
  var path = "/" + file.firstChild.innerText;
  var folder = file.parentNode;
  while (folder.getAttribute("path") !== "/") {
    path = folder.getAttribute("path") + path;
    folder = folder.parentNode.parentNode;
  }
  console.log("Delete "+ path);
  fetch("/files" + path, {
    method: "DELETE",
  }).then(res => {
    if (res.ok) {
       file.parentNode.removeChild(file);
    }
  });
}

function createFileLine(li, file) {
  li.classList.add("file");
  const sp1 = document.createElement("span");
  sp1.classList.add("file-name");
  sp1.appendChild(document.createTextNode(file.name));
  li.appendChild(sp1);
  const sp3 = document.createElement("span");
  sp3.addEventListener("click", deleteFile);
  sp3.classList.add("file-delete");
  sp3.appendChild(document.createTextNode(deleteFileIcon));
  li.appendChild(sp3);
  const sp2 = document.createElement("span");
  sp2.classList.add("file-size");
  sp2.appendChild(document.createTextNode(fileSize(file.size)));
  li.appendChild(sp2);
}

function to_ul(tree) {
  var ul = document.createElement("ul");
  ul.classList.add("hide");
  var branches = tree.branches;
  for (var i = 0, n = branches.length; i < n; i++) {
    var li = document.createElement("li");
    var branch = branches[i];
    if (branch.branches) {
      li.classList.add("folder");
      li.appendChild(createFolderName(branch.name));
      li.appendChild(to_ul(branch));
    } else {
      createFileLine(li, branch);
    }
    ul.setAttribute("path", "/" + tree.name);
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
      //console.log("Parsing data...");
      //console.log(result);
      const app = document.getElementById("treeView");
      const root = to_ul(result);
      root.classList.remove("hide");
      app.appendChild(root);
      console.log("Done");
  }).catch(error => {
    console.error(error);
  });
console.log("End");

