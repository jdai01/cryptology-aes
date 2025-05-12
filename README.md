# IB_CRYL - Cryptology

## Setup
```bash
cd YOUR_PATH    # make your desired folder your current working directory
git clone https://github.com/jdai01/IB_CRYL
cd IB_CRYL      # go to cloned folder or your remaned folder for this repository
```

Go to [main.tex](main.tex) and click on the green play button (Build Latex Project)


> [!TIP]
> Please use `references.bib` to track your references, and `\cite{...}` accordingly in your LaTeX file.

> [!NOTE]
> Default path for any image files have been set to use the folder `img`. 


## Useful Links
- [Learn LaTeX in 30 minutes](https://www.overleaf.com/learn/latex/Learn_LaTeX_in_30_minutes)
- [Sections and chapters](https://www.overleaf.com/learn/latex/Sections_and_chapters)
- [Mathematical expressions](https://www.overleaf.com/learn/latex/Mathematical_expressions)
- [Tables](https://www.overleaf.com/learn/latex/Tables)
- [Inserting Images](https://www.overleaf.com/learn/latex/Inserting_Images)
- [Referencing Figures](https://www.overleaf.com/learn/latex/Referencing_Figures)
<!-- - [Bibliography management in LaTeX](https://www.overleaf.com/learn/latex/Bibliography_management_in_LaTeX) -->
- [Bibliography management with bibtex](https://www.overleaf.com/learn/latex/Bibliography_management_with_bibtex)


> [!TIP]
> To check if your reference work
> ```bash
> pdflatex report.tex
> makeglossaries report
> biber report
> pdflatex report.tex
> ```