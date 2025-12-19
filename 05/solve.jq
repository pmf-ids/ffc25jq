#!/usr/bin/env -S jq -Rrf

[explode | ., length, [indices(.[])]] as [$map, $out, $con]
| [0 | while(. < $out; 1 + add($con[.][]) - .)]

| [$map[] / 32 | 2 * floor - 5] as $cap
| map($cap[.] * (add($con[.][]) - 2 * . | fabs)) as $tun
| [$map[[$con[][0]] - [$con[.[]][0]] | unique[]]]
| add($tun[] | fabs), implode, add($tun[])
