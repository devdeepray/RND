module Nqueen(nqueen) where

import Data.List

type Solution = [Integer]

nqueen :: Integer -> [Solution]
nqueen n = genperms [1..n]

genperms :: Solution -> [Solution]
genperms [] = [[]]
genperms xs = validate([x:ys | x <- xs, ys <- genperms(delete x xs)])

isvalid :: Integer -> Integer -> Solution -> Bool
isvalid _ _ [] = True
isvalid d x y
  | d == abs(x - (head y)) = False
  | otherwise = isvalid (d+1) x (tail y)

validate :: [Solution] -> [Solution]
validate l = filter (\x -> (isvalid 1 (head x) (tail x))) l

