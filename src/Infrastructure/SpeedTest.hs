module SpeedTest(perf_test) where

import Data.Time.Clock.POSIX
import System.IO.Unsafe
import Control.DeepSeq

getCPUTimeMS = round `fmap` (fmap (* 1000) getPOSIXTime)

benchmark :: [Integer] -> IO Integer
benchmark f = do
               start <- getCPUTimeMS
               end <- (f `deepseq` getCPUTimeMS)
               return (end - start)

perf_test :: [Integer] -> Integer -> Double
perf_test func num_runs =
  (perf_helper num_runs 0) / (fromIntegral num_runs)
  where
  perf_helper :: Integer -> Double -> Double
  perf_helper 0 ttime = ttime
  perf_helper n ttime =
    let
      time = benchmark func
    in perf_helper (n - 1) (ttime + (fromInteger (unsafePerformIO time)))

