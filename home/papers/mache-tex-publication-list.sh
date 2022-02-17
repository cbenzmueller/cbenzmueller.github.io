cd ~/chris/trunk/www/papers/

\rm chris-publication-list.pdf

\rm  chris-all-published-bibs-B.bib
\rm  chris-all-published-bibs-J.bib
\rm  chris-all-published-bibs-E.bib
\rm  chris-all-published-bibs-C.bib
\rm  chris-all-published-bibs-W.bib
\rm  chris-all-published-bibs-T.bib
\rm  chris-all-published-bibs-R.bib
\rm chris-all-published-bibs.bib

find . -name "B*.bib" -exec cat {} > chris-all-published-bibs-B.bib \;
find . -name "J*.bib" -exec cat {} > chris-all-published-bibs-J.bib \;
find . -name "E*.bib" -exec cat {} > chris-all-published-bibs-E.bib \;
find . -name "C*.bib" -exec cat {} > chris-all-published-bibs-C.bib \;
find . -name "W*.bib" -exec cat {} > chris-all-published-bibs-W.bib \;
find . -name "T*.bib" -exec cat {} > chris-all-published-bibs-T.bib \;
find . -name "R*.bib" -exec cat {} > chris-all-published-bibs-R.bib \;

cat chris-all-published-bibs-B.bib chris-all-published-bibs-J.bib  chris-all-published-bibs-E.bib chris-all-published-bibs-C.bib chris-all-published-bibs-W.bib chris-all-published-bibs-T.bib chris-all-published-bibs-R.bib > chris-all-published-bibs.bib

latex test-bib-B
bibtex test-bib-B
latex test-bib-B
latex test-bib-B
latex test-bib-J
bibtex test-bib-J
latex test-bib-J
latex test-bib-J
latex test-bib-E
bibtex test-bib-E
latex test-bib-E
latex test-bib-E
latex test-bib-C
bibtex test-bib-C
latex test-bib-C
latex test-bib-C
latex test-bib-W
bibtex test-bib-W
latex test-bib-W
latex test-bib-W
latex test-bib-T
bibtex test-bib-T
latex test-bib-T
latex test-bib-T
latex test-bib-R
bibtex test-bib-R
latex test-bib-R
latex test-bib-R
latex test-bib
latex test-bib
dvips test-bib.dvi -o
dvipdf test-bib.dvi chris-publication-list.pdf
cp -f chris-publication-list.pdf ../cv-texmacs/cv-publications-latex.pdf
gv chris-publication-list.pdf
