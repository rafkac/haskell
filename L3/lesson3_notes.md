# Lesson 3 — Key Takeaways

## The core idea
Functions are **values**. You can pass a function as an argument. A function
that takes or returns a function is **higher-order**. This lets you capture a
recursion pattern **once** and reuse it, instead of rewriting `[]`/`(x:xs)`
every time.

## The three workhorses

| Pattern | Function | Type | Example |
|---|---|---|---|
| "do X to every element" | `map`    | `(a -> b) -> [a] -> [b]`      | `map (+1) [1,2,3] == [2,3,4]` |
| "keep elements passing a test" | `filter` | `(a -> Bool) -> [a] -> [a]` | `filter even [1..10]` |
| "collapse a list to one value" | `foldr`  | `(a -> b -> b) -> b -> [a] -> b` | `foldr (+) 0 [1..3] == 6` |

Each of your Lesson 2 functions IS one of these:
- `addOne`/`squares`/`doubleAll` → `map`
- `evens`/`keepAbove` → `filter`
- `sumList`/`productList`/`myLength`/`totalAge` → `foldr`

## New vocabulary for passing functions

- **Lambda**: `\x -> x * x` — an anonymous function. `\x y -> x + y` takes two args.
- **Section**: an operator missing one side becomes a function:
  - `(+1)`, `(*2)`, `(>3)`, `(`div` 2)`
  - ⚠️ `(-1)` is *negative one*, NOT "subtract 1". Use `(subtract 1)`.

## fold, in one picture
`foldr` replaces every `(:)` with your function and `[]` with your seed `z`:
```
foldr f z [1,2,3] = f 1 (f 2 (f 3 z))    -- nests right-to-left
foldr (+) 0 [1,2,3] = 1 + (2 + (3 + 0)) = 6
```
- `foldr` = fold from the right; `foldl` = from the left.
- For **associative** ops (`+`, `*`) the result is the same.
- **Rule of thumb for now: reach for `foldr` first.**
- `foldr1` uses the last element as the seed → good for `max`/`min` on non-empty lists.
- Amazingly, `map` and `filter` can both be written as `foldr`.

## Glue

- **Composition** `(.)`: `(f . g) x == f (g x)`, read "f after g".
  `sum . map (^2) . filter even` runs right-to-left.
- **Application** `($)`: lowest-precedence application, kills parentheses.
  `f (g (h x))  ==  f $ g $ h x`

## More HOFs worth knowing
`zipWith` (combine two lists pairwise — your `zipSum`), `takeWhile`/`dropWhile`,
`all`/`any`, `concatMap`, `foldr1`.

## Type conversions you'll hit
- `fromIntegral` — turn an `Int`/`Integer` into a fractional type (e.g. for `average`).
- `show` — turn a value into a `String`.

## Habit forming
Reach for `map`/`filter`/`fold` **before** hand-writing recursion. Explicit
`(x:xs)` recursion is for when no combinator fits — which is rarer than you'd think.