module FullAdder where
import XorGate
import AndGate
import OrGate
import CktSimTypes


full_adder :: Delay -> Delay -> (EventSequence, EventSequence, EventSequence) -> (EventSequence, EventSequence)

full_adder xor_delay and_delay (isq_a, isq_b, isq_c) =
  let fs = (False, False)
      o1 = (xor_gate xor_delay fs (isq_a, isq_b))
      s = (xor_gate xor_delay fs (o1, isq_c))
      o2 = (and_gate and_delay fs (isq_a, isq_b))
      o3 = (and_gate and_delay fs (o1, isq_c))
      c = (and_gate and_delay fs (o2, o3))
  in (s, c)
