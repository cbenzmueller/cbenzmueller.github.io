cd /home/chris/www/cv-texmacs/


echo "***************************************************************"
echo "Converting *cv-curriculum-vitae.tm* into *cv-curriculum-vitae.ps* *cv-curriculum-vitae.tex* *cv-curriculum-vitae.html*"  
echo "***************************************************************"
texmacs -c cv-curriculum-vitae.tm cv-curriculum-vitae.ps -q
texmacs -c cv-curriculum-vitae.tm cv-curriculum-vitae.tex -q
texmacs -c cv-curriculum-vitae.tm cv-curriculum-vitae.html -q

echo "***************************************************************"
echo "Converting *cv-general.tm* into *cv-general.ps* *cv-general.tex* *cv-general.html*"
echo "***************************************************************"
texmacs -c cv-general.tm cv-general.ps -q
texmacs -c cv-general.tm cv-general.tex -q
texmacs -c cv-general.tm cv-general.html -q

echo "***************************************************************"
echo "Converting *cv-research-interests.tm* into *cv-research-interests.ps* *cv-research-interests.tex* *cv-research-interests.html*"
echo "***************************************************************"
texmacs -c cv-research-interests.tm cv-research-interests.ps -q
texmacs -c cv-research-interests.tm cv-research-interests.tex -q
texmacs -c cv-research-interests.tm cv-research-interests.html -q


echo "***************************************************************"
echo "Converting *cv-education.tm* into *cv-education.ps* *cv-education.tex* *cv-education.html*"  
echo "***************************************************************"
texmacs -c cv-education.tm cv-education.ps -q
texmacs -c cv-education.tm cv-education.tex -q
texmacs -c cv-education.tm cv-education.html -q

echo "***************************************************************"
echo "Converting *cv-employment-most-recent.tm* into *cv-employment-most-recent.ps* *cv-employment-most-recent.tex* *cv-employment-most-recent.html*" 
echo "***************************************************************"
texmacs -c cv-employment-most-recent.tm cv-employment-most-recent.ps -q
texmacs -c cv-employment-most-recent.tm cv-employment-most-recent.tex -q
texmacs -c cv-employment-most-recent.tm cv-employment-most-recent.html -q


echo "***************************************************************"
echo "Converting *cv-employment-history.tm* into *cv-employment-history.ps* *cv-employment-history.tex* *cv-employment-history.html*"  
echo "***************************************************************"
texmacs -c cv-employment-history.tm cv-employment-history.ps -q
texmacs -c cv-employment-history.tm cv-employment-history.tex -q
texmacs -c cv-employment-history.tm cv-employment-history.html -q


echo "***************************************************************"
echo "Converting *cv-academic-experience.tm* into *cv-academic-experience.ps* *cv-academic-experience.tex* *cv-academic-experience.html*" 
 echo "***************************************************************"
texmacs -c cv-academic-experience.tm cv-academic-experience.ps -q
texmacs -c cv-academic-experience.tm cv-academic-experience.tex -q
texmacs -c cv-academic-experience.tm cv-academic-experience.html -q


echo "***************************************************************"
echo "Converting *cv-publications-new.tm* into *cv-publications-new.ps* *cv-publications-new.tex* *cv-publications-new.html*"  
echo "***************************************************************"
texmacs -c cv-publications-new.tm cv-publications-new.ps -q
texmacs -c cv-publications-new.tm cv-publications-new.tex -q
texmacs -c cv-publications-new.tm cv-publications-new.html -q


echo "***************************************************************"
echo "Converting *cv-teaching.tm* into *cv-teaching.ps* *cv-teaching.tex* *cv-teaching.html*"  
echo "***************************************************************"
texmacs -c cv-teaching.tm cv-teaching.ps -q
texmacs -c cv-teaching.tm cv-teaching.tex -q
texmacs -c cv-teaching.tm cv-teaching.html -q


echo "***************************************************************"
echo "Converting *cv-references.tm* into *cv-references.ps* *cv-references.tex* *cv-references.html*" 
echo "***************************************************************"
texmacs -c cv-references.tm cv-references.ps -q
texmacs -c cv-references.tm cv-references.tex -q
texmacs -c cv-references.tm cv-references.html -q



echo "***************************************************************"
echo "Converting *cv-travel.tm* into *cv-travel.ps* *cv-travel.tex* *cv-travel.html*" 
echo "***************************************************************"
texmacs -c cv-travel.tm cv-travel.ps -q
texmacs -c cv-travel.tm cv-travel.tex -q
texmacs -c cv-travel.tm cv-travel.html -q

echo "***************************************************************"
echo "               Making: cv.ps and cv.pdf                        "
echo "***************************************************************"

echo "***************************************************************"
echo "psconcat cv.ps cv-curriculum-vitae.ps cv-general.ps cv-research-interests.ps cv-education.ps cv-employment-most-recent.ps cv-employment-history.ps cv-academic-experience.ps cv-publications-new.ps cv-teaching.ps"
echo "***************************************************************"

psconcat cv.ps cv-curriculum-vitae.ps cv-general.ps cv-research-interests.ps cv-education.ps cv-employment-most-recent.ps cv-employment-history.ps cv-academic-experience.ps cv-publications-new.ps cv-teaching.ps 

ps2pdf cv.ps cv.pdf

