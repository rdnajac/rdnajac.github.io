function openTab(evt, tabName) {
  // Declare all variables
  var i, tabcontent, tablinks;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tablinks" and remove the class "active"
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }

  // Show the current tab, and add an "active" class to the button that opened the tab
  document.getElementById(tabName).style.display = "block";
  evt.currentTarget.className += " active";

  // Load source code if it's the SourceView tab and hasn't been loaded yet
  if (tabName === 'SourceView' && !window.sourceLoaded) {
    const sourceCode = document.querySelector("#source-container code");
    sourceCode.textContent = "Loading...";
    fetch("https://raw.githubusercontent.com/rdnajac/rdnajac.github.io/main/resume/rdnajac-resume.tex")
      .then(response => response.text())
      .then(data => {
        sourceCode.textContent = data;
        window.sourceLoaded = true;
      })
      .catch(error => {
        console.error("Error:", error);
        sourceCode.textContent = "Failed to load source.";
      });
  }
}

// Open the first tab by default
document.addEventListener("DOMContentLoaded", function() {
  document.getElementsByClassName("tablinks")[0].click();
});
