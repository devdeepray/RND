import TopSort
import SpeedTest

get_next_node :: Integer -> (Integer, [Integer]) -> (Integer, [Integer])
get_next_node new_node_num (prev_node_num, nbrs) =
 (new_node_num , reverse (prev_node_num : nbrs))

gen_big_dag :: Integer -> [(Integer, [Integer])]
gen_big_dag 1 = [(1, [])]
gen_big_dag n =
 reverse new_dag
 where
 new_dag = new_node : smaller_dag
 smaller_dag = gen_big_dag (n - 1)
 new_node = get_next_node n (head smaller_dag)

test :: Integer -> Integer -> Integer -> Integer -> ([(Integer, [Integer])] -> ([Integer], Bool)) -> IO ()
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
      putStr (show (perf_test (fst (topsort big_dag)) num_run))
      putStrLn ","
      (test_helper (dag_size + delta))

main = do
 test 1000 50000 1000 1 topsort

