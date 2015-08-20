module TopSort(topsort) where

import Data.Map (Map)             -- This just imports the type name
import qualified Data.Map as Map  -- Imports everything else, but with names 
                                  -- prefixed with "Map." (with the period).

import Data.Set (Set)
import qualified Data.Set as Set



data ExploreRes a = ExploreRes { getCansort :: Bool,
                               getSorted :: [a],
                               getUnmarked :: Set a,
                               getSeen :: Set a} deriving (Show)


-- graph is a list of pairs, where each pair is (node num, (list of neighbor nodes))
topsort :: Ord a => [(a, [a])] -> ([a], Bool)
topsort graph =
  topsort_helper (Map.fromList graph) [] (Set.fromList (map fst graph)) Set.empty

topsort_helper :: Ord a => Map a [a] -> [a] -> Set a -> Set a -> ([a], Bool)
topsort_helper graph sorted unmarked seen
  | Set.null unmarked = (sorted, True) -- Finished, no more nodes
  | not (getCansort explore_res) = (sorted, False) -- Cannot perform sort, cycle present
  | otherwise = topsort_helper graph (getSorted explore_res) (getUnmarked explore_res) (getSeen explore_res)
  where
    explore_res = explore graph (Set.findMin unmarked) sorted unmarked seen
    
explore :: Ord a => Map a [a] -> a -> [a] -> Set a -> Set a -> ExploreRes a
explore graph node sorted unmarked seen
  | Set.member node seen = ExploreRes False sorted unmarked seen -- Cycle found
  | Set.notMember node unmarked = ExploreRes True sorted unmarked seen -- Already explored, skip
  | otherwise =  ExploreRes (getCansort explore_res)
                     (node : (getSorted explore_res))
                     (Set.delete node (getUnmarked explore_res)) 
                     (Set.delete node (getSeen explore_res))
  where
    explore_res = foldl explore_helper 
                        (ExploreRes True sorted unmarked (Set.insert node seen)) 
                        (Map.findWithDefault [] node graph)
                  where
                    explore_helper exp_h_res node
                      | getCansort exp_h_res = explore graph node (getSorted exp_h_res) 
                                                       (getUnmarked exp_h_res) (getSeen exp_h_res)
                      | otherwise = exp_h_res

