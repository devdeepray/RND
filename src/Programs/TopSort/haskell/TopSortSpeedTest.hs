import TopSort
import SpeedTest

import Data.Array.IArray
import Data.Ix
import Data.Array.ST
import Control.Monad.ST

get_next_node :: Integer -> (Integer, [Integer]) -> (Integer, [Integer])
get_next_node new_node_num (prev_node_num, nbrs) =
 (new_node_num , reverse (prev_node_num : nbrs))

gen_big_dagh :: Integer -> [(Integer, [Integer])]
gen_big_dagh 1 = [(0, [])]
gen_big_dagh n = ((n - 1), new_nbrs) : smaller_dag
  where
  smaller_dag = gen_big_dagh (n - 1)
  new_nbrs = (n - 2) : (snd (head smaller_dag))
gen_big_dag n = array (0, n-1) (gen_big_dagh n)

gen_sparse_dagh :: Integer -> Integer -> [(Integer, [Integer])]
gen_sparse_dagh 1 deg = [(0, [])]
gen_sparse_dagh n deg = ((n - 1), new_nbrs) : smaller_dag
  where
  smaller_dag = gen_sparse_dagh (n - 1) deg
  new_nbrs = [(max 0 ((n - 2)-deg))..(n-2)]

gen_sparse_dag n deg = array (0, n-1) (gen_sparse_dagh n deg)

test gen start_dag end_dag delta num_run sorter_func =
 test_helper start_dag
 where
 test_helper dag_size
  | dag_size > end_dag = putStr "done"
  | otherwise =
     do
      putStr (show dag_size)
      putStr ","
      putStr (show (perf_test (head (topsort (gen dag_size))) num_run))
      putStrLn ","
      (test_helper (dag_size + delta))

main = do
 putStr "[DENSE]"
 x <- test gen_big_dag 1000 10000 200 1 topsort
 putStr "[SPARSE]"
 test (\sz -> gen_sparse_dag sz 500) 1000 10000 200 1 topsort
 

