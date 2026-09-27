-- Check whether a value falls within an inclusive range [lo, hi].
--
-- `inRange lo hi x` is True exactly when lo <= x && x <= hi.
-- The type is `Ord a` so it works for any orderable type: Int,
-- Integer, Double, Char, etc.
inRange :: Ord a => a -> a -> a -> Bool
inRange lo hi x = lo <= x && x <= hi

main :: IO ()
main = do
  print (inRange 1 10 5)     -- True:  1 <= 5 <= 10
  print (inRange 1 10 10)    -- True:  upper bound is inclusive
  print (inRange 1 10 0)     -- False: below the lower bound
  print (inRange 'a' 'z' 'm')-- True:  works for Char too
