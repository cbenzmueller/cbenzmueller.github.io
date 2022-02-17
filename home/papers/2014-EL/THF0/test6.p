%------------------------------------------------------------------------------
% File     : SET753^4 : TPTP v6.0.0. Released v3.6.0.
% Domain   : Set Theory
% Problem  : Image of intersection is a subset of intersection of images
% Version  : [BS+08] axioms.
% English  :

% Refs     : [BS+05] Benzmueller et al. (2005), Can a Higher-Order and a Fi
%          : [BS+08] Benzmueller et al. (2008), Combined Reasoning by Autom
%          : [Ben08] Benzmueller (2008), Email to Geoff Sutcliffe
% Source   : [Ben08]
% Names    :

% Status   : Theorem
% Rating   : 0.14 v5.5.0, 0.17 v5.4.0, 0.20 v5.3.0, 0.40 v5.2.0, 0.20 v4.1.0, 0.00 v3.7.0
% Syntax   : Number of formulae    :   45 (   0 unit;  22 type;  22 defn)
%            Number of atoms       :  261 (  31 equality;  93 variable)
%            Maximal formula depth :   10 (   6 average)
%            Number of connectives :   77 (   5   ~;   3   |;   9   &;  56   @)
%                                         (   0 <=>;   4  =>;   0  <=;   0 <~>)
%                                         (   0  ~|;   0  ~&;   0  !!;   0  ??)
%            Number of type conns  :  119 ( 119   >;   0   *;   0   +;   0  <<)
%            Number of symbols     :   26 (  22   :)
%            Number of variables   :   64 (   1 sgn;  11   !;   5   ?;  48   ^)
%                                         (  64   :;   0  !>;   0  ?*)
%                                         (   0  @-;   0  @+)
% SPC      : TH0_THM_EQU

% Comments : 
%------------------------------------------------------------------------------
%----Include basic set theory definitions
%include('Axioms/SET008^0.ax').
%------------------------------------------------------------------------------
% File     : SET008^0 : TPTP v6.0.0. Released v3.6.0.
% Domain   : Set Theory
% Axioms   : Basic set theory definitions
% Version  : [Ben08] axioms.
% English  :

% Refs     : [BS+05] Benzmueller et al. (2005), Can a Higher-Order and a Fi
%          : [BS+08] Benzmueller et al. (2007), Combined Reasoning by Autom
%          : [Ben08] Benzmueller (2008), Email to Geoff Sutcliffe
% Source   : [Ben08]
% Names    : Typed_Set [Ben08]

% Status   : Satisfiable
% Syntax   : Number of formulae    :   28 (   0 unit;  14 type;  14 defn)
%            Number of atoms       :  200 (  18 equality;  46 variable)
%            Maximal formula depth :    9 (   6 average)
%            Number of connectives :   36 (   5   ~;   3   |;   6   &;  21   @)
%                                         (   0 <=>;   1  =>;   0  <=;   0 <~>)
%                                         (   0  ~|;   0  ~&;   0  !!;   0  ??)
%            Number of type conns  :   70 (  70   >;   0   *;   0   +)
%            Number of symbols     :   17 (  14   :;   0  :=)
%            Number of variables   :   35 (   1 sgn;   1   !;   2   ?;  32   ^)
%                                         (  35   :;   0  :=;   0  !>;   0  ?*)
% SPC      : 

% Comments :
%------------------------------------------------------------------------------
thf(in_decl,type,(
    in: $i > ( $i > $o ) > $o )).

thf(in,definition,
    ( in
    = ( ^ [X: $i,M: $i > $o] :
          ( M @ X ) ) )).

thf(is_a_decl,type,(
    is_a: $i > ( $i > $o ) > $o )).

thf(is_a,definition,
    ( is_a
    = ( ^ [X: $i,M: $i > $o] :
          ( M @ X ) ) )).

thf(emptyset_decl,type,(
    emptyset: $i > $o )).

thf(emptyset,definition,
    ( emptyset
    = ( ^ [X: $i] : $false ) )).

thf(unord_pair_decl,type,(
    unord_pair: $i > $i > $i > $o )).

