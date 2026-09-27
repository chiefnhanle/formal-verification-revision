-- =====================================================================
-- 03 · Functions
-- =====================================================================

-- ---- Defining and calling ------------------------------------------
-- Signature:  name :: InputType -> OutputType
-- Definition: name arg = body
square :: Int -> Int
square x = x * x

-- Calling uses a SPACE, not parentheses/commas:
--   square 5        -- not square(5)
--   square (2 + 3)  -- parens only to group the argument

-- ---- Multiple arguments ---------------------------------------------
-- Read `Int -> Int -> Int` as: takes an Int, then an Int, returns Int.
add :: Int -> Int -> Int
add x y = x + y

-- Function application binds TIGHTER than any operator:
--   square 3 + 1   ==  (square 3) + 1  ==  10
--   square (3 + 1) ==  16

-- ---- Currying & partial application ---------------------------------
-- `->` associates to the right:
--   Int -> Int -> Int   ==   Int -> (Int -> Int)
-- So `add` really takes ONE Int and returns a FUNCTION waiting for
-- the second. Supplying fewer args gives you a new function:
increment :: Int -> Int
increment = add 1

-- ---- Operators are just functions -----------------------------------
-- Wrap an operator in parens to use it prefix:
seven :: Int
seven = (+) 3 4

-- Wrap a function in backticks to use it infix:
alsoSeven :: Int
alsoSeven = 3 `add` 4

-- Define your own operator:
(|>) :: a -> (a -> b) -> b
x |> f = f x

-- ---- Sections: partially applied operators --------------------------
double :: Int -> Int
double = (* 2)        -- \x -> x * 2

halve :: Double -> Double
halve = (/ 2)         -- \x -> x / 2

reciprocal :: Double -> Double
reciprocal = (1 /)    -- \x -> 1 / x

-- ---- Lambdas (anonymous functions) ----------------------------------
-- \args -> body      (the \ is meant to look like λ)
cube :: Int -> Int
cube = \x -> x * x * x

addL :: Int -> Int -> Int
addL = \x y -> x + y

-- ---- Polymorphic functions ------------------------------------------
-- Lowercase names in types are TYPE VARIABLES: "any type".
identity :: a -> a
identity x = x

constant :: a -> b -> a
constant x _ = x      -- `_` = "I ignore this argument"

-- Functions can take functions as arguments:
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

main :: IO ()
main = do
  print (square 5)
  print (square 3 + 1, square (3 + 1))
  print (add 2 3)
  print (increment 41)
  print (seven, alsoSeven)
  print (5 |> square |> increment)   -- 26
  print (double 21, halve 9, reciprocal 4)
  print (cube 3, addL 10 20)
  print (identity "same", constant 'k' True)
  print (applyTwice double 5)        -- 20
  print (applyTwice (++ "!") "hey")  -- "hey!!"

-- ---------------------------------------------------------------------
-- In GHCi:  :t add     :t add 1     :t applyTwice    :t (+)
-- ---------------------------------------------------------------------

-- EXERCISE 1: Write `hypotenuse` using sqrt.
hypotenuse :: Double -> Double -> Double
hypotenuse a b = undefined

-- EXERCISE 2: Using partial application only (no new argument names),
--             define a function that adds 100.
add100 :: Int -> Int
add100 = undefined

-- EXERCISE 3: What's the type of `applyTwice applyTwice`? Guess,
--             then check with :t in GHCi.
