% Someone who lives in Dreadbury Mansion killed Aunt Agatha.
fof(ax1,axiom,
     ( ?[X]: ( lives_in_dm(X) & killed(X,agatha) ) ) ).
% Agatha, the butler, and Charles live in Dreadbury Mansion,
% and are the only people who live therein.
fof(ax2,axiom,
     ( ![X]: ( lives_in_dm(X) <=> ( X = agatha | X = charles | X = butler) ) ) ).
% A killer always hates his victim, and is never richer than his victim.
fof(ax3,axiom,
     ( ![K,H]: ( killed(K,H) => ( hates(K,H) & ~ richer(K,H) ) ) ) ).
% Charles hates no one that Aunt Agatha hates.
fof(ax4,axiom,
     ( ![H]: ( hates(agatha,H) => ~ hates(charles,H) ) ) ).
% Agatha hates everyone except the butler.
fof(ax5,axiom,
     ( ![H]: ( butler != H <=> hates(agatha,H) ) ) ).
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
     ( agatha != butler ) ).
% Therefore : Agatha killed herself.
fof(con,conjecture,( killed(agatha,agatha) ) ).