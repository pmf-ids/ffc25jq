
# Solving [Flip Flop Codes 2025](https://flipflop.slome.org/2025/) in [jq](https://jqlang.org/)

- Each puzzle's solution lives in its own, single, self‑contained `.jq` script file that can independently be processed by jq from the command-line
- A puzzle's input can be read either from stdin or from a file passed as an argument
- The answers to each part of a puzzle are provided as an output stream
- Whether the input is interpreted and/or the output rendered as JSON or as raw text depends on that puzzle's formatting of the input data and/or its expected result, and is declared explicitly in each file

## Execution

These solutions expect the JSON processor [jq](https://jqlang.org/) to be available in [version 1.8.1](https://github.com/jqlang/jq/releases/tag/jq-1.8.1) (released Jul 1, 2025). However, they should generally also work with other versions of jq, likely right out of the box, or at worst with some minor migrational adjustments.

### On Linux / macOS (in a POSIX‑compatible environment)

Every script file starts with a [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)), e.g. `#!/usr/bin/env -S jq -Rnf`, which tells your OS how to invoke jq. So, just make the script file executable, e.g. using `chmod +x`, and run it with the puzzle data either redirected, or provided as an input file argument:

```sh
chmod +x solve.jq       # make it executable (only needed once)
./solve.jq input.txt    # or: ./solve.jq < input.txt
```

### On Windows (or any OS that supports calling jq explicitly)

Invoke the jq binary, e.g. `jq.exe`, and pass these arguments:
- all format flags for that puzzle (find them in the script's header line)
- the `--from-file` (or `-f`) option followed by the script's file name
- the puzzle input's file name

For a script starting with `#!/usr/bin/env -S jq -Rnf`, the command could be:

```bat
jq.exe -R -n -f solve.jq input.txt
```

### Example (Puzzle 07)

#### Script file `solve.jq`:

```jq
#!/usr/bin/env -S jq -nf

def f(x): x | tgamma; [inputs | [., input]]
| map(f(add - 1) / f(first) / f(last))
, map(f(add + first - 2) / pow(f(first); 2) / f(last))
, map(f(first * (last - 1) + 1) / pow(f(last); first))
| add
```

#### Input file `example.txt`:

```
2 2
3 3
2 3
```

#### Execution:

Either one works on MyMachine™:
```sh
# Using the shebang
./solve.jq example.txt
```
```sh
# Calling jq explicitly
jq -nf solve.jq example.txt
```

#### Output:

```
11
108
98
```

## Performance

Times were measured with [hyperfine](https://github.com/sharkdp/hyperfine) on MyMachine™ (1.7 GHz); the displayed value is the average over at least 10 runs. Note that jq is single-threaded and uses only one CPU core.

| Puzzle        | Name                           | Runtime     |
|:-------------:|:-------------------------------|:------------|
| **01** | [Banana Contest](01/solve.jq) | <code>█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░&nbsp;&nbsp;&nbsp;5&nbsp;ms</code> |
| **02** | [Rollercoaster Heights](02/solve.jq) | <code>█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░&nbsp;&nbsp;11&nbsp;ms</code> |
| **03** | [Bush Salesman](03/solve.jq) | <code>█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░&nbsp;&nbsp;24&nbsp;ms</code> |
| **04** | [Beach cleanup](04/solve.jq) | <code>█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░&nbsp;&nbsp;&nbsp;5&nbsp;ms</code> |
| **05** | [Strange tunnels](05/solve.jq) | <code>█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░&nbsp;&nbsp;&nbsp;4&nbsp;ms</code> |
| **06** | [Bird spotters](06/solve.jq) | <code>██████████████████████████████&nbsp;727&nbsp;ms</code> |
| **07** | [Hyper grids](07/solve.jq) | <code>█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░&nbsp;&nbsp;&nbsp;3&nbsp;ms</code> |
|               | **Total time**                 | <code>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;779&nbsp;ms</code>   |

