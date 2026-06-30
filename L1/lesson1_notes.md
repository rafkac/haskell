💡 Idiom note — you can simplify the guards
You already learned this with isEven. Both collatzSteps guards do 1 + (something), and the only difference is the recursive argument. You can lift the common 1 + out:

```Haskell
collatzSteps :: Int -> Int
collatzSteps 1 = 0
collatzSteps x = 1 + collatzSteps next
  where next = if even x then x `div` 2 else 3 * x + 1
```
Same logic, but the structure ("one step, then recurse on the next value") is now visible at a glance. This is the if/where/recursion combo from my last message — and notice I used the built-in even instead of your isEven (both fine; even is standard).