thf(unord_pair,definition,
    ( unord_pair
    = ( ^ [X: $i,Y: $i,U: $i] :
          ( ( U = X )
          | ( U = Y ) ) ) )).

thf(singleton_decl,type,(
    singleton: $i > $i > $o )).

thf(singleton,definition,
    ( singleton
    = ( ^ [X: $i,U: $i] : ( U = X ) ) )).

thf(union_decl,type,(
    union: ( $i > $o ) > ( $i > $o ) > $i > $o )).

thf(union,definition,
    ( union
    = ( ^ [X: $i > $o,Y: $i > $o,U: $i] :
          ( ( X @ U )
          | ( Y @ U ) ) ) )).

thf(excl_union_decl,type,(
    excl_union: ( $i > $o ) > ( $i > $o ) > $i > $o )).

thf(excl_union,definition,
    ( excl_union
    = ( ^ [X: $i > $o,Y: $i > $o,U: $i] :
          ( ( ( X @ U )
            & ~ ( Y @ U ) )
          | ( ~ ( X @ U )
            & ( Y @ U ) ) ) ) )).

thf(intersection_decl,type,(
    intersection: ( $i > $o ) > ( $i > $o ) > $i > $o )).

thf(intersection,definition,
    ( intersection
    = ( ^ [X: $i > $o,Y: $i > $o,U: $i] :
          ( ( X @ U )
          & ( Y @ U ) ) ) )).

thf(setminus_decl,type,(
    setminus: ( $i > $o ) > ( $i > $o ) > $i > $o )).

thf(setminus,definition,
    ( setminus
    = ( ^ [X: $i > $o,Y: $i > $o,U: $i] :
          ( ( X @ U )
          & ~ ( Y @ U ) ) ) )).

thf(complement_decl,type,(
    complement: ( $i > $o ) > $i > $o )).

thf(complement,definition,
    ( complement
    = ( ^ [X: $i > $o,U: $i] :
          ~ ( X @ U ) ) )).

thf(disjoint_decl,type,(
    disjoint: ( $i > $o ) > ( $i > $o ) > $o )).

thf(disjoint,definition,
    ( disjoint
    = ( ^ [X: $i > $o,Y: $i > $o] :
          ( ( intersection @ X @ Y )
          = emptyset ) ) )).

thf(subset_decl,type,(
    subset: ( $i > $o ) > ( $i > $o ) > $o )).

thf(subset,definition,
    ( subset
    = ( ^ [X: $i > $o,Y: $i > $o] :
        ! [U: $i] :
          ( ( X @ U )
         => ( Y @ U ) ) ) )).

thf(meets_decl,type,(
    meets: ( $i > $o ) > ( $i > $o ) > $o )).

thf(meets,definition,
    ( meets
    = ( ^ [X: $i > $o,Y: $i > $o] :
        ? [U: $i] :
          ( ( X @ U )
          & ( Y @ U ) ) ) )).

thf(misses_decl,type,(
    misses: ( $i > $o ) > ( $i > $o ) > $o )).

thf(misses,definition,
    ( misses
    = ( ^ [X: $i > $o,Y: $i > $o] :
          ~ ( ? [U: $i] :
                ( ( X @ U )
                & ( Y @ U ) ) ) ) )).

%------------------------------------------------------------------------------
%----Include definitions for functions
%include('Axioms/SET008^1.ax').
%------------------------------------------------------------------------------
% File     : SET008^1 : TPTP v6.0.0. Released v3.6.0.
% Domain   : Set Theory
% Axioms   : Definitions for functions
% Version  : [Ben08] axioms.
% English  :

% Refs     : [BS+05] Benzmueller et al. (2005), Can a Higher-Order and a Fi
%          : [BS+08] Benzmueller et al. (2007), Combined Reasoning by Autom
%          : [Ben08] Benzmueller (2008), Email to Geoff Sutcliffe
% Source   : [Ben08]
% Names    : Typed_Function [Ben08]

