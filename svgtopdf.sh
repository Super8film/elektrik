#!/bin/bash

# Verzeichnis mit den SVG-Dateien
DIR="$HOME/Documents/rohbaecher"

# Prüfen, ob Inkscape installiert ist
if ! command -v inkscape >/dev/null 2>&1; then
    echo "Fehler: Inkscape ist nicht installiert."
    exit 1
fi

# Anzahl erfolgreicher und fehlgeschlagener Konvertierungen
SUCCESS=0
FAILED=0

# Alle draw.io-SVG-Dateien konvertieren
shopt -s nullglob

for INPUT in "$DIR"/*.drawio.svg; do

    # Dateiname ohne .drawio.svg ermitteln
    BASENAME=$(basename "$INPUT" .drawio.svg)

    # PDF-Dateiname erstellen
    OUTPUT="$DIR/$BASENAME.pdf"

    echo "Konvertiere: $(basename "$INPUT")"

    if inkscape "$INPUT" --export-filename="$OUTPUT"; then
        echo "  OK: $(basename "$OUTPUT")"
        ((SUCCESS++))
    else
        echo "  FEHLER: $(basename "$INPUT")"
        ((FAILED++))
    fi

done

echo
echo "================================"
echo "Konvertierung abgeschlossen!"
echo "Erfolgreich: $SUCCESS"
echo "Fehlgeschlagen: $FAILED"
echo "================================"