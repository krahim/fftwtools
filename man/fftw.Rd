%     The fftwtools R package
%     fftw2d and general mvfftw tools in R
%     Copyright (C) 2013 Karim Rahim 
%
%     Written by Karim Rahim.
%
%     This file is part of the multitaper package for R.
%
%     The fftwtools package is free software: you can redistribute it and
%     or modify it under the terms of the GNU General Public License as 
%     published by the Free Software Foundation, either version 2 of the 
%     License, or any later version.
%
%     The multitaper package is distributed in the hope that it will be 
%     useful, but WITHOUT ANY WARRANTY; without even the implied warranty 
%     of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with multitaper.  If not, see <http://www.gnu.org/licenses/>.
%
%     If you wish to report bugs please contact the author. 
%     karim.rahim@gmail.com
%     Jeffery Hall, Queen's University, Kingston Ontario
%     Canada, K7L 3N6

\name{fftw}
\alias{fftw}
\alias{fftw_c2c}
\alias{fftw_r2c}
\alias{fftw_c2r}
\title{Compute fft using fftw3}
\description{
  Use  fftw_r2c(x, HermConj=0) for real to complex fft. This will
  return the result without the Hermitian conjugate. This follows the R
  convention for returning the inverse of the FFT. The function
  mvfftw_c2r(res, HermConj=0, n=length(x)) will invert the fft
  from the result not containing the Hermitian conjugate. You must
  specify, n, the dimension of the original data--length--if the Hermitian conjugate is not included. 

}
\usage{
fftw(data, inverse=0, HermConj=1, n=NULL)
fftw(data, inverse=0, HermConj=1, n=NULL)
fftw_r2c(data, HermConj=1)
fftw_c2c(data, inverse=0)
fftw_c2r(data, HermConj=1, n=NULL)
}
\arguments{
  \item{data}{(complex or real) vector to be processed}
  \item{inverse}{(integer) 1 or 0 indicating if inverse fft is
    preformed. The return follows the format of the R fft commands.}
  \item{HermConj}{(integer) 1 or 0 indicating if either Hermitian
    conjugate should be returned, or that the complex to real data
    includes the Hermitian
    conjugate.}
  \item{n}{(integer) column length of the original data set, when using
    the inverse coplex to real fft without providing the Hermitian
    conjugate.} 
}
\author{Karim Rahim}
\examples{
res <- fftw_r2c(1:9)
res
fftw_c2r(res)/9
res
fftw_c2r(res)/9

res <- fftw_r2c(1:10)
res
fftw_c2r(res)/10
res
fftw_c2r(res)/10

res <- fftw_r2c(1:9, HermConj=0)
res
fftw_c2r(res, HermConj=0, n=9)/9

res <- fftw_r2c(1:10, HermConj=0)
res
fftw_c2r(res, HermConj=0, n=10)/10

fftw_r2c(1:3)
fftw_c2r(fftw_r2c(1:3))/3
fftw_c2r(fftw_r2c(1:2))/2
fftw_c2r(fftw_r2c(1:4))/4


fftw_r2c(1:3, HermConj=1)
fftw_c2r(fftw_r2c(1:3, HermConj=0), HermConj=0, n=3)/3

fftw_c2r(fftw_r2c(1:4, HermConj=0), HermConj=0, n=4)/4
fftw_c2r(fftw_r2c(1:20, HermConj=0), HermConj=0, n=20)/20

}
\keyword{fftw}
