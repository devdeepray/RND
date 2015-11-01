module RippleAdder where
import CktSimTypes
import FullAdder

ripple_adder :: [(EventSequence, EventSequence)] -> (EventSequence, [EventSequence])
ripple_adder x = ripple_adder_h [(0.0, False)] x

ripple_adder_h :: EventSequence -> [(EventSequence, EventSequence)] -> (EventSequence, [EventSequence])
ripple_adder_h c [] = (c, [])
ripple_adder_h c (x:xs) =
  let addr = full_adder 0.1 0.12 (fst x, snd x, c)
      subckt = ripple_adder_h (snd addr) xs
  in (fst subckt, (fst addr):(snd subckt))
