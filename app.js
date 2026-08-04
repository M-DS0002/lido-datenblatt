const fileInput = document.getElementById("xmlFile");
const button = document.getElementById("transformButton");
const saveButton = document.getElementById("saveButton");
const output = document.getElementById("output");

// Speichern zunächst deaktivieren
saveButton.disabled = true;

button.addEventListener("click", async function () {

    if (fileInput.files.length === 0) {
        alert("Bitte wählen Sie zuerst eine LIDO-Datei aus.");
        return;
    }

    const file = fileInput.files[0];

    const xmlText = await file.text();

    const parser = new DOMParser();

    // XML parsen
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
    const result = processor.transformToFragment(
        xml,
        document
    );

    // Ausgabe anzeigen
    output.innerHTML = "";
    output.appendChild(result);

    // Speichern aktivieren
    saveButton.disabled = false;

});

saveButton.addEventListener("click", function () {

    const html =
`<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<title>LIDO-Datenblatt</title>
</head>
<body>
${output.innerHTML}
</body>
</html>`;

    const blob = new Blob(
        [html],
        { type: "text/html;charset=utf-8" }
    );

    const link = document.createElement("a");

    link.href = URL.createObjectURL(blob);
    link.download = "LIDO-Datenblatt.html";

    link.click();

    URL.revokeObjectURL(link.href);

});
