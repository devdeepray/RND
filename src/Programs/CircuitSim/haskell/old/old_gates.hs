import Data.Maybe
import Data.List

type Event = (Double, Bool)
type EventSequence = [Event]
type LogicFunction = [Bool] -> [Bool]
type GateState = [Bool]

-- COmponent takes a logic function, a delay, an initial state, events for each
-- input and returns outputs for each input.
component :: LogicFunction -> Double -> GateState -> [EventSequence] -> [EventSequence]
component lf de ogs isq =
  -- minind is the index of the list whose head has smallest time
  let minind = findminindex (map fst (map headorinf isq))
  -- We generate outputsequence with this.
  in genosq minind lf de ogs isq

genosq :: Int -> LogicFunction -> Double -> GateState -> [EventSequence] -> [EventSequence]
genosq mi lf de ogs isq =
  -- evt is the event with smallest time
  let evt = head (isq !! mi)
  -- subisq is the list with the smallest time, with the smallest time event
  -- removed
      subisq = getsubisq mi isq
  -- ngs is the next gate state
      ngs = getngs mi lf ogs (snd (head (isq !! mi)))
  in zipWith (zipfun (de + (fst evt))) (lf ngs) (component lf de ngs subisq)

headorinf :: EventSequence -> Event
headorinf [] = (99999999.0, False)
headorinf (x:xs) = x

tailorempty :: EventSequence -> EventSequence
tailorempty [] = []
tailorempty (x:xs) = xs

findminindex :: Ord a => [a] -> Int
findminindex l = fromMaybe 0 (elemIndex (minimum l) l)

getsubisq :: Int -> [EventSequence] -> [EventSequence]
getsubisq minind isq = take minind isq ++ [tailorempty (isq!!minind)] ++ drop (minind + 1) isq

getngs :: Int -> LogicFunction -> GateState -> Bool -> GateState
getngs mi lf ogs v =
  take mi ogs ++ [v] ++ drop (mi + 1) ogs

zipfun :: Double -> Bool -> EventSequence -> EventSequence
zipfun t v xs = (t,v):xs

zol = map (\x -> ((mod x 2) > 0)) [1,2..]
zolevl = [zipWith (,) [1.0,2.0..] zol]

nglf l = map not l




