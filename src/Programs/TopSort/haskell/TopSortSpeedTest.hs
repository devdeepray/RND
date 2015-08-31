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

test start_dag end_dag delta num_run sorter_func =
 test_helper start_dag
 where
 test_helper dag_size
  | dag_size > end_dag = putStr "done"
  | otherwise =
     let big_dag = gen_big_dag dag_size in
     do
      putStr (show dag_size)
      putStr ","
      putStr (show (perf_test (head (topsort big_dag)) num_run))
      putStrLn ","
      (test_helper (dag_size + delta))

main = do
 test 1000 10000 200 1 topsort

