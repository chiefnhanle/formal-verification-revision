-- =====================================================================
-- 01 · Hello, and how to run Haskell
-- =====================================================================
--
-- Run:   runghc 01-hello-and-running.hs
-- Play:  ghci 01-hello-and-running.hs     (then type:  main)
--
-- This is a single-line comment.
{- This is a
   multi-line comment. -}

-- Every runnable Haskell program has a `main`.
-- `main :: IO ()` is its TYPE SIGNATURE, read as:
--   "main has type IO ()"
--   IO  = it performs input/output (side effects)
--   ()  = "unit", it returns nothing interesting (like `void`)
main :: IO ()
main = do
  -- `do` lets you run several IO actions one after another.
  putStrLn "Hello, Haskell!"        -- print a String + newline
  putStr   "No newline here... "    -- print without newline
  putStrLn "see?"
  print 42                          -- print any showable value
  print (2 + 3 * 4)                 -- parentheses group, as in maths
  print "a string with print"       -- print shows the quotes

-- ---------------------------------------------------------------------
-- Things to try in GHCi (ghci 01-hello-and-running.hs):
--
--   ghci> 2 + 2
--   ghci> :t putStrLn          -- putStrLn :: String -> IO ()
--   ghci> :t print             -- print :: Show a => a -> IO ()
--   ghci> main
--
-- Note: `print` vs `putStrLn`
--   putStrLn only takes a String and prints it raw.
--   print takes anything showable and prints its `show` form.
-- ---------------------------------------------------------------------

-- EXERCISE 1: Change `main` to also print your name and the result
--             of 17 * 23.
