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

\name{fftw}
\alias{fftw}
\alias{fftw_c2c}
\alias{fftw_r2c}
\alias{fftw_c2r}
\title{Compute fft using fftw3}
\description{
  These functions compute the FFT using the FFTW3 libraries.
  Use fftw_r2c(x, HermConj=0) for real to complex fft. This will
  return the result without the redundant complex conjugate. This follows the R
  convention for returning the unscaled inverse of the FFT. The function
  fftw_c2r(res, HermConj=0, n=length(x)) will invert the FFT
  from the result not containing the redundant complex conjugate. You must
  specify, n, the dimension of the original data--length--if the
  redundant complex conjugate is not included. 

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
  \item{inverse}{(integer) 1 or 0 indicating if inverse FFT is
    preformed. The return follows the format of the R FFT commands--the
    output is not scaled.}
  \item{HermConj}{(integer) 1 or 0 indicating if either "Hermitian" redundant 
    conjugate should be returned, or that the complex to real data
    includes the "Hermitian" redundant
    conjugate.}
  \item{n}{(integer) column length of the original data set. This is required when using
    the inverse complex to real FFT without providing the "Hermitian" redundant
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
