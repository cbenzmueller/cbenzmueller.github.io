
# texmacs = /project/omega-nb/mwagner/progs/texmacs/bin/texmacs
# texmacs = /project/omega-nb/TeXmacs/bin/texmacs
texmacs = texmacs

cvfile =  cv
tmfile3 = cv-research-interests
tmfile4 = chris-home
tmfile7 = cv-academic-experience
tmfile8 = cv-teaching
tmfile9 = cv-publications
tmfile12a = cv-research-topics
tmfile13 = cv-hobbies
tmfile14 = cv-talks
tmfile15 = cv-supervision
tmfile16 = cv-short-biography

all: tm # pdf

$(tmfile3).html : $(tmfile3).tm 
			$(texmacs) -c $(tmfile3).tm $(tmfile3).html -q
			sed s/"<title>No title<\/title>"/"<title>Research Interests of Christoph Benzmueller<\/title>"/g  $(tmfile3).html > $(tmfile3).html-buf
			mv $(tmfile3).html-buf $(tmfile3).html
$(tmfile3).ps : $(tmfile3).tm 
			$(texmacs) -c $(tmfile3).tm $(tmfile3).ps -q
$(tmfile3).tex : $(tmfile3).tm 
			$(texmacs) -c $(tmfile3).tm $(tmfile3).tex -q
$(tmfile3).scn : $(tmfile3).tm 
			$(texmacs) -c $(tmfile3).tm $(tmfile3).scn -q
$(tmfile3).pdf : $(tmfile3).ps 
			ps2pdf $(tmfile3).ps
			# $(texmacs) -c $(tmfile3).tm $(tmfile3).pdf -q
tm3 : $(tmfile3).html $(tmfile3).ps $(tmfile3).tex $(tmfile3).scn $(tmfile3).pdf


$(tmfile4).html : $(tmfile4).tm 
			$(texmacs) -c $(tmfile4).tm $(tmfile4).html -q
$(tmfile4).ps : $(tmfile4).tm 
			$(texmacs) -c $(tmfile4).tm $(tmfile4).ps -q
$(tmfile4).tex : $(tmfile4).tm 
			$(texmacs) -c $(tmfile4).tm $(tmfile4).tex -q
$(tmfile4).scn : $(tmfile4).tm 
			$(texmacs) -c $(tmfile4).tm $(tmfile4).scn -q
$(tmfile4).pdf : $(tmfile4).ps 
			ps2pdf $(tmfile4).ps
			# $(texmacs) -c $(tmfile4).tm $(tmfile4).pdf -q
tm4 : $(tmfile4).html $(tmfile4).tex $(tmfile4).scn


$(tmfile7).html : $(tmfile7).tm 
			$(texmacs) -c $(tmfile7).tm $(tmfile7).html -q
			sed s/"<title>No title<\/title>"/"<title>Academic Activities of Christoph Benzmueller<\/title>"/g  $(tmfile7).html > $(tmfile7).html-buf
			mv $(tmfile7).html-buf $(tmfile7).html
$(tmfile7).ps : $(tmfile7).tm 
			$(texmacs) -c $(tmfile7).tm $(tmfile7).ps -q
$(tmfile7).tex : $(tmfile7).tm 
			$(texmacs) -c $(tmfile7).tm $(tmfile7).tex -q
$(tmfile7).scn : $(tmfile7).tm 
			$(texmacs) -c $(tmfile7).tm $(tmfile7).scn -q
$(tmfile7).pdf : $(tmfile7).ps
			ps2pdf $(tmfile7).ps
			# $(texmacs) -c $(tmfile7).tm $(tmfile7).pdf -q
tm7 : $(tmfile7).html $(tmfile7).ps $(tmfile7).tex $(tmfile7).scn $(tmfile7).pdf


$(tmfile8).html : $(tmfile8).tm 
			$(texmacs) -c $(tmfile8).tm $(tmfile8).html -q
			sed s/"<title>No title<\/title>"/"<title>Teaching Activities of Christoph Benzmueller<\/title>"/g  $(tmfile8).html > $(tmfile8).html-buf
			mv $(tmfile8).html-buf $(tmfile8).html
$(tmfile8).ps : $(tmfile8).tm 
			$(texmacs) -c $(tmfile8).tm $(tmfile8).ps -q
$(tmfile8).tex : $(tmfile8).tm 
			$(texmacs) -c $(tmfile8).tm $(tmfile8).tex -q
