import TopSort
import Data.Time.Clock

get_next_node :: Integer -> (Integer, [Integer]) -> (Integer, [Integer])
get_next_node new_node_num (prev_node_num, nbrs) =
 (new_node_num , reverse (prev_node_num : nbrs))


gen_big_dag :: Integer -> [(Integer, [Integer])]
gen_big_dag 1 =
  [(1, [])]
gen_big_dag n =
  reverse new_dag
  where
  new_dag = new_node : smaller_dag
  smaller_dag = gen_big_dag (n - 1)
  new_node = get_next_node n (head smaller_dag)

perf_test func num_runs =
  (perf_helper num_runs 0) / num_runs
  where
  getTime = getCurrentTime >>= return . fromRational . toRational . utctDayTime
  perf_helper 0 ttime = ttime
  perf_helper n ttime =
    let start_t = getTime in
    let garb = func in
    let end_t = getTime in
    perf_helper (n - 1) (ttime + end_t - start_t)

test start_dag end_dag delta num_run sorter_func =
  test_helper start_dag
  where
  test_helper dag_size
   | True = dag_size
   | otherwise =
     let big_dag = gen_big_dag dag_size in
     let x1 = putStr (show dag_size) in
     let x2 =  putStr "," in
     let x3 =  putStr (show (perf_test (topsort big_dag) num_run)) in
     let x4 =  putStrLn "," in
     (test_helper (dag_size + delta))

    
