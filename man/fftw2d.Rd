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

\name{fftw2d}
\alias{fftw2d}
\alias{fftw_c2c_2d}
\alias{fftw_r2c_2d}
\alias{fftw_c2c_xd}
\title{Compute a two-dimensional FFT on a matrix using FFTW3}
\description{
  Computes two-dimensional FFT on a matrix using the FFTW3 libraries.
  Use fftw_r2c_2d(x, HermConj=0) for real to complex FFT. This will
  return the result without the "Hermitian" redundancy. These functions follow the R
  convention when returning the inverse of the FFT. For the two-dimension
  fft, the inverse is currently requires the entire matrix, including the
  redundant complex conjugate.

  The function \code{fftw_c2c_xd} can calculate a higher dimensional FFT on a higher dimensional array.
}
\usage{
fftw2d(data, inverse=0, HermConj=1)
fftw_r2c_2d(data, HermConj=1)
fftw_c2c_2d(data, inverse=0)
fftw_c2c_xd(data, inverse=0)
}
\arguments{
  \item{data}{(complex or real) matrix to be processed (or array for \code{fftw_c2c_xd})}
  \item{inverse}{(integer) 1 or 0 indicating if inverse FFT is
    preformed. The return follows the format of the R FFT commands--the
    output is not scaled.}
  \item{HermConj}{(integer) 1 or 0 indicating if either "Hermitian" redundant
    conjugate should be returned.}
}
\author{Karim Rahim and Ege Rubak}
\examples{
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

fftw_c2c_xd(x)
}
\keyword{fftw}
