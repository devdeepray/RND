module Component where
import CktSimTypes

primitive :: LogicFunction -> Delay -> GateState -> [EventSequence] -> EventSequence
primitive lf de gs isq =
  primitive_h lf de gs (zipWith (\x y -> ((0.0, x):y)) gs isq)

-- Primitives simulate one output logic functions. To define a primitive, we
-- need a logic function and a delay. It then gives us an element. 
primitive_h :: LogicFunction -> Double -> GateState -> [EventSequence] -> EventSequence
primitive_h lf de gs isq =
  -- Pick the input which has the earliest event.
  let minind = pick_min isq (1/0) (0-1) 0
  in if minind < 0 
       then [] -- If no events
       else let ev = head (isq !! minind) -- Found an event, generate output and recurse
                seq = take minind isq ++ [(tail (isq !! minind))] ++ drop (minind + 1) isq
                oop = lf gs
                ngs = take minind gs ++ [(snd ev)] ++ drop (minind + 1) gs
                nop = lf ngs 
            in (de + (fst ev), nop):(primitive_h lf de ngs seq)


-- Pick minimum from the event sequence. Need to skip inputs with no events
pick_min :: [EventSequence] -> Double -> Int -> Int -> Int
pick_min [] v def ind = def
pick_min ([]:xs) v def ind = pick_min xs v def (ind + 1)
pick_min (x:xs) v def ind =
  if (fst (head x)) > v
    then pick_min xs v def (ind + 1)
    else pick_min xs (fst (head x)) ind (ind + 1) 
