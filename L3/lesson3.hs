-- =====================================================================
-- LESSON 3 — Higher-Order Functions: map, filter, fold
-- =====================================================================
--
-- Load with:   ghci> :l L3/lesson3.hs
--
-- The payoff for all that hand-written recursion in Lesson 2. Three
-- recurring patterns get captured ONCE and reused forever.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 3.1  FUNCTIONS ARE VALUES
-- ---------------------------------------------------------------------
-- In Haskell a function is just another value. You can pass it to another
-- function as an argument, return it as a result, or store it in a list.
-- A function that takes or returns a function is "higher-order".
--
-- The type of "a function taking an Int and returning an Int" is:  Int -> Int
-- So a function that TAKES such a function has a type like:  (Int -> Int) -> ...
--
-- applyTwice takes a function f and a value x, and applies f to x twice.
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)
-- Try:  applyTwice (+3) 10      == 16
--       applyTwice (++ "!") "hi" == "hi!!"


-- ---------------------------------------------------------------------
-- 3.2  LAMBDAS (anonymous functions)
-- ---------------------------------------------------------------------
-- Sometimes you need a small one-off function without naming it.
--   \x -> x * x            is a function taking x, returning x*x
--   \x y -> x + y          takes two args
-- The backslash \ is meant to look like a lambda (λ). Read "\x ->" as
-- "the function of x that gives ...".
--
-- These two definitions are identical:
squareA :: Int -> Int
squareA x = x * x

squareB :: Int -> Int
squareB = \x -> x * x        -- the lambda form


-- ---------------------------------------------------------------------
-- 3.3  SECTIONS (partially-applied operators)
-- ---------------------------------------------------------------------
-- An operator wrapped in parens, missing one side, becomes a function:
--   (+1)     == \x -> x + 1
--   (10-)    == \x -> 10 - x
--   (*2)     == \x -> x * 2
--   (>3)     == \x -> x > 3
--   (`div` 2)== \x -> x `div` 2      (backticks needed for named funcs)
--   (2 `div`)== \x -> 2 `div` x
--
-- Sections are the idiomatic, terse way to pass simple functions.
-- Watch out: (-1) is NEGATIVE ONE, not "subtract 1". Use (subtract 1) instead.


-- ---------------------------------------------------------------------
-- 3.4  map  —  "do something to every element"
-- ---------------------------------------------------------------------
-- map takes a function and a list, and applies the function to each element.
--   map :: (a -> b) -> [a] -> [b]
-- Note the types can differ: a -> b. map show [1,2,3] :: [String].
--
-- Here's map reimplemented so you see it's just the Lesson 2 recipe with
-- the "combine" step supplied as an argument:
myMap :: (a -> b) -> [a] -> [b]
myMap _ []     = []
myMap f (x:xs) = f x : myMap f xs

-- Your Lesson 2 functions collapse to one-liners:
addOne'   :: [Int] -> [Int]
addOne'   = map (+1)
squares'  :: [Int] -> [Int]
squares'  = map (\x -> x * x)
doubleAll':: [Int] -> [Int]
doubleAll'= map (*2)
-- Try:  map (+1) [1,2,3]        == [2,3,4]
--       map show [1,2,3]        == ["1","2","3"]
--       map (\x -> x*x) [1..5]  == [1,4,9,16,25]


-- ---------------------------------------------------------------------
-- 3.5  filter  —  "keep the elements that pass a test"
-- ---------------------------------------------------------------------
-- filter takes a PREDICATE (a function returning Bool) and a list.
--   filter :: (a -> Bool) -> [a] -> [a]
--
-- Reimplemented (again, just the Lesson 2 recipe with the test supplied):
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter p (x:xs)
  | p x       = x : myFilter p xs
  | otherwise = myFilter p xs

-- Your evens/keepAbove collapse:
evens'    :: [Int] -> [Int]
evens'    = filter even
keepAbove':: Int -> [Int] -> [Int]
keepAbove' n = filter (> n)
-- Try:  filter even [1..10]       == [2,4,6,8,10]
--       filter (> 3) [1,5,2,8]    == [5,8]
--       filter (/= ' ') "a b c"   == "abc"


