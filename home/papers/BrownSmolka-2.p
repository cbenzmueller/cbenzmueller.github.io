thf(h,type,(
    h: $o > $i )).

thf(f,type,(
    f: $o > $o )).

thf(x,type,(
    x: $o )).

thf(ax,axiom,
    (~ ((h @ (f @ (f @ (f @ x)))) = (h @ (f @ x))))).

thf(con,conjecture, $false).