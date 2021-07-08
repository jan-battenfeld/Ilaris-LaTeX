# Spielhilfe für Ilaris auf LaTeX-Basis

Diese Vorlage soll es allen Ilaris-Spielern ermöglichen, möglichst einfach gut gelayoutete Spielhilfen mit Hilfe von LaTeX im Stil der originalen Ilaris-Regeln zu erstellen. Eine Lizenz ist noch nicht endgültig überlegt, aber viel mehr als Namensnennung und eine Form des Copyleft wird es nicht werden. Wer unsicher ist fragt bis dahin einfach freundlich nach.

## Beispiel

![vergleich1.gif](Original und 3 "nachgebaute" Versionen, mit jeweils anderer Textausrichtung)


### Einleitung und Beispieldokument

[Ilaris.Spielhilfe.pdf](Spielhilfen-Vorlage und Erklärung)
[Ilaris.Spielhilfe.tex](Quelltext zur Datei)


## LaTeX - Installation vs Online

* Um eigene Dateien auf dem eigenen Rechner zu erzeugen, braucht es eine (Xe)LaTeX Distribution. Diese sind circa ein Gigabyte groß und lohnen wohl nur, wenn man öfter mit LaTeX arbeiten möchte. Auf aktuellen Linux-Distributionen und Apples sollte man in seiner Paketverwaltung nach texlive und xelatex suchen. Bei Windows entsprechend eine passende Distribution nehmen (Als ich zuletzt nachgeguckt hab, gab es heiße Debatten um Texstudio und texlive - ist aber schon länger her).
* Die Vorlage kann alternativ auch mit LaTeX-Online-Editoren bearbeitet werden: Sowohl [https://overleaf.com] (mit Registrierung) als auch [https://cocalc.com/] (Ohne Registrierung) funktionieren, wenn die Schriften (Links folgen), die `hintergrund.jpg`, `kasten.jpg` und `borde.png` hochgeladen werden und in der Klassendatei `rpg-ilaris.cls` ab der **Zeile 136** bei `<defaultfontfeatures>` der Pfad aufs aktuelle Verzeichnis gesetzt wird. 

@TODO@ Eine Anleitung und Komplettpaket für LaTeX-Neulinge, wie man am besten den Online-Editor zum Laufen bringt, folgt mit dem Schriftenpaket als Nächstes :)


### Benötigte Schriften

@TODO@
## Einrichtung
Hat sich noch einmal vereinfacht, da jetzt alles in einer LaTeX-Klasse vorhanden ist.
Vor dem Start sind minimale Anpassungen nötig:
   * Wegen der Schriftarten wird XeLaTeX benötigt.
   * Die *Minion-Pro* und *Aniron* Schriftarten müssen vorhanden sein, und wahrscheinlich noch passend umbenannt werden. Eine vernünftige Auswahl gibt es auf [https://www.wfonts.com/font/minion-pro](wfonts.com » Minion Pro) und [https://www.wfonts.com/font/aniron](wfonts.com » Aniron)-- Die benötigten Varianten für Minion Pro sind: MinionPro-Regular, -Bold, -BoldIt, -It -- Es fehlen allerdings noch die Kapitälchen (SmallCaps/SC) in Regular und Bold.
   * Sollte es bei den Online-Editoren Probleme mit den Schriftarten geben, muss entweder in der rpg-ilaris-Klasse ein "./" vor die Schriften vorangestellt werden. Einfachheitshalber ist in der Spielhilfe eine Zeile mit einer globalen Pfadangabe, in der man auch die Schriftdateinamen ändern kann. *@TODO@ Weitere Vereinfachung folgt in der nächsten Version* 
   * Du musst dich für eine Ausrichtung entscheiden -- ich empfehle Blocksatz (das ist voreingestellt)
   TODO Aniron
   TODO -SC und -SCBold

Es gibt mehrere Ebenen, um beim Druck Tinte sparen zu können
Syntax: `\begin{ocg}[printocg=never]{Angezeigter Ebenenname}{ID}{Sichtbarkeit beim Öffnen: 0/1}`
        Option: printocg: ifvisible (default)

### Automatisierung des PDF Erzeugens
Um dir das Tippen zu erleichtern, benutze `latexmk`! Im Verzeichnis, in der auch die Dateien liegen diesen Befehl ausführen, damit bei jedem Speichern des Quelltextes die PDF aktualisiert wird (PDF-Viewer mit Aktualisierungsfunktion benutzen - es könnte Probleme mit Adobe unter Windows geben).
```
	> latexmk -pvc -interaction=nonstopmode -xelatex Ilaris.Spielhilfe.tex
```

-----

## TODOs

* chapter-Nummern in der Klasse deaktivieren + chapter* und addchap in Doku durch chapter ersetzen
* Trennbalken wie im Bestiarium auf Seite 100
* Gegnerkästen
* Zaubervorlage?
* Tabellen:
	* Mehrere Seiten checken mit tabularx/y
	* Automatische Vorlagen?
* Index noch nötig?

## Wichtigste Formatierungen
```
						↓ Kapitel-Überschrift über beide Spalten
\begin{multicols}{2}[ \addchap{Kapitel} ]
    Zeispaltiger Bereich
    ...
    ...
   (auch über mehrere Seiten)
\end{multicols}
```

```
\section{Überschrift}            \section*{Überschrift, die nicht im Inhaltsverzeichnis auftaucht}
\subsection{Unterüberschrift}    \subsection*{Unterüberschrift}
\subsubsection{...}              \subsubsection*{Unter$^2$überschrift}
\minisec{Für Manöver oder Vorteile}
```
---
```
\begin{kasten}{höhe}{erste Überschrift}
	\minisec{weitere Überschriften im Kasten}
	Textblöcke...
\end{kasten}
```
---
```
\begin{geschichte}
   Kursiver Block für Einleitung, Beispiele, Vorlesetexte
\end{geschichte}
```
---
Bilder:
```
\includegraphics[width=0.5\linewidth]{grafik.png}
\alphagraphics... um alles weiße im Bild in Transparenz umzuwandeln.
```
---
Tabelle mit genaueren Layoutmöglichkeiten als tabular:
```
\begin{tabularx}{\linewidth}{cXcc} % 2.Spalte hat variable Breite
   1 & 2 & 3 & 4 \\                % (c)enter, (l)eft, (r)ight, p{1cm} : feste Breite
   a & b & c & d  \\               % @{abstand} : Spaltenabstand - Bsp: ...{@{}cc@{}} : Rand entfernen
\end{tabularix}                                                    Bsp: ...{r@{\ }l} : nur ein Leerzeichen Abstand zwischen right_left
```
---
Textformatieren: 
```
\begriff{Fett}
\emph{Kursiv}
\textsc{Kapitälchen} 
\begriff{textsc{Fette Kapitälchen}}
```
---
Steuerung des Textflusses (mit seinen eigenen speziellen LaTeX-Eigenheiten!)
   * Seitenumbrüche: `\clearpage` `\cleardoublepage` `\cleardoubleoddpage` `\cleardoubleevenpage`
   * Spaltenumbruch: `\columnbreak` (füllt auf! Siehe Beispiele im Quelltext)

Abstände einfügen:
   `\smallskip` `\medskip``\bigskip`
