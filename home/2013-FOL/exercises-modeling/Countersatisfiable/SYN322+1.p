%--------------------------------------------------------------------------
% File     : SYN322+1 : TPTP v5.0.0. Released v2.0.0.
% Domain   : Syntactic
% Problem  : Church problem 46.4 (1)
% Version  : Especial.
% English  :

% Refs     : [Chu56] Church (1956), Introduction to Mathematical Logic I
% Source   : [Chu56]
% Names    : 46.4 (1) [Chu56]

% Status   : CounterSatisfiable
% Rating   : 0.00 v4.1.0, 0.17 v4.0.1, 0.00 v3.2.0, 0.25 v3.1.0, 0.17 v2.6.0, 0.25 v2.5.0, 0.33 v2.4.0, 0.00 v2.1.0
% Syntax   : Number of formulae    :    1 (   0 unit)
%            Number of atoms       :    4 (   0 equality)
%            Maximal formula depth :    7 (   7 average)
%            Number of connectives :    5 (   2 ~  ;   0  |;   0  &)
%                                         (   0 <=>;   3 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :    1 (   0 propositional; 2-2 arity)
%            Number of functors    :    0 (   0 constant; --- arity)
%            Number of variables   :    3 (   0 singleton;   2 !;   1 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_CSA_EPR

% Comments :
%--------------------------------------------------------------------------
fof(church_46_4_1,conjecture,
    ( ? [Y] :
        ( ! [X] :
            ( big_f(X,Y)
           => big_f(Y,X) )
       => ~ ( ! [X] :
                ( big_f(X,Y)
               => ~ big_f(Y,X) ) ) ) )).

%--------------------------------------------------------------------------