$(tmfile8).scn : $(tmfile8).tm 
			$(texmacs) -c $(tmfile8).tm $(tmfile8).scn -q
$(tmfile8).pdf : $(tmfile8).ps 
			ps2pdf $(tmfile8).ps
			# $(texmacs) -c $(tmfile8).tm $(tmfile8).pdf -q
tm8 : $(tmfile8).html $(tmfile8).ps $(tmfile8).tex $(tmfile8).scn $(tmfile8).pdf


$(tmfile9).html : $(tmfile9).tm 
			$(texmacs) -c $(tmfile9).tm $(tmfile9).html -q
			sed s/"<title>No title<\/title>"/"<title>All Publications of Christoph Benzmueller<\/title>"/g  $(tmfile9).html > $(tmfile9).html-buf
			mv $(tmfile9).html-buf $(tmfile9).html
			sed s/"\&#x013E;"/"\&copy;"/g  $(tmfile9).html > $(tmfile9).html-buf
			mv $(tmfile9).html-buf $(tmfile9).html
$(tmfile9).ps : $(tmfile9).tm 
			$(texmacs) -c $(tmfile9).tm $(tmfile9).ps -q
$(tmfile9).tex : $(tmfile9).tm 
			$(texmacs) -c $(tmfile9).tm $(tmfile9).tex -q
$(tmfile9).scn : $(tmfile9).tm 
			$(texmacs) -c $(tmfile9).tm $(tmfile9).scn -q
$(tmfile9).pdf : $(tmfile9).ps
			ps2pdf $(tmfile9).ps
			# $(texmacs) -c $(tmfile9).tm $(tmfile9).pdf -q
tm9 : $(tmfile9).html $(tmfile9).ps $(tmfile9).tex $(tmfile9).scn $(tmfile9).pdf

$(tmfile12a).html : $(tmfile12a).tm 
			$(texmacs) -c $(tmfile12a).tm $(tmfile12a).html -q
			sed s/"<title>No title<\/title>"/"<title>Research of Christoph Benzmueller<\/title>"/g  $(tmfile12a).html > $(tmfile12a).html-buf
			mv $(tmfile12a).html-buf $(tmfile12a).html
$(tmfile12a).ps : $(tmfile12a).tm 
			$(texmacs) -c $(tmfile12a).tm $(tmfile12a).ps -q
$(tmfile12a).tex : $(tmfile12a).tm 
			$(texmacs) -c $(tmfile12a).tm $(tmfile12a).tex -q
$(tmfile12a).scn : $(tmfile12a).tm 
			$(texmacs) -c $(tmfile12a).tm $(tmfile12a).scn -q
$(tmfile12a).pdf : $(tmfile12a).ps 
			ps2pdf $(tmfile12a).ps
			# $(texmacs) -c $(tmfile12a).tm $(tmfile12a).pdf -q
tm12a : $(tmfile12a).html $(tmfile12a).ps $(tmfile12a).tex $(tmfile12a).scn $(tmfile12a).pdf

$(tmfile13).html : $(tmfile13).tm 
			$(texmacs) -c $(tmfile13).tm $(tmfile13).html -q
			sed s/"<title>No title<\/title>"/"<title>Hobbies of Christoph Benzmueller<\/title>"/g  $(tmfile13).html > $(tmfile13).html-buf
			mv $(tmfile13).html-buf $(tmfile13).html
$(tmfile13).ps : $(tmfile13).tm 
			$(texmacs) -c $(tmfile13).tm $(tmfile13).ps -q
$(tmfile13).tex : $(tmfile13).tm 
			$(texmacs) -c $(tmfile13).tm $(tmfile13).tex -q
$(tmfile13).scn : $(tmfile13).tm 
			$(texmacs) -c $(tmfile13).tm $(tmfile13).scn -q
$(tmfile13).pdf : $(tmfile13).ps 
			ps2pdf $(tmfile13).ps
			# $(texmacs) -c $(tmfile13).tm $(tmfile13).pdf -q
tm13 : $(tmfile13).html $(tmfile13).ps $(tmfile13).tex $(tmfile13).scn $(tmfile13).pdf

$(tmfile14).html : $(tmfile14).tm 
			$(texmacs) -c $(tmfile14).tm $(tmfile14).html -q
			sed s/"<title>No title<\/title>"/"<title>Talks of Christoph Benzmueller<\/title>"/g  $(tmfile14).html > $(tmfile14).html-buf
			mv $(tmfile14).html-buf $(tmfile14).html
