%------------------------------------------------------------------------------
%---- Test Axioms:

fof(test_True,axiom,
    ( $true )).


fof(test_False,axiom,
    ( $false )).


fof(test_Atom,axiom,
    ( p(f(a,b),c) )).


fof(test_NegTrue,axiom,
    ( ~ $true )).


fof(test_NegFalse,axiom,
    ( ~ $false )).


fof(test_NegAtom,axiom,
    ( ~ p(f(a,b),c) )).


fof(test_NegNegAtom,axiom,
    ( ~ ~ ( p(a,f(a,b)) | p(b,a) ) )).


fof(test_Alpha1,axiom,
    ( p(a,f(a,b)) & p(b,a) )).

fof(test_Alpha2,axiom,
    ( p(a,f(a,b)) ~| p(b,a) )).

fof(test_Alpha3,axiom,
    ( ~ ( p(a,f(a,b)) | p(b,a) ) )).

fof(test_Alpha4,axiom,
    ( ~ ( p(a,f(a,b)) ~& p(b,a) ) )).

fof(test_Alpha5,axiom,
    ( ~ ( p(a,f(a,b)) => p(b,a) ) )).

fof(test_Alpha6,axiom,
    ( ~ ( p(a,f(a,b)) <= p(b,a) ) )).


fof(test_Beta1,axiom,
    ( p(a,f(a,b)) | p(b,a) )).

fof(test_Beta2,axiom,
    ( p(a,f(a,b)) ~& p(b,a) )).

fof(test_Beta3,axiom,
    ( p(a,f(a,b)) => p(b,a) )).

fof(test_Beta4,axiom,
    ( p(a,f(a,b)) <= p(b,a) )).

fof(test_Beta5,axiom,
    ( ~ ( p(a,f(a,b)) & p(b,a) ) )).

fof(test_Beta6,axiom,
    ( ~ ( p(a,f(a,b)) ~| p(b,a) ) )).



fof(test_Gamma1,axiom,
    ( ![Z]: ( p(a,f(Z,b)) | p(b,Z) ) )).

fof(test_Gamma1,axiom,
    (~ ( ?[Z]: ( p(a,f(Z,b)) | p(b,Z) ) ) )).



fof(test_Delta1,axiom,
    ( ?[Z]: ( p(a,f(Z,b)) | p(b,Z) ) )).

fof(test_Delta1,axiom,
    (~ ( ![Z]: ( p(a,f(Z,b)) | p(b,Z) ) ) )).



fof(test_DepthAndRank,axiom,
    ( ( (~ ( ![Z]: ( p(a,f(Z,b)) | p(b,Z) ) ) ) => ( ?[Z]: ( p(a,f(Z,b)) | p(b,Z) ) ) ) )).


fof(pel55,conjecture,
    ( $true )).

%------------------------------------------------------------------------------
