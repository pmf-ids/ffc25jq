#!/usr/bin/env -S jq -nf

def f(x): x | tgamma; [inputs | [., input]]
| map(f(add - 1) / f(first) / f(last))
, map(f(add + first - 2) / pow(f(first); 2) / f(last))
, map(f(first * (last - 1) + 1) / pow(f(last); first))
| add
