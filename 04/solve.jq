#!/usr/bin/env -S jq -Rnf

def f(agg): reduce .[] as $pos ([[0,0],0];
  [$pos, last + ([first, $pos] | [transpose[] | max - min] | agg)]
) | last;

["[\(inputs)]" | fromjson] | f(add), (., sort_by(add) | f(max))
