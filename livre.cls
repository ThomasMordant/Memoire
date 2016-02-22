%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Classe livre de R. Alexandre --- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{livre}

% --- Option pour l'adaptation du document aux tablettes ---

\newif\iftablette\tablettefalse
\DeclareOption{tablette}{\tablettetrue}
\ProcessOptions\relax

\iftablette
	\PassOptionsToPackage{
		top=2cm, bottom=2cm, left=2cm, right=2cm,
		marginparsep=7.5mm, marginparwidth=5cm,
		headsep=2em, footskip=4em,
		paperwidth=15.625cm, paperheight=25cm
	}{geometry}
\else
	\PassOptionsToPackage{
		top=2cm, bottom=2cm, left=3cm, right=3cm,
		headheight=\baselineskip, headsep=2em, footskip=4em,
		marginparsep=7.5mm, marginparwidth=5cm
	}{geometry}
	\PassOptionsToClass{a4paper}{book}
\fi

\LoadClass[11pt, oneside]{book}

% --- Packages utiles ---

\RequirePackage[utf8]{inputenc}
\RequirePackage[french]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage{geometry}
\RequirePackage{lmodern}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage[usenames, dvipsnames]{xcolor}
\RequirePackage{url}
\RequirePackage{appendix}
\RequirePackage[backend=biber, style=trad-alpha, bibstyle=trad-alpha, citestyle=trad-alpha]{biblatex}
%\RequirePackage{asymptote}
%\RequirePackage{tkz-graph}
%\RequirePackage{tkz-berge}
%\RequirePackage{graphviz}
%\RequirePackage{sagetex}
%\RequirePackage{makeidx}
%\RequirePackage{tikz}
\RequirePackage{graphicx}
\RequirePackage[all]{xy}
\RequirePackage{enumitem}
\RequirePackage{dsfont}
\RequirePackage{float}
\RequirePackage[plainpages=false, pdfpagelabels]{hyperref}

% --- Inclusion des commandes générales de cours ---

\input{commandes.tex}

% --- Couleurs des liens ---

\hypersetup{
	colorlinks=true,
	breaklinks=true,
	urlcolor=black,
	linkcolor=black,
	citecolor=black
}

% --- Début du document ---

\AtBeginDocument{\maketitle\frontmatter\doparttoc\addtocontents{toc}{\protect\thispagestyle{nopage}}}

\appto\frontmatter{\pagestyle{nopage}}
\appto\mainmatter{\pagestyle{normale}}
\appto\backmatter{\pagestyle{nopage}}

% --- Page de garde ---

