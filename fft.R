dyn.load(paste("~/PWLisp/fft/fft", .Platform$dynlib.ext, sep=""))

##generic function to call fftw3 
fftw <- function(data, inverse=0) {
    res <- NULL
    if(inverse==0) {
        if(!is.complex(data)) {
            res <- fft_r2c(data, returnHermConj=1)
        } else {
            res <- fft_c2c(data, inverse=0)
        }
    } else {
        res <- fft_c2c(data, inverse=1)
    }
    return(res)
}

##generic 2d fft
fftw2d <- function(data, inverse=0) {
    res <- NULL
    if(inverse==0) {
        if(!is.complex(data)) {
            res <- fft_r2c_2d(data, returnHermConj=1)
        } else {
            res <- fft_c2c_2d(data, inverse=0)
        }
    } else {
        res <- fft_c2c_2d(data, inverse=1)
    }
    return(res)
}

##generic function to call multicol fftw3
mvfftw <- function(data, inverse=0, fftplanopt=0) {
    res <- NULL
    if(inverse==0) {
        if(!is.complex(data)) {
            res <- mvfft_r2c(data, returnHermConj=1, fftplanopt)
        } else {
            res <- mvfft_c2c(data, inverse=0, fftplanopt)
        }
    } else {
        res <- mvfft_c2c(data, inverse=1, fftplanopt)
    }
    return(res)
}


fft_r2c <- function(data, returnHermConj=1) {

    n <- length(data)

    nc <- NULL
    if(returnHermConj ==1) {
        nc <-  n
    } else {
        nc <- n/2 +1
    }    

    out <- .C("fft_r2c", as.integer(n), as.double(data),
              res=complex(nc),
              as.integer(returnHermConj))
    return(out$res)
}


fft_c2r <- function(data, includesHermConj=1) {

    len <- length(data)
    n <-  if(includesHermConj==0) (len-1)*2 else len        
    
    out <- .C("fft_c2r", as.integer(n), as.complex(data),
              res=double(n))
    
    return(out$res)
}


fft_c2c <- function(data, inverse=0) {

    n <- length(data)
    
    out <- .C("fft_c2c", as.integer(n), as.complex(data),
              res=complex(n), as.integer(inverse))
    
    return(out$res)
}

mvfft_r2c <- function(data, returnHermConj=1, fftplanopt=0) {

    data <- as.matrix(data)
    n <- length(data[,1])
    m <- length(data[1,])

    nc <- n/2 +1
    
    out <- .C("mvfft_r2c", as.integer(n), as.integer(m),
              as.double(data),
              res=matrix(as.complex(0), nc, m), as.integer(fftplanopt))

    ## these can be moved to C
    res <- as.matrix(out$res)
    if(returnHermConj==1) {
        res <- rbind(res, Conj(res[(nc-1):2,]))
    }

    return(res)
}


mvfft_c2r <- function(data, includesHermConj=1, fftplanopt=0) {

    data <- as.matrix(data)
    n <- length(data[,1])
    m <- length(data[1,])
    nc <-  NULL

    if(includesHermConj==1) {
        nc <- n/2 +1
    } else {
        nc <- n
        n <- (n-1)*2
    }
    
    out <- .C("mvfft_c2r", as.integer(n), as.integer(m),
              as.complex(data[1:nc,]),
              res=matrix(as.double(0), n, m), as.integer(fftplanopt))

    return(out$res)
}

mvfft_c2c <- function(data, inverse=0, fftplanopt=0) {

    data <- as.matrix(data)
    n <- length(data[,1])
    m <- length(data[1,])
    
    out <- .C("mvfft_c2c", as.integer(n), as.integer(m),
              as.complex(data),
              res=matrix(as.complex(0), n, m),
              as.integer(inverse), as.integer(fftplanopt))
    
    return(out$res)
}

fft_r2c_2d <- function(data, returnHermConj=1) {

    ## can be done with two mvfft's t(mvfft(t(mvfft(a))))
    ## == mvfft(t(mvfft(t(a))))

    data <- as.matrix(data)

    nR <- length(data[,1])
    nC <- length(data[1,])
    nRc <- floor(nR/2) +1
    idxRowAppend <- (nRc - (nRc %% 2)):2

    ##we correct for the fact the c call is column-major

    out <- .C("fft_r2c_2d", as.integer(nC), as.integer(nR),
              as.double(data), res=matrix(as.complex(0), nRc , nC))

    res <- as.matrix(out$res)
    if(returnHermConj==1) {
        if(length(idxRowAppend) == 1) {
            ##if the number of rows to append is one, R
            ##will create a column vector for cbind unless
            ##we transpose.
            res <- rbind(res, Conj(cbind(res[idxRowAppend,1],
                                         t(res[idxRowAppend,nC:2]))))
         } else {
             res <- rbind(res, Conj(cbind(res[idxRowAppend,1],
                                          res[idxRowAppend,nC:2])))
         }
    }
    
    return(res)
}

fft_c2c_2d <- function(data, inverse=0) {

    ## can be done with two mvfft's t(mvfft(t(mvfft(a))))
    ## == mvfft(t(mvfft(t(a))))

    data <- as.matrix(data)

    nR <- length(data[,1])
    nC <- length(data[1,])

    ##we correct for the fact the c call is column-major

    out <- .C("fft_c2c_2d", as.integer(nC), as.integer(nR),
              as.complex(data),
              res=matrix(as.complex(0), nR , nC),
              as.integer(inverse))

    return(out$res)
}
