document.addEventListener("DOMContentLoaded", function () {
  const toggleButton = document.getElementById("toggle-source");
  const pdfContainer = document.getElementById("pdf-container");
  const sourceContainer = document.getElementById("source-container");
  const sourceCode = sourceContainer.querySelector("code");
  let sourceLoaded = false;

  toggleButton.addEventListener("click", function (e) {
    e.preventDefault();
    if (pdfContainer.style.display !== "none") {
      pdfContainer.style.display = "none";
      sourceContainer.style.display = "block";
      toggleButton.textContent = "View PDF";
      if (!sourceLoaded) {
        sourceCode.textContent = "Loading...";
        fetch(
          "https://raw.githubusercontent.com/rdnajac/rdnajac.github.io/main/resume/rdnajac-resume.tex",
        )
          .then((response) => response.text())
          .then((data) => {
            sourceCode.textContent = data;
            sourceLoaded = true;
          })
          .catch((error) => {
            console.error("Error:", error);
            sourceCode.textContent = "Failed to load source.";
          });
      }
    } else {
      pdfContainer.style.display = "block";
      sourceContainer.style.display = "none";
      toggleButton.textContent = "View source";
    }
  });
});
