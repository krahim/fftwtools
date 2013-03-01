#include<stdlib.h>
#include<complex.h>
#include <fftw3.h>
#include "fft.h"

#define N 8
#define M 2
#define NC (N/2+1)
int main(int argc, char* argv[]) {

   int i, j;
   int n[] = {N};
   int inembed[] = {N};
   int onembed[] = {NC};
   int stride=1;

   int rank=1, howmany=2;
   fftw_complex out[M][NC];
   double in[M][N];
   fftw_plan p;   
   double complex out2[M][NC];

   double complex a[N];
   double b[N];
   int n2=N, m2=M;
   int returnConj =0;

   //printf("%d  %d %lf %lf \n\n", sizeof(a), sizeof(b),
   //creal(a), cimag(a));
   
   //in =  (double*)fftw_malloc(sizeof(double) * N * m);
   
   //out = (fftw_complex*) fftw_malloc(sizeof(fftw_complex) * m * nc);
   //p = fftw_plan_dft_r2c_2d(m,  &in[0][0], &out[0][0], FFTW_MEASURE);
   
   for(j=0; j<M; j++) {
      for(i=0; i<N; i++) {
         in[j][i] = (double)(i+1);
         printf("%lf, j %d i %d\n", in[j][i],j,i);
      }
   }
   
   p = fftw_plan_many_dft_r2c(rank, &n[0], 
                                 howmany, &in[0][0], 
                                 &inembed[0], stride,
                                 N, &out[0][0],
                                 &onembed[0], stride,
                                 NC, FFTW_ESTIMATE);
   fftw_execute(p); 

   for(j=0; j<M; j++) {
      for(i=0; i<NC; i++) {
         printf("%lf + %lfi\n", creal(out[j][i]),
                cimag(out[j][i]));
      }
   }   
   fftw_destroy_plan(p);
   //free(in); 
   //fftw_free(out);

   mvfft_r2c(&n2, &m2, &in[0][0], &out2[0][0], &returnConj);


   for(j=0; j<M; j++) {
      for(i=0; i<NC; i++) {
         printf("out2 %lf + %lfi\n", creal(out2[j][i]),
                cimag(out2[j][i]));
      }
   }  
   for(i=0; i<N; i++) {
      b[i] = (double) (i+1);
   }

   
   fft_r2c(&n2, b, a, &returnConj);

   for(i=0; i<N; i++) {
      printf("%lf + %lfi\n", creal(a[i]),
             cimag(a[i]));
   }

   fft_c2r(&n2, a, b);

   for(i=0; i<N; i++) {
      printf("%lf\n", b[i]);
   }
   return(0);
}

