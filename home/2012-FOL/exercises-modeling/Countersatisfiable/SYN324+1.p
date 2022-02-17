%--------------------------------------------------------------------------
% File     : SYN324+1 : TPTP v5.0.0. Released v2.0.0.
% Domain   : Syntactic
% Problem  : Church problem 46.9 (1)
% Version  : Especial.
% English  :

% Refs     : [Chu56] Church (1956), Introduction to Mathematical Logic I
% Source   : [Chu56]
% Names    : 46.9 (1) [Chu56]

% Status   : CounterSatisfiable
% Rating   : 0.00 v4.1.0, 0.17 v4.0.1, 0.33 v3.5.0, 0.25 v3.4.0, 0.33 v3.3.0, 0.17 v3.2.0, 0.00 v3.1.0, 0.17 v2.6.0, 0.00 v2.1.0
% Syntax   : Number of formulae    :    1 (   0 unit)
%            Number of atoms       :    4 (   0 equality)
%            Maximal formula depth :    5 (   5 average)
%            Number of connectives :    3 (   0 ~  ;   0  |;   0  &)
%                                         (   2 <=>;   1 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :    1 (   0 propositional; 2-2 arity)
%            Number of functors    :    0 (   0 constant; --- arity)
%            Number of variables   :    2 (   0 singleton;   1 !;   1 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_CSA_RFO_NEQ

% Comments :
%--------------------------------------------------------------------------
fof(church_46_9_1,conjecture,
    ( ? [X] :
      ! [Y] :
        ( ( big_f(X,Y)
        <=> big_f(X,X) )
       => ( big_f(X,Y)
        <=> big_f(Y,Y) ) ) )).

%--------------------------------------------------------------------------
