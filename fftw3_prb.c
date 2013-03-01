# include <stdlib.h>
# include <stdio.h>
# include <time.h>

# include <fftw3.h>

int main ( void );
void test01 ( void );
void test02 ( void );
double frand ( void );
void timestamp ( void );

/******************************************************************************/

int main ( void )

/******************************************************************************/
/*
  Purpose:

    FFTW3_PRB demonstrates the use of FFTW3.

  Modified:

    23 October 2005
*/
{
  timestamp ( );

  printf ( "\n" );
  printf ( "FFTW3_PRB\n" );
  printf ( "  Demonstrate the use of the C FFTW3 library.\n" );

  test01 ( );
  test02 ( );

  printf ( "\n" );
  printf ( "FFTW3_PRB\n" );
  printf ( "  Normal end of execution.\n" );
 
  printf ( "\n" );
  timestamp ( );

  return 0;
}
/******************************************************************************/

void test01 ( void )

/******************************************************************************/
/*
  Purpose:

    TEST01: complex 1D data.

  Modified:

    23 October 2005
*/
{
  int i;
  fftw_complex *in;
  fftw_complex *in2;
  int n = 100;
  fftw_complex *out;
  fftw_plan plan_backward;
  fftw_plan plan_forward;
  unsigned int seed = 123456789;

  printf ( "\n" );
  printf ( "TEST01\n" );
  printf ( "  Demonstrate FFTW3 on a single vector of complex data.\n" );
  printf ( "\n" );
  printf ( "  Transform data to FFT coefficients.\n" );
  printf ( "  Backtransform FFT coefficients to recover data.\n" );
  printf ( "  Compare recovered data to original data.\n" );

  in = fftw_malloc ( sizeof ( fftw_complex ) * n );
  out = fftw_malloc ( sizeof ( fftw_complex ) * n );
  in2 = fftw_malloc ( sizeof ( fftw_complex ) * n );

  plan_forward = fftw_plan_dft_1d ( n, in, out, FFTW_FORWARD, FFTW_ESTIMATE );

  plan_backward = fftw_plan_dft_1d ( n, out, in2, FFTW_BACKWARD, FFTW_ESTIMATE );

  srand ( seed );

  for ( i = 0; i < n; i++ )
  {
    in[i][0] = frand ( );
    in[i][1] = frand ( );
  }

  printf ( "\n" );
  printf ( "  Input Data:\n" );
  printf ( "\n" );

  for ( i = 0; i < n; i++ )
  {
    printf ( "  %3d  %12f  %12f\n", i, in[i][0], in[i][1] );
  }

  fftw_execute ( plan_forward );

  printf ( "\n" );
  printf ( "  Output FFT Coefficients:\n" );
  printf ( "\n" );

  for ( i = 0; i < n; i++ )
  {
    printf ( "  %3d  %12f  %12f\n", i, out[i][0], out[i][1] );
  }

  fftw_execute ( plan_backward );

  printf ( "\n" );
  printf ( "  Recovered input data:\n" );
  printf ( "\n" );

  for ( i = 0; i < n; i++ )
  {
    printf ( "  %3d  %12f  %12f\n", i, in2[i][0], in2[i][1] );
  }

  printf ( "\n" );
  printf ( "  Recovered input data divided by N:\n" );
  printf ( "\n" );

  for ( i = 0; i < n; i++ )
  {
    printf ( "  %3d  %12f  %12f\n", i, 
      in2[i][0] / ( double ) ( n ), in2[i][1] / ( double ) ( n ) );
  }

  fftw_destroy_plan ( plan_forward );
  fftw_destroy_plan ( plan_backward );

  fftw_free ( in );
  fftw_free ( in2 );
  fftw_free ( out );

  return;
}
/******************************************************************************/

void test02 ( void )

