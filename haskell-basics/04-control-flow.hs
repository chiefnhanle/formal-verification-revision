-- =====================================================================
-- 04 · Control flow: if, guards, case, where, let
-- =====================================================================
-- Haskell has no statements, only EXPRESSIONS. Every branch must
-- produce a value, and all branches must have the same type.

-- ---- if / then / else -----------------------------------------------
-- `else` is mandatory (the expression must always have a value).
absolute :: Int -> Int
absolute n = if n < 0 then negate n else n

-- ---- Guards ---------------------------------------------------------
-- Cleaner than nested ifs. Checked top to bottom; first True wins.
-- `otherwise` is literally just `True`.
classify :: Int -> String
classify n
  | n < 0     = "negative"
  | n == 0    = "zero"
  | n < 10    = "small"
  | otherwise = "large"

-- ---- where: local definitions after the body ------------------------
bmiTell :: Double -> Double -> String
bmiTell weight height
  | bmi < 18.5 = "underweight"
  | bmi < 25.0 = "normal"
  | otherwise  = "overweight"
  where
    bmi = weight / height ^ 2   -- visible in ALL guards above

-- ---- let ... in: local definitions before an expression -------------
cylinderArea :: Double -> Double -> Double
cylinderArea r h =
  let side = 2 * pi * r * h
      top  = pi * r ^ 2
  in  side + 2 * top

-- `where` vs `let`: same idea. `where` scopes over guards and reads
-- "result first, details after"; `let` is an expression usable anywhere.

-- ---- case ... of ----------------------------------------------------
-- Pattern-match on a value (much more in lesson 06).
describeNumber :: Int -> String
describeNumber n = case n of
  0 -> "zero"
  1 -> "one"
  2 -> "two"
  _ -> "many"          -- `_` matches anything (catch-all)

-- ---- Multiple equations (pattern matching on arguments) -------------
-- Equivalent to the case above, written as separate equations:
describeNumber' :: Int -> String
describeNumber' 0 = "zero"
describeNumber' 1 = "one"
describeNumber' 2 = "two"
describeNumber' _ = "many"

-- ---- Layout (indentation) matters -----------------------------------
-- Lines in the same block (guards, where-bindings, case arms, do lines)
-- must line up in the same column. Deeper indentation = continuation.

main :: IO ()
main = do
  print (absolute (-7))       -- note: negative literals need parens
  mapM_ (putStrLn . classify) [-5, 0, 7, 100]
  putStrLn (bmiTell 70 1.75)
  print (cylinderArea 1 2)
  print (map describeNumber [0, 1, 2, 3])
  print (map describeNumber' [0, 1, 2, 3])

-- EXERCISE 1: Write `fizzbuzz` with guards: "FizzBuzz" if divisible by
--             15, "Fizz" by 3, "Buzz" by 5, otherwise `show n`.
fizzbuzz :: Int -> String
fizzbuzz n = undefined

-- EXERCISE 2: Write `maxOf3` using if/then/else OR guards.
maxOf3 :: Int -> Int -> Int -> Int
maxOf3 a b c = undefined