-- ---------------------------------------------------------------------
-- 3.6  foldr / foldl  —  "collapse a whole list into one value"
-- ---------------------------------------------------------------------
-- This is the deep one. A fold combines all the elements using a binary
-- function, starting from an initial ("accumulator") value.
--
--   foldr :: (a -> b -> b) -> b -> [a] -> b
--            \_____________/  \_/  \__/   \_
--            combine fn        z    list   result
--
-- foldr ("fold from the RIGHT") replaces every (:) with your function and
-- [] with your initial value z:
--
--   foldr f z [1,2,3]
--     = f 1 (f 2 (f 3 z))          -- note the nesting goes right-to-left
--
-- Concretely, sum is foldr (+) 0:
--   foldr (+) 0 [1,2,3] = 1 + (2 + (3 + 0)) = 6
--
-- Watch EVERYTHING from Lesson 2 become a fold:
sum'     :: [Int] -> Int
sum'     = foldr (+) 0
product' :: [Int] -> Int
product' = foldr (*) 1
length'  :: [a] -> Int
length'  = foldr (\_ acc -> 1 + acc) 0        -- ignore element, add 1
myMap2   :: (a -> b) -> [a] -> [b]
myMap2 f = foldr (\x acc -> f x : acc) []      -- even map is a fold!
anyEven  :: [Int] -> Bool
anyEven  = foldr (\x acc -> even x || acc) False

-- foldl ("fold from the LEFT") nests the other way:
--   foldl f z [1,2,3] = f (f (f z 1) 2) 3
-- For associative ops like (+) the result is the same. The difference
-- matters for non-associative ops and for performance/laziness — a topic
-- for later. RULE OF THUMB FOR NOW: reach for foldr first.

-- Try:  foldr (+) 0 [1..100]          == 5050
--       foldr (:) [] [1,2,3]          == [1,2,3]   (rebuilds the list!)
--       foldr (\x acc -> x : acc) [] [1,2,3]       (same thing, spelled out)


-- ---------------------------------------------------------------------
-- 3.7  COMPOSITION (.) and APPLICATION ($)
-- ---------------------------------------------------------------------
-- (.) glues two functions into one: (f . g) x  ==  f (g x).
--   (.) :: (b -> c) -> (a -> b) -> a -> c
-- Read f . g as "f after g".
sumOfSquaresOfEvens :: [Int] -> Int
sumOfSquaresOfEvens = sum . map (^2) . filter even
--   reads right-to-left: keep evens, square them, then sum.
--   Try: sumOfSquaresOfEvens [1..10] == 220

-- ($) is function application with the lowest precedence. Its job is to
-- kill parentheses:  f (g (h x))  ==  f $ g $ h x
--   print (sum (map (*2) [1,2,3]))   ==   print $ sum $ map (*2) [1,2,3]


-- ---------------------------------------------------------------------
-- 3.8  A FEW MORE HIGHER-ORDER BUILT-INS TO KNOW
-- ---------------------------------------------------------------------
--   zipWith f xs ys   -- like zip, but combines pairs with f
--                        zipWith (+) [1,2,3] [10,20,30] == [11,22,33]
--                        (this is your Lesson 2 zipSum!)
--   takeWhile p xs    -- longest prefix where p holds
--                        takeWhile (< 3) [1,2,3,1] == [1,2]
--   dropWhile p xs    -- drop that prefix
--   all p xs / any p xs  -- do all / any elements satisfy p?
--   concatMap f xs    -- map then concat:  concatMap (\x -> [x,x]) [1,2] == [1,1,2,2]


-- ---------------------------------------------------------------------
-- TRY THESE IN GHCI ONCE LOADED:
-- ---------------------------------------------------------------------
--   ghci> applyTwice (*2) 3
--   ghci> map (\x -> x*10) [1,2,3]
--   ghci> filter odd [1..10]
--   ghci> foldr (+) 0 [1..10]
--   ghci> foldr (:) [] [1,2,3]
--   ghci> zipWith (*) [1,2,3] [4,5,6]
--   ghci> (sum . map (*2) . filter even) [1..10]
--   ghci> :t map
--   ghci> :t foldr
