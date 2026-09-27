-- =====================================================================
-- 02 · Values and types
-- =====================================================================
--
-- Everything in Haskell has a type. `x :: T` means "x has type T".
-- Names (bindings) are IMMUTABLE: once defined, they never change.
-- `=` means "is defined as", not "assign".

-- ---- Basic types ----------------------------------------------------

anInt :: Int              -- fixed-size integer (64-bit)
anInt = 42

anInteger :: Integer      -- arbitrary precision, never overflows
anInteger = 2 ^ 100

aDouble :: Double         -- floating point
aDouble = 3.14159

aBool :: Bool             -- True or False (capitalised!)
aBool = True

aChar :: Char             -- single character, single quotes
aChar = 'x'

aString :: String         -- double quotes; String = [Char] (a list!)
aString = "hello"

unit :: ()                -- the "unit" type has exactly one value: ()
unit = ()

-- ---- Type inference -------------------------------------------------
-- Signatures are optional; GHC infers types. But writing them for
-- top-level definitions is good style and great documentation.
inferred = anInt + 1      -- GHC infers: inferred :: Int

-- ---- Operators on basic types ---------------------------------------
arith :: [Int]
arith =
  [ 7 + 2       -- 9
  , 7 - 2       -- 5
  , 7 * 2       -- 14
  , 7 `div` 2   -- 3   integer division (note the backticks)
  , 7 `mod` 2   -- 1
  , 2 ^ 10      -- 1024
  ]

fractional :: Double
fractional = 7 / 2          -- 3.5   (/) is only for fractional types

logic :: [Bool]
logic =
  [ True && False   -- and
  , True || False   -- or
  , not True        -- not
  , 3 == 3          -- equal
  , 3 /= 4          -- NOT equal (not != like other languages!)
  , 3 < 4, 3 <= 3
  ]

-- ---- No automatic conversion ----------------------------------------
-- Haskell never silently converts between number types.
-- anInt + aDouble   -- TYPE ERROR
converted :: Double
converted = fromIntegral anInt + aDouble   -- convert explicitly

rounded :: Int
rounded = round aDouble                    -- also: floor, ceiling, truncate

main :: IO ()
main = do
  print anInt
  print anInteger
  print aDouble
  print (aBool, aChar, aString)
  print inferred
  print arith
  print fractional
  print logic
  print converted
  print rounded
  -- `show` turns a value into a String; `++` concatenates strings.
  putStrLn ("anInt is " ++ show anInt)

-- ---------------------------------------------------------------------
-- In GHCi, try:  :t 'a'    :t "a"    :t True    :t 3    :t 3.0
-- Notice `:t 3` gives `Num a => a` — a number literal can become
-- ANY numeric type. (That `=>` is covered properly in lesson 09.)
-- ---------------------------------------------------------------------

-- EXERCISE 1: Define `secondsInADay :: Int` using arithmetic.
secondsInADay :: Int
secondsInADay = undefined

-- EXERCISE 2: Define `average :: Double` as the average of
--             anInt and 10, converting where needed.
average :: Double
average = undefined
