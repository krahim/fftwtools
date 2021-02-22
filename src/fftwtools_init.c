#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .C calls */
extern void cfft_c2c(void *, void *, void *, void *);
extern void cfft_c2c_2d(void *, void *, void *, void *, void *);
extern void cfft_c2c_3d(void *, void *, void *, void *, void *, void *);
extern void cfft_c2c_xd(void *, void *, void *, void *, void *);
extern void cfft_c2r(void *, void *, void *);
extern void cfft_r2c(void *, void *, void *, void *);
extern void cfft_r2c_2d(void *, void *, void *, void *);
extern void cfft_r2c_3d(void *, void *, void *, void *, void *);
extern void cmvfft_c2c(void *, void *, void *, void *, void *, void *);
extern void cmvfft_c2r(void *, void *, void *, void *, void *);
extern void cmvfft_r2c(void *, void *, void *, void *, void *);

static const R_CMethodDef CEntries[] = {
    {"cfft_c2c",    (DL_FUNC) &cfft_c2c,    4},
    {"cfft_c2c_2d", (DL_FUNC) &cfft_c2c_2d, 5},
    {"cfft_c2c_3d", (DL_FUNC) &cfft_c2c_3d, 6},
    {"cfft_c2c_xd", (DL_FUNC) &cfft_c2c_xd, 5},
    {"cfft_c2r",    (DL_FUNC) &cfft_c2r,    3},
    {"cfft_r2c",    (DL_FUNC) &cfft_r2c,    4},
    {"cfft_r2c_2d", (DL_FUNC) &cfft_r2c_2d, 4},
    {"cfft_r2c_3d", (DL_FUNC) &cfft_r2c_3d, 5},
    {"cmvfft_c2c",  (DL_FUNC) &cmvfft_c2c,  6},
    {"cmvfft_c2r",  (DL_FUNC) &cmvfft_c2r,  5},
    {"cmvfft_r2c",  (DL_FUNC) &cmvfft_r2c,  5},
    {NULL, NULL, 0}
};

void R_init_fftwtools(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, NULL, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}

