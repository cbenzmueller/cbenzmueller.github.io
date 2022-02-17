thf(g,type,(
    g: $o > $o )).

thf(p,type,(
    p: ($o > $o) > $o )).

thf(x,type,(
    x: $o )).

thf(y,type,(
    y: $o )).

thf(ax1,axiom,
    (  (~ (x = y))
     & ((g @ x) = y)
     & ((g @ y) = x)
     & (p @ g)
     & (~ (p @ ~))
    )).

thf(con,conjecture, $false).