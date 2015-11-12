module SpeedTest(perf_test) where

import Data.Time.Clock.POSIX
import System.IO.Unsafe
import Control.DeepSeq

getCPUTimeMS = round `fmap` (fmap (* 1000) getPOSIXTime)

benchmark :: NFData a => a -> IO Integer
benchmark f = do
               start <- getCPUTimeMS
               end <- (f `deepseq` getCPUTimeMS)
               return (end - start)

perf_test :: NFData a => a -> Integer
perf_test func = (unsafePerformIO (benchmark func))

