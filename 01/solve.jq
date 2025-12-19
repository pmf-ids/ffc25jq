#!/usr/bin/env -S jq -Rnf

[inputs | contains("ne") as $ne | length / 2 | [
  ., if . % 2 != 0, $ne then 0 end
]] | transpose[] | add
