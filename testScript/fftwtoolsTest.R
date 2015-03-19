library("fftwtools")

fftw_r2c_2d_raw <- function(data) {

    ## can be done with two mvfft's t(mvfft(t(mvfft(a))))
    ## == mvfft(t(mvfft(t(a))))

    data <- as.matrix(data)

    nR <- dim(data)[1]
    nC <- dim(data)[2]
    nRc <- floor(nR/2) +1
    ##idxRowAppend <- (nRc - (nRc %% 2)):2

    ##correct for the fact the c call is column-major

    out <- .C("fft_r2c_2d", as.integer(nC), as.integer(nR),
              as.double(data), res=matrix(as.complex(0), nRc , nC))
    out$res
}


fft2d <- function(X) {
    mvfft(t(mvfft(t(X))))
}

x1 = matrix(1:10, 5, 2)
x2 = matrix(1:12, 6, 2)

x=c(1, 2, 3, 9, 8, 5, 1, 2, 9, 8, 7, 2)
x= t(matrix(x, nrow=4))

fftw_c2c_2d(fftw_c2c_2d(x), inverse=1)/12
fftw_c2c_2d(fftw_c2c_2d(x1), inverse=1)/10
fftw_c2c_2d(fftw_c2c_2d(x2), inverse=1)/12

fftw_c2c_2d(fftw_c2c_2d(t(x)), inverse=1)/12
fftw_c2c_2d(fftw_c2c_2d(t(x1)), inverse=1)/10
fftw_c2c_2d(fftw_c2c_2d(t(x2)), inverse=1)/12


fftw_c2c_2d(fftw_r2c_2d(x), inverse=1)/12
fftw_c2c_2d(fftw_r2c_2d(x1), inverse=1)/10
fftw_c2c_2d(fftw_r2c_2d(x2), inverse=1)/12

fftw_c2c_2d(fftw_r2c_2d(t(x)), inverse=1)/12
fftw_c2c_2d(fftw_r2c_2d(t(x1)), inverse=1)/10
fftw_c2c_2d(fftw_r2c_2d(t(x2)), inverse=1)/12


fftw_c2c_2d(x)
fftw_r2c_2d(x)
fftw_c2c_2d(t(x))
fftw_r2c_2d(t(x))

fftw_r2c_2d_raw (t(x))
res <- fftw_r2c_2d_raw (t(x))


fftw_c2c_2d(x1)
fftw_r2c_2d(x1)
fftw_c2c_2d(t(x1))
fftw_r2c_2d(t(x1))

fftw_c2c_2d(x2)
fftw_r2c_2d(x2)
fftw_c2c_2d(t(x2))
fftw_r2c_2d(t(x2))

## looks good but ....

## consider this mvfftw_r2c
mvfftw(x)
mvfftw_r2c(x)

mvfft(x1)
mvfftw_r2c(x1)
mvfft(x2)
mvfftw_r2c(x2)


## looks good March 17
