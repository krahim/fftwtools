fftwtools
=========

R package, implementing of fftw 2d, multivariate fftw, and other fftw tools.

Build instructions for general Linux machine.

1) download and unzip to a folder called multitaper-master 2) from the parent folder: a) R CMD build fftwtools-master/ b) R CMD check fftwtools_0.9-3.tar.gz (optional) c) R CMD INSTALL fftwtools_0.9-3.tar.gz 

Note: The version number may change, and you will likely have to set the PATH variable for other operating systems. This will require gfortran, and fftw libraries installed. Please see the document ion for your Linux distribution, Fink for Mac, or Rtools, maintained by Duncan Murdoch, on CRAN for Windows. You will need to ensure you properly install fftw and link files accordingly. 

See the folder speedTrials to see an example of testing for whic data length fftw is generally faster. On my laptop I found fftw faster at >= 2^17 data points, and mvfftw faster at >= 2^16 data points using five columns of data.

