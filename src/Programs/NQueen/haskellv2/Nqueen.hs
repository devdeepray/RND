module Nqueen(nqueen) where

import Control.Monad
import Data.List
 
-- given n, "nqueen n" solves the n-nqueen problem, returning a list of all the
-- safe arrangements. each solution is a list of the columns where the nqueen are
-- located for each row
nqueen :: Integer -> [[Integer]]
nqueen n = map fst $ foldM oneMoreQueen ([],[1..n]) [1..n]  where 
 
  -- foldM :: (Monad m) => (a -> b -> m a) -> a -> [b] -> m a
  -- foldM folds (from left to right) in the list monad, which is convenient for 
  -- "nondeterminstically" finding "all possible solutions" of something. the 
  -- initial value [] corresponds to the only safe arrangement of nqueen in 0 rows
 
  -- given a safe arrangement y of nqueen in the first i rows, and a list of 
  -- possible choices, "oneMoreQueen y _" returns a list of all the safe 
  -- arrangements of nqueen in the first (i+1) rows along with remaining choices 
  oneMoreQueen (y,d) _ = [(x:y, delete x d) | x <- d, safe x]  where
 
    -- "safe x" tests whether a queen at column x is safe from previous nqueen
    safe x = and [x /= c + n && x /= c - n | (n,c) <- zip [1..] y]
 
