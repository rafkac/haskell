-- =====================================================================
-- LESSON 2 — Lists, Pattern Matching, and Recursion over Structures
-- =====================================================================
--
-- Load this file with:   ghci> :l L2/lesson2.hs
-- Then try the examples noted in comments.
--
-- This file is for READING and EXPERIMENTING. Do the actual work in
-- lesson2_exercises.hs.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 2.1  WHAT A LIST IS
-- ---------------------------------------------------------------------
-- A list is either:
--    []          -- the empty list ("nil")
--    x : xs      -- an element x stuck onto the front of a list xs ("cons")
--
-- That's the WHOLE definition. Everything else is built from these two.
-- [1,2,3] is just nice syntax for  1 : 2 : 3 : []
--
-- All elements must have the SAME type.
--    [Int]    is a list of Ints
--    [Char]   is a list of Chars  (and String = [Char])
--    [[Int]]  is a list of lists of Ints
--
-- Try in ghci:
--    ghci> 1 : 2 : 3 : []
--    ghci> 'h' : "ello"          -- a String IS a list of Char
--    ghci> [1,2,3] == 1:2:3:[]   -- True

exampleList :: [Int]
exampleList = 1 : 2 : 3 : []          -- identical to [1,2,3]


-- ---------------------------------------------------------------------
-- 2.2  PATTERN MATCHING ON LISTS  (the big idea)
-- ---------------------------------------------------------------------
-- Because a list is ALWAYS either [] or (x:xs), you write functions by
-- giving one equation per shape. The compiler picks the matching one,
-- top to bottom.
--
--   []        matches the empty list
--   (x:xs)    matches a non-empty list; binds  x = head,  xs = rest
--
-- This is the list version of factorial's "base case + recursive case".

-- Our own length. Note: built-in is `length`; we reimplement to learn.
len :: [a] -> Int                      -- 'a' = works for ANY element type
len []     = 0                         -- empty list has length 0     (base case)
len (_:xs) = 1 + len xs                -- 1 + length of the tail    (recursive case)
-- '_' is a wildcard: "I don't care about this value, don't name it."

-- Our own sum (only makes sense for numbers).
sumList :: [Int] -> Int
sumList []     = 0                      -- identity for +  (recall Lesson 1's sumTo)
sumList (x:xs) = x + sumList xs

-- Our own product. Base case is 1 (identity for *).
productList :: [Int] -> Int
productList []     = 1
productList (x:xs) = x * productList xs


-- ---------------------------------------------------------------------
-- 2.3  THE RECURSION-OVER-LISTS RECIPE
-- ---------------------------------------------------------------------
-- Almost every list function you'll write by hand follows this template:
--
--   f []     = <answer for the empty list>
--   f (x:xs) = <combine  x  with  (f xs)>
--
-- Ask yourself two questions:
--   1. What's the answer when the list is empty?      -> base case
--   2. Given the head x and the answer for the tail,
--      how do I build the answer for the whole list?  -> recursive case
--
-- That's it. Once this clicks, you can write dozens of functions.

-- Example: does a value appear in the list?
elemList :: Int -> [Int] -> Bool
elemList _ []     = False                          -- not in an empty list
elemList y (x:xs) = x == y || elemList y xs        -- head matches, OR it's in the tail

-- Example: maximum of a list. (Note: undefined for [] — we'll discuss safety later.)
maxList :: [Int] -> Int
maxList [x]    = x                                  -- one element: it's the max
maxList (x:xs) = max x (maxList xs)                 -- bigger of head vs max-of-tail
-- NOTE there's no [] equation here. maxList [] would CRASH. We'll fix this
-- kind of partial function in a later lesson with Maybe.


-- ---------------------------------------------------------------------
-- 2.4  BUILDING lists, not just consuming them
-- ---------------------------------------------------------------------
-- The recursive case can CONS a new element onto the recursive result.

-- Double every element.
doubleAll :: [Int] -> [Int]
doubleAll []     = []                               -- nothing to double
doubleAll (x:xs) = (2 * x) : doubleAll xs           -- new head : doubled tail

-- Keep only the even numbers.
evens :: [Int] -> [Int]
evens []     = []
evens (x:xs)
  | even x    = x : evens xs                         -- keep x
  | otherwise = evens xs                             -- drop x (don't cons it)

-- Append two lists (this is the built-in (++), reimplemented).
append :: [a] -> [a] -> [a]
append []     ys = ys                               -- nothing to prepend
append (x:xs) ys = x : append xs ys                 -- x in front of (rest ++ ys)


-- ---------------------------------------------------------------------
-- 2.5  HANDY BUILT-INS (so you don't reinvent everything)
-- ---------------------------------------------------------------------
-- These all exist in the standard library. Know them; use them after the
-- exercises (the exercises ask you to build some by hand first).
--
--   head [1,2,3]   == 1          first element  (crashes on [])
--   tail [1,2,3]   == [2,3]      everything but the first
--   null []        == True       is it empty?
--   length         list length
--   reverse [1,2,3]== [3,2,1]
--   (++)           append
--   elem 2 [1,2,3] == True       membership
--   take 2 [1,2,3] == [1,2]      first n
--   drop 2 [1,2,3] == [3]        all but first n
--   zip [1,2] "ab" == [(1,'a'),(2,'b')]   pair up two lists
--   [1..10]        == [1,2,..,10]         range syntax
--   [2,4..10]      == [2,4,6,8,10]        range with step


-- ---------------------------------------------------------------------
-- 2.6  TUPLES (a quick companion to lists)
-- ---------------------------------------------------------------------
-- A tuple groups a FIXED number of values of possibly DIFFERENT types.
--    (1, 'a')        :: (Int, Char)
--    (1, "hi", True) :: (Int, String, Bool)
-- Contrast with lists: lists are any length, one type; tuples are fixed
-- length, mixed types.

-- fst and snd get the parts of a PAIR:
--    fst (1,'a') == 1
--    snd (1,'a') == 'a'

-- You can pattern-match tuples too:
addPair :: (Int, Int) -> Int
addPair (a, b) = a + b

-- Combine tuples + lists: sum a list of pairs by their first components.
sumFirsts :: [(Int, Int)] -> Int
sumFirsts []          = 0
sumFirsts ((a,_):rest) = a + sumFirsts rest


-- ---------------------------------------------------------------------
-- TRY THESE IN GHCI ONCE LOADED:
-- ---------------------------------------------------------------------
--   ghci> len [10,20,30]
--   ghci> sumList [1..100]
--   ghci> doubleAll [1,2,3]
--   ghci> evens [1..10]
--   ghci> elemList 7 [1..10]
--   ghci> maxList [3,9,2,9,1]
--   ghci> append [1,2] [3,4]
--   ghci> addPair (3,4)
--   ghci> sumFirsts [(1,100),(2,200),(3,300)]
