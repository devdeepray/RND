module Nqueen(nqueen) where

import Data.List

nqueen :: Int -> Int
nqueen n = countQueens ([], [1..n])

countQueens :: ([Int], [Int]) -> Int
countQueens (_, []) = 1
countQueens (cur, rem) =
 sum $ map countQueens [(x:cur, delete x rem) | x <- rem, safe x] where
  safe x = and [abs(x - c) /= n | (n,c) <- zip [1..] cur]