/******************************************************************************/
/*
  Purpose:

    TEST02: real 1D data.

  Modified:

    23 October 2005
*/
{
  int i;
  double *in;
  double *in2;
  int n = 100;
  int nc;
  fftw_complex *out;
  fftw_plan plan_backward;
  fftw_plan plan_forward;
  unsigned int seed = 123456789;

  printf ( "\n" );
  printf ( "TEST02\n" );
  printf ( "  Demonstrate FFTW3 on a single vector of real data.\n" );
  printf ( "\n" );
  printf ( "  Transform data to FFT coefficients.\n" );
  printf ( "  Backtransform FFT coefficients to recover data.\n" );
  printf ( "  Compare recovered data to original data.\n" );

  nc = ( n / 2 ) + 1;

  in = fftw_malloc ( sizeof ( double ) * n );
  out = fftw_malloc ( sizeof ( fftw_complex ) * nc );
  in2 = fftw_malloc ( sizeof ( double ) * n );

  plan_forward = fftw_plan_dft_r2c_1d ( n, in, out, FFTW_ESTIMATE );

  plan_backward = fftw_plan_dft_c2r_1d ( n, out, in2, FFTW_ESTIMATE );

  srand ( seed );

  for ( i = 0; i < n; i++ )
  {
    in[i] = frand ( );
  }

  printf ( "\n" );
  printf ( "  Input Data:\n" );
  printf ( "\n" );

  for ( i = 0; i < n; i++ )
  {
    printf ( "  %3d  %12f\n", i, in[i] );
  }


  fftw_execute ( plan_forward );

  printf ( "\n" );
  printf ( "  Output FFT Coefficients:\n" );
  printf ( "\n" );

  for ( i = 0; i < nc; i++ )
  {
    printf ( "  %3d  %12f  %12f\n", i, out[i][0], out[i][1] );
  }

  fftw_execute ( plan_backward );

  printf ( "\n" );
  printf ( "  Recovered input data:\n" );
  printf ( "\n" );

  for ( i = 0; i < n; i++ )
  {
    printf ( "  %3d  %12f\n", i, in2[i] );
  }

  printf ( "\n" );
  printf ( "  Recovered input data divided by N:\n" );
  printf ( "\n" );

  for ( i = 0; i < n; i++ )
  {
    printf ( "  %3d  %12f\n", i, in2[i] / ( double ) ( n ) );
  }

  fftw_destroy_plan ( plan_forward );
  fftw_destroy_plan ( plan_backward );

  fftw_free ( in );
  fftw_free ( in2 );
  fftw_free ( out );

  return;
}
//*****************************************************************************/

double frand ( void )

//*****************************************************************************/
/*
  Purpose:

    FRAND returns random values between 0 and 1.

  Discussion:

    The random seed can be set by a call to SRAND ( unsigned int ).

    Note that Kernighan and Ritchie suggest using

      ( ( double ) rand ( ) / ( RAND_MAX + 1 ) )

    but this seems to result in integer overflow for RAND_MAX + 1,
    resulting in negative values for the random numbers.

  Modified:

    23 October 2005

  Author:

    John Burkardt

  Reference:

    Brian Kernighan and Dennis Ritchie,
    The C Programming Language,
    Prentice Hall, 1988.

  Parameters:

    Output, double FRAND, a random value between 0 and 1.
*/
{
  double value;

  value = ( ( double ) rand ( ) / ( RAND_MAX ) );

  return value;
}
//*****************************************************************************/

void timestamp ( void )

/******************************************************************************/
/*
  Purpose:

    TIMESTAMP prints the current YMDHMS date as a time stamp.

  Example:

    31 May 2001 09:45:54 AM

  Modified:

    24 September 2003

  Author:

    John Burkardt

  Parameters:

    None
*/
{
# define TIME_SIZE 40

  static char time_buffer[TIME_SIZE];
  const struct tm *tm;
  size_t len;
  time_t now;

  now = time ( NULL );
  tm = localtime ( &now );

  len = strftime ( time_buffer, TIME_SIZE, "%d %B %Y %I:%M:%S %p", tm );

  printf ( "%s\n", time_buffer );

  return;
# undef TIME_SIZE
}
