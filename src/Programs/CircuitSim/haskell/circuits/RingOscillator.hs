module RingOscillator where

import NotGate
import CktSimTypes

ring_osc :: Delay -> EventSequence
ring_osc delay =
  let o1 = not_gate delay False o2
      o2 = not_gate delay True o3
      o3 = not_gate delay False o1
  in o1
