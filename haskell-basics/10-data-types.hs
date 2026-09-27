-- =====================================================================
-- 10 · Your own data types
-- =====================================================================

-- ---- Type synonyms: just a new NAME for an existing type ------------
type Name = String
type Age  = Int

-- ---- Sum types: "one of these alternatives" (an enum, and more) ----
data Direction = North | East | South | West
  deriving (Show, Eq)

turnRight :: Direction -> Direction
turnRight North = East
turnRight East  = South
turnRight South = West
turnRight West  = North

-- ---- Product types: constructor carrying fields ---------------------
-- `Point` (left) is the TYPE; `Point` (right) is the CONSTRUCTOR,
-- a function:  Point :: Double -> Double -> Point
data Point = Point Double Double
  deriving Show

origin :: Point
origin = Point 0 0

-- Pattern match to take it apart:
distFromOrigin :: Point -> Double
distFromOrigin (Point x y) = sqrt (x * x + y * y)

-- ---- Both at once: alternatives WITH data ---------------------------
data Shape
  = Circle Point Double          -- centre, radius
  | Rectangle Point Point        -- two corners
  deriving Show

area :: Shape -> Double
area (Circle _ r) = pi * r * r
area (Rectangle (Point x1 y1) (Point x2 y2)) = abs (x2 - x1) * abs (y2 - y1)

-- ---- Records: named fields ------------------------------------------
data Person = Person
  { name :: Name
  , age  :: Age
  } deriving (Show, Eq)

ada :: Person
ada = Person { name = "Ada", age = 36 }

-- Field names are automatically getter functions: name :: Person -> Name
-- Update syntax makes a NEW value (nothing is mutated):
older :: Person -> Person
older p = p { age = age p + 1 }

-- ---- Recursive types ------------------------------------------------
-- A type can refer to itself. This is how lists and trees are built.
data IntList = Empty | Cons Int IntList
  deriving Show

data Tree a = Leaf | Node (Tree a) a (Tree a)   -- `a` = type parameter
  deriving Show

insert :: Ord a => a -> Tree a -> Tree a
insert x Leaf = Node Leaf x Leaf
insert x t@(Node l v r)
  | x < v     = Node (insert x l) v r
  | x > v     = Node l v (insert x r)
  | otherwise = t

toList :: Tree a -> [a]
toList Leaf         = []
toList (Node l v r) = toList l ++ [v] ++ toList r

-- ---- Maybe: a value that might be missing ---------------------------
-- Built in as:  data Maybe a = Nothing | Just a
-- Use it instead of null / crashing.
safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y)

showResult :: Maybe Int -> String
showResult Nothing  = "no result"
showResult (Just n) = "got " ++ show n

-- ---- Either: success OR an error with information -------------------
-- Built in as:  data Either a b = Left a | Right b
-- Convention: Left = error, Right = success ("right" = correct).
parseAge :: Int -> Either String Age
parseAge n
  | n < 0     = Left "age can't be negative"
  | n > 150   = Left "that seems unlikely"
  | otherwise = Right n

-- ---- newtype: a zero-cost wrapper with exactly one field ------------
-- Makes a DISTINCT type so you can't mix them up by accident.
newtype Metres = Metres Double deriving Show
newtype Feet   = Feet Double   deriving Show

toFeet :: Metres -> Feet
toFeet (Metres m) = Feet (m * 3.28084)

main :: IO ()
main = do
  print (turnRight North, map turnRight [North, East, South, West])
  print (origin, distFromOrigin (Point 3 4))
  print (map area [Circle origin 1, Rectangle origin (Point 2 3)])
  print ada
  print (name ada, older ada)
  print (Cons 1 (Cons 2 Empty))
  print (toList (foldr insert Leaf [5, 2, 8, 1, 9, 3 :: Int]))
  putStrLn (showResult (safeDiv 10 2))
  putStrLn (showResult (safeDiv 10 0))
  print (parseAge 30, parseAge (-1))
  print (toFeet (Metres 100))

-- EXERCISE 1: Write `lookupAge` that finds a person's age by name in a
--             list, returning Nothing if absent.
lookupAge :: Name -> [Person] -> Maybe Age
lookupAge n people = undefined

-- EXERCISE 2: Write `treeSize` and `treeDepth` for Tree.
treeSize :: Tree a -> Int
treeSize t = undefined

-- EXERCISE 3: Define `data Expr = Num Int | Add Expr Expr | Mul Expr Expr`
--             and an `eval :: Expr -> Int`. (A tiny interpreter!)
