import Nqueen
import SpeedTest

import Data.Array.IArray
import Data.Ix
import Data.Array.ST
import Control.Monad.ST


test start end =
 test_helper start
 where
 test_helper n
  | n > end = putStr "done"
  | otherwise =
     do
      putStr (show n)
      putStr ","
      putStr (show (perf_test (head (head (nqueen n))) 1))
      putStrLn ","
      (test_helper (n + 1))

main = test 4 14
 

