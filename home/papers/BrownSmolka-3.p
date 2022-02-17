thf(g,type,(
    g: $o > $o )).

thf(f,type,(
    f: $o > $o )).

thf(x,type,(
    x: $o )).

thf(y,type,(
    y: $o )).

thf(ax1,axiom,
   ( (~ (x = y))
     & ((g @ x) = y)
     & ((g @ y) = x)
     & ((f @ (f @ (f @ x))) = (g @ (f @ x)))
   )).


thf(con,conjecture, $false).