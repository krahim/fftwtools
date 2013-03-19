/* ##     The fftwtools R package */
/* ##     fftw2d and general mvfftw tools in R */
/* ##     Copyright (C) 2013 Karim Rahim  */

/* ##     This file is part of the fftwtools package for R. */

/* ##     The fftwtools package is free software: you can redistribute it and */
/* ##     /or modify */
/* ##     it under the terms of the GNU General Public License as published by */
/* ##     the Free Software Foundation, either version 2 of the License, or */
/* ##     any later version. */

/* ##     The fftwtools package is distributed in the hope that it will be  */
/* ##     useful, but WITHOUT ANY WARRANTY; without even the implied warranty  */
/* ##     of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/* ##     GNU General Public License for more details. */

/* ##     You should have received a copy of the GNU General Public License */
/* ##     along with Foobar.  If not, see <http://www.gnu.org/licenses/>. */

/* ##     If you wish to report bugs please contact the author.  */
/* ##     karim.rahim@gmail.com */
/* ##     Jeffery Hall, Queen's University, Kingston Ontario */
/* ##     Canada, K7L 3N6 */

#ifndef __FFTWTOOLS_H__
#define __FFTWTOOLS_H__

/* real to complex forward */
void fft_r2c(int* n, double* data, 
              double complex* res, int* retHermConj);

/* complex to real backward */
void fft_c2r(int* n, double complex* data, 
             double* res);

/* complex to complex --eitherway */
void fft_c2c(int* n, double complex* data, 
             double complex* res, int* inverse);

void mvfft_r2c(int *n, int *m, double* data,
               double complex* res, 
               int* fftwplanopt);

void mvfft_c2r(int *n, int *m, double complex* data,
               double* res, int* fftwplanopt);

void mvfft_c2c(int *n, int *m, double complex* data,
               double complex* res, int* inverse, int* fftwplanopt);

void fft_r2c_2d(int* nx, int* ny, double* data, double complex* res);

void fft_c2c_2d(int* nx, int* ny, double complex* data, 
                double complex* res, int* inverse);

#endif

