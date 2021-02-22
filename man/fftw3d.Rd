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

\name{fftw3d}
\alias{fftw3d}
\alias{fftw_c2c_3d}
\alias{fftw_r2c_3d}
\title{Compute a two-dimensional FFT on a matrix using FFTW3}
\description{
Computes three-dimensional FFT on an array using the FFTW3 libraries.
Use fftw_r2c_3d(x, HermConj=0) for real to complex FFT. This will
return the result without the "Hermitian" redundancy. These functions follow the R
convention when returning the inverse of the FFT. For the two-dimension
fft, the inverse is currently requires the entire matrix, including the
redundant complex conjugate.
}
\usage{
fftw3d(data, inverse=0, HermConj=1)
fftw_r2c_3d(data, HermConj=1)
fftw_c2c_3d(data, inverse=0)
}
\arguments{
\item{data}{(complex or real) 3-dimensional array to be processed}
\item{inverse}{(integer) 1 or 0 indicating if inverse FFT is
preformed. The return follows the format of the R FFT commands--the
output is not scaled.}
\item{HermConj}{(integer) 1 or 0 indicating if either "Hermitian" redundant
conjugate should be returned.}
}
\author{Karim Rahim}
\examples{
x=c(1, 2, 3, 9, 8, 5, 1, 2, 9, 8, 7, 2)
x= array(x, dim=c(3,2,2))

fftw3d(x)
fftw3d(x, HermConj=0)

fftw3d(fftw3d(x), inverse=1)/12

fftw_r2c_3d(x)
fftw_r2c_3d(x, HermConj=0)
}
\keyword{fftw}
