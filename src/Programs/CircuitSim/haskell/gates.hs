import Data.Maybe
import Data.List

type InputId = Int
type Event = (Int, (Double, Bool))
type EventSequence = [Event]
type LogicFunction = [Bool] -> [Bool]
type GateState = [Bool]

component :: LogicFunction -> Double -> GateState -> EventSequence -> [EventSequence]
component lf de igs isq =
  let gsseq = gengsseq lf igs isq
  in zipWith (genevs de) gsseq (map fst (map snd (isq)))

gengsseq :: LogicFunction -> GateState -> EventSequence -> [GateState]
gengsseq lf gs (ev:evs) =
  let newgs = getngs (fst ev) gs (snd (snd ev))
  in (lf newgs):(gengsseq lf newgs evs)

genevs :: Double -> GateState -> Double -> EventSequence
genevs de gs ct =
  zipWith (\x y -> (x, ((de + ct), y))) [0,1..] gs

findminindex :: Ord a => [a] -> Int
findminindex l = fromMaybe 0 (elemIndex (minimum l) l)

getngs :: Int -> GateState -> Bool -> GateState
getngs mi ogs v =
  take mi ogs ++ [v] ++ drop (mi + 1) ogs


zol = map (\x -> ((mod x 2) > 0)) [1,2..]

zolevl :: EventSequence
zolevl = zipWith (,) (map fromInteger [0,0..]) (zipWith (,) [1.0,2.0..] zol)

nglf l = map not l




