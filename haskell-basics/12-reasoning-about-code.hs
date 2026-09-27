-- =====================================================================
-- 12 · Reasoning about code (bridge to formal verification)
-- =====================================================================
-- Because Haskell is pure, `=` really means equality: you can replace
-- a call with its definition anywhere ("substitute equals for equals").
-- That makes it possible to PROVE things about programs on paper,
-- the same way you'd prove things in algebra.

-- ---- Definitions we'll reason about ---------------------------------
myLength :: [a] -> Int
myLength []       = 0                   -- (L1)
myLength (_ : xs) = 1 + myLength xs     -- (L2)

append :: [a] -> [a] -> [a]
append []       ys = ys                 -- (A1)
append (x : xs) ys = x : append xs ys   -- (A2)

myMap :: (a -> b) -> [a] -> [b]
myMap _ []       = []                   -- (M1)
myMap f (x : xs) = f x : myMap f xs     -- (M2)

-- ---- Equational reasoning: evaluate by substitution -----------------
--   myLength (append [1] [2])
-- = myLength (1 : append [] [2])        by (A2)
-- = myLength (1 : [2])                  by (A1)
-- = 1 + myLength [2]                    by (L2)
-- = 1 + (1 + myLength [])               by (L2)
-- = 1 + (1 + 0)                         by (L1)
-- = 2

-- ---- Proof by structural induction ----------------------------------
-- CLAIM:  for all lists xs, ys:
--           myLength (append xs ys) = myLength xs + myLength ys
--
-- Induction on xs (mirrors the two cases of the list type):
--
-- Base case, xs = []:
--     myLength (append [] ys)
--   = myLength ys                       by (A1)
--   = 0 + myLength ys                   arithmetic
--   = myLength [] + myLength ys         by (L1)   ✓
--
-- Inductive case, xs = (x : xs'), assuming the claim for xs' (IH):
--     myLength (append (x : xs') ys)
--   = myLength (x : append xs' ys)      by (A2)
--   = 1 + myLength (append xs' ys)      by (L2)
--   = 1 + (myLength xs' + myLength ys)  by IH
--   = (1 + myLength xs') + myLength ys  associativity of +
--   = myLength (x : xs') + myLength ys  by (L2)   ✓
--
-- Notice: the proof has the same shape as the recursive definition.
-- Base case of the function ↔ base case of the proof.

-- ---- Testing a property (not a proof, but a sanity check) -----------
-- A property is just a function returning Bool that should always be
-- True. Libraries like QuickCheck generate random inputs for these.
propLengthAppend :: [Int] -> [Int] -> Bool
propLengthAppend xs ys =
  myLength (append xs ys) == myLength xs + myLength ys

propMapFusion :: [Int] -> Bool
propMapFusion xs =
  myMap (+ 1) (myMap (* 2) xs) == myMap ((+ 1) . (* 2)) xs

-- A tiny homemade "test all these inputs" check:
samples :: [[Int]]
samples = [[], [1], [1, 2, 3], [5, 4 .. -5]]

main :: IO ()
main = do
  print (and [propLengthAppend xs ys | xs <- samples, ys <- samples])
  print (all propMapFusion samples)

-- EXERCISE 1: Prove by induction on xs:
--               myMap f (append xs ys) = append (myMap f xs) (myMap f ys)
--
-- EXERCISE 2: Prove:  myLength (myMap f xs) = myLength xs
--
-- EXERCISE 3: Prove append is associative:
--               append (append xs ys) zs = append xs (append ys zs)
--
-- EXERCISE 4: Write the properties from exercises 1–3 as Bool functions
--             like propLengthAppend and check them on `samples`.
