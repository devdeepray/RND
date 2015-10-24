import Data.Maybe
import Data.List

type Event = (Double, Bool)
type EventSequence = [Event]
type LogicFunction = [Bool] -> [Bool]
type GateState = [Bool]


component :: LogicFunction -> Double -> GateState -> [EventSequence] -> [EventSequence]
component lf de ogs isq =
  let minind = findminindex (map fst (map head isq))
  in genosq minind lf de ogs isq

genosq :: Int -> LogicFunction -> Double -> GateState -> [EventSequence] -> [EventSequence]
genosq mi lf de ogs isq =
  let evt = head (isq !! mi)
      subisq = getsubisq mi isq
      ngs = getngs mi lf ogs (snd (head (isq !! mi)))
  in zipWith (zipfun (de + (fst evt))) (lf ngs) (component lf de ngs subisq)


findminindex :: Ord a => [a] -> Int
findminindex l = fromMaybe 0 (elemIndex (minimum l) l)

getsubisq :: Int -> [EventSequence] -> [EventSequence]
getsubisq minind isq = take minind isq ++ [tail (isq!!minind)] ++ drop (minind + 1) isq

getngs :: Int -> LogicFunction -> GateState -> Bool -> GateState
getngs mi lf ogs v =
  take mi ogs ++ [v] ++ drop (mi + 1) ogs

zipfun :: Double -> Bool -> EventSequence -> EventSequence
zipfun t v xs = (t,v):xs

zol = map (\x -> ((mod x 2) > 0)) [1,2..]
zolevl = [zipWith (,) [1.0,2.0..] zol]

nglf l = map not l




