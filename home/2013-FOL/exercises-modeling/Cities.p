%------------------------------------------------------------------------------
% File     : GEG024=1 : TPTP v5.2.0. Bugfixed v5.2.0.
% Domain   : Arithmetic
% Problem  : Find sufficiently large and sufficiently close city (easy)
% Version  : Especial.
% English  :

% Refs     : [Wal10] Waldmann (2010), Email to Geoff Sutcliffe
% Source   : [Wal10]
% Names    :

% Status   : Theorem
% Rating   : 0.40 v5.2.0
% Syntax   : Number of formulae    :   11 (   8 unit;  10 type)
%            Number of atoms       :   37 (  21 equality)
%            Maximal formula depth :   23 (   4 average)
%            Number of connectives :   23 (   0   ~;   0   |;  22   &)
%                                         (   0 <=>;   1  =>;   0  <=;   0 <~>)
%                                         (   0  ~|;   0  ~&)
%            Number of type conns  :    3 (   2   >;   1   *;   0   +;   0  <<)
%            Number of predicates  :   14 (  12 propositional; 0-2 arity)
%            Number of functors    :   31 (  28 constant; 0-2 arity)
%            Number of variables   :    7 (   0 sgn;   6   !;   1   ?)
%            Maximal term depth    :    3 (   2 average)
%            Arithmetic symbols    :   23 (   2 pred;    0 func;   21 numbers)
% SPC      : TFF_THM_EQU_ARI

% Comments :
% Bugfixes : v5.2.0 - Changed $plus to $sum.
%------------------------------------------------------------------------------
tff(city_type,type,( city: $tType )).

tff(d_type,type,( d: ( city * city ) > $int )).
tff(inh_type,type,( inh: city > $int )).
tff(kiel_type,type,( kiel: city )).
tff(hamburg_type,type,( hamburg: city )).
tff(berlin_type,type,( berlin: city )).
tff(cologne_type,type,( cologne: city )).
tff(frankfurt_type,type,( frankfurt: city )).
tff(saarbruecken_type,type,( saarbruecken: city )).
tff(munich_type,type,( munich: city )).

tff(ax1,axiom,( ! [X: city,Y: city] : d(X,Y) = d(Y,X) )).
tff(ax2,axiom,( ! [X: city,Y: city,Z: city] : $lesseq(d(X,Z),$sum(d(X,Y),d(Y,Z))) )).
tff(ax3,axiom,( ! [X: city] : d(X,X) = 0 )).
   
tff(ax4,axiom,( d(berlin,munich) = 510 )).
tff(ax5,axiom,( d(berlin,cologne) = 480 )).
tff(ax6,axiom,( d(berlin,frankfurt) = 420 )).
tff(ax7,axiom,( d(saarbruecken,frankfurt) = 160 )).
tff(ax8,axiom,( d(saarbruecken,cologne) = 190 )).
tff(ax9,axiom,( d(hamburg,cologne) = 360 )).
tff(ax10,axiom,( d(hamburg,frankfurt) = 390 )).
tff(ax11,axiom,( d(cologne,frankfurt) = 150 )).
tff(ax12,axiom,( d(hamburg,kiel) = 90 )).
tff(ax13,axiom,( d(hamburg,berlin) = 250 )).
tff(ax14,axiom,( d(munich,frankfurt) = 300 )).
tff(ax15,axiom,( d(munich,saarbruecken) = 360 )).
   
tff(ax16,axiom,( inh(berlin) = 3442675 )).
tff(ax17,axiom,( inh(hamburg) = 1774224 )).
tff(ax18,axiom,( inh(munich) = 1330440 )).
tff(ax19,axiom,( inh(cologne) = 998105 )).
tff(ax20,axiom,( inh(frankfurt) = 671927 )).
tff(ax21,axiom,( inh(saarbruecken) = 175810 )).
tff(ax22,axiom,( inh(kiel) = 238281 )).

tff(con,conjecture,
    ( ? [X: city] : ( $lesseq(d(kiel,X),100) & $lesseq(1000000,inh(X)) ) )).

%------------------------------------------------------------------------------
