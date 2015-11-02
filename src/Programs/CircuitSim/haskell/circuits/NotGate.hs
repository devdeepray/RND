module NotGate where

import Component
import CktSimTypes

not_gate :: Delay -> Bool -> EventSequence -> EventSequence
not_gate delay init_gs inp_seq =
  primitive (\x -> not (head x)) delay [init_gs] [inp_seq]
