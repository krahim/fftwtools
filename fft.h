#ifndef __FFT_H__
#define __FFT_H__

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
               double complex* res, int* fftwplanopt);

void mvfft_c2r(int *n, int *m, double complex* data,
               double* res, int* fftwplanopt);

void mvfft_c2c(int *n, int *m, double complex* data,
               double complex* res, int* inverse, int* fftwplanopt);

void fft_r2c_2d(int* nx, int* ny, double* data, double complex* res);

void fft_c2c_2d(int* nx, int* ny, double complex* data, 
                double complex* res, int* inverse);

#endif

