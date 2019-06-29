/*

power_spectrum_plot.ijm

2019-06-29
Wayne rasband creditied Michael Schmid for this

This macro demonstrates how to use the Array.fourier()
function, which is available in ImageJ 1.49i or later.

Array.fourier() calculates the Fourier amplitudes of an array,
based on a 1D Fast Hartley Transform. With no Window function and
the array size is a power of 2, the input function should be either
periodic or the data at the beginning and end of the array should
approach the same value (the periodic continuation should be smooth).
With no Window function and the array size is not a power of 2, the
data should decay towards 0 at the beginning and end of the array.
For data that do not fulfill these conditions, a window function can be
used to avoid artifacts from the edges. See
http://en.wikipedia.org/wiki/Window_function.

Supported window functions: "Hamming", "Hann" ("raised cosine") or
"flat-top". Flat-top refers to the HFT70 function in the report cited below,
it is named for its response in the frequency domain: a single-frequency
sinewave becomes a peak with a short plateau of 3 roughly equal Fourier
amplitudes. It is optimized for measuring amplitudes of signals with
well-separated sharp frequencies. All window functions will reduce the
frequency resolution; this is especially pronounced for the flat-top window.

Normalization is done such that the peak height in the Fourier transform
(roughly) corresponds to the RMS amplitude of a sinewave (i.e., amplitude/sqrt(2)),
and the first Fourier amplitude corresponds to DC component (average value
of the data). If the sine frequency falls between two discrete frequencies of
the Fourier transform, peak heights can deviate from the true RMS amplitude
by up to approx. 36, 18, 15, and 0.1% for no window function, Hamming,
Hann and flat-top window functions, respectively. When calculating the power
spectrum from the square of the output, note that the result is quantitative
only if the input array size is a power of 2; then the spectral density of the
power spectrum must be divided by 1.3628 for the Hamming, 1.5 for the
Hann, and 3.4129 for the flat-top window.

For more details about window functions, see:
G. Heinzel, A. Rdiger, and R. Schilling
Spectrum and spectral density estimation by the discrete Fourier transform (DFT),
including a comprehensive list of window functions and some new flat-top windows.
Technical Report, MPI f. Gravitationsphysik, Hannover, 2002; http://edoc.mpg.de/395068

The array returned is the RMS amplitudes for each frequency. The size 
of the returned array is half the size of the 2^n-sized array used
for the FHT; array element [0] corresponds to frequency zero
(the "DC component"). The first nonexisting array element,
result[result.length] would correspond to a frequency of 1 cycle
per 2 input points, i.e., the Nyquist frequency. In other words,
if the spacing of the input data points is dx, results[i] corresponds
to a frequency of i/(2*results.length*dx).
*/

  requires("1.49i");
  len=510;
  frequ=155.3;       //cycles per array length
  ampl=10*sqrt(2);   //amplitude of sinewave
  dcoffset=3;        //DC offset
  windowType="None"; //None, Hamming, Hann or Flattop

  x = newArray(len);
  a = newArray(len);
  phase = random()*2*PI;
  sum = 0;
  for (i=0; i<len; i++) {
    x[i] = i;
    a[i] = dcoffset+ampl*sin(2*PI*frequ*i/len+phase);
    sum += a[i];
  }
  Plot.create("Input function", "x", "value", x, a);
  Plot.show();

  //y = Array.fourier(a, windowType);
  y = Array.fourier(a);
  f = newArray(lengthOf(y));
  for (i=0; i<lengthOf(y); i++)
    f[i] = i;
  Plot.create("Fourier amplitudes: "+windowType, "frequency bin", "amplitude (RMS)", f, y);
  Plot.show();

  fhtSize = 2*lengthOf(y);
  peakF = frequ/len*fhtSize; // i.e., frequ/len = peakF/fhtSize
  print("WANTED: a="+(ampl/sqrt(2))+" @f="+peakF+" offset near "+(sum/len)+" to "+dcoffset);