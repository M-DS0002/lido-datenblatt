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

    try {

        console.log("XML geladen:");
        console.log(xml);

        console.log("XSLT geladen:");
        console.log(xslt);

        // XSLT-Prozessor erzeugen
        const processor = new XSLTProcessor();

        console.log("XSLTProcessor erzeugt");

        // Stylesheet importieren
        processor.importStylesheet(xslt);

        console.log("Stylesheet importiert");

        // Transformation durchführen
        const result = processor.transformToFragment(
            xml,
            document
        );

        console.log("Transformation erfolgreich");
        console.log(result);

        // Ausgabe anzeigen
        output.innerHTML = "";
       if (result) {
    output.innerHTML = "";
    output.appendChild(result);
} else {
    output.innerHTML = "<h2>Die Transformation hat kein Ergebnis geliefert.</h2>";
}

    }
    catch (e) {

        console.error("Fehler bei der Transformation:");
        console.error(e);

        output.innerHTML =
            "<h2>Fehler bei der Transformation</h2>" +
            "<pre>" +
            e +
            "</pre>";

    }

});
