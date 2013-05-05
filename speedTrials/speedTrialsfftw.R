rm(list=ls())

library("fftwtools")

## we try power of 2 but we can try other values
## we do ffts of 2^20 points

## reduced to 2^8 for package distribution.

fftLength <- 2^(seq(9,20,1))
resFFT <- array(NA, dim=c(12,5))
resFFTW <- array(NA, dim=c(12,5))
resFFTWnoH <- array(NA, dim=c(12,5))
## quick and dirty test for where fftw gets faster

for( j in 1:12) {
    n <- fftLength[j]
    
    set.seed(10)

    g <- rnorm(n)


    ##timing # Start the clock!
    ptm <- proc.time()

    ##Loop through 
    for (i in 1:100){
        stats::fft(g)
    }

    ## Stop the clock
    resFFT[j,] <- proc.time() - ptm



    ##timing # Start the clock!
    ptm <- proc.time()

    ##Loop through 
    for (i in 1:100){
        fftwtools::fftw(g)
    }

    ## Stop the clock
    resFFTW[j,] <- proc.time() - ptm

        ##timing # Start the clock!
    ptm <- proc.time()

    ##Loop through 
    for (i in 1:100){
        fftwtools::fftw(g, HermConj=FALSE)
    }

    ## Stop the clock
    resFFTWnoH[j,] <- proc.time() - ptm
}

resFFT
resFFTW
resFFTWnoH

## fftw seems faster >= 17


## try mvfft
fftLength <- 2^(seq(13,18,1))
resFFT <- array(NA, dim=c(6,5))
resFFTW <- array(NA, dim=c(6,5))
resFFTWnoH <- array(NA, dim=c(6,5))
## quick and dirty test for where fftw gets faster
ncol <- 10

for( j in 1:6) {
    n <- fftLength[j]
    
    set.seed(10)

    g <- rnorm(n*ncol)
    g <- matrix(g, ncol=ncol)
    


    ##timing # Start the clock!
    ptm <- proc.time()

    ##Loop through 
    for (i in 1:10){
        stats::mvfft(g)
    }

    ## Stop the clock
    resFFT[j,] <- proc.time() - ptm



    ##timing # Start the clock!
    ptm <- proc.time()

    ##Loop through 
    for (i in 1:10){
        fftwtools::mvfftw(g)
    }

    ## Stop the clock
    resFFTW[j,] <- proc.time() - ptm

        ##timing # Start the clock!
    ptm <- proc.time()

    ##Loop through 
    for (i in 1:10){
        fftwtools::mvfftw(g, HermConj=FALSE)
    }

    ## Stop the clock
    resFFTWnoH[j,] <- proc.time() - ptm
}


resFFT
resFFTW
resFFTWnoH

## mvfftw seems faster >= 2^16 with 10 cols of data


## try again with 5 cols of data
fftLength <- 2^(seq(13,18,1))
resFFT <- array(NA, dim=c(6,5))
resFFTW <- array(NA, dim=c(6,5))
resFFTWnoH <- array(NA, dim=c(6,5))
## quick and dirty test for where fftw gets faster
ncol <- 5

for( j in 1:6) {
    n <- fftLength[j]
    
    set.seed(10)

    g <- rnorm(n*ncol)
    g <- matrix(g, ncol=ncol)
    


    ##timing # Start the clock!
    ptm <- proc.time()

    ##Loop through 
    for (i in 1:10){
        stats::mvfft(g)
    }

    ## Stop the clock
    resFFT[j,] <- proc.time() - ptm



    ##timing # Start the clock!
    ptm <- proc.time()

    ##Loop through 
    for (i in 1:10){
        fftwtools::mvfftw(g)
    }

    ## Stop the clock
    resFFTW[j,] <- proc.time() - ptm

        ##timing # Start the clock!
    ptm <- proc.time()

    ##Loop through 
    for (i in 1:10){
        fftwtools::mvfftw(g, HermConj=FALSE)
    }

    ## Stop the clock
    resFFTWnoH[j,] <- proc.time() - ptm
}


resFFT
resFFTW
resFFTWnoH

## mvfftw seems faster >= 2^16 with 5 cols of data


##Suggestions:

useFFTWGE <- 2^17
useMVFFTWGE <- 2^16 ## based on two tests, of 5 and 10 columns of data

fft <- function(z, inverse = FALSE) {
    if(length(z) >= useFFTWGE) {
        fftwtools::fftw(z, inverse=inverse)
    } else {
        stats::fft(z, inverse=inverse)
    }
}

## do the same for now
mvfft <- function(z, inverse=FALSE) {
    if(dim(z)[1] >= useMVFFTWGE) {
        fftwtools::mvfftw(z, inverse=inverse)
    } else {
        stats::mvfft(z, inverse=inverse)
    }
}
rm(fft, mvfft)
