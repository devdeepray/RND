import Data.Maybe
import Data.List

type InputId = Int
type Event = (Double, Bool)
type EventSequence = [Event]
type LogicFunction = [Bool] -> Bool
type GateState = [Bool]
type Element = GateState -> [EventSequence] -> EventSequence
type Component = GateState -> [EventSequence] -> [EventSequence]

-- This function takes a logic fun, delay, initial state and event sequence for
-- each input
primitive :: LogicFunction -> Double -> GateState -> [EventSequence] -> EventSequence
-- Get the event sequence with minimum start time
-- Drop that from that sequence
-- Get new state, add event to sequence, recurse
primitive lf de gs isq =
  let minind = pick_min isq 9999999.0 (0-1) 0
  in if minind < 0 
       then []
       else let ev = head (isq !! minind)
                seq = take minind isq ++ [(tail (isq !! minind))] ++ drop (minind + 1) isq
                oop = lf gs
                ngs = take minind gs ++ [(snd ev)] ++ drop (minind + 1) gs
                nop = lf ngs 
            in (de + (fst ev), nop):(primitive lf de ngs seq)



pick_min :: [EventSequence] -> Double -> Int -> Int -> Int
pick_min [] v def ind = def
pick_min ([]:xs) v def ind = pick_min xs v def (ind + 1)
pick_min (x:xs) v def ind =
  if (fst (head x)) > v
    then pick_min xs v def (ind + 1)
    else pick_min xs (fst (head x)) ind (ind + 1) 

nglf :: GateState -> Bool
nglf l = not (head l)

aglf :: GateState -> Bool
aglf l = (foldl (&&) True l)

ag1 :: [EventSequence] -> EventSequence
ag1 = primitive aglf 0.2 [False]

ag2 :: [EventSequence] -> EventSequence
ag2 = primitive aglf 0.2 [True]


ro :: EventSequence
ro = let o1 = ag1 [o2]
         o2 = ag2 [o3]
         o3 = ag1 [o1]
     in o1


-- serial_connect :: [Element] -> Component -> GateState -> [EventSequence] -> [EventSequence]

-- parallel_connect :: [Component] -> Component

--connect :: Element -> Element -> Int -> Int -> GateState -> [EventSequence] -> EventSequence
--connect e1 e2 e1s inputid gs isq =
--  let esqe1 = take e1s isq
--    gse1 = take eis gs
--		esqe2tmp = drop t1s isq
--		esqe2f = take inputid esqe2tmp ++ [(e1 gse1 esqe1)] ++ 

