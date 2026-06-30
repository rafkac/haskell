double :: Int -> Int
double x = x * 2

square :: Int -> Int
square x = x * x

-- Multiple arguments: the type is arg1 -> arg2 -> result
add :: Int -> Int -> Int
add x y = x + y

-- Functions are called WITHOUT parentheses or commas:
--   add 3 4     not   add(3, 4)


-- if/then/else is an EXPRESSION — it must always have an else,
-- because it must produce a value either way.
absVal :: Int -> Int
absVal n = if n < 0 then -n else n

-- Guards are the idiomatic alternative — cleaner for multiple cases.
-- Read each | as "when this condition holds".
classify :: Int -> String
classify n
  | n < 0     = "negative"
  | n == 0    = "zero"
  | otherwise = "positive"     -- 'otherwise' is just True; it's the catch-all



-- where: attach helper bindings to a definition
quadratic :: Double -> Double -> Double -> Double -> Double
quadratic a b c x = a * x2 + b * x + c
  where x2 = x * x

-- let ... in: an expression that introduces local names
hypotenuse :: Double -> Double -> Double
hypotenuse a b = let a2 = a * a
                     b2 = b * b
                 in sqrt (a2 + b2)
