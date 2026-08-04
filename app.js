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

// XSLT laden
const xsltText = await fetch("datenblatt.xsl")
    .then(response => response.text());

// XSLT parsen
const xslt = parser.parseFromString(
    xsltText,
    "text/xml"
);

// XSLT-Prozessor erzeugen
const processor = new XSLTProcessor();

// Stylesheet importieren
processor.importStylesheet(xslt);

// Transformation durchführen
const result = processor.transformToFragment(xml, document);

// Ausgabe anzeigen
output.innerHTML = "";
output.appendChild(result);

});
