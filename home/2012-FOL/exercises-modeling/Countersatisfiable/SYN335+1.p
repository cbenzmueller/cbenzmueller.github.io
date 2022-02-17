%--------------------------------------------------------------------------
% File     : SYN335+1 : TPTP v5.0.0. Released v2.0.0.
% Domain   : Syntactic
% Problem  : Church problem 46.14 (7)
% Version  : Especial.
% English  :

% Refs     : [Chu56] Church (1956), Introduction to Mathematical Logic I
% Source   : [Chu56]
% Names    : 46.14 (7) [Chu56]

% Status   : CounterSatisfiable
% Rating   : 0.75 v5.0.0, 0.44 v4.1.0, 0.67 v3.7.0, 0.33 v3.5.0, 0.50 v3.3.0, 0.33 v3.2.0, 0.00 v3.1.0, 0.50 v2.6.0, 0.25 v2.5.0, 0.33 v2.3.0, 0.00 v2.1.0
% Syntax   : Number of formulae    :    1 (   0 unit)
%            Number of atoms       :   12 (   0 equality)
%            Maximal formula depth :   10 (  10 average)
%            Number of connectives :   11 (   0 ~  ;   0  |;   0  &)
%                                         (   4 <=>;   7 =>;   0 <=)
%                                         (   0 <~>;   0 ~|;   0 ~&)
%            Number of predicates  :    2 (   0 propositional; 2-2 arity)
%            Number of functors    :    0 (   0 constant; --- arity)
%            Number of variables   :    3 (   0 singleton;   1 !;   2 ?)
%            Maximal term depth    :    1 (   1 average)
% SPC      : FOF_CSA_RFO_NEQ

% Comments :
%--------------------------------------------------------------------------
fof(church_46_14_7,conjecture,
    ( ? [X,Y] :
      ! [Z] :
        ( big_f(X,Z)
       => ( ( ( big_f(Z,Z)
             => big_g(Z,Z) )
          <=> big_f(X,Y) )
         => ( ( ( big_g(Z,Z)
               => big_f(Z,Z) )
            <=> big_g(X,Y) )
           => ( ( ( big_g(X,Y)
                 => big_f(Y,X) )
              <=> big_g(Y,Z) )
             => ( big_f(Z,Y)
              <=> big_f(Y,X) ) ) ) ) ) )).

%--------------------------------------------------------------------------