% Status   : Satisfiable
% Syntax   : Number of formulae    :   16 (   0 unit;   8 type;   8 defn)
%            Number of atoms       :  143 (  13 equality;  40 variable)
%            Maximal formula depth :   10 (   6 average)
%            Number of connectives :   29 (   0   ~;   0   |;   3   &;  23   @)
%                                         (   0 <=>;   3  =>;   0  <=;   0 <~>)
%                                         (   0  ~|;   0  ~&;   0  !!;   0  ??)
%            Number of type conns  :   46 (  46   >;   0   *;   0   +)
%            Number of symbols     :   10 (   8   :;   0  :=)
%            Number of variables   :   26 (   0 sgn;   7   !;   3   ?;  16   ^)
%                                         (  26   :;   0  :=;   0  !>;   0  ?*)
% SPC      : 

% Comments :
%------------------------------------------------------------------------------
thf(fun_image_decl,type,(
    fun_image: ( $i > $i ) > ( $i > $o ) > $i > $o )).

thf(fun_image,definition,
    ( fun_image
    = ( ^ [F: $i > $i,A: $i > $o,Y: $i] :
        ? [X: $i] :
          ( ( A @ X )
          & ( Y
            = ( F @ X ) ) ) ) )).

thf(fun_composition_decl,type,(
    fun_composition: ( $i > $i ) > ( $i > $i ) > $i > $i )).

thf(fun_composition,definition,
    ( fun_composition
    = ( ^ [F: $i > $i,G: $i > $i,X: $i] :
          ( G @ ( F @ X ) ) ) )).

thf(fun_inv_image_decl,type,(
    fun_inv_image: ( $i > $i ) > ( $i > $o ) > $i > $o )).

thf(fun_inv_image,definition,
    ( fun_inv_image
    = ( ^ [F: $i > $i,B: $i > $o,X: $i] :
        ? [Y: $i] :
          ( ( B @ Y )
          & ( Y
            = ( F @ X ) ) ) ) )).

thf(fun_injective_decl,type,(
    fun_injective: ( $i > $i ) > $o )).

thf(fun_injective,definition,
    ( fun_injective
    = ( ^ [F: $i > $i] :
        ! [X: $i,Y: $i] :
          ( ( ( F @ X )
            = ( F @ Y ) )
         => ( X = Y ) ) ) )).

thf(fun_surjective_decl,type,(
    fun_surjective: ( $i > $i ) > $o )).

thf(fun_surjective,definition,
    ( fun_surjective
    = ( ^ [F: $i > $i] :
        ! [Y: $i] :
        ? [X: $i] :
          ( Y
          = ( F @ X ) ) ) )).

thf(fun_bijective_decl,type,(
    fun_bijective: ( $i > $i ) > $o )).

thf(fun_bijective,definition,
    ( fun_bijective
    = ( ^ [F: $i > $i] :
          ( ( fun_injective @ F )
          & ( fun_surjective @ F ) ) ) )).

thf(fun_decreasing_decl,type,(
    fun_decreasing: ( $i > $i ) > ( $i > $i > $o ) > $o )).

thf(fun_decreasing,definition,
    ( fun_decreasing
    = ( ^ [F: $i > $i,SMALLER: $i > $i > $o] :
        ! [X: $i,Y: $i] :
          ( ( SMALLER @ X @ Y )
         => ( SMALLER @ ( F @ Y ) @ ( F @ X ) ) ) ) )).

thf(fun_increasing_decl,type,(
    fun_increasing: ( $i > $i ) > ( $i > $i > $o ) > $o )).

thf(fun_increasing,definition,
    ( fun_increasing
    = ( ^ [F: $i > $i,SMALLER: $i > $i > $o] :
        ! [X: $i,Y: $i] :
          ( ( SMALLER @ X @ Y )
         => ( SMALLER @ ( F @ X ) @ ( F @ Y ) ) ) ) )).

%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
thf(thm,conjecture,(
    ! [X: $i > $o,Y: $i > $o,F: $i > $i] :
     (
      ( ?[A:$i,B:$i]: ((X @ A) & (X @ B) & ~(A = B)) )
      =>
      ( subset @ ( fun_image @ F @ ( union @ X @ Y ) ) @ ( intersection @ ( fun_image @ F @ X ) @ ( fun_image @ F @ Y ) ) ) ) )).

%------------------------------------------------------------------------------
