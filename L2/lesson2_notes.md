# Lesson 2 — Key Takeaways

## The one thing to remember
A list is **always** one of two shapes:
- `[]` — empty
- `x : xs` — a head `x` cons'd onto a tail `xs`

You write list functions by giving **one equation per shape**:

```haskell
f []     = <answer for empty>
f (x:xs) = <combine x with (f xs)>
```

Two questions to ask for any list function:
1. What's the answer for the **empty** list? → base case
2. Given the head `x` and the answer for the **tail** (`f xs`), how do I build the whole answer? → recursive case

## Syntax facts
- `[1,2,3]` is sugar for `1 : 2 : 3 : []`.
- `String = [Char]`, so `'h' : "ello" == "hello"`.
- `_` is a wildcard pattern: "match anything, don't name it."
- Type variables (`a`, `b`) mean "works for any type": `len :: [a] -> Int`.

## Base case = identity of the operation
- sum  → `0`  (identity for `+`)
- product / factorial → `1` (identity for `*`)
- length → `0`
- "build a list" (map-like) → `[]`

## Consuming vs building
- **Consuming** (produce a value): `sumList (x:xs) = x + sumList xs`
- **Building** (produce a list): `doubleAll (x:xs) = (2*x) : doubleAll xs`
  The recursive case **cons**es a new head onto the recursive result.
- **Filtering**: use guards to decide whether to cons `x` or skip it.

## Tuples vs lists
- **List**: any length, all elements **same type** — `[Int]`.
- **Tuple**: fixed length, elements may be **different types** — `(Int, Char)`.
- `fst`/`snd` get the parts of a pair; you can also pattern-match `(a, b)`.

## Partial functions (foreshadowing)
`maxList []` and `head []` **crash** — they have no answer for the empty list.
These are "partial functions." Later we'll make them safe with `Maybe`.

## Useful built-ins introduced
`head` `tail` `null` `length` `reverse` `(++)` `elem` `take` `drop`
`zip` `min` `max` `even` `odd`, range syntax `[1..10]` and `[2,4..10]`,
and `span` (for the challenge).