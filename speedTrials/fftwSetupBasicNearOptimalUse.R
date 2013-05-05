library("fftwtools")

## in my laptop this seems decent.


useFFTWGE <- 2^17 ## about 13 thousand values with padding.
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
    if(dim(z)[1] >= useFFTWGE) {
        fftwtools::mvfftw(z, inverse=inverse)
    } else {
        stats::mvfft(z, inverse=inverse)
    }
}
