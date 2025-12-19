#!/usr/bin/env -S jq -Rnf

1000 as $M | def inv(t): fma(t; .; $M/4) % $M < $M/2;
["[\(inputs)]" | fromjson | map((. + $M) % $M)]

| (map(if any(inv(100)) then empty end) | length)
, (((3600, 31556926) % $M) as $frq
    | [0 | recurse((. + $frq) % $M; . != 0)] as $res
    | [$res[] | [inv($res | keys[])]] as $mem | map(
        [$mem[.[] | $res[[. * $frq % $M]][]]]
        | transpose[] | if first or last then empty end
      ) | ($res | $M / length) * length
  )
