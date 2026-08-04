const fileInput = document.getElementById("xmlFile");
const button = document.getElementById("transformButton");
const output = document.getElementById("output");

button.addEventListener("click", async function () {

    if (fileInput.files.length === 0) {
        alert("Bitte wählen Sie zuerst eine LIDO-Datei aus.");
        return;
    }

    const file = fileInput.files[0];

    const xmlText = await file.text();

    const parser = new DOMParser();

    const xml = parser.parseFromString(
        xmlText,
        "text/xml"
    );
	
	const xsltText = await fetch("datenblatt.xsl")
    .then(response => response.text());

	const xslt = parser.parseFromString(
    xsltText,
    "text/xml"
	);

    output.innerHTML =
    "<h2>XML und XSLT erfolgreich geladen</h2>";

});