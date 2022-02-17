fof(ax1,axiom,(
    ( ![X]: r(X,X) )
    &
    ( ![X,Y]: r(X,Y) => ~ r(Y,X) )
    &
    ( ![X,Y,Z]: ( ( r(X,Y) & r(Y,Z) ) => r(X,Z) ) )
    &
    ( ![X]: ?[Y]: r(X,Y) ) )).