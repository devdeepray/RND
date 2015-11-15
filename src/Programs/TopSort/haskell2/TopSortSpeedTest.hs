import TopSort
import SpeedTest

import Data.Array.IArray
import Data.Ix
import Control.Monad.ST
import Data.Graph

-- gen_dense_node n i = (i, [i+1, ... n-1])
gen_dense_node :: Int -> Int -> (Int, [Int])
gen_dense_node n i = (i, [(i+1)..(n-1)])

-- Generates a dense graph of the following form:
-- 0 -> [1,2,3 ... n-1]
-- 1 -> [2,3 ... n-1]
-- n-1 -> []
gen_dense_dag :: Int -> [(Int, [Int])]
gen_dense_dag n =  (map (gen_dense_node n) [0..(n-1)])

-- Generates a sparse graph of the following form:
-- 0 -> [1,2,3 .. k]
-- 1 -> [2,3,4 .. k+1]
-- n-k -> [n-k+1, .. n-1]
-- n-1 -> []
gen_sparse_node :: Int -> Int -> Int -> (Int, [Int])
gen_sparse_node n k i = (i, [(i+1)..(min (i+k) (n-1))])

gen_sparse_dag :: Int -> Int -> [(Int, [Int])]
gen_sparse_dag n k = (map (gen_sparse_node n k) [0..(n-1)])


-- Measure speed of func
test_gen start_size end_size delta func =
 test_helper start_size
 where
 test_helper dag_size
  | dag_size > end_size = putStr""
  | otherwise =
   do
    putStr (show dag_size)
    putStr ","
    putStr (show (perf_test (func dag_size)))
    putStrLn ","
    (test_helper (dag_size + delta))

s = 1000
e = 3000
d = 100
main = do
-- putStrLn "[DENSE_GEN]"
-- test_gen s e d gen_dense_dag
 putStrLn "[DENSE_SORT_DEFINED]"
 test_gen s e d (\x -> topsort (array (0, x-1) (gen_dense_dag x)))
-- putStrLn "[DENSE_SORT_INTERNAL]"
-- test_gen s e d (\x -> topSort (array (0, x-1) (gen_dense_dag x)))
-- putStrLn "[SPARSE_GEN]"
-- test_gen s e d gen_sparse_dag
-- putStrLn "[SPARSE_SORT_DEFINED]"
-- test_gen s e d (\x -> topSort (array (0, x-1) (gen_sparse_dag x 100)))
-- putStrLn "[SPARSE_SORT_INTERNAL]"
-- test_gen s e d (\x -> topSort (array (0, x-1) (gen_sparse_dag x 100)))
