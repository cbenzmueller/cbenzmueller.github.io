% Equality is reflexive
fof(eqref,axiom,
     ( ![X]: eq(X,X) )).

% Equality is symmetric
fof(eqsym,axiom,
     ( ![X,Y]: ( eq(X,Y) => eq(Y,X) ) )).

% Equality is transitive
fof(eqtrans,axiom,
     ( ![X,Y,Z]: ( ( eq(X,Y) & eq(Y,Z) ) => eq(X,Z) ) )).

% Equality substitution
fof(eqsub1,axiom,
     ( ![X,Y]: ( eq(X,Y) => ( lives_in_dm(X) <=> ( lives_in_dm(Y) ) ) ) )).
fof(eqsub2,axiom,
     ( ![X,Y,Z]: ( eq(X,Y) => ( killed(X,Z) <=> ( killed(Y,Z) ) ) ) )).
fof(eqsub3,axiom,
     ( ![X,Y,Z]: ( eq(X,Y) => ( killed(Z,X) <=> ( killed(Z,Y) ) ) ) )).
fof(eqsub4,axiom,
     ( ![X,Y,Z]: ( eq(X,Y) => ( hates(X,Z) <=> ( hates(Y,Z) ) ) ) )).
fof(eqsub5,axiom,
     ( ![X,Y,Z]: ( eq(X,Y) => ( hates(Z,X) <=> ( hates(Z,Y) ) ) ) )).
fof(eqsub6,axiom,
     ( ![X,Y,Z]: ( eq(X,Y) => ( richer(X,Z) <=> ( richer(Y,Z) ) ) ) )).
fof(eqsub7,axiom,
     ( ![X,Y,Z]: ( eq(X,Y) => ( richer(Z,X) <=> ( richer(Z,Y) ) ) ) )).




% Someone who lives in Dreadbury Mansion killed Aunt Agatha.
fof(ax1,axiom,
     ( ?[X]: ( lives_in_dm(X) & killed(X,agatha) ) ) ).

% Agatha, the butler, and Charles live in Dreadbury Mansion,
% and are the only people who live therein.
fof(ax2,axiom,
     ( ![X]: ( lives_in_dm(X) <=> ( eq(X,agatha) | eq(X,charles) | eq(X,butler)) ) ) ).

% A killer always hates his victim, and is never richer than his victim.
fof(ax3,axiom,
     ( ![K,H]: ( killed(K,H) => ( hates(K,H) & ~ richer(K,H) ) ) ) ).

% Charles hates no one that Aunt Agatha hates.
fof(ax4,axiom,
     ( ![H]: ( hates(agatha,H) => ~ hates(charles,H) ) ) ).

% Agatha hates everyone except the butler.
fof(ax5,axiom,
     ( ![H]: ( ( ~ eq(butler,H) ) <=> hates(agatha,H) ) ) ).

% The butler hates everyone not richer than Aunt Agatha.
fof(ax6,axiom,
     ( ![H]: ( ~ richer(H,agatha) => hates(butler,H) ) ) ).

% The butler hates everyone Aunt Agatha hates.
fof(ax7,axiom,
     ( ![H]: ( hates(agatha,H) => hates(butler,H) ) ) ).

% No one hates everyone.
fof(ax8,axiom,
     ( ![X]: ?[M]: ~ hates(X,M) )).

% Agatha is not the butler.
fof(ax9,axiom,
     ( ~ eq(agatha,butler) )).

% Therefore : Agatha killed herself.
fof(con,conjecture,( killed(agatha,agatha) ) ).