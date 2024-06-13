# Übung 2

Nachdem Sie die Daten zum Streckennetz im GTFS-Format verarbeiten können wollen wir diese in einer graphischen Anwendung den Nutzerinnen und Nutzern zur Verfügung stellen.
Mit dieser Übung implementieren Sie eine eigene graphische Anwendung mit Qt, erstellen im GUI-Builder des Qt-Creator das Layout, verwenden Slots um auf Nutzereingaben zu reagieren und implementieren einen einfachen Such-Algorithmus um Haltestellen im Streckennetz zu finden.

Sie benötigen dabei Ihre Ergebnisse aus Übung 1 um mit den Daten des Streckennetz weiter zu arbeiten und die vorhandenen Klassen zu erweitern.

## Haltestellen suchen

Alle Haltestellen sind in der Datei `stops.txt` definiert und in Ihrer Klasse Network nach der Umsetzung aus Übung 1 im Attribut `stops` gespeichert.

Es ist guter Programmierstil, stets die graphische Oberfläche (den sog. **View**) von Klassen zur Verarbeitung der Daten (dem sog. **Model**) zu trennen. Deswegen implementieren Sie die Funktionalität für die Suche nach Haltestelle in der `Network`-Klasse.

- Richten Sie wieder einen Fork für Übung 2 ein und klonen Sie das Repository auf Ihren Rechner.
- Kopieren Sie Ihre `Network`-Klasse, die `types.h` und alle weiteren benötigten Dateien in ihr Projekt.
- Erweitern Sie die Klasse `Network` um eine Methode `search` mit der Sichtbarkeit public, welche einen `std::string` als Parameter übergeben bekommt und einen `std::vector<Stop>` zurückgibt.
- Implementieren Sie die Methode
  - Übergeben wird ein Suchwort (z.B. "Hauptbahnhof") und als Ergebnis wird ein Vector mit allen Haltestellen zurückgegeben, welche das Wort "Hauptbahnhof" im Namen besitzen.
  - **Freiwillig:** Verbessern Sie die Suche in dem bspw. auch andere Felder einer Haltestelle durchsucht werden oder die suche unabhängig von Groß- und Kleinschreibung funktioniert.

## Qt-Anwendung

Verwenden Sie den Qt-Creator um eine graphische Anwendung zu erstellen. Achten Sie darauf, dass Sie alle Ihre bisherigen Quellcode-Dateien zum Qt-Projekt hinzufügen, damit diese beim Übersetzungsvorgang mit qmake auch berücksichtigt werden.

Erstellen Sie nun mit dem GUI-Builder im Qt-Creator ein Fenster, welches mindestens die folgenden Anforderungen erfüllt:

- Ein Texteingabefeld, in dem Anwenderinnen und Anwender einen Suchbegriff eingeben können.
- Ein Label, welches das Texteingabefeld beschriftet.
- Eine Liste, in der die Suchergebnisse angezeigt werden.

Dokumentation zu Qt:
- https://doc.qt.io/archives/qt-4.8/index.html
- zum Qt-Creator: https://wiki.qt.io/QtCreatorWhitepaper
  - Texteingabefelder: https://doc.qt.io/archives/qt-4.8/qplaintextedit.html
  - Labels: https://doc.qt.io/archives/qt-4.8/qlabel.html
  - Listen
    - https://doc.qt.io/archives/qt-4.8/qlistview.html, 
    - deren Model um Daten anzuzeigen: https://doc.qt.io/archives/qt-4.8/qstringlistmodel.html 
    - und die Qt-Klasse für eine Liste von String: https://doc.qt.io/archives/qt-4.8/qstringlistmodel.html
    - Tutorial für Qt-Listen und Datenanzeige: https://www.bogotobogo.com/Qt/Qt5_QListView_QStringListModel_ModelView_MVC.php
- Datentyp QString: https://doc.qt.io/archives/qt-4.8/qstring.html

## Implementierung der Suche

Wenn Sie im GUI-Builder mit der Gestaltung Ihres Fensters fertig sind müssen nun noch Ihr Model (die Klasse `Network`) und Ihr View (das Fenster) zusammengebracht werden.

- Erweitern Sie die Klasse des Fenstern um ein Attribut, welches vom Typ `Network` ist.
- Erzeugen Sie beim Starten der Anwendung eine Instanz Ihrer Klasse `Network` und weisen Sie diese dem angelegten Attribut zu.

Anschließend müssen Sie auf Texteingaben reagieren, die Suche in Ihrem `Network` durchführen und das Ergebnis in der Liste anzeigen.

- Implementieren Sie eine Methode für einen Slot für das Signal `textChanged` (https://doc.qt.io/qt-6/qplaintextedit.html#textChanged) Ihres Eingabefeldes:
  - Lesen Sie den Text des Eingabefelds aus (https://doc.qt.io/qt-6/qplaintextedit.html#plainText-prop) 
  - Suchen Sie nach passenden Haltestellen mit Ihrer `search`-Methode
  - Zeigen Sie die Ergebnisse in der Liste an

Hinweise zur Verwendung von Signalen und Slots in Qt finden Sie hier:
  - Mit GUI-Builder: https://www.youtube.com/watch?v=P_uYKl5RPTk
  - Variante ohne den GUI-Builder: https://www.youtube.com/watch?v=JakMj5XEBoc

## Abgabe und automatische Auswertung
Die automatische Auswertung prüft Ihre `search`-Methode. Ihre graphische Oberfläche wird bei der persönlichen Abgabe besprochen.

## Freiwillig: Erweitern Sie die Oberfläche
Mit Ihrer Oberfläche werden Sie auch in kommenden Übungen weiter arbeiten und diese stetig ausbauen. Erweitern Sie gerne Ihre Abgabe um zusätzliche Felder und probieren Sie andere GUI-Elemente aus.
