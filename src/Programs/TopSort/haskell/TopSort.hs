module TopSort(topsort) where

-- Import the Map data structure. This is needed for quick lookup
-- of neighbors of a given node. It is immutable.
import Data.Map (Map)
import qualified Data.Map as Map

-- Import the Set data structure. This is needed for keeping track
-- of the nodes to be explored, the temp marked nodes, etc. It is
-- immutable.
import Data.Set (Set)
import qualified Data.Set as Set

-- A data structure for the result of exploration of a node.
data ExploreRes a = ExploreRes {
  getCansort :: Bool, -- Whether the graph can be sorted.
  getSorted :: [a], -- The sorted list.
  getUnmarked :: Set a, -- The list of unmarked nodes so far.
  getSeen :: Set a -- The list of seen nodes so far.
} deriving (Show)


-- graph is a list of pairs, where each pair is (node num, (list of neighbor nodes))
topsort :: Ord a => [(a, [a])] -> ([a], Bool)
topsort graph =
  topsort_helper (Map.fromList graph) [] (Set.fromList (map fst graph))

topsort_helper :: Ord a => Map a [a] -> [a] -> Set a -> ([a], Bool)
topsort_helper graph sorted unmarked
  | Set.null unmarked = (sorted, True) -- Finished, no more nodes
  | not (getCansort explore_res) = (sorted, False) -- Cannot perform sort, cycle present
  | otherwise = topsort_helper graph
      (getSorted explore_res) -- The sorted nodes after call to explore
      (getUnmarked explore_res) -- The unmarked nodes after call to explore
  where   -- Pick one node from unmarked and explore it.
    explore_res = explore graph (Set.findMin unmarked) sorted unmarked Set.empty

-- Run DFS on a node and sort the induced subgraph.
explore :: Ord a => Map a [a] -> a -> [a] -> Set a -> Set a -> ExploreRes a
explore graph node sorted unmarked seen
  | Set.member node seen = ExploreRes False sorted unmarked seen -- Cycle found.
  | Set.notMember node unmarked = ExploreRes True sorted unmarked seen -- Already explored, skip.
  | otherwise =  ExploreRes (getCansort explore_res) -- Result of exploring all neighbors.
                     (node : (getSorted explore_res)) -- Add node to sorted list.
                     (Set.delete node (getUnmarked explore_res)) -- Delete from unmarked
                     (Set.delete node (getSeen explore_res)) -- Remove temp mark.
  where -- Explore all the neighbors
    explore_res = foldl explore_helper
                    (ExploreRes True sorted unmarked (Set.insert node seen))
                    (Map.findWithDefault [] node graph)
      where
        explore_helper exp_h_res node
           | getCansort exp_h_res = explore graph node (getSorted exp_h_res)
               (getUnmarked exp_h_res) (getSeen exp_h_res)
           | otherwise = exp_h_res
