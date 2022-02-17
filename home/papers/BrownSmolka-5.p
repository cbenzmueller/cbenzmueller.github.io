thf(f,type,(
    f: $o > $o )).

thf(q,type,(
    q: ($o > $o) > $o > $o)).

thf(x,type,(
    x: $o )).

thf(ax1,axiom,
    (   (q @ f @ x)
      & (f @ (f @ x))
      & (~ ((f @ (q @ f @ x)) = (f @ x)))
    )).

thf(con,conjecture, $false).