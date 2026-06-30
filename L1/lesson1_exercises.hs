-- warm up
-- 1.
cube :: Int -> Int
cube x = x * x * x

-- 2.
average3 :: Double -> Double -> Double -> Double
average3 x y z = (x + y + z) / 3

-- 3.
isEven :: Int -> Bool
isEven b
  | mod b 2 == 0  = True
  | otherwise     = False

-- 4.
maxOf2 :: Int -> Int -> Int
maxOf2 x y = if x >= y then x else y

-- 5.
maxOf3 :: Int -> Int -> Int -> Int
maxOf3 x y z = maxOf2 x (maxOf2 y z)

-- 6.
grade :: Int -> Char
grade x
  | x >= 90     = 'A'
  | x >= 80     = 'B'
  | x >= 70     = 'C'
  | x >= 60     = 'D'
  | otherwise   = 'F'

-- 7. 
bmi :: Double -> Double -> String
bmi weight height
  | bmiValue < 18.5 = "underweight"
  | bmiValue < 25.0 = "normal"
  | bmiValue < 30.0 = "overweight"
  | otherwise       = "Obese"
  where bmiValue = weight / (height * height)


-- 8.
-- why Integer not Int matters here? My answer - probably higher storage limits
daysToSeconds :: Integer -> Integer
daysToSeconds d = d * 3600 * 24


-- 9.
factorial :: Integer -> Integer
factorial x
  | x == 0      = 1
  | otherwise   = x * factorial (x-1)


-- 10.
power :: Integer -> Integer -> Integer
power base 0 = 1
power base exp 
    | exp > 0   = base * power base (exp - 1)
    | otherwise = error "Negative exponents not supported for Integer"


-- extra exercise 1 (post lesson 1)
sumTo :: Integer -> Integer
sumTo 1 = 1
sumTo x
    | x > 1     = x + sumTo (x-1)
    | otherwise = error "negative numbers not supported"

-- extra exercise 2 (post lesson 1)
collatzSteps :: Int -> Int
collatzSteps 1 = 0
collatzSteps x
    | isEven x  = 1 + collatzSteps (x `div` 2)
    | otherwise = 1 + collatzSteps (3*x +1)



