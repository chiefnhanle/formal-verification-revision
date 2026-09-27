-- =====================================================================
-- 06 · Tuples and pattern matching
-- =====================================================================

-- ---- Tuples ---------------------------------------------------------
-- Fixed size, and elements can have DIFFERENT types.
-- (Lists: any length, one type. Tuples: fixed length, mixed types.)
person :: (String, Int)
person = ("Ada", 36)

point3 :: (Double, Double, Double)
point3 = (1.0, 2.0, 3.0)

-- fst / snd work on PAIRS only:
nameOf :: String
nameOf = fst person

-- ---- Pattern matching on tuples -------------------------------------
-- Destructure right in the argument list:
addPair :: (Int, Int) -> Int
addPair (x, y) = x + y

swap :: (a, b) -> (b, a)
swap (a, b) = (b, a)

third :: (a, b, c) -> c
third (_, _, z) = z

-- ---- Pattern matching on lists --------------------------------------
-- Patterns mirror how lists are built: []  or  (x : xs)
describeList :: [a] -> String
describeList []           = "empty"
describeList [_]          = "one element"        -- same as (_ : [])
describeList [_, _]       = "two elements"
describeList (_ : _ : _)  = "three or more"

safeHead :: [a] -> Maybe a     -- Maybe: see lesson 10
safeHead []      = Nothing
safeHead (x : _) = Just x

-- ---- Literal patterns -----------------------------------------------
isVowel :: Char -> Bool
isVowel 'a' = True
isVowel 'e' = True
isVowel 'i' = True
isVowel 'o' = True
isVowel 'u' = True
isVowel _   = False

-- ---- As-patterns: name the whole AND its parts ----------------------
firstLetter :: String -> String
firstLetter ""           = "empty string"
firstLetter all@(x : _)  = all ++ " starts with " ++ [x]

-- ---- Patterns in let / where / lambdas / comprehensions -------------
distance :: (Double, Double) -> (Double, Double) -> Double
distance p q = sqrt (dx * dx + dy * dy)
  where
    (x1, y1) = p
    (x2, y2) = q
    dx = x2 - x1
    dy = y2 - y1

sumPairs :: [(Int, Int)] -> [Int]
sumPairs ps = [a + b | (a, b) <- ps]

firsts :: [(a, b)] -> [a]
firsts = map (\(a, _) -> a)

-- ---- Order matters, and completeness matters ------------------------
-- Equations are tried TOP TO BOTTOM. If no pattern matches you get a
-- runtime crash, so cover every case. Compile with -Wall and GHC
-- warns you about missing cases ("non-exhaustive patterns").

main :: IO ()
main = do
  print (person, nameOf, snd person)
  print (addPair (3, 4), swap (1, 'a'), third point3)
  print (map describeList [[], [1], [1, 2], [1, 2, 3 :: Int]])
  print (safeHead [10, 20 :: Int], safeHead ([] :: [Int]))
  print (filter isVowel "functional programming")
  putStrLn (firstLetter "haskell")
  print (distance (0, 0) (3, 4))
  print (sumPairs [(1, 2), (3, 4)], firsts [('a', 1), ('b', 2 :: Int)])

-- EXERCISE 1: Return the second element of a list, if it exists.
secondElem :: [a] -> Maybe a
secondElem xs = undefined

-- EXERCISE 2: Given a list of (name, age), return names of people
--             aged 18+. Use a pattern inside a comprehension.
adults :: [(String, Int)] -> [String]
adults people = undefined