\newcommand{\titre}[1]{
	\title{#1}
	\hypersetup{pdftitle={#1}}
}
\newcommand{\soustitre}[1]{
	\def\@soustitre{#1}
	\hypersetup{pdfsubject={#1}}
}
\newcommand{\auteurs}[1]{
	\def\@auteurs{#1}
	\hypersetup{pdfauthor={#1}}
}
\newcommand{\illustration}[1]{\def\@illustration{#1}}
\def\@date{}
\renewcommand{\date}[1]{\def\@date{#1}}
\newcommand{\lieu}[1]{\def\@lieu{#1}}
\newcommand{\externes}[1]{\def\@externes{#1}}

\renewenvironment{titlepage}{%
	\cleardoublepage
	\if@twocolumn
		\@restonecoltrue\onecolumn
	\else
		\@restonecolfalse\newpage
	\fi
	\thispagestyle{empty}%
	\setcounter{page}\z@
}{%
	\restoregeometry
	\if@restonecol\twocolumn \else \newpage \fi
}

\renewcommand{\maketitle}{%
	\begin{titlepage}%
		\let\footnotesize\small
		\let\footnoterule\relax
		\let \footnote \thanks
		\null
		\ifdefined\@illustration\relax\else
			\vspace{3cm}
		\fi
		\begin{center}%
			\Huge
			\linespread{1.5}\selectfont
			\MakeUppercase{\@title}
			
			\linespread{1}\selectfont
			\ifdefined\@soustitre\relax
				\vspace{.3cm}
				{\Large\@soustitre}
			\fi

			\ifdefined\@auteurs\relax
				\vspace{1cm}
				{\LARGE\@auteurs}
			\fi

			\vfill

			\ifdefined\@illustration\relax
				\@illustration
			\fi
		\end{center}
		\vfill

		\noindent{\LARGE
		\begin{minipage}{.5\linewidth}
			\strut
			\ifdefined\@date\relax
				\@date
			\fi

			\ifdefined\@lieu\relax
				\@lieu
			\fi
		\end{minipage}%
		\begin{minipage}{.5\linewidth}
			\strut
			\raggedleft
			\ifdefined\@externes\relax
				\@externes
			\fi
		\end{minipage}
		}

		\vspace{2cm}\null
	\end{titlepage}%
	\setcounter{footnote}{0}%
	\global\let\thanks\relax
	\global\let\maketitle\relax
	\global\let\@thanks\@empty
	\global\let\@author\@empty
	\global\let\@date\@empty
	\global\let\author\relax
	\global\let\date\relax
	\global\let\and\relax
}

% --- Rédéfinitions des sections ---

\RequirePackage{titlesec}

\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\setthesection}{\Alph{section}} % Numérotation de sous-annexes

\setcounter{secnumdepth}{3} % Numérotation des sections jusqu'au sous-sous-section

\renewcommand{\part}{ % Style des parties
	\if@openright
		\cleardoublepage
	\else
		\clearpage
	\fi
	\thispagestyle{normale}%
	\if@twocolumn
		\onecolumn
		\@tempswatrue
	\else
		\@tempswafalse
	\fi
	\secdef\@part\@spart%
}

\newif\ifnewpart\newpartfalse % Booléen pour savoir s'il y a une nouvelle partie.
\def\@part[#1]#2{ % Style des parties
	\ifnum \c@secnumdepth >-2\relax
		\refstepcounter{part}%
		\addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
	\else
		\addcontentsline{toc}{part}{#1}%
	\fi
	\markboth{}{}%
	{\centering
	\interlinepenalty \@M
	\normalfont
	\ifnum \c@secnumdepth >-2\relax
	\huge\bfseries \partname\nobreakspace\thepart
	\par
	\vskip 20\p@
	\fi
	\Huge \bfseries #2\vskip2\baselineskip\par}%
	\label{partie:\thepart}%
	\global\newparttrue % On le met à vrai.
}

\def\@spart#1{ % Styles des parties sans numéro
	{\centering
	 \interlinepenalty \@M
	 \normalfont
	 \Huge \bfseries #1\vskip2\baselineskip\par}%
}

\renewcommand{\chapter}{
	\ifnewpart\else % On test.
		\newpage
	\fi
	\global\newpartfalse % Et on le met à feux
	\thispagestyle{empty}%
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter
}

\renewcommand{\appendix}{ % Annexes
	\par
	\setcounter{chapter}{0}%
	\setcounter{section}{0}%
	\gdef\@chapapp{\appendixname}%
	\gdef\thesection{\@Alph\c@section}%
	\def\sectionname{Appendice}
}

\newcounter{@presSection}

\let\oldeverypar\everypar
\newtoks\everypar
\oldeverypar{\the\everypar\stepcounter{@presSection}}

\newcommand{\Saut}{%
	\ifnum\the@presSection>0%
		\par\addvspace\bigskipamount\par
	\fi%
	\global\stepcounter{@presSection}%
}

\newcommand{\@presSection}{\global\setcounter{@presSection}{0}}

\normalfont\DeclareFontShape{T1}{lmr}{bx}{sc} { <-> ssub * cmr/bx/sc }{}

\titleformat{\section}{\Large\bfseries\scshape}{\thesection}{1em}{}[\@presSection]
\titleformat{\subsection}{\large\bfseries}{\thesubsection}{1em}{}[\@presSection]
\titleformat{\subsubsection}{\scshape}{\thesubsubsection}{1em}{}[\@presSection]
\titleformat{\paragraph}[runin]{\scshape}{}{1em}{}[.]
\titlespacing{\paragraph}{\z@}{\bigskipamount}{1em}

\patchcmd{\ttl@straight@ii}{\vspace{\@tempskipb}}{\vskip\@tempskipb}{}{}

% --- En-tête et pied-de-page ---

\RequirePackage{fancyhdr}

\newcommand{\@maison}{\includegraphics[height=.7em]{maison}}
\newcommand{\@cadrerouge}[1]{\fboxsep3pt\color{red!15}\fbox{\color{black}#1}}

\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\fancypagestyle{normale}{%
	\fancyhead{}
	\fancyfoot{}
	\rhead{%
		\small%
		\ifodd\thepage\relax
			\parbox[b]{.9\linewidth}{\raggedleft\rightmark}
		\else
			\parbox[b]{.1\linewidth}{\raggedleft\thepage}
		\fi
	}
	\lhead{%
		\small%
		\ifodd\thepage\relax
			\parbox[b]{.1\linewidth}{\thepage}
		\else
			\parbox[b]{.9\linewidth}{\leftmark}
		\fi
	}
}

\fancypagestyle{nopage}{
	\fancyhead{}
	\fancyfoot{}
	\lhead{\small\ifodd\value{page}\else\thepage\fi}
	\rhead{\small\ifodd\value{page}\relax\thepage\fi}
}


\pagestyle{normale}

\advance\textheight by -2em

% --- Notes en pied-de-page ---

\newcommand{\@noteContent}[1]{\parbox[t]{\dimexpr\linewidth-\leftmargin}{#1}}
\newcommand{\note}[1]{\footnote{\@noteContent{#1}}}

\let\thempfootnote\thefootnote % Évite l'erreur quand on met une note dans une minipage
\renewcommand{\thefootnote}{\S\arabic{footnote}}

\let\footnotetextold\footnotetext
\renewcommand{\footnotetext}[2][]{
	\def\@content{\@noteContent{#2}}
	\def\@tempa{#1}
	\ifx\@tempa\@empty
		\footnotetextold{\@content}
	\else
		\footnotetextold[#1]{\@content}
	\fi
}

% --- Marges ---

\RequirePackage{marginnote}

\reversemarginpar 
\newcommand{\notemarge}[1]{\marginnote{#1}}
\newcommand{\imgmarge}[1]{\notemarge{\includegraphics[width=\linewidth]{#1}}}
\newcommand{\urlmarge}[1]{\notemarge{Voir \url{#1}}}
\newcommand{\annexemarge}[1]{\notemarge{Annexe : #1}}

% --- Image sans marges ---

\newcommand{\imgnomarge}[1]{%
	\par\noindent%
	\makebox[\textwidth][r]{\includegraphics[width=\dimexpr\paperwidth-\marginparsep-\marginparwidth]{#1}}%
	\par%
}

% --- Sommaire ---

\setcounter{tocdepth}{1} % Profondeur du sommaire (sera affiché les sous-sections), avant : 2

\addto\captionsfrench{%
	\renewcommand{\contentsname}{Sommaire}%
}

\newcommand{\tocentree}[2][section]{\addcontentsline{toc}{#1}{\hspace*{1em}#2}}

% --- Tables des matières ---

\RequirePackage[french]{minitoc}

\renewcommand{\beforeparttoc}{}
\renewcommand{\afterparttoc}{\newpage}

\setcounter{parttocdepth}{3}

\renewcommand{\parttoc@}[1][]{ % Personnalisation des \parttoc
	\global\@parttoc@used@true
	\if@mtc@longext@%
		\def\@tocfile{ptc\Thepart}%
	\else
		\def\@tocfile{P\Thepart}%
	\fi
	\mtc@CkFile{\jobname.\@tocfile}
	\if@mtc@FE
		\mtcPackageInfo[I0006]{minitoc}%
		{\jobname.\@tocfile\space is empty}
		\@mtc@empty@parttoc@true
	\else
		\beforeparttoc
		\@ifundefined{chapter}{}{%
		\global\let\mtc@markboth\markboth \global\let\@mkboth\markboth
		\thispageparttocstyle
		\mtc@markboth{\MakeUppercase{\ptctitle}}{\MakeUppercase{\ptctitle}}}%
		\relax\begin{samepage}%
		\if #1e\let\do@ptitc\e@pti
		\else\if #1n\let\do@ptitc\n@pti
		\else\if #1c\let\do@ptitc\c@pti
		\else\if #1l\let\do@ptitc\l@pti
		\else\if #1r\let\do@ptitc\r@pti
		\else\if #1d\let\do@ptitc\df@ptitc
		\fi\fi\fi\fi\fi
	\fi
	\mtc@CkStr{\ptctitle}\if@mtc@FE \let\do@ptitc\e@pti\relax\fi
	\raggedright \reset@font\ptcfont \parskip=\z@ \parindent=\z@%
	\nopagebreak[4]\kern-0.8\baselineskip\nopagebreak[4]%
	\par\noindent \nopagebreak[4]%
	\ifx\ptc@rule\relax
		\reset@font\ptifont{\mtc@v\ptctitle}
	\else
		\begin{tabular}{@{}p{\columnwidth}@{}}
			\reset@font\ptifont{\mtc@v\ptctitle}\\[40\p@]\hline
		\end{tabular}%
	\fi

	\leftmargin\ptcindent \rightmargin\ptcindent
	\itemindent=\z@ \labelwidth=\z@ \labelsep=\z@ \listparindent=\z@%
	\begin{ptc@verse}{\ptcoffset}\c@tocdepth=\c@parttocdepth%
		\leavevmode\\\mtc@BBR\vskip -.5\baselineskip
		\begingroup
		\makeatletter
			\@ifundefined{ptc@pgno}%
				{\let\@dottedtocline\@undottedtocline}{}
			\@ifundefined{ptc@pgno}%
				{\let\l@chapter@SVPN\l@chapter%
			\def\l@chapter##1##2{\l@chapter@SVPN{##1}{\hbox{}}}}{}
			\@fileswfalse\mtc@hook@beforeinputfile
			\ptc@setform
			\openparttoc\global\inparttoctrue
			\@input{\jobname.\@tocfile}%
			\global\inparttocfalse\closeparttoc
			\vspace{-1ex} \vspace{-1\baselineskip}
			\leavevmode\mtc@strut
			\global\@nobreakfalse
		\endgroup
	\end{ptc@verse}%
	\kernafterparttoc
	\nopagebreak[4]\ptc@rule\null\leavevmode\\%
	\vskip-1.0\baselineskip
	\mtc@zrule\end{samepage}%
	\par\@ifundefined{chapter}{\pagebreak[1]\vspace*{-1ex}}%
	\afterparttoc\fi
}

\renewcommand{\kernafterparttoc}{\kern-\baselineskip}

% --- Résumé ---

\newcommand{\resume}[1]{%
	\titlepage
	\null\vfill
	\@beginparpenalty\@lowpenalty
	\begin{center}%
		\bfseries Résumé
		\@endparpenalty\@M
	\end{center}%
		#1\par\vfill%
	\begin{center}%
		Image ici
	\end{center}%
	\endtitlepage%
}

% --- Environnement itemize ---

\RequirePackage{enumitem}
\frenchbsetup{StandardLists=true}
\renewcommand{\labelitemi}{$\bullet$}

% --- Partie méthodes ---

\newcommand{\methode}{ % Méthodes
	\par
	\setcounter{chapter}{0}%
	\setcounter{section}{0}%
	\gdef\@chapapp{Méthodes}%
	\gdef\thesection{\@arabic\c@section}%
}

% --- Exercice ---

\newcommand{\regle@centree}{%
	\leavevmode\leaders\hrule height \dimexpr.25\baselineskip+1pt\relax depth \dimexpr -.25\baselineskip+1pt\relax \hfill\kern0pt%
}

\newcounter{exo}[part]
\newcommand{\exercice}[1]{%
	\addtocounter{exo}{1}%
	\Saut
	{\parindent\z@%
	 \regle@centree\enskip{\scshape Exercice \theexo}\enskip\regle@centree\par%
	 #1}\Saut%
}

% ---- Espacements ----

\RequirePackage[math]{cellspace}

\cellspacetoplimit3pt
\cellspacebottomlimit3pt

\endinput

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Fin classe livre --- %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
