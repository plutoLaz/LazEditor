# LazEditor

Eine Editor Komponente für Lazarus.

Es sollen folgende Formatierungen unterstützt werden:
- Fett
- kursiv
- Unterstrichen
- Durchgestrichen
- Vordergrund Farbe
- Hintergrund Farbe
- Schrift Größen
- Schrift Name
- Zeilen Ausrichtungen(Links, Zentriert, Rechts, Block)
- Paragraph
- Grafiken(Auch im Fließtext)
- Tabellen

# Verschiedene Tests

Bisher liegen hier verschiedene Konzept Ideen. Die Unterschiedlich weit sind und unterschiedliche Ideen verfolgen.

## 1. plEditor_02062021

Hier verwende ich eine Zeilen/Spalten Struktur. Die Idee:
Es gibt keine Style Verwerbung. Jede Spalte hat eine Eindeutige Formatierung. 
Durch die Zeilen/Spalte Struktur war/ist die Hoffnung, dass die Cursor Steuerung ermöglich wird.
Es wird eine Wörterliste erstellt.

Einzelne Wörter können bereits ausgewählt werden. 

## 2. pr1

Es gibt eine "Langezeile", die Zeilenelemente enthält, alle 254 Zeichen wird ein neues Zeilenelement erstellt.
So die Idee. Durch Steuerzeichen soll die Formatierung umgesetzt werden.

Es gibt derzeit zwei Arten von Zeilenelementen: Die eine, enthält die "Steuerzeichen" und die andere den Text.

## 3. pr2

Aus einer Baumstruktur wird die Zeilen/Spalten struktur erstellt. Im Prinzip wie bei "plEditor_02062021", nur ohne eine Wörterliste.
Bei diesem Versuch habe ich erkannt, dass eine Vererbung auch für eine Editor Komponente durchaus Sinn machen würde.

## 4. pr3 

Es gibt eine Baumstruktur. Jede Box hat eine Display Eigenschaft. Im Moment gibt es Inline/Block Boxen.
Hier habe ich noch Probleme beim Rendern.
