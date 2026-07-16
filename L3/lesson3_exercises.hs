import Data.IntMap (size)
-- =====================================================================
-- LESSON 3 — EXERCISES
-- =====================================================================
-- Goal: get fluent with map, filter, fold, sections, lambdas, and (.).
-- Write a type signature for EVERY function.
--
-- Where an exercise says "point-free", try to write it WITHOUT naming the
-- list argument (e.g.  f = map (+1)  instead of  f xs = map (+1) xs).
-- If point-free won't come, write the normal version first, then simplify.
--
-- DO NOT hand-write [] / (x:xs) recursion in section A/B/C — the whole
-- point is to use the higher-order functions. Section D is where you may
-- reimplement things by hand.
-- =====================================================================


-- ---- A. map & sections ----------------------------------------------

-- A1. Triple every element.  tripleAll [1,2,3] == [3,6,9]
-- tripleAll :: [Int] -> [Int]
tripleAll :: [Int] -> [Int]
tripleAll = map (*3)


-- A2. Turn a list of Ints into their String forms. (Hint: `show`.)
--     showAll [1,2,3] == ["1","2","3"]
-- showAll :: [Int] -> [String]
showAll :: [Int] -> [String]
showAll = map (show)


-- A3. Given a list of words, return their lengths.
--     wordLengths ["hi","bye","yo"] == [2,3,2]
-- wordLengths :: [String] -> [Int]
wordLengths :: [String] -> [Int]
wordLengths = map (length)


-- A4. Negate every number.  negateAll [1,-2,3] == [-1,2,-3]
--     Use a section or the built-in `negate`.
-- negateAll :: [Int] -> [Int]
negateAll :: [Int] -> [Int]
negateAll = map (negate)


-- ---- B. filter & predicates -----------------------------------------

-- B1. Keep only the positive numbers.  positives [-1,2,-3,4] == [2,4]
-- positives :: [Int] -> [Int]
positives :: [Int] -> [Int]
positives = filter (>0)


-- B2. Keep only strings longer than n characters.
--     longerThan 2 ["a","abc","hi","hello"] == ["abc","hello"]
longerThan :: Int -> [String] -> [String]
longerThan x = filter ((> x) . length)



-- B3. Remove all spaces from a string. (A String is [Char]; filter it.)
--     removeSpaces "a b c" == "abc"
-- removeSpaces :: String -> String
removeSpaces :: String -> String
removeSpaces = filter (/= ' ')


-- B4. Keep numbers divisible by BOTH 3 and 5.
--     divBy15 [1..30] == [15,30]
--     Hint: a lambda combining two conditions with &&.
divBy15 :: [Int] -> [Int]
divBy15 = filter (\x -> x `mod` 3 == 0 && x `mod` 5 == 0)


-- ---- C. fold --------------------------------------------------------
-- Use foldr (or foldl) for these — no explicit recursion.

-- C1. Sum a list of Doubles with a fold.  (Your Lesson 2 sumDoubles, redone.)
-- sumD :: [Double] -> Double
sumD :: [Double] -> Double
sumD = foldr (+) 0

-- C2. Find the maximum of a NON-empty list using foldr1.
--     (foldr1 is like foldr but uses the last element as the seed, so no
--      initial value needed. Look it up: :t foldr1 and :t max)
--     maxViaFold [3,9,2,9,1] == 9
-- maxViaFold :: [Int] -> Int
maxViaFold :: [Int] -> Int
maxViaFold = foldl1 max


-- C3. Count how many elements satisfy a predicate, using a fold.
--     countIf even [1..10] == 5
--     Note the type: it takes the predicate as an argument (higher-order!).
-- countIf :: (a -> Bool) -> [a] -> Int
countIf :: (a -> Bool) -> [a] -> Int
countIf cond = foldl (\acc x -> if (cond x) then acc+1 else acc) 0

-- C4. Concatenate a list of strings into one, using a fold.
--     concatAll ["ab","cd","ef"] == "abcdef"
--     (Yes, `concat` exists — but build it with foldr (++) here.)
-- concatAll :: [String] -> String
concatAll :: [String] -> String
concatAll = foldr (++) ""


-- ---- D. Composition & combining the tools ---------------------------

-- D1. sumOfSquares: square every element, then sum. Use (.) to compose
--     map and sum. Try to write it point-free.
--     sumOfSquares [1,2,3] == 14
-- sumOfSquares :: [Int] -> Int
sumOfSquares :: [Int] -> Int
sumOfSquares = sum . map (\x -> x * x)


-- D2. countVowels: how many vowels (a,e,i,o,u) are in a string?
--     countVowels "hello world" == 3
--     Hint: filter to the vowels, then length. Compose them.
-- countVowels :: String -> Int
countVowels :: String -> Int
countVowels = length . filter (`elem` "aeiouAEIOU")


-- D3. zipSum revisited: reimplement Lesson 2's zipSum using zipWith
--     instead of hand recursion. One line.
--     zipSum [1,2,3] [10,20,30,40] == [11,22,33]
zipSum :: [Int] -> [Int] -> [Int]
zipSum = zipWith (+)



-- D4. average of a list of Doubles: sum / length. Careful — length gives
--     an Int, and you can't divide a Double by an Int directly. Look up
--     `fromIntegral` (:t fromIntegral) to convert.
--     average [1,2,3,4] == 2.5
-- average :: [Double] -> Double


-- ---- E. Stretch -----------------------------------------------------

-- E1. myReverse using a fold.  Think about which fold and which combiner.
--     myReverse [1,2,3] == [3,2,1]
--     Hint: foldl (\acc x -> x : acc) [] ... trace it to see why left, not right.
-- myReverse :: [a] -> [a]


-- E2. Reimplement `filter` yourself using foldr (don't use the built-in filter).
--     myFilter even [1..6] == [2,4,6]
-- myFilter :: (a -> Bool) -> [a] -> [a]


-- E3. CHALLENGE — encode a list into run-length pairs using the tools you know.
--     rle [1,1,2,3,3,3] == [(2,1),(1,2),(3,3)]   -- (count, value)
--     You built `runs` in Lesson 2 (list of runs). Combine it with map:
--     map each run to (length run, head run). Reuse or re-derive `runs`.
-- rle :: [Int] -> [(Int, Int)]
