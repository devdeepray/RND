module CktSimTypes where

-- Delay is the timegap
type Delay = Double

-- Inputs are identified by integer index
type InputId = Int

-- An event is a timestamp and the new value
type Event = (Delay, Bool)

-- An event sequence is a sequence of events
type EventSequence = [Event]

-- Logic function has a bunch of inputs and returns one output
type LogicFunction = [Bool] -> Bool

-- Gatestate is a list of true false states for a bunch of inputs/outputs
type GateState = [Bool]

