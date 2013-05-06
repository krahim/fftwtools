library("multitaper")
library("fftwtools")
library("rbenchmark")

## with 1 million data points we are seeing fftw
## work in a little over half the time.
dat <-  rnorm(10^6)


benchmark(res <-  spec.mtm(dat, nw=4, k=7, dT=1, plot=FALSE),
          replications=2)
##  elapsed relative user.self sys.self user.child sys.child
## 1   39.55        1    37.906    1.516          0         0

source("fftwSetupBasicNearOptimalUse.R")

benchmark(res <-  spec.mtm(dat, nw=4, k=7, dT=1, plot=FALSE),
          replications=2)
##   elapsed relative user.self sys.self user.child sys.child
## 1    21.2        1    17.785     3.32          0         0


source("restoreStandardfft.R")

## with 1 hundred thousand data points we are seeing
## fftw take about 65% of the time.
dat <-  rnorm(10^5)


benchmark(res <-  spec.mtm(dat, nw=4, k=7, dT=1, plot=FALSE),
          replications=10)
##   elapsed relative user.self sys.self user.child sys.child
## 1   15.41        1    15.285    0.076          0         0



source("fftwSetupBasicNearOptimalUse.R")

benchmark(res <-  spec.mtm(dat, nw=4, k=7, dT=1, plot=FALSE),
          replications=10)

##   elapsed relative user.self sys.self user.child sys.child
## 1  10.084        1    10.061        0          0         0



source("restoreStandardfft.R")
