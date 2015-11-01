module TwoInput where
import CktSimTypes
import Component

type BinaryOperator = Bool -> Bool -> Bool

double_input_primitive :: BinaryOperator -> Delay -> (Bool, Bool) -> 
                          (EventSequence, EventSequence) -> EventSequence

-- Generate a primitive by transforming the tuples into lists
double_input_primitive bin_op delay init_st inp_seq =
  primitive lst_bin_op delay lst_init_st lst_inp_seq

  where lst_bin_op = (\x -> bin_op (x !! 0) (x !! 1))
        lst_init_st = [(fst init_st), (snd init_st)]
        lst_inp_seq = [(fst inp_seq), (snd inp_seq)]
