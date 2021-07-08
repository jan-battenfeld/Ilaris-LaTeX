\ProvidesClass{rpg-ilaris}[2021/01/01 v1.3 Ilaris Spielhilfenklasse von Jan Battenfeld]

\PassOptionsToClass{ngerman,% Neue deutsche Rechschreibung
	twoside,                % linke und rechte Seite unterschiedlich
	open=any,               % Kapitel starten auf beiden Seiten
	parskip=no,             % Neuen Absatz mit Einzug deutlich machen
	fontsize=10pt}{scrbook} % Schriftgröße und Vorlage (KOMA-Script)

\newcommand{\TOCnum}{2} % Standard zweispaltiges Inhaltsverzeichnis
\DeclareOption{singleTOC}{\renewcommand{\TOCnum}{1}}
\DeclareOption{doubleTOC}{\renewcommand{\TOCnum}{2}}
\DeclareOption{tripleTOC}{\renewcommand{\TOCnum}{3}}

\newcommand{\atvt}[3]{\textbf{VT}\makebox[1.3em][r]{#1} #3 \textbf{AT}\makebox[1.3em][r]{#2}}
\DeclareOption{ATvorVT}{
	\renewcommand{\atvt}[3]{\textbf{AT}\makebox[1.3em][r]{#2}  #3 \textbf{VT}\makebox[1.3em][r]{#1}}
	}

\def\waffecls{}
\DeclareOption{classicWaffen}{ \def\waffecls{foo} }

% Hängender Einzug auch bei Linksbund: Mit "\RaggedRight" oder "\iraggedright" definieren
\DeclareOption{linksbund}{\makeatletter\g@addto@macro\document{\RaggedRight \parindent=1em}\makeatother}
\DeclareOption{linksbundOhneTrennung}{\makeatletter%
	\newcommand\iraggedright{\let\\\@centercr\@rightskip\@flushglue \rightskip\@rightskip \leftskip\z@skip}%
	\g@addto@macro\document{\iraggedright}
\makeatother}

% Alle weiteren (unbekannten) Optionen an scrbook weitergeben
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax
\LoadClass{scrbook}

% Leerseiten durch clear*doublepage haben auch Hintergrund (wird über PassOptionsToClass oben ignoriert) %BUG
\KOMAoptions{cleardoublepage=current} 

\RequirePackage[table]{xcolor} % Muss vor tikz geladen werden
\RequirePackage{
	%babel, stattdessen polyglossa
	booktabs,   % Tabellen: \toprule, \midrule, \bottomrule
	ocg-p,      % Ebenen für transparenten Hintergrund beim Drucken
	ragged2e,   % TODO: Optional laden bei Option 'linksbund' scheitert
	% setspace,   % Für \onehalfspacing (Nicht nötig für Standard-Ilaris-Style)
	% nicefrac,   % Brüche mit schrägem Strich
	scrlayer-scrpage, % Individuelle Header für KOMA-Script
	enumitem,   % Listen anpassen
	multicol,   % Zweispaltiges Layout
	tabularx,   % Tabellen mit dynamischer Breite
	tikz,       % Grafik-Tool
	microtype   % Typografische Feinjustierung
}
\definecolor{black}{gray}{0} % 10% gray
\RequirePackage[bookmarks,pdfusetitle,colorlinks,linkcolor=black,citecolor=black,urlcolor=blue,breaklinks]{hyperref}

% Kapitelüberschriften mit Zierbalken
\RequirePackage{varwidth} %Breite anpassen für überlange Zeilen 
\renewcommand*{\raggedchapter}{\centering}
\renewcommand\chapterlinesformat[3]{%
      \scalebox{-1}[1]{\raisebox{-0.3\height}{\includegraphics[height=1.4cm]{./borde.png}}}%
	  \hspace{0.2em}%
      \begin{varwidth}{\dimexpr\textwidth-9em\relax}%
        \raggedchapter#2#3%
      \end{varwidth}%
	  \hspace{0.2em}%
	  \raisebox{-0.3\height}{\includegraphics[height=1.4cm]{./borde.png}}%
      \par\nobreak
      \par
}

%%%%%%%%%%%%%%%%
\makeatletter

% Inhaltsverzeichnis auf mehrspaltig setzen, wenn TOCnum>1
\ifnum\TOCnum>1
\g@addto@macro\document{% Mehrspaltiges TOC
	\BeforeStartingTOC[toc]{\begin{multicols}{\TOCnum}}%
	\AfterStartingTOC[toc]{\end{multicols}}%
}
\fi

% Nach ...skips keinen Einzug einfügen!
\def\nind{\@afterindentfalse\@afterheading}
\def\bigskip{\vspace{\bigskipamount}\nind}
\def\medskip{\vspace{\medskipamount}\nind}
\def\smallskip{\vspace{\smallskipamount}\nind}

\makeatother
%%%%%%%%%%%%%%%

\newcommand{\begriff}[1]{\textbf{#1}}
\newenvironment{geschichte}{\medskip\begingroup\begin{addmargin}{0pt}\em}{\end{addmargin}\endgroup\aftergroup\smallskip}
\newenvironment{kasten}[2]{\begingroup%
	\begin{ocg}{Kasten}{2}{1}
		\noindent\tikz[overlay, blend mode=multiply]%
		\draw (0.5\linewidth,-#1/2-0.1cm) node[inner sep=0pt]{\includegraphics[width=1.03\linewidth,height=#1]{kasten.jpg}};%
	\end{ocg}
	\begin{ocg}{Rahmen-statt-Kasten-Druck}{3}{0}
		\noindent\tikz[overlay, blend mode=multiply] \draw (0,-#1) rectangle  (1\linewidth,0-0.1cm);%
	\end{ocg}
\begin{addmargin}{0.3cm}
\minisec{#2}}{\end{addmargin}\endgroup\aftergroup\medskip}
\newcommand{\beispiel}[2][black]{\textcolor{#1}{#2}}

\newcommand{\WsMrGsIni}[4]{\makebox[7.4em][l]{\textbf{Wundschwelle}} #1 \hfill \textbf{Magieresistenz} \enskip #2 \quad\! \\
\makebox[7.4em][l]{\textbf{Geschwindigkeit}} #3 \hfill \textbf{Initiative} \enskip #4 \quad\! \\ }

\newcommand{\waffe}[6]{\makebox[0.33\linewidth][l]{» \textbf{#1} \ifx\waffecls\empty\ (#2) \else\fi } \ifx\waffecls\empty \else \textbf{RW} #2 \fi \hfill \atvt{#3}{#4}{
	\quad
	% \hfill
	}  \hfill \textbf{TP}\makebox[0.16\linewidth][l]{ \enskip #5 \quad\! } \def\mnvr{#6} \ifx\mnvr\empty \\[0.3em] \else \\[0.3em]  \begin{addmargin}[2em]{0em}\fontsize{10}{12} #6 \\[0.3em]\end{addmargin} \fi }

\newcommand{\trennlinie}[1][0.4pt]{\par\vskip 0.4ex \hrule height #1 \par\vskip 1ex}

% Als Notiz aus https://tex.stackexchange.com/questions/58628/optional-argument-for-newcommand
% \newcommand{\test}[1][]{ \def\tst{#1} \ifx\tst\empty {optional argument was omitted} \else {optional argument was given: '#1'} \fi }

\newenvironment{gegner}[6]{\begingroup\bigskip\begin{minipage}{0.95\linewidth}\begin{minipage}[b]{0.87\linewidth}\subsection*{#1} \footnotesize \emph{#2} \end{minipage}\def\bld{#3} \ifx\bld\empty \else \hfill\includegraphics[width=0.1\linewidth]{#3} \fi \trennlinie[0.8pt]
	\footnotesize #4 \trennlinie \def\vrtl{#5} \ifx\vrtl\empty \else #5 \trennlinie \fi #6}{\trennlinie[0.8pt]\end{minipage}\endgroup\aftergroup\bigskip}

\newcommand{\alphagraphics}[2][width=\linewidth]{\begin{tikzpicture}%
	\node [blend mode=multiply] at (0,0) {\includegraphics[#1]{#2}};%
\end{tikzpicture}}

%%%%%%%%%%%%%%%%

\RequirePackage[top=20mm, bottom=15mm, outer=15mm, inner=15mm, marginparsep=10mm, marginparwidth=20mm, head=12.5mm, foot=8mm]{geometry}


\clearpairofpagestyles

\RequirePackage{ifxetex}
\ifxetex
    \RequirePackage{polyglossia}
	\setdefaultlanguage{german}
    \RequirePackage{fontspec}
	\defaultfontfeatures{
		% Path="./",          % Im aktuellen Ordner nach den Schriften suchen - Für Online-LaTeX-Editoren aktivieren TODO
		Ligatures=TeX}
		\setmainfont[         % TODO Evtl Schriftnamen anpassen, so dass sie auf vorhandene passen
			ItalicFont=* Italic,
			BoldFont=* Bold Subhead,
			BoldFeatures={SmallCapsFont=Minion-SemiboldSC},
			% SmallCapsFont=Minion-RegularSC,
			BoldItalicFont=* Bold Italic,
			Ligatures=TeX
			]{Minion Pro}
		\setsansfont[
			BoldFeatures={SmallCapsFont=Minion-SemiboldSC}
			]{Minion Pro}
        % \setmathfont{XITS Math}
\newfontfamily{\uberschrift}{Aniron}
\else
        \RequirePackage[T1]{fontenc}
		\RequirePackage{lmodern}
		\RequirePackage[ngerman]{babel}
\newcommand{\uberschrift}{}  % Für LaTeX den Befehl uberschrift leeren, damit Überschriften in Standardschrift gesetzt werden.
\fi


\RedeclareSectionCommand[beforeskip=0.1\baselineskip]{chapter}
\RedeclareSectionCommands[
	% beforeskip=-2\baselineskip,
	runin=false,
	beforeskip=-0.5\baselineskip,
	afterskip=-0.1\baselineskip
]{section,subsection,subsubsection}

\addtokomafont{chapter}{\fontsize{30}{36}\uberschrift}
\addtokomafont{section}{\Large\uberschrift} 
\addtokomafont{subsection}{\fontsize{15.1}{16}\scshape} 
\addtokomafont{subsubsection}{\fontsize{12}{12}\scshape} 
\addtokomafont{minisec}{\normalfont\bfseries}

% Inhaltsverzeichnis
\setkomafont{chapterentry}{\LARGE \scshape \textbf}
\setkomafont{chapterentrypagenumber}{\normalfont\normalsize}

% Nummern in section ausblenden
\setcounter{secnumdepth}{0}
% Inhaltsverzeichnis -> Inhalt
\addto{\captionsgerman}{\renewcommand*{\contentsname}{Inhalt}}


\pagestyle{scrheadings}
\cehead*{
	\begin{ocg}{Hintergrund}{1}{1}
	\tikz[remember picture,overlay] \node[inner sep=0pt] at (current page.center){\scalebox{-1}[1]{\includegraphics[width=\paperwidth,height=\paperheight]{hintergrund.jpg}}};
	\end{ocg}
	}
\cohead*{
	\begin{ocg}{Hintergrund}{1}{1}
	\tikz[remember picture,overlay] \node[inner sep=0pt] at (current page.center){\includegraphics[width=\paperwidth,height=\paperheight]{hintergrund.jpg}}; 
	\end{ocg}
	}

\ofoot*{\qquad\textbf{\normalfont\LARGE\thepage}\qquad}

% Zebrastreifen in Tabellen
\rowcolors{2}{}{brown!47}

% Listenabstand
\setlist[enumerate]{topsep=8pt,itemsep=-1ex,partopsep=8pt,parsep=1ex,leftmargin=3ex}

% Tabellen vertikal zentrieren
\renewcommand{\tabularxcolumn}[1]{m{#1}} 
%-- FIN --
