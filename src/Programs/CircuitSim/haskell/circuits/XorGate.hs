module XorGate where
import TwoInput

xor_gate = double_input_primitive (\x y -> (x && (not y)) || ((not x) && y))
