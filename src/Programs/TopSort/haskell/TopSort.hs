module TopSort(topsort) where

import Data.Array.IArray
import Data.Ix
import Data.Array.ST
import Control.Monad.ST

-- Representation of a graph as a table of vertices
type Vertex = Integer
type Table a = Array Vertex a
type Graph =  Table [Vertex]

type Bounds = (Vertex, Vertex)

data Tree a = Node a (Forest a)
type Forest a= [Tree a]

-- This function is to generate a tree from a node in the graph.
-- This can potentially be an infinite tree if there are loops.
generate :: Graph -> Vertex -> Tree Vertex
generate g v = Node v (map (generate g) (g!v))

type Set s = STArray s Vertex Bool

mkEmpty :: Bounds -> ST a (Set a)
mkEmpty bounds = newArray bounds False

contains :: (Set a) -> Vertex -> ST a Bool
contains s v = readArray s v

include :: (Set a) -> Vertex -> ST a ()
include s v = writeArray s v True

prune :: Bounds -> Forest Vertex -> Forest Vertex
prune bnds trees
  = runST (do
      m <- mkEmpty bnds
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
dfs g vs = prune (bounds g) (map (generate g) vs)

dfforest :: Graph -> Forest Vertex
dfforest g = dfs g (vertices g)

vertices :: Graph -> [Vertex]
vertices = indices

