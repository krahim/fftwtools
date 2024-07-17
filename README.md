[![](https://www.r-pkg.org/badges/version/badger?color=green)](https://cran.r-project.org/package=fftwtools)
[![](http://cranlogs.r-pkg.org/badges/grand-total/badger?color=green)](https://cran.r-project.org/package=fftwtools)
[![](http://cranlogs.r-pkg.org/badges/last-month/badger?color=green)](https://cran.r-project.org/package=fftwtools)
[![](http://cranlogs.r-pkg.org/badges/last-week/badger?color=green)](https://cran.r-project.org/package=fftwtools)


NOTE: FFTW **MUST** be installed on the build machine and fftw.h **must** be visible for this to work. 

NOTE to Maintainer (*me*): Update the version number in DESCRIPTION and configure.ac prior to uploading to CRAN. This must be done in two places.

 
I appreciate all contributions, pull requests, and help. I would like to keep this version ready to upload to CRAN. That means if a pull request does not pass R CMD check --as-cran with the latest version of R, I will only spend a short bit of time trying to debug it before removing it.

Please note that if the  --as-cran check generates a WARNING or a NOTE then it is not a clean pass, and it is not ready to upload to CRAN. If I cannot quickly debug the Warning or Note, then I will remove the change.

In general, I do not keep a seperate development version and changes are uploaded to CRAN once they are integrated. 


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
