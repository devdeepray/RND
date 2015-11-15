module TopSort(topsort) where

import Data.Array.IArray
import Data.Ix
import Data.Array.ST
import Control.Monad.ST
import Data.Vector.Unboxed.Mutable as MV

-- Representation of a graph as a table of vertices
type Vertex = Int
type Table a = Array Vertex a
type Graph =  Table [Vertex]

type Bounds = (Vertex, Vertex)

data Tree a = Node a (Forest a)
type Forest a= [Tree a]

-- This function is to generate a tree from a node in the graph.
-- This can potentially be an infinite tree if there are loops.
generate :: Graph -> Vertex -> Tree Vertex
generate g v = Node v (map (generate g) (g!v))

type Set s = MV.STVector s Bool

mkEmpty :: Int -> ST a (Set a)
mkEmpty size = MV.replicate size False

contains :: (Set a) -> Vertex -> ST a Bool
contains s v = MV.read s v

include :: (Set a) -> Vertex -> ST a ()
include s v = MV.write s v True

prune :: Int -> Forest Vertex -> Forest Vertex
prune size trees
  = runST (do
      m <- mkEmpty size
      chop m trees)

chop :: Set a -> Forest Vertex -> ST a (Forest Vertex)
chop m [] = return []
chop m ((Node v subtr) : res)
  = do
      visited <- contains m v
      if visited then
        chop m res
      else do
        _ <- include m v
        ct <- chop m subtr
        cr <- chop m res
        return ((Node v ct) : cr)

postordTr :: Tree a -> [a]
postordTr (Node v f) = (postordFr f) ++ [v]

postordFr :: Forest a -> [a]
postordFr f = concat (map postordTr f)

postOrd :: Graph -> [Vertex]
postOrd g = postordFr (dfforest g)

topsort :: Graph -> [Vertex]
topsort g = reverse (postOrd g)

dfs :: Graph -> [Vertex] -> Forest Vertex
dfs g vs = prune ((snd (bounds g))+1) (map (generate g) vs)

dfforest :: Graph -> Forest Vertex
dfforest g = dfs g (vertices g)

vertices :: Graph -> [Vertex]
vertices = indices

