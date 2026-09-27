# Haskell Basics — a top-down path

Work through the files in order. Each one is a runnable program: read the
comments top to bottom, run it, then do the exercises at the bottom.

| #  | File                          | Topic                                            |
|----|-------------------------------|--------------------------------------------------|
| 01 | `01-hello-and-running.hs`     | `main`, comments, running code, GHCi             |
| 02 | `02-values-and-types.hs`      | Basic types, type signatures, `::`, bindings     |
| 03 | `03-functions.hs`             | Defining/calling functions, currying, operators, lambdas |
| 04 | `04-control-flow.hs`          | `if`, guards, `case`, `where`, `let`             |
| 05 | `05-lists-and-strings.hs`     | Lists, ranges, comprehensions, strings           |
| 06 | `06-tuples-and-patterns.hs`   | Tuples, pattern matching on everything           |
| 07 | `07-recursion.hs`             | Recursion instead of loops                       |
| 08 | `08-higher-order.hs`          | `map`, `filter`, `foldr`, `.`, `$`               |
| 09 | `09-type-classes.hs`          | `Eq`, `Ord`, `Show`, `=>`, constraints, instances |
| 10 | `10-data-types.hs`            | `data`, records, `Maybe`, `Either`, `type`, `newtype` |
| 11 | `11-io-and-do.hs`             | `IO`, `do` notation, reading input               |
| 12 | `12-reasoning-about-code.hs`  | Equational reasoning & induction (verification bridge) |

## How to run a lesson

```bash
runghc 01-hello-and-running.hs      # run it
ghci 03-functions.hs                # load it and play interactively
```

Inside GHCi:

```
:t expr      -- show the type of an expression
:i Name      -- info about a type/class/function
:r           -- reload the file after editing
:q           -- quit
```

## Exercises

Exercises are marked `EXERCISE` and usually have a stub defined as
`undefined`. Replace `undefined` with your implementation, then test it in
GHCi (`ghci NN-file.hs`, then call your function).
