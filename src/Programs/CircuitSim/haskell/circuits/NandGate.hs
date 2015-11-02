module NandGate where
import TwoInput

nand_gate = double_input_primitive ((&&) . not)
