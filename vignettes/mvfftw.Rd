%     The fftwtools R package
%     fftw2d and general mvfftw tools in R
%     Copyright (C) 2013 Karim Rahim 
%
%     Written by Karim Rahim.
%
%     This file is part of the fftwtools package for R.
%
%     The fftwtools package is free software: you can redistribute it and
%     or modify it under the terms of the GNU General Public License as 
%     published by the Free Software Foundation, either version 2 of the 
%     License, or any later version.
%
%     The fftwtools package is distributed in the hope that it will be 
%     useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
%     of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with fftwtools.  If not, see <http://www.gnu.org/licenses/>.
%
%     If you wish to report bugs please contact the author. 
%     karim.rahim@gmail.com
%     Jeffery Hall, Queen's University, Kingston Ontario
%     Canada, K7L 3N6

\name{mvfftw}
\alias{mvfftw}
\alias{mvfftw_c2c}
\alias{mvfftw_r2c}
\alias{mvfftw_c2r}
\title{Compute the FFT on each column of a matrix using FFTW3}
\description{
  This will compute the FFT of each column of a matrix using the FFTW3 libraries.
  Use mvfftw_r2c(x, HermConj=0) for real to complex fft. This will
  return the result without the redundant complex conjugate. This follows the R
  convention for returning the unscaled inverse of the FFT. The function
  mvfftw_c2r(res, HermConj=0, n=dim(x)[1]) will invert the FFT
  from the result not containing the "Hermitian" redundant conjugate. You must
  specify, n, the column dimension of the original data--the column
  length of the original data--if the redundant complex conjugate is not included. 

}
\usage{
mvfftw(data, inverse=0, HermConj=1, n=NULL, fftplanopt=0)
mvfftw(data, inverse=0, HermConj=1, n=NULL, fftplanopt=0)
mvfftw_r2c(data, HermConj=1, fftplanopt=0)
mvfftw_c2c(data, inverse=0, fftplanopt=0)
mvfftw_c2r(data, HermConj=1, n=NULL, fftplanopt=0)
}
\arguments{
  \item{data}{(complex or real) matrix of columns to be processed}
  \item{inverse}{(integer) 1 or 0 indicating if inverse fft is
    preformed. The return follows the format of the R FFT commands. The
    result is not scaled.}
  \item{HermConj}{(integer) 1 or 0 indicating if either "Hermitian" redundant
    conjugate should be returned, or that the complex to real data
    includes the "Hermitian" redundant
    conjugate.}
  \item{n}{(integer) column length of the original data set, when using
    the inverse coplex to real fft without providing the "Hermitian" redundant
    conjugate.}
  \item{fftplanopt}{(integer) 0 or 1 specifying the flag passed to
    FFTW. 0 indicates the flag FFTW_ESTIMATE is used, and 1 indicates
    FFTW_MEASURE is used. See FFTW documentation for use of these flags.
  }
}
\author{Karim Rahim}
\examples{
x=c(1, 2, 3, 9, 8, 5, 1, 2, 9, 8, 7, 2)
x= t(matrix(x, nrow=4))
mvfft(x)
t(mvfft(t(mvfft(x))))

res <- mvfftw_r2c(x, HermConj=1)
res
mvfftw_c2c(res, inverse=1)/3
mvfftw_c2r(res)/3

res <- mvfftw_r2c(x, HermConj=0)
res
mvfftw_c2r(res, HermConj=0, n=3)/3


mvfftw_r2c(x, HermConj=1)
mvfft(x)
res <- mvfftw_r2c(x, HermConj=0)
res
mvfftw_c2r(res, HermConj=0, n=3)/3

res <- mvfftw_r2c(t(x), HermConj=1)
res
mvfftw_c2r(res, HermConj=1)/4
res <- mvfftw_r2c(t(x), HermConj=0)
res
mvfftw_c2r(res, HermConj=0, n=4)/4


mvfftw_r2c(t(x), HermConj=1)
mvfft(t(x))

mvfftw(mvfftw(x, HermConj=0), inverse=1, HermConj=0, n=3)/3
mvfftw(mvfftw(t(x), HermConj=0), inverse=1, HermConj=0, n=4)/4
mvfftw(mvfftw(t(x), inverse=1))/4
}
\keyword{fftw}
