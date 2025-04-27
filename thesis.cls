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
\RequirePackage[backend=biber,style=numeric]{biblatex}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{subcaption} 
\RequirePackage{amsmath}
\RequirePackage{xcolor}

\setstretch{1.25}  % Set line spacing to 1.25
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
            {\Large Fakultät Informatik\\}
        \end{center}
        \vspace*{3ex}
        \begin{center}
            {\Huge \textbf{~\\ \@title} \\}
        \end{center}
        \vspace*{8ex}

        \begin{center}
            {\Large Jiahui Dai\\Student-ID: 00153014\\B.Sc. Computer Science and Artificial Intelligence}
        \end{center}
        \vspace*{3ex}
        \begin{center}
            {\Large Yana Halamakh\\Student-ID: 00151596\\B.Sc. Computer Science and Artificial Intelligence}
        \end{center}
        \vspace*{3ex}
        \begin{center}
            {\Large Zeynep Melisa Akyol \\Student-ID: 00138182\\B.Sc. Computer Science and Artificial Intelligence}
        \end{center}
        % \begin{center}
        %     {\huge \textsc{\@subtitle} \\[3ex] }
        %     {\Large \@author  \\}
        % \end{center}
        % \vspace*{15ex}
        % \begin{center}
        %     {\large
        %     \begin{tabular}{ r l }
        %         Supervisor: & \@supervisor \\ 
        %         Date: & \customdate\today
        %     \end{tabular}
        %     }
        % \end{center}	
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
\fancyfoot[C]{\nouppercase{\rightmark}}  % Bottom center: Section title
\fancyfoot[R]{\thepage}  % Bottom right: Page number


% Tighter spacing for itemize and enumerate environments
\setlist[itemize]{topsep=2pt, itemsep=1pt, parsep=0pt, partopsep=0pt}
\setlist[enumerate]{topsep=2pt, itemsep=1pt, parsep=0pt, partopsep=0pt}



\endinput
