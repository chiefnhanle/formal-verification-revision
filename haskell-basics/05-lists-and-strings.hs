-- =====================================================================
-- 05 · Lists and strings
-- =====================================================================
-- A list holds any number of values of the SAME type: [Int], [Bool] ...

nums :: [Int]
nums = [3, 1, 4, 1, 5, 9, 2, 6]

-- ---- How lists are really built -------------------------------------
-- A list is either EMPTY `[]` or an element CONS'd onto a list `x : xs`.
--   [1, 2, 3]  is sugar for  1 : (2 : (3 : []))
-- This structure is why recursion on lists (lesson 07) works so well.
built :: [Int]
built = 1 : 2 : 3 : []

-- ---- Common list functions ------------------------------------------
basics :: IO ()
basics = do
  print (head nums, tail nums)     -- first element / everything else
  print (last nums, init nums)     -- last element / everything but last
  print (length nums, null nums, null [])
  print (nums !! 2)                -- index (0-based) – avoid in real code
  print (reverse nums)
  print (take 3 nums, drop 3 nums)
  print (sum nums, product nums, maximum nums, minimum nums)
  print (elem 9 nums, 9 `elem` nums)
  print ([1, 2] ++ [3, 4])         -- concatenation
  print (0 : nums)                 -- prepend (cheap); ++ at end is O(n)
  print (zip [1, 2, 3] "abc")      -- pair up two lists
  print (concat [[1], [2, 3], []])
  print (replicate 3 'x')
  print (splitAt 2 nums)

-- ---- Ranges ---------------------------------------------------------
ranges :: IO ()
ranges = do
  print [1 .. 10]
  print [2, 4 .. 20]               -- step given by first two elements
  print [10, 9 .. 1]
  print ['a' .. 'f']
  print (take 5 [1 ..])            -- infinite list! fine because Haskell
                                   -- is LAZY: only computes what's needed

-- ---- List comprehensions --------------------------------------------
-- Like set-builder notation: { x² | x ∈ [1..10], x even }
squaresOfEvens :: [Int]
squaresOfEvens = [x * x | x <- [1 .. 10], even x]

pairs :: [(Int, Char)]
pairs = [(n, c) | n <- [1, 2], c <- "ab"]   -- nested loops

pythagorean :: [(Int, Int, Int)]
pythagorean =
  [ (a, b, c) | c <- [1 .. 20], b <- [1 .. c], a <- [1 .. b]
  , a * a + b * b == c * c ]

-- ---- Strings are lists of Char --------------------------------------
-- type String = [Char], so every list function works on strings.
strings :: IO ()
strings = do
  let s = "Hello, World"
  print (length s, reverse s, take 5 s)
  print ('H' : "ey")
  print (words "split into words", unwords ["glue", "back"])
  print (lines "line1\nline2", unlines ["a", "b"])
  print [c | c <- s, c `elem` ['A' .. 'Z']]   -- uppercase letters only
  print (show 123 ++ "!", read "456" + 1 :: Int)

main :: IO ()
main = do
  print built
  basics
  ranges
  print squaresOfEvens
  print pairs
  print pythagorean
  strings

-- EXERCISE 1: Using a comprehension, list all multiples of 3 or 5
--             below 50, and their sum.
multiples :: [Int]
multiples = undefined

-- EXERCISE 2: Remove all spaces from a string (comprehension).
noSpaces :: String -> String
noSpaces s = undefined

-- EXERCISE 3: Why does `head []` crash? What does that suggest about
--             `head`? (Hint: lesson 10 introduces `Maybe`.)