$(tmfile14).ps : $(tmfile14).tm 
			$(texmacs) -c $(tmfile14).tm $(tmfile14).ps -q
$(tmfile14).tex : $(tmfile14).tm 
			$(texmacs) -c $(tmfile14).tm $(tmfile14).tex -q
$(tmfile14).scn : $(tmfile14).tm 
			$(texmacs) -c $(tmfile14).tm $(tmfile14).scn -q
$(tmfile14).pdf : $(tmfile14).ps 
			ps2pdf $(tmfile14).ps
			# $(texmacs) -c $(tmfile14).tm $(tmfile14).pdf -q
tm14 : $(tmfile14).html $(tmfile14).ps $(tmfile14).tex $(tmfile14).scn $(tmfile14).pdf

$(tmfile15).html : $(tmfile15).tm 
			$(texmacs) -c $(tmfile15).tm $(tmfile15).html -q
			sed s/"<title>No title<\/title>"/"<title>Supervision of Christoph Benzmueller<\/title>"/g  $(tmfile15).html > $(tmfile15).html-buf
			mv $(tmfile15).html-buf $(tmfile15).html
$(tmfile15).ps : $(tmfile15).tm 
			$(texmacs) -c $(tmfile15).tm $(tmfile15).ps -q
$(tmfile15).tex : $(tmfile15).tm 
			$(texmacs) -c $(tmfile15).tm $(tmfile15).tex -q
$(tmfile15).scn : $(tmfile15).tm 
			$(texmacs) -c $(tmfile15).tm $(tmfile15).scn -q
$(tmfile15).pdf : $(tmfile15).ps 
			ps2pdf $(tmfile15).ps
			# $(texmacs) -c $(tmfile15).tm $(tmfile15).pdf -q
tm15 : $(tmfile15).html $(tmfile15).ps $(tmfile15).tex $(tmfile15).scn $(tmfile15).pdf


$(tmfile16).html : $(tmfile16).tm 
			$(texmacs) -c $(tmfile16).tm $(tmfile16).html -q
			sed s/"<title>No title<\/title>"/"<title>Short Biography of Christoph Benzmueller<\/title>"/g  $(tmfile16).html > $(tmfile16).html-buf
			mv $(tmfile16).html-buf $(tmfile16).html
$(tmfile16).ps : $(tmfile16).tm 
			$(texmacs) -c $(tmfile16).tm $(tmfile16).ps -q
$(tmfile16).tex : $(tmfile16).tm 
			$(texmacs) -c $(tmfile16).tm $(tmfile16).tex -q
$(tmfile16).scn : $(tmfile16).tm 
			$(texmacs) -c $(tmfile16).tm $(tmfile16).scn -q
$(tmfile16).pdf : $(tmfile16).ps 
			ps2pdf $(tmfile16).ps
			# $(texmacs) -c $(tmfile16).tm $(tmfile16).pdf -q
tm16 : $(tmfile16).html $(tmfile16).ps $(tmfile16).tex $(tmfile16).scn $(tmfile16).pdf




$(cvfile).pdf : $(tmfile16).ps $(tmfile3).ps $(tmfile6).ps $(tmfile7).ps $(tmfile8).ps $(tmfile15).ps $(tmfile9).ps $(tmfile14).ps 
		        psmerge -o$(cvfile).ps $(tmfile1).ps $(tmfile2).ps $(tmfile5).ps $(tmfile6).ps $(tmfile7).ps $(tmfile8).ps $(tmfile9).ps $(tmfile14).ps 
			ps2pdf $(cvfile).ps
			gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=$(cvfile).pdf $(tmfile16).pdf $(tmfile3).pdf $(tmfile6).pdf $(tmfile7).pdf $(tmfile8).pdf $(tmfile15).pdf $(tmfile9).pdf $(tmfile14).pdf 

# pdf: $(cvfile).pdf


$(tmfile9)-latex.pdf : $(tmfile9).tm
	../papers/mache-tex-publication-list.sh

tex-publist : $(tmfile9).tm $(tmfile9)-latex.pdf

cv-short : 
	latex cv-short-2007.tex
	pdflatex cv-short-2007.tex

tm : tm3 tm7 tm8 tm9 tm12a tm13 tm14 tm15 tm16 cv-short tex-publist

