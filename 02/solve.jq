#!/usr/bin/env -S jq -Rf

def f(mod): [foreach .[] as [$d,$n] (0; . + $d * ($n | mod); .)] | max;
[scan("\\^+|v+") | [7 - explode[0] % 11, length]]

| f(.)
, f(. * (. + 1) / 2)
, f(nth(. - 1; [0,1] | recurse([last, add])) | last)
