\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2025/03/21 Custom Thesis Class]

% Default: 12pt Times New Roman
\LoadClass[12pt]{article}

\RequirePackage{graphicx}  % For including images
\RequirePackage{fancyhdr}  % For custom headers/footers
\RequirePackage{geometry}  % For margins
\RequirePackage{titlesec}  % For section title customization
\RequirePackage{datetime}  % For date formatting
\RequirePackage{setspace}  % For line spacing
\RequirePackage[backend=biber,style=numeric, sorting=none]{biblatex}
\RequirePackage[pdfborder={0 0 0}]{hyperref}
\RequirePackage{enumitem}
\RequirePackage{subcaption} 
\RequirePackage{amsmath}
\RequirePackage{xcolor}
\RequirePackage[acronym]{glossaries}
\RequirePackage{listings}
\RequirePackage{pdflscape}
\RequirePackage{parskip}

\setstretch{1.25}  % Set line spacing to 1.25
\setlength{\parindent}{0pt}  % No paragraph indentation
\setlength{\parskip}{1em}    % 1em vertical space between paragraphs

\addbibresource{references.bib}


% Default Image Path
\graphicspath{{img/}}

% Set margins
\geometry{a4paper, left=2cm, right=4cm, top=3cm, bottom=3cm}

% Set date format to DD mmmm YYYY
\newdateformat{customdate}{\THEDAY~\monthname[\THEMONTH]~\THEYEAR}

% Define custom commands
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand{\subject}[1]{\gdef\@subject{#1}}
\newcommand{\affiliation}[1]{\gdef\@affiliation{#1}}
\newcommand{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand{\supervisorAffiliation}[1]{\gdef\@supervisorAffiliation{#1}}

% Default values for warnings
\def\@subtitle{\@latex@warning@no@line{No \noexpand\subtitle given}}
\def\@supervisor{\@latex@warning@no@line{No \noexpand\supervisor given}}
\def\@affiliation{\@latex@warning@no@line{No \noexpand\affiliation given}}

% Define the title page
\def\maketitle{
    \begin{titlepage}
        % \hfill \includegraphics[clip,scale=.35]{thi_AImotion.png}
        \begin{center}
            \includegraphics[width=0.5\textwidth]{thi_logo_wb_RGB.jpg}
        \end{center}
        \vspace*{1ex}
        \begin{center}
            {\LARGE \textsc{Technische Hochschule Ingolstadt}} \\[4ex]
            {\Large Fakultät Informatik} \\[3ex]
            {\large Cryptology SS25\\}
        \end{center}
        \vspace*{2ex}
        \begin{center}
            {\Huge \textbf{~\\ \@title} \\}
        \end{center}
        \vspace*{8ex}

        \begin{center}
            {\large Jiahui Dai\\Student-ID: 00153014\\B.Sc. Computer Science and Artificial Intelligence}
        \end{center}
        \vspace*{2ex}
        \begin{center}
            {\large Yana Halamakh\\Student-ID: 00151596\\B.Sc. Computer Science and Artificial Intelligence}
        \end{center}
        \vspace*{2ex}
        \begin{center}
            {\large Zeynep Melisa Akyol \\Student-ID: 00138182\\B.Sc. Computer Science and Artificial Intelligence}
        \end{center}
        % \begin{center}
        %     {\huge \textsc{\@subtitle} \\[3ex] }
        %     {\Large \@author  \\}
        % \end{center}
        % \vspace*{15ex}
        \vspace*{4ex}
        \begin{center}
            {\large
            \begin{tabular}{ r l }
                Supervisor: & \@supervisor \\ 
                Date: & \customdate\today
            \end{tabular}
            }
        \end{center}	
    \end{titlepage}
}
% Header & Footer
\lhead{\@title}
\renewcommand{\footrulewidth}{0.4pt}
\rfoot{\thepage}
\lfoot{\@author}
\cfoot{\nouppercase{\rightmark}}


% Setup Header & Footer
\pagestyle{fancy}
\fancyhf{}  % Clear all default header/footer settings
\fancyhead[L]{\textbf{\@title}}  % Left header: Title
\fancyhead[R]{}  % Right header: Page number
\renewcommand{\headrulewidth}{0.4pt}  % Horizontal line under header

% Footer Configuration
\renewcommand{\footrulewidth}{0.4pt}
% \fancyfoot[L]{\@author}  % Bottom left: Author Name
\fancyfoot[L]{\nouppercase{\rightmark}}  % Bottom center: Section title
\fancyfoot[R]{\thepage}  % Bottom right: Page number


% Tighter spacing for itemize and enumerate environments
\setlist[itemize]{topsep=2pt, itemsep=1pt, parsep=0pt, partopsep=0pt}
\setlist[enumerate]{topsep=2pt, itemsep=1pt, parsep=0pt, partopsep=0pt}



% For python
\definecolor{codegray}{gray}{0.95}
\definecolor{pykeyword}{rgb}{0.25,0.2,0.75}
\definecolor{pystring}{rgb}{0.0,0.5,0.0}

\renewcommand{\lstlistingname}{Python Code}
\renewcommand{\lstlistlistingname}{List of Code Listings}
\lstset{
  language=Python,
  backgroundcolor=\color{gray!10},
  basicstyle=\ttfamily\small,
  keywordstyle=\color{blue}\bfseries,
  stringstyle=\color{green!60!black},
  commentstyle=\color{gray}\itshape,
  frame=single,
  showstringspaces=false,
  breaklines=true,
  tabsize=4,
  captionpos=b,
  numbers=left,
  numberstyle=\tiny\color{gray},
  numbersep=10pt,
  breakatwhitespace=false,
  postbreak=\mbox{\textcolor{gray}{$\hookrightarrow$}\space} % ← continuation arrow
}

\endinput
