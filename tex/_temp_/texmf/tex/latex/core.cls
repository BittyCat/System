\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{core}
\LoadClass[11pt, oneside, a4paper]{memoir}
\RequirePackage[hidelinks]{hyperref}

% < MARGINS >
  \setlength{\footskip}{1cm}
  \setlrmarginsandblock{2cm}{2cm}{*}
  \setulmarginsandblock{2cm}{2.5cm}{*}
  \checkandfixthelayout
% - MARGINS -

% < FOOTER >
  \makeevenfoot{plain}{test}{}{\scshape\thepage}
  \makeoddfoot{plain}{}{}{\scshape\thepage}
% - FOOTER -

% < FONT >
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[T1]{fontenc}
  \RequirePackage{fontspec}
  \renewcommand{\familydefault}{\sfdefault}
  \setmonofont{Ubuntu Mono}
  \boldmath
% - FONT -

% < MATH >
  \RequirePackage{amsmath}
  \RequirePackage{longtable}
% - MATH -

% < FIGURE >
  \RequirePackage{graphicx}
  \RequirePackage{caption}
  \RequirePackage{subcaption}
  % from `pandoc -D latex`:
  \def\maxwidth{
    \ifdim\Gin@nat@width>\linewidth
      \linewidth
    \else
      \Gin@nat@width
    \fi}
  \def\maxheight{
    \ifdim\Gin@nat@height>\textheight
      \textheight
    \else
      \Gin@nat@height
    \fi}
  \setkeys{Gin}{width=\maxwidth,height=\maxheight,keepaspectratio}
  \def\fps@figure{htbp}
  \captionsetup[figure]{font=footnotesize}
  \renewcommand*{\figurename}{Fig}
% - FIGURE -

% < PARAGRAPH >
  \setlength{\parindent}{24pt}
  \setlength{\parskip}{2pt}
  \setlength{\emergencystretch}{3em} % prevent overfull lines
% - PARAGRAPH -

% < SECTION >
  \hangsecnum
  \sethangfrom{{\tiny #1}\\}
% - SECTION -

% < CHAPTER >
  \makechapterstyle{default}{
    \renewcommand*{\printchaptername}{}
    \renewcommand*{\chapnumfont}{\normalfont\centering}
    \renewcommand*{\chapnamefont}{\huge\centering}
    \setlength{\beforechapskip}{30pt}
    \setlength{\midchapskip}{20pt}
    \setlength{\afterchapskip}{60pt}
  }
  \makechapterstyle{toc}{
    \renewcommand*\contentsname{\centering\Large Table of Contents}
    \setlength{\beforechapskip}{0pt}
    \setlength{\midchapskip}{0pt}
    \setlength{\afterchapskip}{60pt}
  }
% - CHAPTER -

% < TITLE >
  \renewcommand*{\maketitle}{
    \pagestyle{empty}
    \begin{center}
      \vspace*{\fill}
      \theauthor\\
      \Huge\thetitle\\
      \vspace*{\fill}
    \end{center}
    \newpage
    \pagestyle{plain}
    \chapterstyle{toc}
    \frontmatter
    \addcontentsline{toc}{part}{\thetitle}
    \tableofcontents*
    \mainmatter
    \chapterstyle{default}
    \newpage
  }
% - TITLE -

% < TABLE OF CONTENTS >
  \setpnumwidth{12pt}
  \renewcommand*{\cftdot}{\scriptsize .}
  \renewcommand*{\cftpartfont}{\large}
  \cftpagenumbersoff{part}
  \setlength{\cftbeforechapterskip}{24pt}
  \cftsetindents{chapter}{0pt}{30pt}
  \renewcommand*{\cftchapterpresnum}{\normalfont}
  \renewcommand*{\cftchapterfont}{\large}
  \setlength{\cftbeforesectionskip}{6pt}
  \cftsetindents{section}{30pt}{30pt}
% - TABLE OF CONTENTS -

% < CODE >
  \RequirePackage{fancyvrb}
  \DefineVerbatimEnvironment{Code}{Verbatim}
    {commandchars=\\\{\},xleftmargin=.1cm}
% - CODE -

% < COLORS >
  \RequirePackage[dvipsnames]{xcolor}
  \RequirePackage{vimcol}
  \color{white}
  \pagecolor{black}
  \vimcolors
  \DeclareOption{print}{
    \color{black}
    \pagecolor{white}
    \printcolors
    \unboldmath
  }\ProcessOptions\relax
% - COLORS -
