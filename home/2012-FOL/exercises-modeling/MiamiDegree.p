% Students complete requirements in English composition, Humanities, Natural science,
% Mathematics, Social science, a Second language, and Writing.
fof(degree,axiom,
    ( ( composition & humanities & science & math & social_science & language
      & writing )
    => degree ) ).

% English composition is taugth in two lectures
fof(composition,axiom,
    ( ( eng105 & eng106 )
    => composition ) ).

% Assume that the student has taken these courses.
fof(composition_courses,axiom,
    ( eng105 & eng106 ) ).

% To fulfill the humanities requirements, courses in art, literature,
% religion and philosophy have to be taken.
fof(humanities,axiom,
    ( ( art & literature & religion & phi115 )
    => humanities ) ).

% There are several arts courses and students can choose
% which one to visit.
fof(art,axiom,
    ( ( artXXX | arhXXX | danXXX | mcyXXX | thaXXX )
    => art ) ).

% Assume the students has taken the artXXX class.
fof(artXXX,axiom,artXXX ).
% fof(arhXXX,axiom,arhXXX ).
% fof(danXXX,axiom,danXXX ).
% fof(mcyXXX,axiom,mcyXXX ).
% fof(thaXXX,axiom,thaXXX ).

% There is one literature course.
fof(literature,axiom,
    ( eng2XX
    => literature ) ).

% assume that the student takes this course.
fof(literature_courses,axiom,
    ( eng2XX ) ).

% There is one religion course.
fof(religion,axiom,
    ( relXXX
    => religion ) ).

% Assume that the student takes this religion course.
fof(religion_courses,axiom,
    ( relXXX ) ).

% Assume the student takes the philosophy course.
fof(phi115,axiom,
    ( phi115 ) ).

% There are several science courses ...
fof(science,axiom,
    ( ( bilXXX | chmXXX | ecsXXX | geoXXX | mscXXX | phyXXX )
    => science ) ).

% ... assume the student has taken phyXXX
% fof(bilXXX,axiom,bilXXX ).
% fof(chmXXX,axiom,chmXXX ).
% fof(ecsXXX,axiom,ecsXXX ).
% fof(geoXXX,axiom,geoXXX ).
% fof(mscXXX,axiom,mscXXX ).
fof(phyXXX,axiom,phyXXX ).

% In maths, one has to take the mth162 course and computer science or statistics
fof(math,axiom,
    ( ( mth162 & ( cscXXX | staXXX) )
    => math ) ).

% Assume the student has taken mth162 and cscXXX
fof(mth162,axiom,mth162 ).
fof(cscXXX,axiom,cscXXX ).
% fof(staXXX,axiom,staXXX ).

% In social sciences there is choice of various courses.
fof(social_science,axiom,
    ( ( apyXXX | ecoXXX | gegXXX | hisXXX | intXXX | polXXX | psyXXX | socXXX )
    => social_science ) ).

% Assume the student has taken ecoXXX.
% fof(apyXXX,axiom,apyXXX ).
fof(ecoXXX,axiom,ecoXXX ).
% fof(gegXXX,axiom,gegXXX ).
% fof(hisXXX,axiom,hisXXX ).
% fof(intXXX,axiom,intXXX ).
% fof(polXXX,axiom,polXXX ).
% fof(psyXXX,axiom,psyXXX ).
% fof(socXXX,axiom,socXXX ).

% Also in languages there is wide range of choices ....
fof(language,axiom,
    ( ( arb2XX | chi2XX | fre2XX | ger2XX | gre2XX | heb2XX | ita2XX | jap2XX |
        lat2XX | por2XX | spa2XX )
    => language ) ).

% Assume that the student has taken course arbXXX.
fof(arbXXX,axiom,arb2XX ).
% fof(chiXXX,axiom,chi2XX ).
% fof(freXXX,axiom,fre2XX ).
% fof(gerXXX,axiom,ger2XX ).
% fof(greXXX,axiom,gre2XX ).
% fof(hebXXX,axiom,heb2XX ).
% fof(itaXXX,axiom,ita2XX ).
% fof(japXXX,axiom,jap2XX ).
% fof(latXXX,axiom,lat2XX ).
% fof(porXXX,axiom,por2XX ).
% fof(spzXXX,axiom,spa2XX ).

% To obtain the writing requirement, one may take course wwwXXX
fof(wwwXXX_writing,axiom,
    wwwXXX => writing ).

% ... which has been taken by the student.
fof(wwwXXX,axiom,wwwXXX).

% ... or one may take course hisXXX
fof(hisXXX_writing,axiom,
    hisXXX => writing ).
% ... or course eng2XX
fof(eng2XX_writing,axiom,
    eng2XX => writing ).

% ... or course phi115
fof(phi115_writing,axiom,
    phi115 => writing ).

% The conjecture: Prove that one can get a degree
% (Bachelor of Science degree from the College of
%  Arts and Sciences at the University of Miami)
fof(get_degree,conjecture,
    degree ).