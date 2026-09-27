-- =====================================================================
-- 09 · Type classes and constraints (=>)
-- =====================================================================
-- A TYPE CLASS is a set of types that support some operations.
-- Think of it as an interface, or a predicate on types:
--   Eq a    "a supports == and /="
--   Ord a   "a can be ordered: <, <=, compare, max ..."  (needs Eq)
--   Show a  "a can be turned into a String with show"
--   Num a   "a supports + - * and number literals"

-- ---- Constraints: the `=>` ------------------------------------------
--   inRange :: Ord a => a -> a -> a -> Bool
--              ^^^^^    ^^^^^^^^^^^^^^^^^^^^
--              constraint   the actual type
-- Read: "for any type a SUCH THAT a is ordered, a -> a -> a -> Bool".
-- Without `Ord a`, using <= on an arbitrary `a` is a type error.
inRange :: Ord a => a -> a -> a -> Bool
inRange lo hi x = lo <= x && x <= hi

-- Several constraints go in a tuple:
describeMax :: (Ord a, Show a) => a -> a -> String
describeMax x y = "the max is " ++ show (max x y)

-- Constraints on different type variables:
labelled :: (Show k, Num v, Show v) => k -> v -> String
labelled k v = show k ++ " => " ++ show (v * 2)

-- ---- Ordering -------------------------------------------------------
-- compare returns an Ordering: LT, EQ or GT
compareDemo :: [Ordering]
compareDemo = [compare 1 2, compare 'b' 'b', compare "zoo" "apple"]

-- ---- Getting instances for free: deriving ---------------------------
data Colour = Red | Green | Blue
  deriving (Show, Eq, Ord, Enum, Bounded)
-- Derived Ord uses declaration order: Red < Green < Blue.
-- Enum gives [Red ..]; Bounded gives minBound / maxBound.

-- ---- Writing an instance by hand ------------------------------------
data Suit = Hearts | Spades

instance Show Suit where
  show Hearts = "♥"
  show Spades = "♠"

instance Eq Suit where
  Hearts == Hearts = True
  Spades == Spades = True
  _      == _      = False
  -- /= comes for free from ==

-- ---- Defining your own class ----------------------------------------
class Shape a where
  area      :: a -> Double
  perimeter :: a -> Double
  describe  :: a -> String              -- with a DEFAULT implementation
  describe s = "shape with area " ++ show (area s)

data Circle = Circle Double             -- radius
data Rect   = Rect Double Double        -- width, height

instance Shape Circle where
  area (Circle r)      = pi * r * r
  perimeter (Circle r) = 2 * pi * r

instance Shape Rect where
  area (Rect w h)      = w * h
  perimeter (Rect w h) = 2 * (w + h)
  describe r           = "rectangle, area " ++ show (area r)  -- override

-- Generic over ANY Shape:
isBig :: Shape a => a -> Bool
isBig s = area s > 10

-- ---- Superclasses ---------------------------------------------------
-- In the real Prelude:   class Eq a => Ord a where ...
-- means "to be Ord, a type must already be Eq".
-- Conditional instances: instance Ord a => Ord [a]
-- means "lists are ordered whenever their elements are".

main :: IO ()
main = do
  print (inRange 1 10 (5 :: Int), inRange 'a' 'z' 'Q')
  putStrLn (describeMax 3 (7 :: Int))
  putStrLn (labelled "count" (21 :: Int))
  print compareDemo
  print (Red < Blue, maximum [Green, Red], [minBound .. maxBound :: Colour])
  print (Hearts, Hearts == Spades)
  putStrLn (describe (Circle 1))
  putStrLn (describe (Rect 3 4))
  print (isBig (Circle 1), isBig (Rect 3 4))

-- ---------------------------------------------------------------------
-- In GHCi:  :i Ord     :i Num     :t (+)     :t show     :t (==)
-- ---------------------------------------------------------------------

-- EXERCISE 1: Give this the most general type signature (delete the
--             one here and ask GHCi with :t, then compare).
largestOf :: [Int] -> Int
largestOf = foldr1 max

-- EXERCISE 2: Write a `Show` instance for Colour2 that prints lowercase
--             names ("red", "green").
data Colour2 = Red2 | Green2

-- EXERCISE 3: Add a `Triangle` (three side lengths) that is a Shape.
--             (Area: Heron's formula.)
