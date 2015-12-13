module Component where
import CktSimTypes
import Data.List
import Data.Maybe
-- Takes in a logic function, a delay, initial gate state and the input event
-- sequences
-- Outputs the output event sequence
primitive :: LogicFunction -> Delay -> GateState -> [EventSequence] -> EventSequence
primitive logic_fn delay gate_init isq =
  primitive_h logic_fn delay gate_init (zipWith (\x y -> ((0.0, x):y)) gate_init isq)

-- Helper for primitive, with initialized event sequences
primitive_h :: LogicFunction -> Delay -> GateState -> [EventSequence]
               -> EventSequence
primitive_h logic_fn delay gate_init isq =
  -- Pick the input which has the earliest event.
  let minind = pick_min isq
  in if minind < 0 -- No events
       then []
       else let ev = head (isq !! minind) -- Found an event
                next_seq = take minind isq ++
                                [(tail (isq !! minind))] ++
                                drop (minind + 1) isq
                oop = logic_fn gate_init
                next_gate_init = take minind gate_init ++
                                 [(snd ev)] ++
                                drop (minind + 1) gate_init
                nop = logic_fn next_gate_init
            in (delay + (fst ev), nop):(primitive_h
                                logic_fn delay next_gate_init next_seq)


-- Pick minimum from the event sequence. Need to skip inputs with no events

pick_min :: [EventSequence] -> Int
pick_min isq = pick_min_h isq (1/0) (-1) 0

pick_min_h :: [EventSequence] -> Double -> Int -> Int -> Int
pick_min_h [] cur_min_val cur_min_ind ind = cur_min_ind
pick_min_h ([]:xs) cur_min_val cur_min_ind ind =
  pick_min_h xs cur_min_val cur_min_ind (ind + 1)

pick_min_h (x:xs) cur_min_val cur_min_ind ind =
  if (fst (head x)) > cur_min_val
    then pick_min_h xs cur_min_val cur_min_ind (ind + 1)
    else pick_min_h xs (fst (head x)) ind (ind + 1)
