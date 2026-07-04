-- =====================================================================
-- LESSON 2 — EXERCISES
-- =====================================================================
-- Write a type signature for EVERY function.
-- Build each one with the recursion recipe from section 2.3:
--     f []     = <answer for empty>
--     f (x:xs) = <combine x with (f xs)>
-- Use built-ins (length, reverse, ++, etc.) only where an exercise says so.
-- When done, send the file back for review.
-- =====================================================================


-- ---- A. Consuming lists (produce a single value) --------------------

-- A1. countDown is not needed here; warm up instead:
-- Count how many elements are in a list. (Reimplement length by hand.)
myLength :: [a] -> Int
myLength [] = 0
myLength (x:xs) = 1 + myLength xs


-- A2. Sum of a list of Doubles.
sumDoubles :: [Double] -> Int
sumDoubles [] = 0
sumDoubles (x:xs) = 1 + sumDoubles xs


-- A3. Does the list contain a given Char? (Reimplement elem for Char by hand.)
containsChar :: Char -> [Char] -> Bool
containsChar c [] = False
containsChar c (x:xs)
    | c == x    = True
    | otherwise = containsChar c xs


-- A4. Count how many elements satisfy "is even".
--     countEvens [1,2,3,4,5,6] == 3
countEvens :: [Int] -> Int
countEvens [] = 0
countEvens (x:xs)
    | even x    = 1 + countEvens xs
    | otherwise = countEvens xs


-- A5. Find the minimum of a non-empty list of Ints (reimplement, don't use minimum).
--     Use the `min` built-in for the pairwise comparison.
--     You may leave the [] case out (it will crash) — we handle safety later.
minList :: [Int] -> Int
minList [x]    = x                                  -- one element: it's the min
minList (x:xs) = min x (minList xs)



-- ---- B. Building lists (produce a new list) -------------------------

-- B1. Increment every element by 1.
--     addOne [1,2,3] == [2,3,4]
addOne :: [Int] -> [Int]
addOne [] = []
addOne (x:xs) = (x + 1) : addOne xs



-- B2. Keep only the elements greater than a threshold.
--     keepAbove 3 [1,5,2,8,3,9] == [5,8,9]
keepAbove :: Int -> [Int] -> [Int]
keepAbove n [] = []
keepAbove n (x:xs) 
    | n < x     = x : keepAbove n xs 
    | otherwise = keepAbove n xs



-- B3. Reverse a list (reimplement; you may use ++).
--     myReverse [1,2,3] == [3,2,1]
--     Hint: reverse of (x:xs) is (reverse xs) ++ [x].
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]


-- B4. Given a list of Ints, return a list of their squares.
--     squares [1,2,3,4] == [1,4,9,16]
squares :: [Int] -> [Int]
squares [] = []
squares (x:xs) = (x * x) : squares (xs)



-- ---- C. Tuples ------------------------------------------------------

-- C1. Swap the two components of a pair.
--     swap (1, 'a') == ('a', 1)
--     (Note the type: it works for any two types. Use type variables a and b.)
swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)



-- C2. Given a list of (name, age) pairs, sum all the ages.
--     totalAge [("Ann",30),("Bo",25)] == 55
totalAge :: [(String, Int)] -> Int
totalAge [] = 0
totalAge (x:xs) = snd x + totalAge xs



-- ---- D. Stretch (these make you think) ------------------------------

-- D1. "Run length" style: count consecutive copies of the FIRST element
--     at the front of the list.
--     leadingCount [5,5,5,1,2,5] == 3   (three 5s, then it stops)
--     leadingCount []            == 0
--     leadingCount [9]           == 1
--     Hint: you need to look at the first TWO elements, so pattern-match
--     (x : y : rest) as one case, and handle [x] and [] separately.
leadingCount :: [Int] -> Int
leadingCount [] = 0
leadingCount [x] = 1
leadingCount (x:y:rest)
    | x == y    = 1 + leadingCount (y : rest)
    | otherwise = 1


-- D2. zipSum: given two lists, add them element-wise. Stop when EITHER
--     list runs out (mirror how the built-in zip behaves).
--     zipSum [1,2,3] [10,20,30,40] == [11,22,33]
--     zipSum [] [1,2]              == []
--     Hint: three equations — one for each empty case, one for both non-empty.
zipSum :: [Int] -> [Int] -> [Int]
zipSum l1 [] = []
zipSum [] l2 = []
zipSum (x:xs) (y:ys) = (x + y) : zipSum xs ys


-- D3. CHALLENGE — runs: split a list into runs of equal consecutive elements.
--     runs [1,1,2,3,3,3] == [[1,1],[2],[3,3,3]]
--     runs []            == []
--     This one is genuinely tricky. Attempt it; partial credit for trying.
--     Hint: a helper that accumulates the current run may help — or use
--     a built-in like `span` (look it up with :t span) if you want a shortcut.

-- helper function to get repeating ints from the start
repeated :: [Int] -> [Int]
repeated [] = []
repeated [x] = [x]
repeated (x:y:rest)
    | x == y    = x : repeated (y:rest)
    | otherwise = [x]

runs :: [Int] -> [[Int]]
runs [] = []
runs xs = let run  = repeated xs
              rest = drop (length run) xs
          in run : runs rest

