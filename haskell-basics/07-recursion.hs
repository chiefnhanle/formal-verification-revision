-- =====================================================================
-- 07 · Recursion
-- =====================================================================
-- There are no loops (for/while) in Haskell. Repetition = recursion.
-- Recipe:
--   1. BASE CASE:      the simplest input, answered directly.
--   2. RECURSIVE CASE: shrink the problem, assume the smaller answer,
--                      build the bigger answer from it.

-- ---- On numbers -----------------------------------------------------
factorial :: Integer -> Integer
factorial 0 = 1                          -- base case
factorial n = n * factorial (n - 1)      -- recursive case

fib :: Int -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)        -- slow (exponential), but clear

-- ---- On lists: the (x : xs) pattern ---------------------------------
-- Base case []; recursive case processes head x and recurses on xs.
mySum :: [Int] -> Int
mySum []       = 0
mySum (x : xs) = x + mySum xs

myLength :: [a] -> Int
myLength []       = 0
myLength (_ : xs) = 1 + myLength xs

myReverse :: [a] -> [a]
myReverse []       = []
myReverse (x : xs) = myReverse xs ++ [x]

myMap :: (a -> b) -> [a] -> [b]
myMap _ []       = []
myMap f (x : xs) = f x : myMap f xs

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter p (x : xs)
  | p x       = x : myFilter p xs
  | otherwise = myFilter p xs

-- Two lists at once:
myZip :: [a] -> [b] -> [(a, b)]
myZip (x : xs) (y : ys) = (x, y) : myZip xs ys
myZip _        _        = []            -- either list ran out

-- ---- Accumulators ---------------------------------------------------
-- Carry a running result in an extra argument, often with a helper `go`.
-- This is "tail recursive": the recursive call is the last thing done.
sumAcc :: [Int] -> Int
sumAcc = go 0
  where
    go acc []       = acc
    go acc (x : xs) = go (acc + x) xs

fastFib :: Int -> Integer
fastFib n = go n 0 1
  where
    go 0 a _ = a
    go k a b = go (k - 1) b (a + b)

-- ---- A classic: quicksort -------------------------------------------
quicksort :: Ord a => [a] -> [a]
quicksort []       = []
quicksort (p : xs) = quicksort smaller ++ [p] ++ quicksort larger
  where
    smaller = [x | x <- xs, x < p]
    larger  = [x | x <- xs, x >= p]

-- ---- Hand-evaluating (do this on paper!) ----------------------------
--   mySum [1, 2, 3]
-- = 1 + mySum [2, 3]
-- = 1 + (2 + mySum [3])
-- = 1 + (2 + (3 + mySum []))
-- = 1 + (2 + (3 + 0))
-- = 6

main :: IO ()
main = do
  print (factorial 20)
  print (map fib [0 .. 10])
  print (mySum [1, 2, 3], sumAcc [1 .. 100])
  print (myLength "hello", myReverse [1, 2, 3 :: Int])
  print (myMap (* 10) [1, 2, 3 :: Int], myFilter even [1 .. 10 :: Int])
  print (myZip [1, 2, 3 :: Int] "ab")
  print (fastFib 90)
  print (quicksort [3, 1, 4, 1, 5, 9, 2, 6 :: Int])

-- EXERCISE 1: `myElem x xs` is True if x is in xs. Needs Eq (lesson 09).
myElem :: Eq a => a -> [a] -> Bool
myElem x xs = undefined

-- EXERCISE 2: `myReplicate 3 'a' == "aaa"`
myReplicate :: Int -> a -> [a]
myReplicate n x = undefined

-- EXERCISE 3: `myTake`, same behaviour as the Prelude's `take`.
myTake :: Int -> [a] -> [a]
myTake n xs = undefined

-- EXERCISE 4: Hand-evaluate `myReverse [1, 2, 3]` step by step.
