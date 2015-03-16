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

## correction
isEven <- 1 - (nRc %% 2)
idxRowAppend <- (nRc - isEven):2

## construct default 2d fft for comparison
fft2d <- function(X) {
    mvfft(t(mvfft(t(X))))
}


x1 = matrix(1:10, 5, 2)
y = fftw_r2c_2d(x)
nrow(x)==nrow(y)
##[1] FALSE
## this seems to be a real error

x2 = matrix(1:12, 6, 2)

xHalf <- fftw2d(x2, HermConj=0)


fft2d(x1)
fftw_c2c_2d(x1)
fftw_r2c_2d(x1) ## wrong
fftw_r2c_2d(x1, HermConj=0)

fft2d(x2)
fftw_c2c_2d(x2)
fftw_r2c_2d(x2) ## wrong
fftw_r2c_2d(x2, HermConj=0)

xComp = matrix(as.complex(1:10), 5, 2)
x2Comp = matrix(as.complex(1:12), 6, 2)

fftw2d(xComp)
fft2d(xComp)

fftw2d(x2Comp)
fft2d(x2Comp) ## seems good, it's just the real one that is the issue.

## example 
x=c(1, 2, 3, 9, 8, 5, 1, 2, 9, 8, 7, 2)
x= t(matrix(x, nrow=4))
mvfft(x)
t(mvfft(t(mvfft(x))))
fftw2d(x)
fftw2d(x, HermConj=0)

fftw2d(fftw2d(x), inverse=1)/12
fftw2d(fftw2d(t(x)), inverse=1)/12
fftw_r2c_2d(x)
fftw_r2c_2d(x, HermConj=0)

fft2d(x)  
fftw_r2c_2d(x) ## this one works


fftw_r2c_2d_raw(x1)
fftw_r2c_2d_raw(x2)

nRc_x1 <- floor(dim(x1)[1]/2) +1
nRc_x2 <- floor(dim(x2)[1]/2) +1

isEven <- 1 - nRc_x1 %% 2

idxRowAppend_x1 <- (nRc_x1 - (nRc_x1 %% 2)):2
idxRowAppend_x2 <- (nRc_x2 - (nRc_x2 %% 2)):2


## modified 
fftw_r2c_2d <- function(data, HermConj=1) {

    ## can be done with two mvfft's t(mvfft(t(mvfft(a))))
    ## == mvfft(t(mvfft(t(a))))

    data <- as.matrix(data)

    nR <- dim(data)[1]
    nC <- dim(data)[2]
    nRc <- floor(nR/2) +1
    
    isEven <- 1 - (nRc %% 2)
    idxRowAppend <- (nRc - isEven):2

    ##correct for the fact the c call is column-major

    out <- .C("fft_r2c_2d", as.integer(nC), as.integer(nR),
              as.double(data), res=matrix(as.complex(0), nRc , nC))

    res <- as.matrix(out$res)
    if(HermConj==1) {
        if(length(idxRowAppend) == 1) {
            ##if the number of rows to append is one, R
            ##will create a column vector for cbind unless
            ##we transpose.
            ## with the exception of the first row, the
            ## resulting matrix is Hermatian --conjugate symmetric
            res <- rbind(res, Conj(cbind(res[idxRowAppend,1],
                                         t(res[idxRowAppend,nC:2]))))
         } else {
             res <- rbind(res, Conj(cbind(res[idxRowAppend,1],
                                          res[idxRowAppend,nC:2])))
         }
    }
    
    return(res)
}
##generic 2d fft
fftw2d <- function(data, inverse=0, HermConj=1) {
    res <- NULL
    if(inverse==0) {
        if(!is.complex(data)) {
            res <- fftw_r2c_2d(data, HermConj=HermConj)
        } else {
            res <- fftw_c2c_2d(data, inverse=0)
        }
    } else {
        res <- fftw_c2c_2d(data, inverse=1)
    }
    return(res)
}

fft2d(x1)
fftw_c2c_2d(x1)
fftw_r2c_2d(x1) ## seems Right
fftw2d(x1)
fftw_r2c_2d(x1, HermConj=0)

fft2d(x2)
fftw_c2c_2d(x2)
fftw_r2c_2d(x2) ## Seems Right
fftw_r2c_2d(x2, HermConj=0)
