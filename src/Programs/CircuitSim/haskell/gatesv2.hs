import Data.Maybe
import Data.List

type InputId = Int
type Event = (Double, Bool)

-- An event sequence is a sequence of events along with their times
type EventSequence = [Event]

-- Logic function has a bunch of inputs and returns one output
type LogicFunction = [Bool] -> Bool

-- Gatestate is a list of true false states for a bunch of inputs/outputs
type GateState = [Bool]

-- The type element is a circuit component, that has multiple inputs and one
-- output. It takes the initial gate state, the event sequence for all its
-- inputs and returns the event sequence for the output.
type Element = GateState -> [EventSequence] -> EventSequence

type Delay = Double

type InputSequence = [EventSequence]
type OutputSequence = EventSequence

primitive :: LogicFunction -> Delay -> GateState -> InputSequence -> OutputSequence
primitive lf d gs isq =
  primitive_h lf d gs (zipWith (\x y -> ((0.0, x):y)) gs isq)

-- Primitives simulate one output logic functions. To define a primitive, we
-- need a logic function and a delay. It then gives us an element. 
primitive_h :: LogicFunction -> Double -> GateState -> InputSequence -> OutputSequence
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

type SingleInputLogicFunction = Bool -> Bool
single_input_primitive :: SingleInputLogicFunction -> Double -> Bool -> EventSequence -> EventSequence
single_input_primitive silf de gs isq = primitive (\x -> silf (head x)) de [gs] [isq]

type DoubleInputLogicFunction = Bool -> Bool -> Bool
double_input_primitive :: DoubleInputLogicFunction -> Double -> (Bool, Bool) -> (EventSequence, EventSequence) -> EventSequence
double_input_primitive dilf de gs isq = primitive (\x -> dilf (x !! 0) (x !! 1)) de [(fst gs), (snd gs)] [(fst isq), (snd isq)]

not_gate = single_input_primitive (not)

and_gate = double_input_primitive (&&) 0.2 (False, False)

or_gate = double_input_primitive (||) 0.1 (False, False)

nand_gate = double_input_primitive ((&&) . not) 0.3 (False, False)

xor_gate = double_input_primitive (\x y -> (x && (not y)) || ((not x) && y)) 0.4 (False, False)

half_adder :: (EventSequence, EventSequence) -> (EventSequence, EventSequence)
half_adder isq = (xor_gate isq, and_gate isq)

full_adder :: (EventSequence, EventSequence, EventSequence) -> (EventSequence, EventSequence)
full_adder (isq_a, isq_b, isq_c) =
  let o1 = (xor_gate (isq_a, isq_b))
      s = (xor_gate (o1, isq_c))
      o2 = (and_gate (isq_a, isq_b))
      o3 = (and_gate (o1, isq_c))
      c = (and_gate (o2, o3))
  in (s, c)

ripple_adder :: [(EventSequence, EventSequence)] -> (EventSequence, [EventSequence])
ripple_adder x = ripple_adder_h [(0.0, False)] x

ripple_adder_h :: EventSequence -> [(EventSequence, EventSequence)] -> (EventSequence, [EventSequence])
ripple_adder_h c [] = (c, [])
ripple_adder_h c (x:xs) =
  let addr = full_adder (fst x, snd x, c)
      subckt = ripple_adder_h (snd addr) xs
  in (fst subckt, (fst addr):(snd subckt))

-- Backward flow example
ring_osc :: EventSequence
ring_osc =
  let o1 = not_gate 0.1 False o2
      o2 = not_gate 0.1 True o3
      o3 = not_gate 0.1 False o1
  in o1

