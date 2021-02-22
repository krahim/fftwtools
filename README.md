[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/fftwtools)](https://cran.r-project.org/package=fftwtools)

NOTE: 
I appreciate all contributions, pull requests, and help. I would like to keep this version ready to upload to CRAN. That means if a pull request does not pass R CMD check --as-cran with the latest version of R, I will only spend a short bit of time trying to debug it before removing it.

Please note that if the  --as-cran check generates a WARNING or a NOTE then it is not a clean pass, and it is not ready to upload to CRAN. If I cannot quickly debug the Warning or Note, then I will remove the change.

fftwtools
=========

R package wrapping fftw. It has 1d, 2d, 3d, multivariate fftw, and other tools.

Alternative manual build instructions for general Linux machine:

1) download and unzip to a folder called fftwtools-master
2) from the parent folder:
    1.  R CMD build fftwtools-master/ 
    2.  R CMD check fftwtools_*.tar.gz (optional)
    3.  R CMD INSTALL fftwtools_*.tar.gz 

Note: The version number will change. Compiling this from source will require a C compiler [I used gcc], math library, and fftw development libraries installed. 

See the folder speedTrials for an example of testing for which data length fftw is generally faster. On my laptop I found fftw faster at approximately >= 2^17 data points, and mvfftw faster at approximately >= 2^16 data points using five columns of data.

You can use fftw directly if your OS does not provide it as a package.
http://www.fftw.org/

Note: Windows users please see: 
https://cran.r-project.org/bin/windows/Rtools/

Mac users please see: 
https://mac.r-project.org/tools/
