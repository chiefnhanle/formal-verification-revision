-- A lazy if-then-else as an ordinary function.
--
-- Because Haskell is non-strict, `lazyIf` only forces the branch it
-- actually returns. The unused branch is never evaluated, so it can
-- safely be `undefined` or a diverging computation.
lazyIf :: Bool -> a -> a -> a
lazyIf True  t _ = t
lazyIf False _ f = f

main :: IO ()
main = do
  -- The False branch (undefined) is never touched.
  putStrLn (lazyIf True "took the true branch" undefined)
  -- Works with infinite/diverging values in the untaken branch too.
  print (lazyIf False (1 `div` 0) 42)
