-- =====================================================================
-- 11 · IO and do-notation
-- =====================================================================
-- Haskell functions are PURE: same input, same output, no side effects.
-- Side effects live in the IO type. A value of type `IO a` is a
-- *description* of an action that, when run, produces an `a`.
--
--   getLine  :: IO String         -- an action that yields a String
--   putStrLn :: String -> IO ()   -- a function returning an action
--
-- `main` is the one action the runtime actually executes.

import Text.Read (readMaybe)
import Control.Monad (forM_, when, unless)

-- ---- Pure core, thin IO shell ---------------------------------------
-- Good style: keep logic in pure functions, use IO only at the edges.
greeting :: String -> String
greeting n = "Nice to meet you, " ++ n ++ "!"

-- ---- do-notation ----------------------------------------------------
--   x <- action    run the action, bind its RESULT to x
--   let y = expr   an ordinary pure binding (no `in` needed inside do)
--   action         run an action, ignore its result
-- The last line's value is the result of the whole do block.
askName :: IO String
askName = do
  putStrLn "What's your name?"
  n <- getLine
  let cleaned = if null n then "stranger" else n
  return cleaned        -- `return` wraps a pure value into IO.
                        -- It does NOT exit early like in other languages!

-- ---- Reading numbers safely -----------------------------------------
askNumber :: IO (Maybe Int)
askNumber = do
  putStrLn "Give me a number:"
  s <- getLine
  return (readMaybe s)  -- Nothing if it doesn't parse

-- ---- Loops in IO ----------------------------------------------------
countdown :: Int -> IO ()
countdown 0 = putStrLn "Liftoff!"
countdown n = do
  print n
  countdown (n - 1)     -- recursion again

table :: IO ()
table = forM_ [1 .. 3 :: Int] $ \i ->
  putStrLn (show i ++ " squared is " ++ show (i * i))

-- ---- Conditionals in IO ---------------------------------------------
checkEven :: Int -> IO ()
checkEven n = do
  when (even n) $ putStrLn "even!"
  unless (even n) $ putStrLn "odd!"

-- ---- Common mistake -------------------------------------------------
-- `getLine` is NOT a String; it's an IO String. You must `<-` it
-- inside do to get the String out:
--     length getLine            -- TYPE ERROR
--     do { s <- getLine; print (length s) }   -- OK

main :: IO ()
main = do
  n <- askName
  putStrLn (greeting n)
  mn <- askNumber
  case mn of
    Nothing -> putStrLn "That wasn't a number."
    Just k  -> do
      putStrLn ("Double that is " ++ show (k * 2))
      checkEven k
  countdown 3
  table

-- Run it interactively:        runghc 11-io-and-do.hs
-- Or feed it input:            printf 'Ada\n21\n' | runghc 11-io-and-do.hs

-- EXERCISE 1: Write a guessing game: keep asking for numbers until the
--             user types 7, printing "higher"/"lower" hints.
guessLoop :: IO ()
guessLoop = undefined

-- EXERCISE 2: Read lines until an empty line, then print their sum.
--             (Hint: recursion that returns IO [Int].)
