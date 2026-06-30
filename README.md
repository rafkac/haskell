# haskell learning repo

I scored 95% from uni's Functional Programming module with Haskell. Now I am back to practicing it as I am looking into Haskell full-time positions.

Each lesson lives in its own directory (`L1`, `L2`, …) with the lesson source, exercise solutions, and 
notes.

## Lessons

| Lesson | Topics | Files |
| ------ | ------ | ----- |
| L1 | Functions, type signatures, `if`/guards, `where`/`let`, recursion | [`L1/`](L1/) |

## Running the code

These are plain `.hs` files — no build tool required. With [GHC](https://www.haskell.org/ghc/)
installed (e.g. via [GHCup](https://www.haskell.org/ghcup/)), load a file into
the interpreter and try the functions:

```sh
ghci L1/lesson1.hs
```

```haskell
ghci> double 21
42
ghci> classify (-3)
"negative"
```

Or compile a file to an executable:

```sh
ghc L1/lesson1.hs && ./L1/lesson1
```
