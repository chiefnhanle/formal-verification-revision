-- =====================================================================
-- 08 · Higher-order functions, composition, and $
-- =====================================================================
-- A HIGHER-ORDER function takes or returns a function. Most of the
-- recursion from lesson 07 has already been packaged up as these.

import Data.Char (toUpper, isDigit)
import Data.List (sortBy, sortOn)
import Data.Ord (comparing, Down (..))

-- ---- map, filter ----------------------------------------------------
--   map    :: (a -> b)    -> [a] -> [b]      transform every element
--   filter :: (a -> Bool) -> [a] -> [a]      keep elements that pass
shout :: String -> String
shout = map toUpper

digitsOnly :: String -> String
digitsOnly = filter isDigit

-- ---- Folds: collapse a list into one value --------------------------
--   foldr :: (a -> b -> b) -> b -> [a] -> b
-- foldr f z [x1, x2, x3]  =  x1 `f` (x2 `f` (x3 `f` z))
-- i.e. replace every (:) with f and [] with z.
sumF :: [Int] -> Int
sumF = foldr (+) 0

lengthF :: [a] -> Int
lengthF = foldr (\_ n -> n + 1) 0

mapF :: (a -> b) -> [a] -> [b]
mapF f = foldr (\x acc -> f x : acc) []

-- foldl goes left-to-right with an accumulator (like sumAcc in 07).
-- In practice use foldl' from Data.List for strict, efficient folds.
reverseF :: [a] -> [a]
reverseF = foldl (\acc x -> x : acc) []

-- ---- Other useful ones ----------------------------------------------
others :: IO ()
others = do
  print (zipWith (+) [1, 2, 3] [10, 20, 30 :: Int])
  print (takeWhile (< 10) [1, 3 ..] :: [Int])
  print (dropWhile (== ' ') "   trimmed")
  print (any even [1, 3, 5 :: Int], all odd [1, 3, 5 :: Int])
  print (iterate (* 2) 1 !! 10 :: Int)
  print (sortOn negate [3, 1, 2 :: Int])
  print (sortBy (comparing snd) [('a', 3), ('b', 1), ('c', 2 :: Int)])
  print (sortOn Down "haskell")

-- ---- Function composition (.) ---------------------------------------
--   (.) :: (b -> c) -> (a -> b) -> a -> c
--   (f . g) x = f (g x)            -- read right to left: g, then f
countEvens :: [Int] -> Int
countEvens = length . filter even

-- "Point-free" style: define functions by composing, without naming
-- the argument. Compare:
sumOfSquaresA :: [Int] -> Int
sumOfSquaresA xs = sum (map (^ 2) xs)

sumOfSquaresB :: [Int] -> Int
sumOfSquaresB = sum . map (^ 2)

-- ---- The $ operator -------------------------------------------------
--   f $ x = f x   but with the LOWEST precedence.
-- Its only job: save parentheses. "Everything to the right is one arg."
withParens, withDollar :: Int
withParens = sum (filter even (map (* 3) [1 .. 10]))
withDollar = sum $ filter even $ map (* 3) [1 .. 10]

-- Often combined: compose a pipeline, then $ the input in.
pipeline :: Int
pipeline = sum . filter even . map (* 3) $ [1 .. 10]

main :: IO ()
main = do
  putStrLn (shout "quiet please")
  putStrLn (digitsOnly "phone: 555-1234")
  print (sumF [1 .. 10], lengthF "abc", mapF (+ 1) [1, 2, 3 :: Int])
  print (reverseF [1, 2, 3 :: Int])
  others
  print (countEvens [1 .. 10])
  print (sumOfSquaresA [1, 2, 3], sumOfSquaresB [1, 2, 3])
  print (withParens, withDollar, pipeline)

-- EXERCISE 1: Using foldr, write `myAnd :: [Bool] -> Bool`.
myAnd :: [Bool] -> Bool
myAnd = undefined

-- EXERCISE 2: Point-free: count the words in a string longer than 3.
longWords :: String -> Int
longWords = undefined

-- EXERCISE 3: Implement `myFilter` using foldr.
myFilterF :: (a -> Bool) -> [a] -> [a]
myFilterF p = undefined
