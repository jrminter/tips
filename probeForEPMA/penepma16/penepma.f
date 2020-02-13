C  ****  Files included to simplify compilation.
      INCLUDE 'penelope.f'
      INCLUDE 'rita.f'
      INCLUDE 'pengeom.f'
      INCLUDE 'penvared.f'
      INCLUDE 'timer.f'

CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C                                                                      C
C        PPPPP   EEEEEE  N    N  EEEEEE  PPPPP   M    M    AA          C
C        P    P  E       NN   N  E       P    P  MM  MM   A  A         C
C        P    P  E       N N  N  E       P    P  M MM M  A    A        C
C        PPPPP   EEEE    N  N N  EEEE    PPPPP   M    M  AAAAAA        C
C        P       E       N   NN  E       P       M    M  A    A        C
C        P       EEEEEE  N    N  EEEEEE  P       M    M  A    A        C
C                                                                      C
C                                                   (version 2016).    C
C                                                                      C
C  This program performs Monte Carlo simulation of electron-probe      C
C  microanalysis (EPMA) and x-ray fluorescence measurements, i.e.,     C
C  of x-ray emission from targets irradiated by electron or x-ray      C
C  beams. The geometry of the sample is described by means of the      C
C  quadric geometry package 'PENGEOM.F'.                               C
C                                                                      C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C                                                                      C
C  PENELOPE/PENGEOM (version 2014)                                     C
C  Copyright (c) 2001-2014                                             C
C  Universitat de Barcelona                                            C
C                                                                      C
C  Permission to use, copy, modify, distribute and sell this software  C
C  and its documentation for any purpose is hereby granted without     C
C  fee, provided that the above copyright notice appears in all        C
C  copies and that both that copyright notice and this permission      C
C  notice appear in all supporting documentation. The Universitat de   C
C  Barcelona makes no representations about the suitability of this    C
C  software for any purpose. It is provided 'as is' without express    C
C  or implied warranty.                                                C
C                                                                      C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
C  >>>>>>>> NOTE: All energies and lengths are given in eV and cm,
C                 respectively.
C
C
C  ************  Structure of the input data file.
C
C  Each line in the input data file consists of a 6-character keyword
C  (columns 1-6) followed either by numerical data (in free format) or
C  by a character string, which start at the 8th column. Keywords are
C  explicitly used/verified by the program (which is case sensitive!).
C  Notice also that the order of the data lines is important. The
C  keyword '______' (6 blanks) indicates comment lines, these can be
C  placed anywhere in the input file. The program ignores any text
C  following the first blank after the last numerical datum, or after
C  the character string, in each line (thus, in the table given below,
C  the comments in square brackets are ignored by the program). Lines
C  with some keywords (e.g., 'PDANGL', 'PDENER') can appear an arbitrary
C  number of times, limited only by the allocated amount of memory.
C
C  The program assigns default values to many input variables; lines
C  that declare default values may be eliminated from the input file.
C
C
C  The structure of the input file is the following,
C
C  ....+....1....+....2....+....3....+....4....+....5....+....6....+....
C  TITLE  Title of the job, up to 120 characters.
C         . (the dot prevents editors from removing trailing blanks)
C         >>>>>>>> Incident beam definition.
C  SKPAR  KPARP    [Primary particles: 1=electron, 2=photon, 3=positron]
C  SENERG SE0                              [Energy of the incident beam]
C  SPECTR Ei,Pi                 [E bin: lower-end and total probability]
C  SPOSIT SX0,SY0,SZ0                 [Coordinates of the source center]
C  SRADI  SRAD                               [Radius of the beam, in cm]
C  SDIREC STHETA,SPHI        [Direction angles of the beam axis, in deg]
C  SAPERT SALPHA                                 [Beam aperture, in deg]
C         .
C         >>>>>>>> Material data and simulation parameters.
C                  Up to 10 materials; 2 lines for each material.
C  MFNAME mat-filename.ext               [Material file, up to 20 chars]
C  MSIMPA EABS(1:3),C1,C2,WCC,WCR              [EABS(1:3),C1,C2,WCC,WCR]
C         .
C         >>>>>>>> Geometry of the sample.
C  GEOMFN geo-filename.ext          [Geometry definition file, 20 chars]
C  DSMAX  KB,DSMAX(KB)         [KB, maximum step length (cm) in body KB]
C         .
C         >>>>>>>> Interaction forcing.
C  IFORCE KB,KPAR,ICOL,FORCER,WLOW,WHIG  [KB,KPAR,ICOL,FORCER,WLOW,WHIG]
C         .
C         >>>>>>>> Bremsstrahlung splitting.
C  IBRSPL KB,IBRSPL                                [KB,splitting factor]
C         .
C         >>>>>>>> X-ray splitting.
C  IXRSPL KB,IXRSPL                                [KB,splitting factor]
C         .
C         >>>>>>>> Emerging particles. Energy and angular distributions.
C  NBE    EL,EU,NBE                  [E-interval and no. of energy bins]
C  NBANGL NBTH,NBPH          [Nos. of bins for the angles THETA and PHI]
C         .
C         >>>>>>>> Photon detectors (up to 25 different detectors).
C         IPSF=0, the psf is not created.
C         IPSF=1, a psf is created.
C         IPSF>1, a psf is created, but contains only state variables
C                 of detected photons that have ILB(4)=IPSF (used for
C                 studying angular distributions of x rays).
C  PDANGL THETA1,THETA2,PHI1,PHI2,IPSF    [Angular window, in deg, IPSF]
C  PDENER EDEL,EDEU,NCHE                [Energy window, no. of channels]
C  XRORIG pe-emission-01.dat  [Map of emission sites of detected x-rays]
C         .
C         >>>>>>>> Spatial distribution of events in a box.
C  GRIDX  XL,XU,NBX          [X coords of the box vertices, no. of bins]
C  GRIDY  YL,YU,NBY          [Y coords of the box vertices, no. of bins]
C  GRIDZ  ZL,ZU,NBZ          [Z coords of the box vertices, no. of bins]
C  XRAYE  EMIN,EMAX            [Energy interval where x rays are mapped]
C  XRLINE IZS1S200                    [X-ray line, IZ*1e6+S1*1e4+S2*1e2]
C         .
C         >>>>>>>> Job properties.
C  RESUME dump1.dat               [Resume from this dump file, 20 chars]
C  DUMPTO dump2.dat                  [Generate this dump file, 20 chars]
C  DUMPP  DUMPP                                 [Dumping period, in sec]
C         .
C  RSEED  ISEED1,ISEED2           [Seeds of the random-number generator]
C  REFLIN IZS1S200,IDET,TOL    [IZ*1e6+S1*1e4+S2*1e2,detector,tolerance]
C  NSIMSH DSHN                     [Desired number of simulated showers]
C  TIME   TIMEA                       [Allotted simulation time, in sec]
C  ....+....1....+....2....+....3....+....4....+....5....+....6....+....
C
C
C  The following listing describes the function of each of the keywords,
C  the accompanying data and their default values. For clarity, blanks
C  in keywords are indicated as '_'.
C
C  TITLE_ : Title of the job (up to 120 characters).
C             DEFAULT: none (the input file must start with this line)
C
C           The TITLE string is used to mark dump files. To prevent the
C           improper use of wrong resuming files, change the title each
C           time you modify basic parameters of your problem. The code
C           will then be able to identify the inconsistency and to print
C           an error message before stopping.
C
C  >>>>>>>> Incident beam definition.
C
C  SKPAR_ : Type of primary particle KPARP (1=electrons, 2=photons or
C           3=positrons).
C             DEFAULT: KPARP=1
C
C  SENERG : For a monoenergetic source, initial energy SE0 of primary
C           particles.
C             DEFAULT: SE0=1.0E6
C
C  SPECTR : For a source with continuous (stepwise constant) spectrum,
C           each 'SPECTR' line gives the lower end-point of an energy
C           bin of the source spectrum (Ei) and the associated relative
C           probability (Pi), integrated over the bin. Up to NSEM=1000
C           lines, in arbitrary order. The upper end of the spectrum is
C           defined by entering a line with Ei equal to the upper energy
C           end point and with a negative Pi value.
C             DEFAULT: none
C
C  SPOSIT : Coordinates of the source center.
C             DEFAULT: SX0=SY0=0.0, SZ0=10.0E0
C  SRADI  : The initial position of the particle is sampled randomly
C           within a circle of radius SRAD, centered at (SX0,SY0,SZ0)
C           and perpendicular to the beam axis direction.
C             DEFAULT: SRAD=0.0
C  SDIREC : Polar and azimuthal angles of the particle beam axis direc-
C           tion, in deg.
C             DEFAULTS: STHETA=180.0, SPHI=0.0
C  SAPERT : Angular aperture of the particle beam, in deg.
C             DEFAULT: SALPHA=0.0
C
C           --> Notice that the default beam is a pencil beam that
C           moves downwards along the Z-axis.
C
C  >>>>>>>> Material data and simulation parameters.
C
C  Each material is defined by introducing the following _two_ lines;
C
C  MFNAME : Name of a PENELOPE input material data file (up to 20
C           characters). This file must be generated in advance by
C           running the program MATERIAL.
C             DEFAULT: none
C
C  MSIMPA : Set of simulation parameters for this material; absorption
C           energies, EABS(1:3,M), elastic scattering parameters, C1(M)
C           and C2(M), and cutoff energy losses for inelastic collisions
C           and bremsstrahlung emission, WCC(M) and WCR(M).
C             DEFAULTS: EABS(1,M)=EABS(3,M)=0.01*EPMAX,
C                       EABS(2,M)=0.001*EPMAX
C                       C1(M)=C2(M)=0.1, WCC=EABS(1,M), WCR=EABS(2,M)
C             EPMAX is the upper limit of the energy interval covered
C             by the simulation lookup tables.
C
C  Note that we must declare a separate material data file name and a
C  set of simulation parameters for each material. The label (material
C  number) asigned by PENELOPE to each material is determined by the
C  ordering of the material data files in the PENMAIN input file. That
C  is, the first, second, ... materials are assigned the labels 1, 2,
C  ... These labels are also used in the geometry definition file.
C
C  The original programs in the distribution package allow up to 10
C  materials. This number can be increased by changing the value of the
C  parameter MAXMAT in the original source files.
C
C  >>>>>>>> Geometry of the sample.
C
C  GEOMFN : PENGEOM geometry definition file name (a string of up to
C           20 characters). It is assumed that the sample is located at
C           the origin of coordinates, with its surface at the z=0
C           plane.
C             DEFAULT: none.
C
C           --> The geometry definition file can be debugged/visualised
C           with the viewers GVIEW2D and GVIEW3D (operable only under
C           Windows).
C
C           The bodies in the material structure are normally identified
C           by the sequential labels assigned by PENGEOM. For complex
C           geometries, however, it may be more practical to employ user
C           labels, i.e., the four-character strings that identify the
C           body in the geometry definition file. In PENMAIN (and only
C           in the parts of the code that follow the definition of the
C           geometry), a body can be specified by giving either its
C           PENGEOM numerical label or its user label enclosed in a
C           pair of apostrophes (e.g., 'BOD1'). However, bodies that
C           result from the cloning of modules (as well as those defined
C           in an INCLUDEd geometry file) do not have a user label and
C           only the PENGEOM numerical label is acceptable.
C
C  DSMAX_ : Maximum step length DSMAX(KB) of electrons and positrons in
C           body KB. This parameter is important only for thin bodies;
C           it should be given a value of the order of one tenth of the
C           body thickness or less.
C             DEFAULT: DSMAX=1.0E20 (no step length control)
C
C  >>>>>>>> Interaction forcing.
C
C  IFORCE : Activates forcing of interactions of type ICOL of particles
C           KPAR in body KB. FORCER is the forcing factor, which must
C           be larger than unity. WLOW and WHIG are the lower and upper
C           limits of the weight window where interaction forcing is
C           applied. When several interaction mechanisms are forced in
C           the same body, the effective weight window is set equal to
C           the intersection of the windows for these mechanisms.
C             DEFAULT: no interaction forcing
C
C           If the mean free path for real interactions of type ICOL is
C           MFP, the program will simulate interactions of this type
C           (real or forced) with an effective mean free path equal to
C           MFP/FORCER.
C
C           TRICK: a negative input value of FORCER, -FN, is assumed to
C           mean that a particle with energy E=EPMAX should interact,
C           on average, +FN times in the course of its slowing down to
C           rest, for electrons and positrons, or along a mean free
C           path, for photons. This is very useful, e.g., to generate
C           x-ray spectra from bulk samples.
C
C  The real effect of interaction forcing on the efficiency is not easy
C  to predict. Please, do tentative runs with different FORCER values
C  and check the efficiency gain (or loss!).
C
C  >>>>>>>> Bremsstrahlung splitting.
C
C  IBRSPL : Activates bremsstrahlung splitting in body KB for electrons
C           and positrons with weights in the window (WLOW,WHIG) where
C           interaction forcing is applied. The integer IBRSPL is the
C           splitting factor.
C             DEFAULT: no bremsstrahlung splitting
C
C           Note that bremsstrahlung splitting is applied in combination
C           with interaction forcing and, consequently, it is activated
C           only in those bodies where interaction forcing is active.
C
C  >>>>>>>> X-ray splitting.
C
C  IXRSPL : Splitting of characteristic x rays emitted in body KB, from
C           any element. Each unsplit x ray with ILB(2)=2 (i.e., of the
C           second generation) when extracted from the secondary stack
C           is split into IXRSPL quanta. The new, lighter, quanta are
C           assigned random directions distributed isotropically.
C             DEFAULT: no x-ray splitting
C
C  >>>>>>>> Energy and angular distributions of emerging particles.
C
C  NBE___ : Limits EL and EU of the interval where energy distributions
C           of emerging particles are tallied. Number of energy bins
C           (.LE. 1000).
C             DEFAULT: EL=0.0, EU=EPMAX, NBE=500
C
C           NBE is the number of bins in the output energy distribution
C           (.LE. 1000). If NBE is positive, energy bins have uniform
C           width, DE=(EU-EL)/NBE. When NBE is negative, the bin wifth
C           increases geometrically with the energy, i.e., the energy
C           bins have uniform width in a logarithmic scale.
C
C  NBANGL : Numbers of bins for the polar angle THETA and the azimuthal
C           angle PHI, respectively, NBTH and NBPH (.LE. 3600 and 180,
C           respectively).
C             DEFAULT: NBTH=90, NBPH=1 (azimuthal average)
C
C           If NBTH is positive, angular bins have uniform width,
C           DTH=180./NBTHE. When NBTH is negative, the bin width
C           increases geometrically with THETA, i.e., the bins have
C           uniform width in a logarithmic scale.
C
C           NOTE: In the output files, the terms 'upbound' and
C           'downbound' are used to denote particles that leave the
C           material system moving upwards (W>0) and downwards (W<0),
C           respectively.
C
C  >>>>>>>> Photon detectors.
C
C  Each detector collects photons that leave the sample with directions
C  within a 'rectangle' on the unit sphere, limited by the 'parallels'
C  THETA1 and THETA2 and the 'meridians' PHI1 and PHI2. The output
C  spectrum is the energy distribution of photons that emerge within the
C  acceptance solid angle of the detector with energies in the interval
C  from EDEL to EDEU, recorded using NCHE channels. Notice that the
C  spectrum is given in absolute units (per incident particle, per eV
C  and per unit solid angle).
C
C  PDANGL : Starts the definition of a new detector. Up to 25 different
C           detectors can be defined. THETA1,THETA2 and PHI1,PHI2 are
C           the limits of the angular intervals covered by the detector,
C           in degrees.
C
C           The integer flag IPSF serves to activate the creation of a
C           phase-space file (psf), which contains the state variables
C           and weigths of particles that enter the detector. Use this
C           option with care, because psf's may grow very fast.
C           IPSF=0, the psf is not created.
C           IPSF=1, a psf is created.
C           IPSF>1, a psf is created, but contains only state variables
C                   of detected photons that have ILB(4)=IPSF (used for
C                   studying angular distributions of x rays).
C           Generating the psf is useful for tuning interaction forcing,
C           which requires knowing the weights of detected particles.
C
C             DEFAULTS: THETA1=35, THETA2=45, PHI1=0, PHI2=360, IPSF=0
C
C           NOTE: PHI1 and PHI2 must be both either in the interval
C           (0,360) or in the interval (-180,180).
C
C  PDENER : EDEL and EDEU are the lower and upper limits of the energy
C           window covered by the detector.
C           NCHE is the number of energy channels in the output spectrum
C           (.LE. 1000).
C             DEFAULT: EDEL=0.0, EDU=E0, NCHE=1000
C
C  XRORIG : This line in the input file activates the generation of a
C           file with the position coordinates of the emission sites of
C           the photons that reach the detector. The file name must be
C           explicitly defined. Notice that the file may grow very fast,
C           so use this option only in short runs. The output file is
C           overwritten when a simulation is resumed.
C             DEFAULT: NONE
C
C  >>>>>>>> Spatial distributions of x-ray emission.
C
C  The program can generate space distributions of x-ray emission
C  inside a parallelepiped (the scoring box) whose edges are parallel to
C  the axes of the laboratory frame. This box is defined by giving the
C  coordinates of its vertices. The spatial distribution of x-ray
C  generation events is tallied using a uniform orthogonal grid with
C  NBX, NBY and NBZ (.LE. 100) bins along the directions of the
C  coordinate axes. Maps of x ray emission sites for up to ten energy
C  intervals or x-ray lines can be tallied simultaneously.
C
C  GRIDX_ : X-coordinates of the vertices of the scoring box and number
C           of bins in the X direction.
C             DEFAULT: None
C  GRIDY_ : Y-coordinates of the vertices of the scoring box and number
C           of bins in the Y direction.
C             DEFAULT: None
C  GRIDY_ : Z-coordinates of the vertices of the scoring box and number
C           of bins in the Z direction.
C             DEFAULT: None
C  XRAYE_ : This line activates the generation of the space distribution
C           of emission sites of x rays with energies in the interval
C           from EMIN to EMAX, limited to the scoring box.
C             DEFAULTS: none
C  XRLINE : The space distribution of emission sites of x rays IZS1S200
C           [ILB(4) notation, note the final double zero] will be
C           mapped.
C             DEFAULTS: none
C
C  >>>>>>>> Job properties.
C
C  RESUME : The program will read the dump file named 'dump1.dat' (up to
C           20 characters) and resume the simulation from the point
C           where it was left. Use this option very, _VERY_ carefully.
C           Make sure that the input data file is fully consistent with
C           the one used to generate the dump file.
C             DEFAULT: off
C
C  DUMPTO : Generate a dump file named 'dump2.dat' (up to 20 characters)
C           after completing the simulation run. This allows the
C           simulation to be resumed later on to improve statistics.
C             DEFAULT: off
C
C           NOTE: If the file 'dump2.dat' already exists, it is
C           overwritten.
C
C  DUMPP_ : When the DUMPTO option is activated, simulation results are
C           written in the output files every DUMPP seconds. This option
C           is useful to check the progress of long simulations. It also
C           allows the program to be run with a long execution time and
C           to be stopped when the required statistical uncertainty has
C           been reached.
C             DEFAULT: DUMPP=1.0E15
C
C  RSEED_ : Seeds of the random-number generator. When ISEED1 is equal
C           to a negative integer, -N, the seeds are set by calling
C           subroutine RAND0(N) with the input argument equal to N. This
C           ensures that sequences of random numbers used in different
C           runs of the program (with different values of N) are truly
C           independent.
C             DEFAULT: ISEED1=1, ISEED2=1
C
C  REFLIN : The simulation will be discontinued when the relative
C           statistical uncertainty (3*sigma) of the intensity of line
C           IZS1S200 [note the final double zero] in detector IDET is
C           less than the tolerance TOL.
C             DEFAULTS: none
C
C  NSIMSH : Desired number of simulated showers.
C             DEFAULT: DSHN=2.0E9
C
C  TIME__ : Allotted simulation time, in sec.
C             DEFAULT: TIMEA=100.0E0
C
C  The program is aborted when an incorrect input datum is found. The
C  conflicting quantity usually appears in the last line of the output
C  file 'penepma.dat'. If the trouble is with arrays having dimensions
C  smaller than required, the program indicates how the problem can be
C  solved (this usually requires editing the source file, be careful).
C
C  The clock subroutine (TIMER) may have to be adapted to your specific
C  computer-compiler configuration; standard fortran 77 does not provide
C  timing tools. However, the routines in module TIMER.F do work for
C  many fortran compilers.
C
C  ************  Generating the executable PENEPMA and running it.
C
C  To generate the executable binary file PENEPMA.EXE, compile and link
C  the FORTRAN 77 source files PENEPMA.F, PENELOPE.F, RITA.F, PENGEOM.F,
C  PENVARED.F and TIMER.F. For example, if you are using the g77
C  compiler under Windows, place these five files in the same directory,
C  open a DOS window and from that directory enter the command
C    'g77 -Wall -O PENEPMA.F -o PENEPMA.EXE'
C  (The same, with file names in lowercase, should work under Linux).
C
C  To run PENEPMA, you have to generate an input data file, let's call
C  it PENEPMA.IN, and the corresponding geometry definition and material
C  data files. Place these files and the binary file PEMEPMA.EXE in the
C  same directory and, from there, issue the command
C    'PENEPMA.EXE < PENEPMA.IN'
C
C  The calculated distributions are written in separate files, whose
C  names start with 'pe-' (for PenEpma) and have the extension '.dat'.
C  These files are in a format suited for direct visualisation with
C  GNUPLOT (version 4.0).
C
C  *********************************************************************
C                       MAIN PROGRAM
C  *********************************************************************
C
      USE PENELOPE_mod
      USE TRACK_mod
      USE PENGEOM_mod
      USE PENVARED_mod
C
      IMPLICIT DOUBLE PRECISION (A-H,O-Z), INTEGER*4 (I-N)
      LOGICAL LFORCE,LINTF,LXRSPL,LDUMP,LSPEC
      CHARACTER LIT*2,WORD*4,LCH10*10,DATE23*23
      CHARACTER*20 PMFILE,PFILE,SPCDIO,PFILED,PFILER,PSFDIO,PORIG
      CHARACTER*120 TITLE,TITLE2,BUFFER,BUF2
      CHARACTER*200 PSFREC
C
      CHARACTER CS2(30)*2
      DATA CS2 /' K','L1','L2','L3','M1','M2','M3','M4','M5','N1','N2',
     1     'N3','N4','N5','N6','N7','O1','O2','O3','O4','O5','O6','O7',
     2     'P1','P2','P3','P4','P5','Q1',' X'/
C
      CHARACTER*6 KWORD,KWCOMM,
     1  KWTITL,KWKPAR,KWSENE,KWSPEC,  KWSPOS,KWSRAD,KWSDIR,KWSAPE,
     1  KWMATF,KWSIMP,KWGEOM,KWSMAX,  KWIFOR,KBRSPL,KXRSPL,KWNBE ,
     1  KWNBAN,KWDANG,KWDENE,KWORIG,  KGRDXX,KGRDYY,KGRDZZ,KEVENT,
     1  KEVEN2,KWRESU,KWDUMP,KWDMPP,  KWNSIM,KWRSEE,KWREFL,KWTIME
      PARAMETER (KWCOMM='      ',
     1  KWTITL='TITLE ',KWKPAR='SKPAR ',KWSENE='SENERG',KWSPEC='SPECTR',
     1  KWSPOS='SPOSIT',KWSRAD='SRADI ',KWSDIR='SDIREC',KWSAPE='SAPERT',
     1  KWMATF='MFNAME',KWSIMP='MSIMPA',KWGEOM='GEOMFN',KWSMAX='DSMAX ',
     1  KWIFOR='IFORCE',KBRSPL='IBRSPL',KXRSPL='IXRSPL',KWNBE ='NBE   ',
     1  KWNBAN='NBANGL',KWDANG='PDANGL',KWDENE='PDENER',KWORIG='XRORIG',
     1  KGRDXX='GRIDX ',KGRDYY='GRIDY ',KGRDZZ='GRIDZ ',KEVENT='XRAYE ',
     1  KEVEN2='XRLINE',KWRESU='RESUME',KWDUMP='DUMPTO',KWDMPP='DUMPP ',
     1  KWRSEE='RSEED ',KWREFL='REFLIN',KWNSIM='NSIMSH',KWTIME='TIME  ')
C
      PARAMETER (PI=3.1415926535897932D0, TWOPI=2.0D0*PI,
     1  RA2DE=180.0D0/PI, DE2RA=PI/180.0D0)
C
      COMMON/RSEED/ISEED1,ISEED2
C
      PARAMETER (REV=5.10998928D5)  ! Electron rest energy (eV)
      PARAMETER (TREV=2.0D0*REV)
C  ****  Current state in class II simulation.
C        MHINGE=0 (1) before (after) the hinge.
      COMMON/CJUMP1/ELAST1,ELAST2,MHINGE,KSOFTE,KSOFTI,KDELTA
C
C
      DIMENSION PMFILE(MAXMAT)
C  ****  Composition data.
      COMMON/COMPOS/STF(MAXMAT,30),ZT(MAXMAT),AT(MAXMAT),RHO(MAXMAT),
     1  VMOL(MAXMAT),IZ(MAXMAT,30),NELEM(MAXMAT)
C  ****  Geometry.
      DIMENSION PARINP(20)
      DIMENSION DSMAX(NB)
C  ****  Interaction forcing parameters.
      COMMON/CFORCI/WLOW(NB,3),WHIG(NB,3),LFORCE(NB,3)
C  ****  X-ray splitting.
      COMMON/CXRSPL/IXRSPL(NB),ILBA(5),LXRSPL(NB)
C  ----  Energy spectrum of the source.
      PARAMETER (NSEM=4096)
      COMMON/CSOUR1/SHIST(NSEM),NSEB  ! Definition.
      COMMON/CSOUR2/ESRC(NSEM),PSRC(NSEM),IASRC(NSEM),FSRC(NSEM),LSPEC
C
C  ************  Discrete counters.
C
      DIMENSION
     1  PRIM(3),PRIM2(3),DPRIM(3),     ! Numbers of IEXIT particles.
     1  SEC(3,3),SEC2(3,3),DSEC(3,3)   ! Generated secondary particles.
      DATA PRIM,PRIM2,SEC,SEC2/24*0.0D0/
      DIMENSION WSEC(3,3),WSEC2(3,3)
C  ----  Deposited energies in various bodies.
      DIMENSION TDEBO(NB),TDEBO2(NB),DEBO(NB)
C
C  ************  Continuous distributions.
C
C  ----  Energy distributions of emerging particles.
      PARAMETER (NBEM=4096)
      DIMENSION BSE(2)
      DIMENSION PDE(3,2,NBEM),PDE2(3,2,NBEM),PDEP(3,2,NBEM),
     1          LPDE(3,2,NBEM)
C
C  ----  Angular distributions of emerging particles.
      PARAMETER (NBTHM=90,NBPHM=60)
      DIMENSION PDA(3,NBTHM,NBPHM),PDA2(3,NBTHM,NBPHM),
     1          PDAP(3,NBTHM,NBPHM),LPDA(3,NBTHM,NBPHM)
C
      DIMENSION PDAT(3,NBTHM),PDAT2(3,NBTHM),PDATP(3,NBTHM),
     1  LPDAT(3,NBTHM)
C
C  ----  Photon detectors (up to NEDM different detectors).
      PARAMETER (NEDM=25,NEDCM=4096)
      DIMENSION IORIG(NEDM)
      DIMENSION DET(NEDM,NEDCM),DET2(NEDM,NEDCM),DETP(NEDM,NEDCM),
     1  LDET(NEDM,NEDCM),TDED(NEDM),TDED2(NEDM),DEDE(NEDM)
      DIMENSION EDEL(NEDM),EDEU(NEDM),BDEE(NEDM),NDECH(NEDM)
      DIMENSION THETA1(NEDM),THETA2(NEDM),PHI1(NEDM),PHI2(NEDM)
C
      DIMENSION RLAST(NEDM),RWRITE(NEDM),PSFDIO(NEDM),IPSF(NEDM)
C
C  ----  Event map (up to NDXM bins along each coord. axis).
      DIMENSION DXL(3),DXU(3),BDOEV(3),BDOEVR(3),NDB(3)
C  IEVENT: 1, x ray in energy interval; 2, x-ray line.
      PARAMETER (NEVM=10)
      PARAMETER (NDXM=100,NDYM=100,NDZM=100)
      DIMENSION DOEV(NEVM,NDXM,NDYM,NDZM),DOEV2(NEVM,NDXM,NDYM,NDZM),
     1          DOEVP(NEVM,NDXM,NDYM,NDZM),LDOEV(NEVM,NDXM,NDYM,NDZM)
      DIMENSION DREV(NEVM,NDXM),DREV2(NEVM,NDXM),DREVP(NEVM,NDXM),
     1          LDREV(NEVM,NDXM)
      DIMENSION XEMIN(NEVM),XEMAX(NEVM),IEVENT(NEVM),ITRANS(NEVM)
C
C  ----  Intensities of characteristic photons at the detectors.
      PARAMETER (NTRANS=4000,NIZ=99,NIS=30)
      PARAMETER (NILB5=3)
      DIMENSION IZS(NTRANS),IS1S(NTRANS),IS2S(NTRANS),ENERGS(NTRANS)
      DIMENSION PTIoT(NEDM,NIZ,NIS,NIS),PTIoT2(NEDM,NIZ,NIS,NIS),
     1  PTIoTP(NEDM,NIZ,NIS,NIS),LPTIoT(NEDM,NIZ,NIS,NIS)
      DIMENSION PTIoF(NEDM,NIZ,NIS,NIS,NILB5),
     1  PTIoF2(NEDM,NIZ,NIS,NIS,NILB5),PTIoFP(NEDM,NIZ,NIS,NIS,NILB5),
     1  LPTIoF(NEDM,NIZ,NIS,NIS,NILB5)
C
C  ----  Probability of emission of characteristic photons.
      DIMENSION PTIGT(NIZ,NIS,NIS),PTIGT2(NIZ,NIS,NIS),
     1  PTIGTP(NIZ,NIS,NIS),LPTIGT(NIZ,NIS,NIS)
      DIMENSION PTIoG(NIZ,NIS,NIS,NILB5),PTIoG2(NIZ,NIS,NIS,NILB5),
     1  PTIoGP(NIZ,NIS,NIS,NILB5),LPTIoG(NIZ,NIS,NIS,NILB5)
C
C  ----  Probability of emission of bremsstrahlung photons.
      DIMENSION PDEBR(NBEM),PDEBR2(NBEM),PDEBRP(NBEM),LPDEBR(NBEM)
C
      EXTERNAL RAND
C
C  ****  Time counter initiation.
C
      CALL TIME0
C
      DO I=1,NB
        TDEBO(I)=0.0D0
        TDEBO2(I)=0.0D0
      ENDDO
C
      DO I=1,3
        DO J=1,2
          DO K=1,NBEM
            PDE(I,J,K)=0.0D0
            PDE2(I,J,K)=0.0D0
            PDEP(I,J,K)=0.0D0
            LPDE(I,J,K)=0
          ENDDO
        ENDDO
      ENDDO
C
      DO I=1,3
        DO J=1,NBTHM
          DO K=1,NBPHM
            PDA(I,J,K)=0.0D0
            PDA2(I,J,K)=0.0D0
            PDAP(I,J,K)=0.0D0
            LPDA(I,J,K)=0
          ENDDO
        ENDDO
      ENDDO
C
      DO I=1,3
        DO J=1,NBTHM
          PDAT(I,J)=0.0D0
          PDAT2(I,J)=0.0D0
          PDATP(I,J)=0.0D0
          LPDAT(I,J)=0
        ENDDO
      ENDDO
C
      DO I=1,NEDM
        DO J=1,NEDCM
          DET(I,J)=0.0D0
          DET2(I,J)=0.0D0
          DETP(I,J)=0.0D0
          LDET(I,J)=0
        ENDDO
        TDED(I)=0.0D0
        TDED2(I)=0.0D0
      ENDDO
C
      DO I=1,NSEM
        SHIST(I)=0.0D0
      ENDDO
C
      DO NEV=1,10
        IEVENT(NEV)=0
        ITRANS(NEV)=0
        XEMIN(NEV)=0.0D0
        XEMAX(NEV)=1.0D9
        DO I=1,NDXM
          DREV(NEV,I)=0.0D0
          DREV2(NEV,I)=0.0D0
          DREVP(NEV,I)=0.0D0
          LDREV(NEV,I)=0
          DO J=1,NDYM
            DO K=1,NDZM
              DOEV(NEV,I,J,K)=0.0D0
              DOEV2(NEV,I,J,K)=0.0D0
              DOEVP(NEV,I,J,K)=0.0D0
              LDOEV(NEV,I,J,K)=0
            ENDDO
          ENDDO
        ENDDO
      ENDDO
C
      DO I=1,NEDM
        DO J=1,NIZ
          DO K=1,NIS
            DO L=1,NIS
              PTIoT(I,J,K,L)=0.0D0
              PTIoT2(I,J,K,L)=0.0D0
              PTIoTP(I,J,K,L)=0.0D0
              LPTIoT(I,J,K,L)=0
              DO M=1,NILB5
                PTIoF(I,J,K,L,M)=0.0D0
                PTIoF2(I,J,K,L,M)=0.0D0
                PTIoFP(I,J,K,L,M)=0.0D0
                LPTIoF(I,J,K,L,M)=0
              ENDDO
            ENDDO
          ENDDO
        ENDDO
      ENDDO
C
      DO J=1,NIZ
        DO K=1,NIS
          DO L=1,NIS
            PTIGT(J,K,L)=0.0D0
            PTIGT2(J,K,L)=0.0D0
            PTIGTP(J,K,L)=0.0D0
            LPTIGT(J,K,L)=0
            DO M=1,NILB5
              PTIoG(J,K,L,M)=0.0D0
              PTIoG2(J,K,L,M)=0.0D0
              PTIoGP(J,K,L,M)=0.0D0
              LPTIoG(J,K,L,M)=0
            ENDDO
          ENDDO
        ENDDO
      ENDDO
C
      DO I=1,NBEM
        PDEBR(I)=0.0D0
        PDEBR2(I)=0.0D0
        PDEBRP(I)=0.0D0
        LPDEBR(I)=0
      ENDDO
C
C  ------------------------  Read input data file.
C
      OPEN(26,FILE='penepma.dat')
      WRITE(26,1000)
 1000 FORMAT(/3X,61('*'),/3X,'**   Program PENEPMA. ',
     1 ' Input data and run-time messages.   **',/3X,61('*'))
C
      CALL PDATET(DATE23)
      WRITE(26,1001) DATE23
 1001 FORMAT(/3X,'Date and time: ',A23)
C
C  ****  Title.
C
      READ(5,'(A6,1X,A120)') KWORD,TITLE
      IF(KWORD.EQ.KWTITL) THEN
        WRITE(26,'(/3X,A120)') TITLE
      ELSE
        WRITE(26,*) 'The input file must begin with the TITLE line.'
        STOP 'The input file must begin with the TITLE line.'
      ENDIF
C
C  ************  Incident beam.
C
   11 CONTINUE
      READ(5,'(A6,1X,A120)') KWORD,BUFFER
      IF(KWORD.EQ.KWCOMM) GO TO 11
C
      WRITE(26,1100)
 1100 FORMAT(/3X,72('-'),/3X,'>>>>>>  Incident beam.')
C
C  ****  Kind of primary particles
C
      KPARP=1
      IF(KWORD.EQ.KWKPAR) THEN
        READ(BUFFER,*) KPARP
   12   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 12
      ENDIF
      IF(KPARP.LT.0.OR.KPARP.GT.2) THEN
        WRITE(26,*) 'KPARP =',KPARP
        WRITE(26,*) 'Incorrect particle type.'
        STOP 'Incorrect particle type.'
      ENDIF
      IF(KPARP.EQ.1) WRITE(26,1110)
 1110 FORMAT(/3X,'Primary particles: electrons')
      IF(KPARP.EQ.2) WRITE(26,1111)
 1111 FORMAT(/3X,'Primary particles: photons')
      IF(KPARP.EQ.3) WRITE(26,1112)
 1112 FORMAT(/3X,'Primary particles: positrons')
C
C  ****  Monoenergetic source.
C
      NSEB=1
      LSPEC=.FALSE.
      IF(KWORD.EQ.KWSENE) THEN
        READ(BUFFER,*) E0
        WRITE(26,1120) E0
 1120   FORMAT(3X,'Initial energy = ',1P,E13.6,' eV')
   13   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 13
C
C  ****  Continuous energy spectrum.
C
      ELSE IF(KWORD.EQ.KWSPEC) THEN
        LSPEC=.TRUE.
        NSEB=0
   14   CONTINUE
        NSEB=NSEB+1
        IF(NSEB.GT.NSEM) THEN
          WRITE(26,*) 'Source energy spectrum.'
          WRITE(26,*) 'The number of energy bins is too large.'
          STOP 'The number of energy bins is too large.'
        ENDIF
        READ(BUFFER,*) ESRC(NSEB),PSRC(NSEB)
        PSRC(NSEB)=MAX(PSRC(NSEB),0.0D0)
   15   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 15
        IF(KWORD.EQ.KWSPEC) GO TO 14
      ELSE
        E0=1.0D9
        IF(KPARP.NE.0) WRITE(26,1120) E0
      ENDIF
      IF(LSPEC) THEN
        IF(NSEB.GT.1) THEN
          CALL SORT2(ESRC,PSRC,NSEB)
          WRITE(26,1121)
 1121     FORMAT(/3X,'Spectrum:',7X,'I',4X,'E_low(eV)',4x,'E_high(eV)',
     1      5X,'P_sum(E)',/16X,45('-'))
          DO I=1,NSEB-1
            WRITE(26,'(16X,I4,1P,3E14.6)') I,ESRC(I),ESRC(I+1),PSRC(I)
          ENDDO
          WRITE(26,*) '  '
          E0=ESRC(NSEB)
          NSEB=NSEB-1
          CALL IRND0(PSRC,FSRC,IASRC,NSEB)
        ELSE
          WRITE(26,*) 'The source energy spectrum is not defined.'
          STOP 'The source energy spectrum is not defined.'
        ENDIF
      ENDIF
      IF(E0.LT.50.0D0) THEN
        WRITE(26,*) 'The initial energy E0 is too small.'
        STOP 'The initial energy E0 is too small.'
      ENDIF
      EPMAX=E0
C  ----  Positrons eventually give annihilation gamma rays. The maximum
C        energy of annihilation photons is .lt. 1.21*(E0+me*c**2).
      IF(KPARP.EQ.3) EPMAX=1.21D0*(E0+5.12D5)
C
C  ****  Geometry of the incident beam.
C
      IF(KWORD.EQ.KWSPOS) THEN
        READ(BUFFER,*) SX0,SY0,SZ0
   16   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 16
      ELSE
        SX0=0.0D0
        SY0=0.0D0
        SZ0=10.0D0
      ENDIF
      WRITE(26,1132) SX0,SY0,SZ0
 1132 FORMAT(3X,'Coordinates of source:     SX0 = ',1P,E13.6,
     1  ' cm',/30X,'SY0 = ',E13.6,' cm',/30X,'SZ0 = ',E13.6,' cm')
C
      IF(KWORD.EQ.KWSRAD) THEN
        READ(BUFFER,*) SRAD
   76   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 76
      ELSE
        SRAD=0.0D0
      ENDIF
      WRITE(26,1732) SRAD
 1732 FORMAT(3X,'Beam redius:              SRAD = ',1P,E13.6,' cm')
C
      IF(KWORD.EQ.KWSDIR) THEN
        READ(BUFFER,*) STHETA,SPHI
   17   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 17
      ELSE
        STHETA=180.0D0
        SPHI=0.0D0
      ENDIF
      WRITE(26,1133) STHETA,SPHI
 1133 FORMAT(3X,'Beam direction angles:   THETA = ',1P,E13.6,' deg',
     1  /30X,'PHI = ',E13.6,' deg')
C
      IF(KWORD.EQ.KWSAPE) THEN
        READ(BUFFER,*) SALPHA
   18   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 18
      ELSE
        SALPHA=0.0D0
      ENDIF
      WRITE(26,1134) SALPHA
 1134 FORMAT(3X,'Beam aperture:',11X,'ALPHA = ',1P,E13.6,' deg')
      CALL GCONE0(STHETA*DE2RA,SPHI*DE2RA,SALPHA*DE2RA)
C
C  ************  Material data and simulation parameters.
C
      WRITE(26,1300)
 1300 FORMAT(/3X,72('-'),/
     1  3X,'>>>>>>  Material data and simulation parameters.')
C
C  ****  Simulation parameters.
C
      DO M=1,MAXMAT
        EABS(1,M)=0.010D0*EPMAX
        EABS(2,M)=0.001D0*EPMAX
        EABS(3,M)=0.010D0*EPMAX
        C1(M)=0.10D0
        C2(M)=0.10D0
        WCC(M)=EABS(1,M)
        WCR(M)=EABS(2,M)
      ENDDO
      DO IB=1,NB
        DSMAX(IB)=1.0D20
      ENDDO
      WGHT0=1.0D0   ! Primary particle weight.
C
      NMATR=0
   31 CONTINUE
      IF(KWORD.EQ.KWMATF) THEN
        NMATR=NMATR+1
        READ(BUFFER,'(A20)') PMFILE(NMATR)
   32   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 32
        IF(KWORD.EQ.KWMATF) GO TO 31
      ENDIF
C
      IF(KWORD.EQ.KWSIMP) THEN
        READ(BUFFER,*) EABS(1,NMATR),EABS(2,NMATR),EABS(3,NMATR),
     1    C1(NMATR),C2(NMATR),WCC(NMATR),WCR(NMATR)
   33   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 33
        IF(KWORD.EQ.KWMATF) GO TO 31
      ENDIF
C
      IF(NMATR.EQ.0) THEN
        WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
        WRITE(26,*) 'You have to specify a material file (line MFNAME).'
        STOP 'You have to specify a material file (line MFNAME).'
      ENDIF
      IF(NMATR.GT.MAXMAT) THEN
        WRITE(26,*) 'Wrong number of materials.'
        WRITE(26,'(''NMAT ='',I4,'' is larger than MAXMAT ='',I4)')
     1    NMATR,MAXMAT
        STOP 'Wrong number of materials.'
      ENDIF
C
      DO M=1,NMATR
        IF(M.EQ.1) LIT='st'
        IF(M.EQ.2) LIT='nd'
        IF(M.EQ.3) LIT='rd'
        IF(M.GT.3) LIT='th'
        WRITE(26,1320) M,LIT
 1320   FORMAT(/3X,'**** ',I2,A2,' material')
        WRITE(26,1325) PMFILE(M)
 1325   FORMAT(3X,'Material data file: ',A)
        IF(EABS(1,M).LT.5.0D1) EABS(1,M)=5.0D1
        EABS(2,M)=EABS(1,M)
        EABS(3,M)=EABS(1,M)
        WRITE(26,1321) EABS(1,M)
 1321   FORMAT(3X,'Electron absorption energy = ',1P,E13.6,' eV')
        WRITE(26,1322) EABS(2,M)
 1322   FORMAT(3X,'  Photon absorption energy = ',1P,E13.6,' eV')
        WRITE(26,1323) EABS(3,M)
 1323   FORMAT(3X,'Positron absorption energy = ',1P,E13.6,' eV')
        WCR(M)=MIN(WCR(M),EABS(1,M))
        WRITE(26,1324) C1(M),C2(M),WCC(M),WCR(M)
 1324   FORMAT(3X,'Electron-positron simulation parameters:',
     1    /4X,'C1 =',1P,E13.6,',      C2 =',E13.6,/3X,'Wcc =',E13.6,
     1    ' eV,  Wcr =',E13.6,' eV')
      ENDDO
C
C  ****  Initialisation of PENELOPE.
C
      WRITE(6,*) ' Initialising PENELOPE ...'
      IWR=16
      OPEN(IWR,FILE='pe-material.dat')
        INFO=1
        CALL PEINIT(EPMAX,NMATR,IWR,INFO,PMFILE)
      CLOSE(IWR)
C
C  ************  Geometry definition.
C
C  Define here the geometry parameters that are to be altered, if any.
C     PARINP(1)=
C     PARINP(2)=  ...
      NPINP=0
C
      IF(KWORD.EQ.KWGEOM) THEN
        READ(BUFFER,'(A20)') PFILE
        WRITE(26,1340) PFILE
 1340   FORMAT(/3X,'PENGEOM''s geometry definition file: ',A20)
        OPEN(15,FILE=PFILE,IOSTAT=KODE)
        IF(KODE.NE.0) THEN
          WRITE(26,'(''File '',A20,'' could not be opened.'')') PFILE
          STOP
        ENDIF
        OPEN(16,FILE='pe-geometry.rep')
        CALL GEOMIN(PARINP,NPINP,NMATG,NBODY,15,16)
        CLOSE(UNIT=15)
        CLOSE(UNIT=16)
        IF(NMATG.LT.1) THEN
          WRITE(26,*) 'NMATG must be greater than 0.'
          STOP 'NMATG must be greater than 0.'
        ENDIF
C
        IF(NBODY.GT.NB) THEN
          WRITE(26,'(/6X,''Too many bodies.'')')
          STOP 'Too many bodies.'
        ENDIF
C
        IF(NMATG.GT.NMAT) THEN
          WRITE(26,'(/6X,''Too many different materials.'')')
          STOP 'Too many different materials.'
        ENDIF
C
   34   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 34
      ELSE
        WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
        WRITE(26,*) 'You have to specify a geometry file.'
        STOP 'You have to specify a geometry file.'
      ENDIF
C
C  ****  Maximum step lengths of electrons and positrons.
C
      IF(KWORD.EQ.KWSMAX) THEN
        CALL FWORD(BUFFER,BUF2,WORD,LENGTH)
        IF(LENGTH.EQ.4) THEN
          DO IB=1,NBODY
            IF(WORD.EQ.BALIAS(IB)) KB=IB
          ENDDO
          READ(BUF2,*) DSMAX(KB)
        ELSE
          READ(BUFFER,*) KB,DSMAX(KB)
        ENDIF
        IF(KB.LT.1.OR.KB.GT.NBODY) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Incorrect body number.'
          STOP 'Incorrect body number.'
        ENDIF
        IF(DSMAX(KB).LT.1.0D-7) DSMAX(KB)=1.0D20
   35   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 35
        IF(KWORD.EQ.KWSMAX) THEN
          CALL FWORD(BUFFER,BUF2,WORD,LENGTH)
          IF(LENGTH.EQ.4) THEN
            DO IB=1,NBODY
              IF(WORD.EQ.BALIAS(IB)) KB=IB
            ENDDO
            READ(BUF2,*) DSMAX(KB)
          ELSE
            READ(BUFFER,*) KB,DSMAX(KB)
          ENDIF
          IF(KB.LT.1.OR.KB.GT.NBODY) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,*) 'Incorrect body number.'
            STOP 'Incorrect body number.'
          ENDIF
          IF(DSMAX(KB).LT.1.0D-7) DSMAX(KB)=1.0D20
          GO TO 35
        ENDIF
      ENDIF
C
      WRITE(26,1350)
 1350 FORMAT(/3X,72('-'),/3X,'>>>>>>  Maximum allowed step lengths of',
     1  ' electrons and positrons.')
      DO IB=1,NBODY
        WRITE(26,1351) IB,DSMAX(IB)
 1351   FORMAT(3X,'* Body =',I4,',   DSMAX = ',1P,E13.6,' cm')
      ENDDO
C
C  ************  Variance reduction.
C
      DO KB=1,NB
        DO ICOLi=1,8
          DO KPARi=1,3
            FORCE(KB,KPARi,ICOLi)=1.0D0
          ENDDO
        ENDDO
        DO KPARi=1,3
          LFORCE(KB,KPARi)=.FALSE.
          WLOW(KB,KPARi)=0.0D0
          WHIG(KB,KPARi)=1.0D6
        ENDDO
        IBRSPL(KB)=1
      ENDDO
C
      DO I=1,NB
        IXRSPL(I)=1
        LXRSPL(I)=.FALSE.
      ENDDO
C
C  ****  Interaction forcing.
C
      IF(KWORD.EQ.KWIFOR) THEN
        WRITE(26,1400)
 1400   FORMAT(/3X,72('-'),/
     1    3X,'>>>>>>  Interaction forcing: FORCE(IBODY,KPAR,ICOL)')
   41   CONTINUE
        CALL FWORD(BUFFER,BUF2,WORD,LENGTH)
        IF(LENGTH.EQ.4) THEN
          DO IB=1,NBODY
            IF(WORD.EQ.BALIAS(IB)) KB=IB
          ENDDO
          READ(BUF2,*) KPAR,ICOL,FORCER,WWLOW,WWHIG
        ELSE
          READ(BUFFER,*) KB,KPAR,ICOL,FORCER,WWLOW,WWHIG
        ENDIF
C  ****  Negative FORCER values are re-interpreted, as described in the
C        heading comments above.
        IF(FORCER.LT.-1.0D-6) THEN
          MM=MATER(KB)
          AVNCL=AVNCOL(E0,KPAR,MM,ICOL)
          IF(AVNCL.GT.1.0D-8) THEN
            FORCER=MAX(ABS(FORCER)/AVNCL,1.0D0)
          ELSE
            FORCER=MAX(ABS(FORCER),1.0D0)
          ENDIF
        ELSE
          FORCER=MAX(FORCER,1.0D0)
        ENDIF
        IF(WWLOW.LT.1.0D-6) WWLOW=1.0D-6
        IF(WWHIG.GT.1.0D6) WWHIG=1.0D6
        IF(KB.LT.1.OR.KB.GT.NBODY) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Incorrect KB value.'
          STOP 'Incorrect KB value.'
        ENDIF
        IF(KPAR.LT.1.OR.KPAR.GT.3) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Incorrect value of KPAR.'
          STOP 'Incorrect value of KPAR.'
        ENDIF
        IF(ICOL.LT.1.OR.ICOL.GT.8) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Incorrect value of ICOL.'
          STOP 'Incorrect value of ICOL.'
        ENDIF
        WLOW(KB,KPAR)=MAX(WLOW(KB,KPAR),WWLOW)*0.9999999999D0
        WHIG(KB,KPAR)=MIN(WHIG(KB,KPAR),WWHIG)*1.0000000001D0
        IF(WLOW(KB,KPAR).GT.WHIG(KB,KPAR)) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Incorrect weight window limits.'
          STOP 'Incorrect weight window limits.'
        ENDIF
        IF(FORCER.GT.1.0001D0) THEN
          LFORCE(KB,KPAR)=.TRUE.
          FORCE(KB,KPAR,ICOL)=FORCER
          WRITE(26,1410) KB,KPAR,ICOL,FORCER,WLOW(KB,KPAR),WHIG(KB,KPAR)
 1410     FORMAT(3X,'FORCE(',I4,',',I1,',',I1,') =',1P,E13.6,
     1      ',  weight window = (',E9.2,',',E9.2,')')
        ENDIF
   42   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 42
        IF(KWORD.EQ.KWIFOR) GO TO 41
      ENDIF
C
C  ****  Bremsstrahlung splitting.
C
      IF(KWORD.EQ.KBRSPL) THEN
        WRITE(26,1420)
 1420   FORMAT(/3X,72('-'),/
     1    3X,'>>>>>>  Bremsstrahlung splitting')
   26   CONTINUE
        CALL FWORD(BUFFER,BUF2,WORD,LENGTH)
        IF(LENGTH.EQ.4) THEN
          DO IB=1,NBODY
            IF(WORD.EQ.BALIAS(IB)) KB=IB
          ENDDO
          READ(BUF2,*) IBR
        ELSE
          READ(BUFFER,*) KB,IBR
        ENDIF
        IF(KB.LT.1.OR.KB.GT.NBODY) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Incorrect KB value.'
          STOP 'Incorrect KB value.'
        ENDIF
        IF(IBR.LT.1) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Incorrect value of IBRSPL.'
          STOP 'Incorrect value of IBRSPL.'
        ENDIF
        IF(LFORCE(KB,KPAR)) THEN
          IBRSPL(KB)=IBR
        ELSE
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Interaction forcing unactive in this body.'
          STOP 'Interaction forcing unactive in this body.'
        ENDIF
        WRITE(26,1421) KB,IBRSPL(KB)
 1421   FORMAT(3X,'IBODY = ',I4,',  IBRSPL =',I4)
   27   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 27
        IF(KWORD.EQ.KBRSPL) GO TO 26
      ENDIF
C
C  ****  X-ray splitting.
C
      IF(KWORD.EQ.KXRSPL) THEN
        WRITE(26,1422)
 1422   FORMAT(/3X,72('-'),/
     1    3X,'>>>>>>  X-ray splitting')
   57   CONTINUE
        CALL FWORD(BUFFER,BUF2,WORD,LENGTH)
        IF(LENGTH.EQ.4) THEN
          DO IB=1,NBODY
            IF(WORD.EQ.BALIAS(IB)) KB=IB
          ENDDO
          READ(BUF2,*) IXR
        ELSE
          READ(BUFFER,*) KB,IXR
        ENDIF
        IF(KB.LT.1.OR.KB.GT.NBODY) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Incorrect KB value.'
          STOP 'Incorrect KB value.'
        ENDIF
        IF(IXR.LT.1) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Incorrect value of IXRSPL.'
          STOP 'Incorrect value of IXRSPL.'
        ENDIF
        IXRSPL(KB)=IXR
        IF(IXR.GT.1) LXRSPL(KB)=.TRUE.
        IF(LXRSPL(KB)) WRITE(26,1423) KB,IXRSPL(KB)
 1423   FORMAT(3X,'IBODY = ',I4,',  IXRSPL =',I4)
   58   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 58
        IF(KWORD.EQ.KXRSPL) GO TO 57
      ENDIF
C
C  ************  Energy and angular distributions of emerging
C                particles.
C
      WRITE(26,1500)
 1500 FORMAT(/3X,72('-'),/
     1  3X,'>>>>>>  Energy and angular distributions of emerging',
     1  ' particles.')
C
      IF(KWORD.EQ.KWNBE) THEN
        READ(BUFFER,*) EMIN,EMAX,NBE
   51   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 51
      ELSE
        EMIN=0.0D0
        EMAX=EPMAX
        NBE=NBEM
      ENDIF
      EMIN=MAX(EMIN,0.0D0)
      EMAX=MAX(EMAX,EPMAX)
      NBE=MIN(MAX(NBE,10),NBEM)
      WRITE(26,1510) NBE,EMIN,EMAX
 1510 FORMAT(3X,'E:       NBE = ',I3,
     1  ',  EMIN =',1P,E13.6,' eV,  EMAX =',E13.6,' eV')
      IF(EMIN.GT.EMAX) THEN
        WRITE(26,*) 'Energy interval is too narrow.'
        STOP 'Energy interval is too narrow.'
      ENDIF
C
      IF(KWORD.EQ.KWNBAN) THEN
        READ(BUFFER,*) NBTH,NBPH
   52   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 52
      ELSE
        NBTH=90
        NBPH=1
      ENDIF
      IF (NBTH.EQ.0) THEN
        WRITE(26,*) 'NBTH is equal to zero.'
        STOP 'NBTH equal to 0.'
      ENDIF
      IF(NBTH.GT.0) THEN
        WRITE(26,1520) NBTH
 1520   FORMAT(3X,'Theta:  NBTH = ',I3,' (linear scale)')
      ELSE
        WRITE(26,1521) NBTH
 1521   FORMAT(3X,'Theta:  NBTH = ',I3,' (logarithmic scale)')
      ENDIF
      WRITE(26,1530) NBPH
 1530 FORMAT(3X,'Phi:    NBPH = ',I3)
      IF(NBPH.LT.1) THEN
        WRITE(26,*) 'Wrong number of PHI bins.'
        STOP 'Wrong number of PHI bins.'
      ENDIF
C
C  ****  Bin sizes.
C
C  ----  The factor 1.0000001 serves to ensure that the upper limit of
C  the tallied interval is within the last channel (otherwise, the array
C  dimensions could be exceeded).
      BSE(1)=1.0000001D0*(EMAX-EMIN)/DBLE(NBE)
      BSE(2)=1.0000001D0*(EMAX-EMIN)/DBLE(NBE)
      BSTH=1.0000001D0*180.0D0/DBLE(NBTH)
      BSPH=1.0000001D0*360.0D0/DBLE(NBPH)
C
C  ************  Photon detectors.
C
      NDEDEF=0
      DO I=1,NEDM
        IORIG(I)=0
      ENDDO
   43 CONTINUE
      IF(KWORD.EQ.KWDANG) THEN
        NDEDEF=NDEDEF+1
        IF(NDEDEF.GT.NEDM) THEN
          WRITE(26,'(3X,''NDEDEF = '',I4)') NDEDEF
          WRITE(26,*) 'Too many energy-deposition detectors.'
          STOP 'Too many energy-deposition detectors.'
        ENDIF
        WRITE(26,1650) NDEDEF
 1650   FORMAT(/3X,72('-'),/
     1    3X,'>>>>>>  Photon detector #', I2)
        READ(BUFFER,*) THETA1(NDEDEF),THETA2(NDEDEF),
     1    PHI1(NDEDEF),PHI2(NDEDEF),IPSF(NDEDEF)
        IF(THETA1(NDEDEF).GE.THETA2(NDEDEF)) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'THETA1 must be less than THETA2.'
          STOP 'THETA1 must be less than THETA2.'
        ENDIF
        IF(THETA1(NDEDEF).LT.0.0D0.OR.THETA1(NDEDEF).GT.180.0D0) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'THETA1 must be must be in the interval (0,180).'
          STOP 'THETA1 must be must be in the interval (0,180).'
        ENDIF
        IF(THETA2(NDEDEF).LT.0.0D0.OR.THETA2(NDEDEF).GT.180.0D0) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'THETA2 must be must be in the interval (0,180).'
          STOP 'THETA2 must be must be in the interval (0,180).'
        ENDIF
        IF(PHI1(NDEDEF).GE.PHI2(NDEDEF)) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'PHI1 must be less than PHI2.'
          STOP 'PHI1 must be less than PHI2.'
        ENDIF
        IF(PHI1(NDEDEF).LT.0.0D0) THEN
          IF(PHI1(NDEDEF).LT.-180.0001D0) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,*) 'PHI1 must be must be larger than -180.'
            STOP 'PHI1 must be must be larger than -180.'
          ENDIF
          IF(PHI2(NDEDEF).GT.180.0001D0) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,*) 'PHI2 must be must be less than 180.'
            STOP 'PHI2 must be must be less than 180.'
          ENDIF
        ELSE
          IF(PHI1(NDEDEF).GT.360.0001D0) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,*) 'PHI1 must be must be less than 360.'
            STOP 'PHI1 must be must be less than 360.'
          ENDIF
          IF(PHI2(NDEDEF).GT.360.0001D0) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,*) 'PHI2 must be must be less than 360.'
            STOP 'PHI2 must be must be less than 360.'
          ENDIF
        ENDIF
C
        WRITE(26,1611) THETA1(NDEDEF),THETA2(NDEDEF),
     1    PHI1(NDEDEF),PHI2(NDEDEF)
 1611   FORMAT(3X,'Angular intervals : theta_1 =',1P,E11.4,
     1    ' deg,  theta_2 =',E11.4,' deg',/25X,'phi_1 =',E11.4,
     2    ' deg,    phi_2 =',E11.4,' deg')
        THETA1(NDEDEF)=THETA1(NDEDEF)*DE2RA
        THETA2(NDEDEF)=THETA2(NDEDEF)*DE2RA
        PHI1(NDEDEF)=PHI1(NDEDEF)*DE2RA
        PHI2(NDEDEF)=PHI2(NDEDEF)*DE2RA
C
   44   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 44
        IF(KWORD.EQ.KWDENE) THEN
          READ(BUFFER,*) EDEL(NDEDEF),EDEU(NDEDEF),NDECH(NDEDEF)
          EDEL(NDEDEF)=MAX(EDEL(NDEDEF),0.0D0)
          EDEU(NDEDEF)=MIN(EDEU(NDEDEF),E0)
          IF(EDEU(NDEDEF).LT.EDEL(NDEDEF)) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,*) 'Incorrect energy limits. Modified.'
            WRITE(26,'(A,1P,E13.6)') 'EDEL =',EDEL(NDEDEF)
            WRITE(26,'(A,1P,E13.6)') 'EDEU =',EDEU(NDEDEF)
            STOP 'Incorrect energy limits.'
          ENDIF
          NDECH(NDEDEF)=MIN(MAX(NDECH(NDEDEF),10),NEDCM)

          WRITE(26,1610) EDEL(NDEDEF),EDEU(NDEDEF),NDECH(NDEDEF)
          BDEE(NDEDEF)=1.0000001D0*(EDEU(NDEDEF)-EDEL(NDEDEF))
     1      /DBLE(NDECH(NDEDEF))
          WRITE(26,1612) BDEE(NDEDEF)
   55     CONTINUE
          READ(5,'(A6,1X,A120)') KWORD,BUFFER
          IF(KWORD.EQ.KWCOMM) GO TO 55
          GO TO 56
        ELSE
          EDEL(NDEDEF)=0.0D0
          EDEU(NDEDEF)=E0
          NDECH(NDEDEF)=4096
          WRITE(26,1610) EDEL(NDEDEF),EDEU(NDEDEF),NDECH(NDEDEF)
          BDEE(NDEDEF)=1.0000001D0*(EDEU(NDEDEF)-EDEL(NDEDEF))
     1      /DBLE(NDECH(NDEDEF))
          WRITE(26,1612) BDEE(NDEDEF)
          IF(KWORD.EQ.KWDANG) GO TO 43
        ENDIF
 1610   FORMAT(3X,'Energy window = (',1P,E12.5,',',E12.5,') eV, no.',
     1    ' of channels = ',I4)
 1612   FORMAT(3X,'Channel width =',1P,E13.6,' eV')
C
   56   CONTINUE
        IF(IPSF(NDEDEF).GT.0) THEN
          WRITE(BUF2,'(I5)') 1000+NDEDEF
          SPCDIO='pe-psf-'//BUF2(4:5)//'.dat'
          PSFDIO(NDEDEF)=SPCDIO
          WRITE(26,1613) PSFDIO(NDEDEF)
 1613     FORMAT(3X,'Output phase-space file: ',A20)
        ENDIF
        IF(KWORD.EQ.KWDANG) GO TO 43
C
        IF(KWORD.EQ.KWORIG) THEN
          IORIG(NDEDEF)=1
          READ(BUFFER,'(A20)') PORIG
          OPEN(60+NDEDEF,FILE=PORIG)
          WRITE(26,1623) PORIG
 1623     FORMAT(3X,'Output x-ray emission sites file: ',A20)
   45     CONTINUE
          READ(5,'(A6,1X,A120)') KWORD,BUFFER
          IF(KWORD.EQ.KWCOMM) GO TO 45
          IF(KWORD.EQ.KWDANG) GO TO 43
        ENDIF
      ENDIF
      IF(NDEDEF.EQ.0) THEN
        WRITE(26,*) 'No photon detectors were defined.'
        WRITE(26,*) 'You must define at least one photon detector.'
        STOP 'No photon detectors were defined.'
      ENDIF
C
C  ************  Space distribution of x-ray emission events in a box.
C
      NEVENT=0
      IF(KWORD.EQ.KGRDXX) THEN
        WRITE(26,1700)
 1700   FORMAT(/3X,72('-'),/3X,'>>>>>>  Space distribution of x-ray ',
     1    'emission events in a box.')
        READ(BUFFER,*) DXL(1),DXU(1),NDB(1)
        IF(DXL(1).GT.DXU(1)) THEN
          SAVE=DXL(1)
          DXL(1)=DXU(1)
          DXU(1)=SAVE
        ENDIF
        IF(DXU(1).LT.DXL(1)+1.0D-6) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'XU must be greater than XL+1.0E-6.'
          STOP 'XU must be greater than XL+1.0E-6.'
        ENDIF
        IF(NDB(1).LT.0.OR.NDB(1).GT.NDXM) THEN
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,'(''NDB(1) must be .GT.0. and .LT.'',I4)') NDXM
          WRITE(26,*) 'Increase the value of the parameter NDXM.'
          STOP 'NDB(1) must be .GT.0. and .LE.NDXM'
        ENDIF
        WRITE(26,1710) DXL(1),DXU(1),NDB(1)
 1710   FORMAT(3X,'XL = ',1P,E13.6,' cm,  XU = ',E13.6,
     1    ' cm,  NDBX =',I4)
   71   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 71
        IF(KWORD.EQ.KGRDYY) THEN
          READ(BUFFER,*) DXL(2),DXU(2),NDB(2)
          IF(DXL(2).GT.DXU(2)) THEN
            SAVE=DXL(2)
            DXL(2)=DXU(2)
            DXU(2)=SAVE
          ENDIF
          IF(DXU(2).LT.DXL(2)+1.0D-6) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,*) 'YU must be greater than YL+1.0E-6.'
            STOP 'YU must be greater than YL+1.0E-6.'
          ENDIF
          IF(NDB(2).LT.0.OR.NDB(2).GT.NDYM) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,'(''NDB(2) must be .GT.0. and .LT.'',I4)') NDYM
            WRITE(26,*) 'Increase the value of the parameter NDYM.'
            STOP 'NDB(2) must be .GT.0. and .LE.NDYM'
          ENDIF
          WRITE(26,1711) DXL(2),DXU(2),NDB(2)
 1711     FORMAT(3X,'YL = ',1P,E13.6,' cm,  YU = ',E13.6,
     1      ' cm,  NDBY =',I4)
        ELSE
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Unrecognized keyword.'
          STOP 'Unrecognized keyword.'
        ENDIF
   72   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 72
        IF(KWORD.EQ.KGRDZZ) THEN
          READ(BUFFER,*) DXL(3),DXU(3),NDB(3)
          IF(DXL(3).GT.DXU(3)) THEN
            SAVE=DXL(3)
            DXL(3)=DXU(3)
            DXU(3)=SAVE
          ENDIF
          IF(DXU(3).LT.DXL(3)+1.0D-6) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,*) 'ZU must be greater than ZL+1.0E-6.'
            STOP 'ZU must be greater than ZL+1.0E-6.'
          ENDIF
          IF(NDB(3).LT.0.OR.NDB(3).GT.NDZM) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,'(''NDB(3) must be .GT.0. and .LT.'',I4)') NDZM
            WRITE(26,*) 'Increase the value of the parameter NDZM.'
            STOP 'NDB(3) must be .GT.0. and .LE.NDZM'
          ENDIF
          WRITE(26,1712) DXL(3),DXU(3),NDB(3)
 1712     FORMAT(3X,'ZL = ',1P,E13.6,' cm,  ZU = ',E13.6,
     1      ' cm,  NDBZ =',I4)
        ELSE
          WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
          WRITE(26,*) 'Unrecognized keyword.'
          STOP 'Unrecognized keyword.'
        ENDIF
C
        DO I=1,3
          BDOEV(I)=1.0000001D0*(DXU(I)-DXL(I))/DBLE(NDB(I))
          BDOEVR(I)=1.0D0/BDOEV(I)
        ENDDO
C
C  ****  Events to be mapped.
C
   74   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 74
        IF(KWORD.EQ.KEVENT) THEN
          NEVENT=NEVENT+1
          IF(NEVENT.GT.NEVM) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,*) 'Too many maps.'
            STOP 'Too many maps.'
          ENDIF
          IEVENT(NEVENT)=1
          READ(BUFFER,*) XEMIN(NEVENT),XEMAX(NEVENT)
          IF(XEMIN(NEVENT).GT.XEMAX(NEVENT)) THEN
            SAVE=XEMIN(NEVENT)
            XEMIN(NEVENT)=XEMAX(NEVENT)
            XEMAX(NEVENT)=SAVE
          ENDIF
          WRITE(26,1714) XEMIN(NEVENT),XEMAX(NEVENT)
 1714     FORMAT(3X,'X-ray energy interval:  from',1P,E13.6,' keV to',
     1      E13.6,' keV')
          GO TO 74
        ELSE IF(KWORD.EQ.KEVEN2) THEN
          NEVENT=NEVENT+1
          IF(NEVENT.GT.NEVM) THEN
            WRITE(26,'(A6,1X,A120)') KWORD,BUFFER
            WRITE(26,*) 'Too many maps.'
            STOP 'Too many maps.'
          ENDIF
          IEVENT(NEVENT)=2
          READ(BUFFER,*) ITRANS(NEVENT)
          CALL PEILB4(ITRANS(NEVENT),IZZ,IS1,IS2,IS3)
          IF(IS3.NE.0) THEN
            WRITE(26,'(A)') BUFFER
            WRITE(26,*) 'Non-radiative transition.'
            STOP 'Non-radiative transition.'
          ENDIF
          WRITE(26,1715) IZZ,CS2(IS1),CS2(IS2)
 1715     FORMAT(3X,'X-ray emission line:  Z = ',I2,',',A2,'-',A2)
          GO TO 74
        ENDIF
      ENDIF
C
C  ************  Job characteristics.
C
      WRITE(26,1800)
 1800 FORMAT(/3X,72('-'),/
     1  3X,'>>>>>>  Job characteristics.')
C
      IRESUM=0
      IF(KWORD.EQ.KWRESU) THEN
        READ(BUFFER,'(A20)') PFILER
        WRITE(26,1810) PFILER
 1810   FORMAT(3X,'Resume simulation from previous dump file: ',A20)
        IRESUM=1
   81   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 81
      ENDIF
C
      LDUMP=.FALSE.
      DUMPP=1.0D15
      IF(KWORD.EQ.KWDUMP) THEN
        READ(BUFFER,'(A20)') PFILED
        WRITE(26,1820) PFILED
 1820   FORMAT(3X,'Write final counter values on the dump file: ',A20)
        LDUMP=.TRUE.
   82   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 82
      ENDIF
C
      IF(KWORD.EQ.KWDMPP) THEN
        READ(BUFFER,*) DUMPP
        IF(LDUMP) THEN
          IF(DUMPP.LT.15.0D0) DUMPP=15.0D0
          IF(DUMPP.GT.86400.0D0) DUMPP=86400.0D0
          WRITE(26,1830) DUMPP
 1830     FORMAT(3X,'Dumping period: DUMPP =',1P,E13.6)
        ENDIF
   83   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 83
      ENDIF
C
      IF(KWORD.EQ.KWRSEE) THEN
        READ(BUFFER,*) ISEED1,ISEED2
        IF(ISEED1.LT.0) CALL RAND0(-ISEED1)
        WRITE(26,1850) ISEED1,ISEED2
 1850   FORMAT(3X,'Random-number generator seeds = ',I10,', ',I10)
   85   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 85
      ELSE
        ISEED1=1
        ISEED2=1
        WRITE(26,1850) ISEED1,ISEED2
      ENDIF
C
      IF(KWORD.EQ.KWREFL) THEN
        READ(BUFFER,*) IENDL,IENDD,TOL
        TOL=ABS(TOL)
        WRITE(26,1851) IENDL,IENDD,TOL
 1851   FORMAT(/3X,'Reference line: ',I8,',  detector =',I3,
     1    ',  tolerance =',1P,E9.2)
   86   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 86
      ELSE
        IENDD=0
        IENDL=0
        IENDTR=0
        TOL=0.0D0
      ENDIF
C
      IF(KWORD.EQ.KWNSIM) THEN
        READ(BUFFER,*) DSHN
        IF(DSHN.LT.1.0D0) DSHN=2.0D9
   84   CONTINUE
        READ(5,'(A6,1X,A120)') KWORD,BUFFER
        IF(KWORD.EQ.KWCOMM) GO TO 84
      ELSE
        DSHN=2.0D9
      ENDIF
      WRITE(26,1840) DSHN
 1840 FORMAT(/3X,'Number of showers to be simulated =',1P,E13.6)
C
      IF(KWORD.EQ.KWTIME) THEN
        READ(BUFFER,*) TIMEA
      ELSE
        TIMEA=100.0D0
      ENDIF
      IF(TIMEA.LT.1.0D0) TIMEA=100.0D0
      WRITE(26,1860) TIMEA
 1860 FORMAT(3X,'Computation time available = ',1P,E13.6,' sec')
C
      CALL TIMER(TSECIN)
      TSECA=TIMEA+TSECIN
      TSECAD=TSECIN
      WRITE(26,1870)
 1870 FORMAT(/3X,72('-'))
C
C  ************  Sorted list of radiative transitions.
C
      DO I=1,NTRANS
        IZS(I)=0
        IS1S(I)=0
        IS2S(I)=0
        ENERGS(I)=0.0D0
      ENDDO
C
      IS3=0
      NPTRAN=0 ! Number of radiative transitions.
      DO M=1,NMAT
        DO IEL=1,NELEM(M)
          IZZ=IZ(M,IEL)
          DO IS1=1,NIS
            DO IS2=1,NIS
              CALL RELAXE(IZZ,IS1,IS2,IS3,ENERGY,TRPROB)
              IF(ENERGY.LT.1.0D34) THEN
                DO I=1,MAX(NPTRAN,1)
                  IF((IZS(I).EQ.IZZ).AND.(IS1S(I).EQ.IS1).AND.
     1              (IS2S(I).EQ.IS2)) GO TO 1900
                ENDDO
                NPTRAN=NPTRAN+1
                IF(NPTRAN.GT.NTRANS) STOP 'Too many x-ray lines.'
                IZS(NPTRAN)=IZZ
                IS1S(NPTRAN)=IS1
                IS2S(NPTRAN)=IS2
                ENERGS(NPTRAN)=ENERGY
              ENDIF
 1900         CONTINUE
            ENDDO
          ENDDO
        ENDDO
      ENDDO
C
C  ---- Sort the transitions by increasing energies.

      IF(NPTRAN.GT.1) THEN
        DO I=1,NPTRAN-1
          DO J=I+1,NPTRAN
            IF(ENERGS(I).GT.ENERGS(J)) THEN
              ISAVE=IZS(I)
              IZS(I)=IZS(J)
              IZS(J)=ISAVE
              ISAVE=IS1S(I)
              IS1S(I)=IS1S(J)
              IS1S(J)=ISAVE
              ISAVE=IS2S(I)
              IS2S(I)=IS2S(J)
              IS2S(J)=ISAVE
              SAVE=ENERGS(I)
              ENERGS(I)=ENERGS(J)
              ENERGS(J)=SAVE
            ENDIF
          ENDDO
        ENDDO
      ENDIF
C
      IF(IENDL.GT.0) THEN
        DO I=1,NPTRAN
          ILB4=IZS(I)*1000000+IS1S(I)*10000+IS2S(I)*100
          IF(IENDL.EQ.ILB4) THEN
            IENDTR=I
          ENDIF
        ENDDO
      ENDIF
C
C  ************  If 'RESUME' is active, read previously generated
C                counters...
C
      SHNA=0.0D0
      CPUTA=0.0D0
      IRETRN=0
C
      DO ID=1,NDEDEF
        RLAST(ID)=0.0D0
        RWRITE(ID)=0.0D0
      ENDDO
C
      IF(IRESUM.EQ.1) THEN
        WRITE(6,*) ' Reading the DUMP file ...'
        OPEN(9,FILE=PFILER)
        READ (9,*,ERR=91,END=91) SHNA,CPUTA
        READ (9,'(A120)',ERR=90) TITLE2
        IF(TITLE2.NE.TITLE) THEN
          WRITE(26,*)
     1      'The dump file is corrupted (the TITLE does not match).'
          STOP 'The dump file is corrupted (the TITLE does not match).'
        ENDIF
        READ (9,*,ERR=90) ISEED1,ISEED2
        READ (9,*,ERR=90) NSEB
        READ (9,*,ERR=90) (ESRC(I),I=1,NSEB+1)
        READ (9,*,ERR=90) (PSRC(I),I=1,NSEB+1)
        READ (9,*,ERR=90) (SHIST(I),I=1,NSEB+1)
        READ (9,*,ERR=90) (PRIM(I),I=1,3)
        READ (9,*,ERR=90) (PRIM2(I),I=1,3)
        READ (9,*,ERR=90) ((SEC(K,I),I=1,3),K=1,3)
        READ (9,*,ERR=90) ((SEC2(K,I),I=1,3),K=1,3)
        READ (9,*,ERR=90) NBODY
        READ (9,*,ERR=90) (TDEBO(I),I=1,NBODY)
        READ (9,*,ERR=90) (TDEBO2(I),I=1,NBODY)
C
        READ (9,*,ERR=90) NBE,EMIN,EMAX,BSE(1),BSE(2)
        READ (9,*,ERR=90) (((PDE(I,J,K),K=1,NBE),J=1,2),I=1,3)
        READ (9,*,ERR=90) (((PDE2(I,J,K),K=1,NBE),J=1,2),I=1,3)
        READ (9,*,ERR=90) NBTH,NBPH,BSTH,BSPH
        READ (9,*,ERR=90) (((PDA(I,J,K),K=1,NBPH),J=1,NBTH),I=1,3)
        READ (9,*,ERR=90) (((PDA2(I,J,K),K=1,NBPH),J=1,NBTH),I=1,3)
        READ (9,*,ERR=90) ((PDAT(I,J),J=1,NBTH),I=1,3)
        READ (9,*,ERR=90) ((PDAT2(I,J),J=1,NBTH),I=1,3)
        READ (9,*,ERR=90) NDEDEF
        READ (9,*,ERR=90) (TDED(I),I=1,NDEDEF)
        READ (9,*,ERR=90) (TDED2(I),I=1,NDEDEF)
        READ (9,*,ERR=90) (RLAST(ID),ID=1,NDEDEF)
        READ (9,*,ERR=90) (RWRITE(ID),ID=1,NDEDEF)
C
        READ (9,*,ERR=90) (PHI1(ID),ID=1,NDEDEF)
        READ (9,*,ERR=90) (PHI2(ID),ID=1,NDEDEF)
        READ (9,*,ERR=90) (THETA1(ID),ID=1,NDEDEF)
        READ (9,*,ERR=90) (THETA2(ID),ID=1,NDEDEF)
        READ (9,*,ERR=90) (EDEL(ID),ID=1,NDEDEF)
        READ (9,*,ERR=90) (EDEU(ID),ID=1,NDEDEF)
        READ (9,*,ERR=90) (BDEE(ID),ID=1,NDEDEF)
        READ (9,*,ERR=90) (NDECH(ID),ID=1,NDEDEF)
        DO ID=1,NDEDEF
          READ (9,*,ERR=90) (DET(ID,J),J=1,NDECH(ID))
          READ (9,*,ERR=90) (DET2(ID,J),J=1,NDECH(ID))
        ENDDO
C
        READ (9,*,ERR=90) NEVENT
        IF(NEVENT.NE.0) THEN
          READ (9,*,ERR=90) (DXL(I),I=1,3),(DXU(I),I=1,3)
          READ (9,*,ERR=90) (BDOEV(I),I=1,3),(BDOEVR(I),I=1,3)
          READ (9,*,ERR=90) (NDB(I),I=1,3)
          READ (9,*,ERR=90) (IEVENT(I),I=1,NEVENT)
          READ (9,*,ERR=90) (XEMIN(I),I=1,NEVENT)
          READ (9,*,ERR=90) (XEMAX(I),I=1,NEVENT)
          READ (9,*,ERR=90) (ITRANS(I),I=1,NEVENT)
          READ (9,*,ERR=90)
     1      ((((DOEV(NEV,I1,I2,I3),I3=1,NDB(3)),I2=1,NDB(2)),
     1          I1=1,NDB(1)),NEV=1,NEVENT)
          READ (9,*,ERR=90)
     1      ((((DOEV2(NEV,I1,I2,I3),I3=1,NDB(3)),I2=1,NDB(2)),
     1          I1=1,NDB(1)),NEV=1,NEVENT)
          READ (9,*,ERR=90) ((DREV(NEV,IR),IR=1,NDB(1)),NEV=1,NEVENT)
          READ (9,*,ERR=90) ((DREV2(NEV,IR),IR=1,NDB(1)),NEV=1,NEVENT)
        ENDIF
C
        READ (9,*,ERR=90) NDEDEF,NPTRAN,NILB5R
        READ (9,*,ERR=90) (IZS(IT),IT=1,NPTRAN)
        READ (9,*,ERR=90) (IS1S(IT),IT=1,NPTRAN)
        READ (9,*,ERR=90) (IS2S(IT),IT=1,NPTRAN)
        READ (9,*,ERR=90) (ENERGS(IT),IT=1,NPTRAN)
        DO ID=1,NDEDEF
          DO I=1,NPTRAN
            IZZ=IZS(I)
            IS1=IS1S(I)
            IS2=IS2S(I)
          READ (9,*,ERR=90) PTIoT(ID,IZZ,IS1,IS2),PTIoT2(ID,IZZ,IS1,IS2)
          READ (9,*,ERR=90) (PTIoF(ID,IZZ,IS1,IS2,L),L=1,NILB5)
          READ (9,*,ERR=90) (PTIoF2(ID,IZZ,IS1,IS2,L),L=1,NILB5)
          ENDDO
        ENDDO
        DO I=1,NPTRAN
          IZZ=IZS(I)
          IS1=IS1S(I)
          IS2=IS2S(I)
          READ (9,*,ERR=90) PTIGT(IZZ,IS1,IS2),PTIGT2(IZZ,IS1,IS2)
          READ (9,*,ERR=90) (PTIoG(IZZ,IS1,IS2,L),L=1,NILB5)
          READ (9,*,ERR=90) (PTIoG2(IZZ,IS1,IS2,L),L=1,NILB5)
        ENDDO
        READ (9,*,ERR=90) (PDEBR(I),I=1,NBE)
        READ (9,*,ERR=90) (PDEBR2(I),I=1,NBE)
        CLOSE(9)
        WRITE(26,1880) PFILER
 1880   FORMAT(3X,'Simulation has been resumed from dump file: ',A20)
        GO TO 92
   90   CONTINUE
        WRITE(26,*) 'The dump file is empty or corrupted.'
        STOP 'The dump file is empty or corrupted.'
   91   CONTINUE
        WRITE(26,1890)
 1890   FORMAT(3X,'WARNING: Could not resume from dump file...')
        CLOSE(9)
        IRESUM=0
      ENDIF
   92 CONTINUE
C
      IF(NDEDEF.GT.0) THEN
        DO ID=1,NDEDEF
          IF(IPSF(ID).NE.0) THEN
            IPSFU=20+ID
            OPEN(IPSFU,FILE=PSFDIO(ID),IOSTAT=KODE)
            IF(KODE.NE.0) THEN
              WRITE(26,'(''File '',A20,'' could not be opened.'')')
     1          PSFDIO(ID)
              STOP 'File could not be opened.'
            ENDIF
            RWR=0.0D0
            IF(RWRITE(ID).GT.0) THEN
   93         CONTINUE
              CALL RDPSF(IPSFU,PSFREC,KODE)
              IF(KODE.NE.0) THEN
                GO TO 94
              ELSE
                RWR=RWR+1.0D0
                IF(RWR.LT.RWRITE(ID)-0.5D0) GO TO 93
                GO TO 94
              ENDIF
            ENDIF
   94       CONTINUE
            IF(RWR.LT.0.5D0) THEN
              WRITE(IPSFU,1901) ID
 1901         FORMAT(1X,'#  Results from PENEPMA. Phase-space fi',
     1          'le of detector no.',I3,/1X,'#')
              WRITE(IPSFU,1902)
 1902         FORMAT(1X,'#/KPAR',2X,'E',12X,'X',12X,'Y',12X,'Z',12X,
     1          'U',12X,'V',12X,'W',11X,'WGHT',5X,'ILB(1:4)',7X,'NSHI',
     1          /1X,'#',125('-'))
            ENDIF
          ENDIF
        ENDDO
      ENDIF
C
C  ************  Initialise constants.
C
      SHN=SHNA          ! Shower counter, including the dump file.
      DSHN=DSHN+SHNA
      N=MOD(SHN,2.0D9)+0.5D0
      TSIM=CPUTA
      CPUT0=CPUTIM()
      IF(SHN.GE.DSHN) GO TO 105
      WRITE(6,*) ' The simulation is started ...'
C
C
C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C  ------------------------  Shower simulation starts here.
C
  101 CONTINUE
C
C  ************  Primary particle counters.
C
      DO I=1,3
        DPRIM(I)=0.0D0
        DO K=1,3
          DSEC(K,I)=0.0D0
        ENDDO
      ENDDO
      DO ID=1,NDEDEF
        DEDE(ID)=0.0D0
      ENDDO
      DO KBi=1,NBODY
        DEBO(KBi)=0.0D0  ! Energies deposited in the various bodies KB.
      ENDDO
      IEXIT=0
C
      CALL CLEANS          ! Cleans the secondary stack.
C
C  **********  Set the initial state of the primary particle.
C
C  ****  Point source.
      SHN=SHN+1.0D0
      N=N+1
      IF(N.GT.2000000000) N=N-2000000000
      KPAR=KPARP
      WGHT=WGHT0
C  ----  Initial position ...
      X=SX0
      Y=SY0
      Z=SZ0
      IF(SRAD.GT.0.0D0) THEN
        RR=SQRT(RAND(1.0D0))*SRAD
        PHI=TWOPI*RAND(2.0D0)
        DX=RR*COS(PHI)
        DY=RR*SIN(PHI)
        DZ=0.0D0
        CALL GCONEP(DX,DY,DZ)
        X=X+DX
        Y=Y+DY
        Z=Z+DZ
      ENDIF
C  ----  Initial direction ...
      CALL GCONE(U,V,W)
C  ----  Initial energy ...
      IF(LSPEC) THEN
        RN=RAND(6.0D0)*NSEB+1
        K=INT(RN) ! Continuous spectrum. E sampled by Walker's method.
        RNF=RN-K
        IF(RNF.GT.FSRC(K)) THEN
          KEn=IASRC(K)
        ELSE
          KEn=K
        ENDIF
        E=ESRC(KEn)+RAND(7.0D0)*(ESRC(KEn+1)-ESRC(KEn))
        SHIST(KEn)=SHIST(KEn)+1.0D0
      ELSE
        E=E0      ! Monoenergetic source.
        SHIST(1)=SHIST(1)+1.0D0
      ENDIF
      ILB(1)=1  ! Identifies primary particles.
      ILB(2)=0
      ILB(3)=0
      ILB(4)=0
      ILB(5)=1 ! Used to track the origin of photons (1: primary,
               ! 2: characteristic, 3: bremsstrahlung).
C
C  ****  Check if the trajectory intersects the material system.
C
      CALL LOCATE
C
      IF(MAT.EQ.0) THEN
        CALL STEP(1.0D30,DSEF,NCROSS)
        IF(MAT.EQ.0) THEN  ! The particle does not enter the system.
          IF(W.GT.0) THEN
            IEXIT=1        ! Labels emerging 'upbound' particles.
          ELSE
            IEXIT=2        ! Labels emerging 'downbound' particles.
          ENDIF
          GO TO 104        ! Exit.
        ENDIF
      ENDIF
C  ---------------------------------------------------------------------
C  ------------------------  Track simulation begins here.
C
      XORIG=X
      YORIG=Y
      ZORIG=Z
  102 CONTINUE
      IF(E.LT.EABS(KPAR,MAT)) THEN  ! The particle has been absorbed.
        IEXIT=3                     ! Labels absorbed particles.
        GO TO 104                   ! Exit.
      ENDIF
      CALL START           ! Starts simulation in current medium.
C
  103 CONTINUE
c<<   write(6,'(''n,kpar,gen,x,y,z,w,e,ibody='',3i3,1p,5e11.3,i3)')
c<<  1    mod(n,100),kpar,ilb(1),x,y,z,w,e,ibody
C
      IBODYL=IBODY
      IF(LFORCE(IBODY,KPAR).AND.((WGHT.GT.WLOW(IBODY,KPAR)).AND.
     1  (WGHT.LT.WHIG(IBODY,KPAR)))) THEN
        CALL JUMPF(DSMAX(IBODY),DS)  ! Interaction forcing.
        LINTF=.TRUE.
      ELSE
        CALL JUMP(DSMAX(IBODY),DS)   ! Analogue simulation.
        LINTF=.FALSE.
      ENDIF
      CALL STEP(DS,DSEF,NCROSS)      ! Determines step end position.
C  ----  If the particle has crossed an interface, restart the track in
C        the new material.
      IF(NCROSS.GT.0) THEN
C  ----  Correction to the soft energy loss (CSDA).
        IF(KPAR.NE.2) THEN
          E=E0STEP-SSOFT*DSEF
          IF(MHINGE.EQ.0) THEN
            DEBO(IBODYL)=DEBO(IBODYL)+SSOFT*DSEF*WGHT
          ELSE
            DEBO(IBODYL)=DEBO(IBODYL)-SSOFT*(DS-DSEF)*WGHT
          ENDIF
        ENDIF
C
        IF(MAT.EQ.0) THEN  ! The particle is outside the enclosure.
          IF(W.GT.0.0D0) THEN
            IEXIT=1        ! Labels emerging 'upbound' particles.
          ELSE
            IEXIT=2        ! Labels emerging 'downbound' particles.
          ENDIF
          GO TO 104        ! Exit.
        ENDIF
        GO TO 102
      ENDIF
C  ----  Simulate next event.
      IF(LINTF) THEN
        CALL KNOCKF(DE,ICOL)  ! Interaction forcing is active.
      ELSE
        CALL KNOCK(DE,ICOL)  ! Analogue simulation.
      ENDIF
C
      IF(E.LT.EABS(KPAR,MAT)) THEN  ! The particle has been absorbed.
        DE=DE+E
        E=0.0D0
      ENDIF
C
      DEBO(IBODY)=DEBO(IBODY)+DE*WGHT
C
      IF(E.LT.EABS(KPAR,MAT)) THEN  ! The particle has been absorbed.
        IEXIT=3                     ! Labels absorbed particles.
        GO TO 104                   ! Exit.
      ENDIF
C
      GO TO 103
C  ------------------------  The simulation of the track ends here.
C  ---------------------------------------------------------------------
  104 CONTINUE
C
C  ************  Increment particle counters.
C
      IF(ILB(1).EQ.1) THEN
        DPRIM(IEXIT)=DPRIM(IEXIT)+WGHT
      ELSE
        DSEC(KPAR,IEXIT)=DSEC(KPAR,IEXIT)+WGHT
      ENDIF
C
      IF(IEXIT.LT.3) THEN
C  ****  Energy distribution of emerging particles.
        K=1.0D0+(E-EMIN)/BSE(KPAR)
        IF(K.GT.0.AND.K.LE.NBE) THEN
          IF(N.NE.LPDE(KPAR,IEXIT,K)) THEN
            PDE(KPAR,IEXIT,K)=PDE(KPAR,IEXIT,K)+PDEP(KPAR,IEXIT,K)
            PDE2(KPAR,IEXIT,K)=PDE2(KPAR,IEXIT,K)+PDEP(KPAR,IEXIT,K)**2
            PDEP(KPAR,IEXIT,K)=WGHT
            LPDE(KPAR,IEXIT,K)=N
          ELSE
            PDEP(KPAR,IEXIT,K)=PDEP(KPAR,IEXIT,K)+WGHT
          ENDIF
        ENDIF
C  ****  Angular distribution of emerging particles.
        THETA=ACOS(W)
        KTH=1.0D0+THETA*RA2DE/BSTH
        IF(ABS(U).GT.1.0D-16) THEN  !  Azimuthal bin number corrected.
           PHI=ATAN2(V,U)
        ELSE IF(ABS(V).GT.1.0D-16) THEN
           PHI=ATAN2(V,U)
        ELSE
           PHI=0.0D0
        ENDIF
        IF(PHI.LT.0.0D0) PHI=PHI+TWOPI
        KPH=1.0D0+PHI*RA2DE/BSPH
        IF(N.NE.LPDA(KPAR,KTH,KPH)) THEN
          PDA(KPAR,KTH,KPH)=PDA(KPAR,KTH,KPH)+PDAP(KPAR,KTH,KPH)
          PDA2(KPAR,KTH,KPH)=PDA2(KPAR,KTH,KPH)+PDAP(KPAR,KTH,KPH)**2
          PDAP(KPAR,KTH,KPH)=WGHT
          LPDA(KPAR,KTH,KPH)=N
        ELSE
          PDAP(KPAR,KTH,KPH)=PDAP(KPAR,KTH,KPH)+WGHT
        ENDIF
C
        IF(N.NE.LPDAT(KPAR,KTH)) THEN
          PDAT(KPAR,KTH)=PDAT(KPAR,KTH)+PDATP(KPAR,KTH)
          PDAT2(KPAR,KTH)=PDAT2(KPAR,KTH)+PDATP(KPAR,KTH)**2
          PDATP(KPAR,KTH)=WGHT
          LPDAT(KPAR,KTH)=N
        ELSE
          PDATP(KPAR,KTH)=PDATP(KPAR,KTH)+WGHT
        ENDIF
C  ****  Spectra of photon detectors.
        IF(KPAR.EQ.2) THEN
c<<       write(6,*) 'theta,phi =',theta*ra2de,phi*ra2de
          DO ID=1,NDEDEF
            IF(PHI1(ID).LT.0.0D0) THEN
              IF(PHI.GT.PI) THEN
                PHID=PHI-TWOPI
              ELSE
                PHID=PHI
              ENDIF
            ELSE
              PHID=PHI
            ENDIF
            IF(PHID.GT.PHI1(ID).AND.PHID.LT.PHI2(ID).AND.
     1          THETA.GT.THETA1(ID).AND.THETA.LT.THETA2(ID)) THEN
              IF(E.GT.EDEL(ID).AND.E.LT.EDEU(ID)) THEN
                DEDE(ID)=DEDE(ID)+E*WGHT
                IE=1.0D0+(E-EDEL(ID))/BDEE(ID)
C  ****  All photons (full spectrum).
                IF(N.NE.LDET(ID,IE)) THEN
                  DET(ID,IE)=DET(ID,IE)+DETP(ID,IE)
                  DET2(ID,IE)=DET2(ID,IE)+DETP(ID,IE)**2
                  DETP(ID,IE)=WGHT
                  LDET(ID,IE)=N
                ELSE
                  DETP(ID,IE)=DETP(ID,IE)+WGHT
                ENDIF
C
                IF(IORIG(ID).NE.0) THEN
                  WRITE(60+ID,'(1P,3E13.5)') XORIG,YORIG,ZORIG
                ENDIF
C
                IF(IPSF(ID).GT.0) THEN
                  IF(IPSF(ID).EQ.1) THEN
                    NSHJ=SHN-RLAST(ID)
                    CALL N2CH10(NSHJ,LCH10,NDIG)
                    WRITE(20+ID,'(I2,1P,8E13.5,I3,I2,I2,I9,1X,A)')
     1                KPAR,E,X,Y,Z,U,V,W,WGHT,
     1                ILB(1),ILB(2),ILB(3),ILB(4),LCH10(1:NDIG)
                    RWRITE(ID)=RWRITE(ID)+1.0D0
                    RLAST(ID)=SHN
                  ELSE IF(IPSF(ID).EQ.ILB(4)) THEN
                    NSHJ=SHN-RLAST(ID)
                    CALL N2CH10(NSHJ,LCH10,NDIG)
                    WRITE(20+ID,'(I2,1P,8E13.5,I3,I2,I2,I9,1X,A)')
     1                KPAR,E,X,Y,Z,U,V,W,WGHT,
     1                ILB(1),ILB(2),ILB(3),ILB(4),LCH10(1:NDIG)
                    RWRITE(ID)=RWRITE(ID)+1.0D0
                    RLAST(ID)=SHN
                  ENDIF
                ENDIF
              ENDIF
C
C  ****  Intensities of charact. lines (excluding electron bremss).
C
              IF(.NOT.(ILB(2).EQ.1.AND.ILB(3).EQ.4).AND.ILB(4).GT.0)
     1          THEN
                CALL PEILB4(ILB(4),IZZ,IS1,IS2,IS3)
C  ----  All characteristic lines.
                IF(N.NE.LPTIoT(ID,IZZ,IS1,IS2)) THEN
                  PTIoT(ID,IZZ,IS1,IS2)=PTIoT(ID,IZZ,IS1,IS2)+
     1              PTIoTP(ID,IZZ,IS1,IS2)
                  PTIoT2(ID,IZZ,IS1,IS2)=PTIoT2(ID,IZZ,IS1,IS2)+
     1              PTIoTP(ID,IZZ,IS1,IS2)**2
                  PTIoTP(ID,IZZ,IS1,IS2)=WGHT
                  LPTIoT(ID,IZZ,IS1,IS2)=N
                ELSE
                  PTIoTP(ID,IZZ,IS1,IS2)=PTIoTP(ID,IZZ,IS1,IS2)+WGHT
                ENDIF
C  ----  Fluorescent x-rays (2nd and higher generations).
                ILB5=ILB(5)
                IF(ILB(1).EQ.2.OR.ILB(2).NE.2) ILB5=1  ! Primary x ray.
                IF(N.NE.LPTIoF(ID,IZZ,IS1,IS2,ILB5)) THEN
                  PTIoF(ID,IZZ,IS1,IS2,ILB5)=
     1              PTIoF(ID,IZZ,IS1,IS2,ILB5)+
     1              PTIoFP(ID,IZZ,IS1,IS2,ILB5)
                  PTIoF2(ID,IZZ,IS1,IS2,ILB5)=
     1              PTIoF2(ID,IZZ,IS1,IS2,ILB5)+
     1              PTIoFP(ID,IZZ,IS1,IS2,ILB5)**2
                  PTIoFP(ID,IZZ,IS1,IS2,ILB5)=WGHT
                  LPTIoF(ID,IZZ,IS1,IS2,ILB5)=N
                ELSE
                  PTIoFP(ID,IZZ,IS1,IS2,ILB5)=
     1              PTIoFP(ID,IZZ,IS1,IS2,ILB5)+WGHT
                ENDIF
              ENDIF
            ENDIF
          ENDDO
        ENDIF
      ENDIF
C
C  ************  Any secondary left?
C
  202 CONTINUE
      CALL SECPAR(LEFT)
      IF(LEFT.GT.0) THEN
C  ****  Simulate particles up to the 6th generation.
        IF(ILB(1).GT.6) GO TO 202
C
        IF(KPAR.EQ.2) THEN
C
C  ****  X-ray splitting.
          IF(ILB(4).GT.0) THEN  ! Characteristic x rays.
            IF(ILB(1).EQ.2.AND.ILB(3).LT.9) THEN  ! Unsplit, 2nd gen.
              IF(LXRSPL(IBODY)) THEN
                WGHT=WGHT/DBLE(IXRSPL(IBODY))
                ILBA(1)=ILB(1)
                ILBA(2)=ILB(2)
                ILBA(3)=9
                ILBA(4)=ILB(4)
                ILBA(5)=ILB(5)
                DO I=2,IXRSPL(IBODY)
                  WS=-1.0D0+2.0D0*RAND(10.0D0)
                  SDTS=SQRT(1.0D0-WS*WS)
                  DF=TWOPI*RAND(11.0D0)
                  US=COS(DF)*SDTS
                  VS=SIN(DF)*SDTS
                  CALL STORES(E,X,Y,Z,US,VS,WS,WGHT,KPAR,ILBA,0)
                ENDDO
              ENDIF
            ENDIF
          ENDIF
C
C  ****  Energy distribution of emitted bremsstrahlung photons.
          IF(ILB(2).EQ.1.AND.ILB(3).EQ.4) THEN
            K=1.0D0+(E-EMIN)/BSE(KPAR)
            IF(K.GT.0.AND.K.LE.NBE) THEN
              IF(N.NE.LPDEBR(K)) THEN
                PDEBR(K)=PDEBR(K)+PDEBRP(K)
                PDEBR2(K)=PDEBR2(K)+PDEBRP(K)**2
                PDEBRP(K)=WGHT
                LPDEBR(K)=N
              ELSE
                PDEBRP(K)=PDEBRP(K)+WGHT
              ENDIF
            ENDIF
          ENDIF
C
C  ****  Set ILB(5) for primary photons, to separate fluorescence
C  from characteritic x rays and from the bremsstrahlung continuum.
          IF(ILB(5).EQ.1) THEN
            IF(ILB(3).EQ.5) THEN
              ILB(5)=2  ! Characteristic x-ray from a shell ionization.
            ELSE IF(ILB(3).EQ.4) THEN
              ILB(5)=3  ! Bremsstrahlung photon.
            ENDIF
          ENDIF
C
C  *****  Store generated intensities of characteristic lines
          IF(.NOT.(ILB(2).EQ.1.AND.ILB(3).EQ.4).AND.ILB(4).GT.0) THEN
            CALL PEILB4(ILB(4),IZZ,IS1,IS2,IS3)
C  ----  All characteristic lines.
            IF(N.NE.LPTIGT(IZZ,IS1,IS2)) THEN
              PTIGT(IZZ,IS1,IS2)=PTIGT(IZZ,IS1,IS2)+PTIGTP(IZZ,IS1,IS2)
              PTIGT2(IZZ,IS1,IS2)=PTIGT2(IZZ,IS1,IS2)+
     1              PTIGTP(IZZ,IS1,IS2)**2
              PTIGTP(IZZ,IS1,IS2)=WGHT
              LPTIGT(IZZ,IS1,IS2)=N
            ELSE
              PTIGTP(IZZ,IS1,IS2)=PTIGTP(IZZ,IS1,IS2)+WGHT
            ENDIF
C  ----  Fluorescent x-rays (2nd and higher generations).
            ILB5=ILB(5)
            IF(ILB(1).EQ.2.OR.ILB(2).NE.2) ILB5=1  ! Primary x ray.
            IF(N.NE.LPTIoG(IZZ,IS1,IS2,ILB5)) THEN
              PTIoG(IZZ,IS1,IS2,ILB5)=PTIoG(IZZ,IS1,IS2,ILB5)+
     1          PTIoGP(IZZ,IS1,IS2,ILB5)
              PTIoG2(IZZ,IS1,IS2,ILB5)=PTIoG2(IZZ,IS1,IS2,ILB5)+
     1          PTIoGP(IZZ,IS1,IS2,ILB5)**2
              PTIoGP(IZZ,IS1,IS2,ILB5)=WGHT
              LPTIoG(IZZ,IS1,IS2,ILB5)=N
            ELSE
              PTIoGP(IZZ,IS1,IS2,ILB5)=PTIoGP(IZZ,IS1,IS2,ILB5)+WGHT
            ENDIF
          ENDIF
C
C  ****  Spatial distribution of x-ray emission events.
          IF(NEVENT.GT.0) THEN
            I1=0;I2=0;I3=0  ! To prevent compiler warnings.
            ITST=0
            DO NEV=1,NEVENT
              IF(IEVENT(NEV).EQ.1) THEN
                IF(ILB(4).NE.0) THEN
                  IF(XEMIN(NEV).LT.E.AND.XEMAX(NEV).GT.E) THEN
                    IF(ITST.EQ.0) THEN
                      IF((X.GT.DXL(1).AND.X.LT.DXU(1)).AND.
     1                   (Y.GT.DXL(2).AND.Y.LT.DXU(2)).AND.
     1                   (Z.GT.DXL(3).AND.Z.LT.DXU(3))) THEN
                        I1=1.0D0+(X-DXL(1))*BDOEVR(1)
                        I2=1.0D0+(Y-DXL(2))*BDOEVR(2)
                        I3=1.0D0+(Z-DXL(3))*BDOEVR(3)
                        ITST=1
                      ELSE
                        GO TO 204
                      ENDIF
                    ENDIF
                    IF(N.NE.LDOEV(NEV,I1,I2,I3)) THEN
                      DOEV(NEV,I1,I2,I3)=DOEV(NEV,I1,I2,I3)
     1                  +DOEVP(NEV,I1,I2,I3)
                      DOEV2(NEV,I1,I2,I3)=DOEV2(NEV,I1,I2,I3)
     1                  +DOEVP(NEV,I1,I2,I3)**2
                      DOEVP(NEV,I1,I2,I3)=WGHT
                      LDOEV(NEV,I1,I2,I3)=N
                    ELSE
                      DOEVP(NEV,I1,I2,I3)=DOEVP(NEV,I1,I2,I3)+WGHT
                    ENDIF
C
                    IR=1.0D0+SQRT(X*X+Y*Y)*BDOEVR(1)
                    IF(IR.LE.NDB(1)) THEN
                      IF(N.NE.LDREV(NEV,IR)) THEN
                        DREV(NEV,IR)=DREV(NEV,IR)+DREVP(NEV,IR)
                        DREV2(NEV,IR)=DREV2(NEV,IR)+DREVP(NEV,IR)**2
                        DREVP(NEV,IR)=WGHT
                        LDREV(NEV,IR)=N
                      ELSE
                        DREVP(NEV,IR)=DREVP(NEV,IR)+WGHT
                      ENDIF
                    ENDIF
                  ENDIF
                ENDIF
              ENDIF
C
              IF(IEVENT(NEV).EQ.2) THEN
                IF(ILB(4).EQ.ITRANS(NEV)) THEN
                  IF(ITST.EQ.0) THEN
                    IF((X.GT.DXL(1).AND.X.LT.DXU(1)).AND.
     1                 (Y.GT.DXL(2).AND.Y.LT.DXU(2)).AND.
     1                 (Z.GT.DXL(3).AND.Z.LT.DXU(3))) THEN
                      I1=1.0D0+(X-DXL(1))*BDOEVR(1)
                      I2=1.0D0+(Y-DXL(2))*BDOEVR(2)
                      I3=1.0D0+(Z-DXL(3))*BDOEVR(3)
                    ELSE
                      GO TO 204
                    ENDIF
                  ENDIF
                  IF(N.NE.LDOEV(NEV,I1,I2,I3)) THEN
                    DOEV(NEV,I1,I2,I3)=DOEV(NEV,I1,I2,I3)
     1                +DOEVP(NEV,I1,I2,I3)
                    DOEV2(NEV,I1,I2,I3)=DOEV2(NEV,I1,I2,I3)
     1                +DOEVP(NEV,I1,I2,I3)**2
                    DOEVP(NEV,I1,I2,I3)=WGHT
                    LDOEV(NEV,I1,I2,I3)=N
                  ELSE
                    DOEVP(NEV,I1,I2,I3)=DOEVP(NEV,I1,I2,I3)+WGHT
                  ENDIF
C
                  IR=1.0D0+SQRT(X*X+Y*Y)*BDOEVR(1)
                  IF(IR.LE.NDB(1)) THEN
                    IF(N.NE.LDREV(NEV,IR)) THEN
                      DREV(NEV,IR)=DREV(NEV,IR)+DREVP(NEV,IR)
                      DREV2(NEV,IR)=DREV2(NEV,IR)+DREVP(NEV,IR)**2
                      DREVP(NEV,IR)=WGHT
                      LDREV(NEV,IR)=N
                    ELSE
                      DREVP(NEV,IR)=DREVP(NEV,IR)+WGHT
                    ENDIF
                  ENDIF
                ENDIF
              ENDIF
            ENDDO
          ENDIF
  204     CONTINUE
        ENDIF
c<<   write(6,'(/''new secondary'')')
c<<   write(6,'(''n,kpar,gen,x,y,z,w,e,ibody='',3i3,1p,5e11.3,i3)')
c<<  1    mod(n,100),kpar,ilb(1),x,y,z,w,e,ibody
        DEBO(IBODY)=DEBO(IBODY)-E*WGHT  ! Energy is removed.
        XORIG=X
        YORIG=Y
        ZORIG=Z
        GO TO 102
      ENDIF
C
C  ------------------------  The simulation of the shower ends here.
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C
C
C
      DO I=1,3
        PRIM(I)=PRIM(I)+DPRIM(I)
        PRIM2(I)=PRIM2(I)+DPRIM(I)**2
        DO K=1,3
          SEC(K,I)=SEC(K,I)+DSEC(K,I)
          SEC2(K,I)=SEC2(K,I)+DSEC(K,I)**2
        ENDDO
      ENDDO
C
C  ****  Energies deposited in different bodies.
C
      DO KB=1,NBODY
        TDEBO(KB)=TDEBO(KB)+DEBO(KB)
        TDEBO2(KB)=TDEBO2(KB)+DEBO(KB)**2
      ENDDO
C
C  ****  Energies entering the photon detectors.
C
      DO KD=1,NDEDEF
        TDED(KD)=TDED(KD)+DEDE(KD)
        TDED2(KD)=TDED2(KD)+DEDE(KD)**2
      ENDDO
C
  105 CONTINUE
      CALL TIMER(TSEC)
C
C  ----  End the simulation after the allotted time or after completing
C        DSHN showers.
C
      IRETRN=0
      IF(TSEC.LT.TSECA.AND.SHN.LT.DSHN) THEN
C  ****  Write partial results after each dumping period.
        IF(LDUMP) THEN
          IF(TSEC-TSECAD.GT.DUMPP) THEN
            TSECAD=TSEC
            IRETRN=1
            GO TO 203
          ENDIF
        ENDIF
        GO TO 101
      ENDIF
  203 CONTINUE
      TSIM=TSIM+CPUTIM()-CPUT0
C
C  ************  Transfer partial counters to global counters.
C
      DO KPARi=1,3
      DO IEXIT=1,2
      DO IE=1,NBE
        PDE(KPARi,IEXIT,IE)=PDE(KPARi,IEXIT,IE)+PDEP(KPARi,IEXIT,IE)
        PDE2(KPARi,IEXIT,IE)=PDE2(KPARi,IEXIT,IE)
     1     +PDEP(KPARi,IEXIT,IE)**2
        PDEP(KPARi,IEXIT,IE)=0.0D0
        LPDE(KPARi,IEXIT,IE)=0
      ENDDO
      ENDDO
      ENDDO
C
      DO KPARi=1,3
      DO KTH=1,NBTH
        PDAT(KPARi,KTH)=PDAT(KPARi,KTH)+PDATP(KPARi,KTH)
        PDAT2(KPARi,KTH)=PDAT2(KPARi,KTH)+PDATP(KPARi,KTH)**2
        PDATP(KPARi,KTH)=0.0D0
        LPDAT(KPARi,KTH)=0
        DO KPH=1,NBPH
          PDA(KPARi,KTH,KPH)=PDA(KPARi,KTH,KPH)+PDAP(KPARi,KTH,KPH)
          PDA2(KPARi,KTH,KPH)=PDA2(KPARi,KTH,KPH)+PDAP(KPARi,KTH,KPH)**2
          PDAP(KPARi,KTH,KPH)=0.0D0
          LPDA(KPARi,KTH,KPH)=0
        ENDDO
      ENDDO
      ENDDO
C
      DO ID=1,NDEDEF
        DO J=1,NDECH(ID)
          DET(ID,J)=DET(ID,J)+DETP(ID,J)
          DET2(ID,J)=DET2(ID,J)+DETP(ID,J)**2
          DETP(ID,J)=0.0D0
          LDET(ID,J)=0
        ENDDO
      ENDDO
C
      IF(NEVENT.NE.0) THEN
        DO NEV=1,NEVENT
        DO I3=1,NDB(3)
        DO I2=1,NDB(2)
        DO I1=1,NDB(1)
          DOEV(NEV,I1,I2,I3)=DOEV(NEV,I1,I2,I3)+DOEVP(NEV,I1,I2,I3)
          DOEV2(NEV,I1,I2,I3)=DOEV2(NEV,I1,I2,I3)+DOEVP(NEV,I1,I2,I3)**2
          DOEVP(NEV,I1,I2,I3)=0.0D0
          LDOEV(NEV,I1,I2,I3)=0
        ENDDO
        ENDDO
        ENDDO
        DO IR=1,NDB(1)
          DREV(NEV,IR)=DREV(NEV,IR)+DREVP(NEV,IR)
          DREV2(NEV,IR)=DREV2(NEV,IR)+DREVP(NEV,IR)**2
          DREVP(NEV,IR)=0.0D0
          LDREV(NEV,IR)=0
        ENDDO
        ENDDO
      ENDIF
C
      DO ID=1,NDEDEF
        DO I=1,NPTRAN
          IZZ=IZS(I)
          IS1=IS1S(I)
          IS2=IS2S(I)
C
          PTIoT(ID,IZZ,IS1,IS2)=PTIoT(ID,IZZ,IS1,IS2)+
     1      PTIoTP(ID,IZZ,IS1,IS2)
          PTIoT2(ID,IZZ,IS1,IS2)=PTIoT2(ID,IZZ,IS1,IS2)+
     1      PTIoTP(ID,IZZ,IS1,IS2)**2
          PTIoTP(ID,IZZ,IS1,IS2)=0.0D0
          LPTIoT(ID,IZZ,IS1,IS2)=0
C
          DO J=1,NILB5
            PTIoF(ID,IZZ,IS1,IS2,J)=PTIoF(ID,IZZ,IS1,IS2,J)+
     1        PTIoFP(ID,IZZ,IS1,IS2,J)
            PTIoF2(ID,IZZ,IS1,IS2,J)=PTIoF2(ID,IZZ,IS1,IS2,J)+
     1        PTIoFP(ID,IZZ,IS1,IS2,J)**2
            PTIoFP(ID,IZZ,IS1,IS2,J)=0.0D0
            LPTIoF(ID,IZZ,IS1,IS2,J)=0
          ENDDO
        ENDDO
      ENDDO
C
      DO I=1,NPTRAN
        IZZ=IZS(I)
        IS1=IS1S(I)
        IS2=IS2S(I)
C
        PTIGT(IZZ,IS1,IS2)=PTIGT(IZZ,IS1,IS2)+PTIGTP(IZZ,IS1,IS2)
        PTIGT2(IZZ,IS1,IS2)=PTIGT2(IZZ,IS1,IS2)+PTIGTP(IZZ,IS1,IS2)**2
        PTIGTP(IZZ,IS1,IS2)=0.0D0
        LPTIGT(IZZ,IS1,IS2)=0
C
        DO J=1,NILB5
          PTIoG(IZZ,IS1,IS2,J)=PTIoG(IZZ,IS1,IS2,J)+
     1      PTIoGP(IZZ,IS1,IS2,J)
          PTIoG2(IZZ,IS1,IS2,J)=PTIoG2(IZZ,IS1,IS2,J)+
     1      PTIoGP(IZZ,IS1,IS2,J)**2
          PTIoGP(IZZ,IS1,IS2,J)=0.0D0
          LPTIoG(IZZ,IS1,IS2,J)=0
        ENDDO
      ENDDO
C
      DO K=1,NBE
        PDEBR(K)=PDEBR(K)+PDEBRP(K)
        PDEBR2(K)=PDEBR2(K)+PDEBRP(K)**2
        PDEBRP(K)=0.0D0
        LPDEBR(K)=0
      ENDDO
C
C  ************  If 'DUMPTO' is active, write counters in a dump file.
C
      IF(LDUMP) THEN
        OPEN(9,FILE=PFILED)
        WRITE(9,*) SHN,TSIM
        WRITE(9,'(A120)') TITLE
        WRITE(9,*) ISEED1,ISEED2
        WRITE(9,*) NSEB
        WRITE(9,*) (ESRC(I),I=1,NSEB+1)
        WRITE(9,*) (PSRC(I),I=1,NSEB+1)
        WRITE(9,*) (SHIST(I),I=1,NSEB+1)
        WRITE(9,*) (PRIM(I),I=1,3)
        WRITE(9,*) (PRIM2(I),I=1,3)
        WRITE(9,*) ((SEC(K,I),I=1,3),K=1,3)
        WRITE(9,*) ((SEC2(K,I),I=1,3),K=1,3)
        WRITE(9,*) NBODY
        WRITE(9,*) (TDEBO(I),I=1,NBODY)
        WRITE(9,*) (TDEBO2(I),I=1,NBODY)
C
        WRITE(9,*) NBE,EMIN,EMAX,BSE(1),BSE(2)
        WRITE(9,*) (((PDE(I,J,K),K=1,NBE),J=1,2),I=1,3)
        WRITE(9,*) (((PDE2(I,J,K),K=1,NBE),J=1,2),I=1,3)
        WRITE(9,*) NBTH,NBPH,BSTH,BSPH
        WRITE(9,*) (((PDA(I,J,K),K=1,NBPH),J=1,NBTH),I=1,3)
        WRITE(9,*) (((PDA2(I,J,K),K=1,NBPH),J=1,NBTH),I=1,3)
        WRITE(9,*) ((PDAT(I,J),J=1,NBTH),I=1,3)
        WRITE(9,*) ((PDAT2(I,J),J=1,NBTH),I=1,3)
        WRITE(9,*) NDEDEF
        WRITE(9,*) (TDED(I),I=1,NDEDEF)
        WRITE(9,*) (TDED2(I),I=1,NDEDEF)
        WRITE(9,*) (RLAST(ID),ID=1,NDEDEF)
        WRITE(9,*) (RWRITE(ID),ID=1,NDEDEF)
C
        WRITE(9,*) (PHI1(ID),ID=1,NDEDEF)
        WRITE(9,*) (PHI2(ID),ID=1,NDEDEF)
        WRITE(9,*) (THETA1(ID),ID=1,NDEDEF)
        WRITE(9,*) (THETA2(ID),ID=1,NDEDEF)
        WRITE(9,*) (EDEL(ID),ID=1,NDEDEF)
        WRITE(9,*) (EDEU(ID),ID=1,NDEDEF)
        WRITE(9,*) (BDEE(ID),ID=1,NDEDEF)
        WRITE(9,*) (NDECH(ID),ID=1,NDEDEF)
        DO ID=1,NDEDEF
          WRITE(9,*) (DET(ID,J),J=1,NDECH(ID))
          WRITE(9,*) (DET2(ID,J),J=1,NDECH(ID))
        ENDDO
C
        WRITE(9,*) NEVENT
        IF(NEVENT.NE.0) THEN
          WRITE(9,*) (DXL(I),I=1,3),(DXU(I),I=1,3)
          WRITE(9,*) (BDOEV(I),I=1,3),(BDOEVR(I),I=1,3)
          WRITE(9,*) (NDB(I),I=1,3)
          WRITE(9,*) (IEVENT(I),I=1,NEVENT)
          WRITE(9,*) (XEMIN(I),I=1,NEVENT)
          WRITE(9,*) (XEMAX(I),I=1,NEVENT)
          WRITE(9,*) (ITRANS(I),I=1,NEVENT)
          WRITE(9,*)
     1      ((((DOEV(NEV,I1,I2,I3),I3=1,NDB(3)),I2=1,NDB(2)),
     1          I1=1,NDB(1)),NEV=1,NEVENT)
          WRITE(9,*)
     1      ((((DOEV2(NEV,I1,I2,I3),I3=1,NDB(3)),I2=1,NDB(2)),
     1          I1=1,NDB(1)),NEV=1,NEVENT)
          WRITE(9,*) ((DREV(NEV,IR),IR=1,NDB(1)),NEV=1,NEVENT)
          WRITE(9,*) ((DREV2(NEV,IR),IR=1,NDB(1)),NEV=1,NEVENT)
        ENDIF
C
        WRITE(9,*) NDEDEF,NPTRAN,NILB5
        WRITE(9,*) (IZS(IT),IT=1,NPTRAN)
        WRITE(9,*) (IS1S(IT),IT=1,NPTRAN)
        WRITE(9,*) (IS2S(IT),IT=1,NPTRAN)
        WRITE(9,*) (ENERGS(IT),IT=1,NPTRAN)
        DO ID=1,NDEDEF
          DO I=1,NPTRAN
            IZZ=IZS(I)
            IS1=IS1S(I)
            IS2=IS2S(I)
            WRITE(9,*) PTIoT(ID,IZZ,IS1,IS2),PTIoT2(ID,IZZ,IS1,IS2)
            WRITE(9,*) (PTIoF(ID,IZZ,IS1,IS2,L),L=1,NILB5)
            WRITE(9,*) (PTIoF2(ID,IZZ,IS1,IS2,L),L=1,NILB5)
          ENDDO
        ENDDO
        DO I=1,NPTRAN
          IZZ=IZS(I)
          IS1=IS1S(I)
          IS2=IS2S(I)
          WRITE(9,*) PTIGT(IZZ,IS1,IS2),PTIGT2(IZZ,IS1,IS2)
          WRITE(9,*) (PTIoG(IZZ,IS1,IS2,L),L=1,NILB5)
          WRITE(9,*) (PTIoG2(IZZ,IS1,IS2,L),L=1,NILB5)
        ENDDO
        WRITE(9,*) (PDEBR(I),I=1,NBE)
        WRITE(9,*) (PDEBR2(I),I=1,NBE)
        WRITE(9,'(/3X,''*** END ***'')')
        CLOSE(9)
      ENDIF
C
C  ------------------------  Print simulation results.
C
C     IEXIT: 1=upbound, 2=downbound, 3=absorbed.
C
      OPEN(27,FILE='penepma-res.dat')
      TOTN=SHN*WGHT0
      WRITE(27,3000)
 3000 FORMAT(//3X,35('*')/3X,'**   Program PENEPMA. Results.   **',
     1  /3X,35('*'))
C
      WRITE(27,3001) TSIM
 3001 FORMAT(/3X,'Simulation time ......................... ',
     1  1P,E13.6,' sec')
      TAVS=TOTN/TSIM
      WRITE(27,3002) TAVS
 3002 FORMAT(3X,'Simulation speed ........................ ',
     1  1P,E13.6,' showers/sec')
      WRITE(27,3003) TOTN
 3003 FORMAT(/3X,'Simulated primary showers ............... ',
     1  1P,E13.6)
C
      WRITE(27,3004) PRIM(1)
 3004 FORMAT(/3X,'Upbound primary particles ............... ',
     1  1P,E13.6)
      WRITE(27,3005) PRIM(2)
 3005 FORMAT(3X,'Downbound primary particles ............. ',
     1  1P,E13.6)
      WRITE(27,3006) PRIM(3)
 3006 FORMAT(3X,'Absorbed primary particles .............. ',
     1  1P,E13.6)
C
      FNT=1.0D0/TOTN
      FT=(PRIM(1)+SEC(KPARP,1))*FNT
      ERR1=3.0D0*FNT*SQRT(ABS(PRIM2(1)-PRIM(1)**2*FNT))
      ERR2=3.0D0*FNT*SQRT(ABS(SEC2(KPARP,1)-SEC(KPARP,1)**2*FNT))
      ERR=ERR1+ERR2
      WRITE(27,3007) FT,ERR
 3007 FORMAT(/3X,'Upbound fraction ................... ',
     1  1P,E13.6,' +-',E8.1)
      FB=(PRIM(2)+SEC(KPARP,2))*FNT
      ERR1=3.0D0*FNT*SQRT(ABS(PRIM2(2)-PRIM(2)**2*FNT))
      ERR2=3.0D0*FNT*SQRT(ABS(SEC2(KPARP,2)-SEC(KPARP,2)**2*FNT))
      ERR=ERR1+ERR2
      WRITE(27,3008) FB,ERR
 3008 FORMAT(3X,'Downbound fraction ................. ',
     1  1P,E13.6,' +-',E8.1)
      FA=PRIM(3)*FNT
      ERR=3.0D0*FNT*SQRT(ABS(PRIM2(3)-PRIM(3)**2*FNT))
      WRITE(27,3009) FA,ERR
 3009 FORMAT(3X,'Absorption fraction ................ ',
     1  1P,E13.6,' +-',E8.1)
C
      DO K=1,3
        DO I=1,3
          WSEC2(K,I)=3.0D0*FNT*SQRT(ABS(SEC2(K,I)-SEC(K,I)**2*FNT))
          WSEC(K,I)=SEC(K,I)*FNT
        ENDDO
      ENDDO
      WRITE(27,3010)
     1  WSEC(1,1),WSEC(2,1),WSEC(3,1),WSEC2(1,1),WSEC2(2,1),WSEC2(3,1),
     1  WSEC(1,2),WSEC(2,2),WSEC(3,2),WSEC2(1,2),WSEC2(2,2),WSEC2(3,2),
     1  WSEC(1,3),WSEC(2,3),WSEC(3,3),WSEC2(1,3),WSEC2(2,3),WSEC2(3,3)
 3010 FORMAT(/3X,'Secondary-particle generation probabilities:',
     1  /19X,46('-'),
     1  /19X,'|  electrons   |   photons    |  positrons   |',1P,
     1  /3X,62('-')/3X,'|   upbound     |',3(E13.6,1X,'|'),
     1  /3X,'|               |',3('  +-',E8.1,2X,'|'),
     1  /3X,62('-')/3X,'|   downbound   |',3(E13.6,1X,'|'),
     1  /3X,'|               |',3('  +-',E8.1,2X,'|'),
     1  /3X,62('-')/3X,'|   absorbed    |',3(E13.6,1X,'|'),
     1  /3X,'|               |',3('  +-',E8.1,2X,'|'),
     1  /3X,62('-'))
C
C  ****  Average energies deposited in bodies..
C
      DF=1.0D0/TOTN
      WRITE(27,3011)
 3011 FORMAT(/3X,'Average deposited energies (bodies):')
      DO KBi=1,NBODY
        IF(MATER(KBi).NE.0) THEN
          QER=3.0D0*DF*SQRT(ABS(TDEBO2(KBi)-TDEBO(KBi)**2*DF))
          QAV=TDEBO(KBi)*DF
          IF(QER.GT.1.0D-10*ABS(QAV)) THEN
            EFFIC=QAV**2/((QER/3.0D0)**2*TSIM)
          ELSE
            EFFIC=0.0D0
          ENDIF
          WRITE(27,3012) KBi,QAV,QER,EFFIC
        ENDIF
      ENDDO
 3012 FORMAT(6X,'Body ',I4, ' ...... ',1P,E13.6,' +-',E8.1,' eV',4X,
     1  '(effic. =',E9.2,')')
C
C  ************  Energy distributions of emerging particles.
C
C  ****  Upbound electrons.
      OPEN(9,FILE='pe-energy-el-up.dat')
      WRITE(9,9110)
 9110 FORMAT(
     1  1X,'#  Results from PENEPMA.',
     1 /1X,'#  Energy distribution of upbound electrons.',
     1 /1X,'#  1st column: E (eV).',
     1 /1X,'#  2nd and 3rd columns: probability density and STU',
     1         ' (1/(eV*particle)).',/)
      DO K=1,NBE
        XX=EMIN+(K-0.5D0)*BSE(1)
        YERR=3.0D0*SQRT(ABS(PDE2(1,1,K)-PDE(1,1,K)**2*DF))
        YAV=PDE(1,1,K)*DF/BSE(1)
        YERR=YERR*DF/BSE(1)
        WRITE(9,'(1X,1P,3E14.6)')
     1     XX,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
      ENDDO
      CLOSE(9)
C  ****  Downbound electrons.
      OPEN(9,FILE='pe-energy-el-down.dat')
      WRITE(9,9120)
 9120 FORMAT(
     1  1X,'#  Results from PENEPMA.',
     1 /1X,'#  Energy distribution of downbound electrons.',
     1 /1X,'#  1st column: E (eV).',
     1 /1X,'#  2nd and 3rd columns: probability density and STU',
     1         ' (1/(eV*particle)).',/)
      DO K=1,NBE
        XX=EMIN+(K-0.5D0)*BSE(1)
        YERR=3.0D0*SQRT(ABS(PDE2(1,2,K)-PDE(1,2,K)**2*DF))
        YAV=PDE(1,2,K)*DF/BSE(1)
        YERR=YERR*DF/BSE(1)
        WRITE(9,'(1X,1P,3E14.6)')
     1     XX,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
      ENDDO
      CLOSE(9)
C  ****  Upbound photons.
      OPEN(9,FILE='pe-energy-ph-up.dat')
      WRITE(9,9130)
 9130 FORMAT(
     1  1X,'#  Results from PENEPMA.',
     1 /1X,'#  Energy distribution of upbound photons.',
     1 /1X,'#  1st column: E (eV).',
     1 /1X,'#  2nd and 3rd columns: probability density and STU',
     1         ' (1/(eV*particle)).',/)
      DO K=1,NBE
        XX=EMIN+(K-0.5D0)*BSE(2)
        YERR=3.0D0*SQRT(ABS(PDE2(2,1,K)-PDE(2,1,K)**2*DF))
        YAV=PDE(2,1,K)*DF/BSE(2)
        YERR=YERR*DF/BSE(2)
        WRITE(9,'(1X,1P,3E14.6)')
     1     XX,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
      ENDDO
      CLOSE(9)
C  ****  Downbound photons.
      OPEN(9,FILE='pe-energy-ph-down.dat')
      WRITE(9,9140)
 9140 FORMAT(
     1  1X,'#  Results from PENEPMA.',
     1 /1X,'#  Energy distribution of downbound photons.',
     1 /1X,'#  1st column: E (eV).',
     1 /1X,'#  2nd and 3rd columns: probability density and STU',
     1         ' (1/(eV*particle)).',/)
      DO K=1,NBE
        XX=EMIN+(K-0.5D0)*BSE(2)
        YERR=3.0D0*SQRT(ABS(PDE2(2,2,K)-PDE(2,2,K)**2*DF))
        YAV=PDE(2,2,K)*DF/BSE(2)
        YERR=YERR*DF/BSE(2)
        WRITE(9,'(1X,1P,3E14.6)')
     1     XX,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
      ENDDO
      CLOSE(9)
C
C  ************  Angular distributions of emerging particles.
C
      OPEN(9,FILE='pe-anel.dat')
      WRITE(9,9060)
 9060 FORMAT(
     1  1X,'#  Results from PENEPMA. ',
     1 /1X,'#  Angular distribution of emerging electrons.',
     1 /1X,'#  1st column: THETA (deg).',
     1 /1X,'#  2nd and 3rd columns: probability density and STU',
     1         ' (1/sr)',/)
      DO K=1,NBTH
        XX=(K-0.5D0)*BSTH
        XXR=(K-1.0D0)*BSTH*DE2RA
        DSANG=(COS(XXR)-COS(XXR+BSTH*DE2RA))*TWOPI
        YERR=3.0D0*SQRT(ABS(PDAT2(1,K)-PDAT(1,K)**2*DF))
        YAV=PDAT(1,K)*DF/DSANG
        YERR=YERR*DF/DSANG
        WRITE(9,'(1X,1P,6E14.6)')
     1       XX,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
      ENDDO
      CLOSE(9)
C
      OPEN(9,FILE='pe-anga.dat')
      WRITE(9,9070)
 9070 FORMAT(
     1  1X,'#  Results from PENEPMA. ',
     1 /1X,'#  Angular distribution of emerging photons.',
     1 /1X,'#  1st column: THETA (deg).',
     1 /1X,'#  2nd and 3rd columns: probability density and STU',
     1         ' (1/sr)',/)
      DO K=1,NBTH
        XX=(K-0.5D0)*BSTH
        XXR=(K-1.0D0)*BSTH*DE2RA
        DSANG=(COS(XXR)-COS(XXR+BSTH*DE2RA))*TWOPI
        YERR=3.0D0*SQRT(ABS(PDAT2(2,K)-PDAT(2,K)**2*DF))
        YAV=PDAT(2,K)*DF/DSANG
        YERR=YERR*DF/DSANG
        WRITE(9,'(1X,1P,6E14.6)')
     1     XX,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
      ENDDO
      CLOSE(9)
C
      OPEN(9,FILE='pe-angle-el.dat')
      WRITE(9,9210)
 9210 FORMAT(
     1  1X,'#  Results from PENEPMA.',
     1 /1X,'#  Angular distribution of emerging electrons.',
     1 /1X,'#  1st and 2nd columns: THETA and PHI (deg).',
     1 /1X,'#  3rd and 4th columns: probability density and STU',
     1         ' (1/sr)',/)
      DO K=1,NBTH
        XX=(K-0.5D0)*BSTH
        XXR=(K-1.0D0)*BSTH*DE2RA
        DSANG=(COS(XXR)-COS(XXR+BSTH*DE2RA))*(BSPH*DE2RA)
        DO L=1,NBPH
          YY=(L-0.5D0)*BSPH
          YERR=3.0D0*SQRT(ABS(PDA2(1,K,L)-PDA(1,K,L)**2*DF))
          YAV=PDA(1,K,L)*DF/DSANG
          YERR=YERR*DF/DSANG
          WRITE(9,'(1X,1P,6E14.6)')
     1       XX,YY,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
        ENDDO
        WRITE(9,*) '   '
      ENDDO
      CLOSE(9)
C
      OPEN(9,FILE='pe-angle-ph.dat')
      WRITE(9,9220)
 9220 FORMAT(
     1  1X,'#  Results from PENEPMA.',
     1 /1X,'#  Angular distribution of emerging photons.',
     1 /1X,'#  1st and 2nd columns: THETA and PHI (deg).',
     1 /1X,'#  3rd and 4th columns: probability density and STU',
     1         ' (1/sr)',/)
      DO K=1,NBTH
        XX=(K-0.5D0)*BSTH
        XXR=(K-1.0D0)*BSTH*DE2RA
        DSANG=(COS(XXR)-COS(XXR+BSTH*DE2RA))*(BSPH*DE2RA)
        DO L=1,NBPH
          YY=(L-0.5D0)*BSPH
          YERR=3.0D0*SQRT(ABS(PDA2(2,K,L)-PDA(2,K,L)**2*DF))
          YAV=PDA(2,K,L)*DF/DSANG
          YERR=YERR*DF/DSANG
          WRITE(9,'(1X,1P,6E14.6)')
     1       XX,YY,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
        ENDDO
        WRITE(9,*) '   '
      ENDDO
      CLOSE(9)
C
C  ************  Energy spectrum of the source.
C
      IF(LSPEC.AND.NSEB.GT.1) THEN
        OPEN(9,FILE='psource.dat')
        WRITE(9,9000)
 9000 FORMAT(
     1  1X,'#  Results from PENMAIN. ',
     1 /1X,'#  Source energy spectrum.',
     1 /1X,'#  1st column: E (eV). 2nd column: spectrum (1/eV).',
     1 /1X,'#  3rd and 4th columns: simul. pdf limits (3SD, 1/eV).')
        PTOT=0.0D0
        WRITE(9,'(1P,4E14.6)') ESRC(1),PTOT,PTOT,PTOT
        DO KEn=1,NSEB
          PTOT=PTOT+PSRC(KEn)
        ENDDO
        DO KEn=1,NSEB
          YAV=SHIST(KEn)*DF
          YERR=3.0D0*SQRT(ABS(YAV*(1.0D0-YAV)*DF))
          EINTL=ESRC(KEn+1)-ESRC(KEn)
          IF(EINTL.GT.1.0D-15) THEN
            FACT=1.0D0/EINTL
          ELSE
            FACT=1.0D15
          ENDIF
          WRITE(9,'(1P,4E14.6)') ESRC(KEn),PSRC(KEn)*FACT/PTOT,
     1      (YAV-YERR)*FACT,(YAV+YERR)*FACT
          WRITE(9,'(1P,4E14.6)') ESRC(KEn+1),PSRC(KEn)*FACT/PTOT,
     1      (YAV-YERR)*FACT,(YAV+YERR)*FACT
        ENDDO
        PTOT=0.0D0
        WRITE(9,'(1P,4E14.6)') ESRC(NSEB+1),PTOT,PTOT,PTOT
        CLOSE(9)
      ENDIF
C
C  ****  Average energies entering the detectors.
C
      WRITE(27,3015)
 3015 FORMAT(/3X,'Average photon energy at the detectors:')
      DO KD=1,NDEDEF
        QER=3.0D0*DF*SQRT(ABS(TDED2(KD)-TDED(KD)**2*DF))
        QAV=TDED(KD)*DF
        IF(QER.GT.1.0D-10*ABS(QAV)) THEN
          EFFIC=QAV**2/((QER/3.0D0)**2*TSIM)
        ELSE
          EFFIC=0.0D0
        ENDIF
        WRITE(27,3014) KD,QAV,QER,EFFIC
      ENDDO
 3014 FORMAT(6X,'Detector #',I2,' ... ',1P,E13.6,' +-',E8.1,' eV',4X,
     1  '(effic. =',E9.2,')')
C
C  ************  Spectra from photon detectors.
C
      IF(NDEDEF.GT.0) THEN
        DO ID=1,NDEDEF
          WRITE(BUF2,'(I5)') 1000+ID
          SPCDIO='pe-spect-'//BUF2(4:5)//'.dat'
          OPEN(9,FILE=SPCDIO)
          WRITE(9,9310) ID
 9310 FORMAT(1X,'#  Results from PENEPMA. Output from photon ',
     1  'detector #',I3,/1X,'#')
          WRITE(9,9311) THETA1(ID)*RA2DE,THETA2(ID)*RA2DE,
     1      PHI1(ID)*RA2DE,PHI2(ID)*RA2DE
 9311 FORMAT(1X,'#  Angular intervals : theta_1 =',1P,E13.6,
     1  ',  theta_2 =',E13.6,/1X,'#',24X,'phi_1 =',E13.6,
     1  ',    phi_2 =',E13.6)
          WRITE(9,9312) EDEL(ID),EDEU(ID),NDECH(ID)
 9312 FORMAT(1X,'#  Energy window = (',1P,E12.5,',',E12.5,') eV, no.',
     1  ' of channels = ',I4)
          WRITE(9,9313) BDEE(ID)
 9313 FORMAT(1X,'#  Channel width =',1P,E13.6,' eV',/1X,'#')
          WRITE(9,9314)
 9314 FORMAT(
     1  1X,'#  Whole spectrum. Characteristic peaks and background.',
     1 /1X,'#  1st column: photon energy (eV).',
     1 /1X,'#  2nd column: probability density (1/(eV*sr*particle)).',
     1 /1X,'#  3rd column: statistical uncertainty (3 sigma).',/1X,'#')
          SANGLE=(PHI2(ID)-PHI1(ID))*(COS(THETA1(ID))-COS(THETA2(ID)))
          DO J=1,NDECH(ID)
            XX=EDEL(ID)+(J-0.5D0)*BDEE(ID)
            YERR=3.0D0*SQRT(ABS(DET2(ID,J)-DET(ID,J)**2*DF))
            YAV=DET(ID,J)*DF/(BDEE(ID)*SANGLE)
            YERR=YERR*DF/(BDEE(ID)*SANGLE)
            WRITE(9,'(1X,1P,3E14.6)')
     1        XX,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
          ENDDO
          CLOSE(9)
        ENDDO
      ENDIF
C
C  ************  Space distribution of x-ray emission events.
C
      IF(NEVENT.NE.0) THEN
        DO NEV=1,NEVENT
          IF(IEVENT(NEV).EQ.1) THEN
            WRITE(BUFFER,9401) XEMIN(NEV),XEMAX(NEV)
 9401       FORMAT(2X,'X-ray energy interval:  from',1P,E13.6,' keV to',
     1        E13.6,' keV')
          ELSE
            CALL PEILB4(ITRANS(NEVENT),IZZ,IS1,IS2,IS3)
            WRITE(BUFFER,9402) IZZ,CS2(IS1),CS2(IS2)
 9402       FORMAT(3X,'X-ray emission line:  Z = ',I2,',',A2,'-',A2)
          ENDIF
          WRITE(LIT,'(I2)') NEV
          IF(NEV.LT.10) LIT(1:1)='0'
C
C  ****  Depth distribution of x rays.
C
        OPEN(9,FILE='pe-map-'//LIT//'-depth.dat')
        WRITE(9,9410) BUFFER
 9410   FORMAT(
     1     1X,'#  Results from PENEPMA. Depth distribution of x rays.',
     1    /1X,'#',A,
     1    /1X,'#  1st column: z coordinate (cm).',
     1    /1X,'#  2nd column: density of x-ray emission (1/cm).',
     1    /1X,'#  3rd column: statistical uncertainty (3 sigma).',/)
        DO I3=1,NDB(3)
          ZZ=DXL(3)+(I3-0.5D0)*BDOEV(3)
          YAV=0.0D0
          YAV2=0.0D0
          DO I1=1,NDB(1)
            DO I2=1,NDB(2)
              YAV=YAV+DOEV(NEV,I1,I2,I3)
              YAV2=YAV2+DOEV2(NEV,I1,I2,I3)
            ENDDO
          ENDDO
          YERR=3.0D0*SQRT(ABS(YAV2-YAV**2*DF))
          YAV=YAV*DF/BDOEV(3)
          YERR=YERR*DF/BDOEV(3)
          WRITE(9,'(1X,1P,3E14.6)')
     1      ZZ,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
        ENDDO
        CLOSE(9)
C
C  ****  Radial distribution of x rays.
C
        OPEN(9,FILE='pe-map-'//LIT//'-radial.dat')
        WRITE(9,9411) BUFFER
 9411   FORMAT(
     1     1X,'#  Results from PENEPMA. Radial distribution of x rays.',
     1    /1X,'#',A,
     1    /1X,'#  WARNING: This result is faithful only when the box ',
     1        'is centred at the origin.',
     1    /1X,'#  1st column: radius (cm).',
     1    /1X,'#  2nd column: density of x-ray emission (1/cm**2).',
     1    /1X,'#  3rd column: statistical uncertainty (3 sigma).',/)
        DO IR=1,NDB(1)
          RR=(IR-0.5D0)*BDOEV(1)
          YAV=DREV(NEV,IR)
          YAV2=DREV2(NEV,IR)
          YERR=3.0D0*SQRT(ABS(YAV2-YAV**2*DF))
          FACT=DF/(PI*BDOEV(1)*(2.0D0*((IR-1)*BDOEV(1))+BDOEV(1)))
          YAV=YAV*FACT
          YERR=YERR*FACT
          WRITE(9,'(1X,1P,3E14.6)')
     1      RR,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
        ENDDO
        CLOSE(9)
C
        VOXEL=BDOEV(1)*BDOEV(2)*BDOEV(3)
        OPEN(9,FILE='pe-map-'//LIT//'-3d.dat')
        WRITE(9,9420) BUFFER
 9420   FORMAT(1X,'#  Results from PENEPMA. 3D distribution of x rays.',
     1    /1X,'#',A)
        WRITE(9,9421) DXL(1),DXU(1)
 9421   FORMAT(1X,'#  X-ray map box:    XL = ',1P,E13.6,
     1    ' cm,  XU = ',E13.6,' cm')
        WRITE(9,9422) DXL(2),DXU(2)
 9422   FORMAT(1X,'#',20X,'YL = ',1P,E13.6,' cm,  YU = ',E13.6,' cm')
        WRITE(9,9423) DXL(3),DXU(3)
 9423   FORMAT(1X,'#',20X,'ZL = ',1P,E13.6,' cm,  ZU = ',E13.6,' cm')
        WRITE(9,9424) NDB(1),NDB(2),NDB(3)
 9424   FORMAT(1X,'#  Numbers of bins:  NBX =',I4,', NBY =',I4,
     1        ', NBZ =',I4)
        WRITE(9,9425) BDOEV(1),BDOEV(2),BDOEV(3)
 9425   FORMAT(1X,'#  Bin dimensions:   DX = ',1P,E13.6,' cm',
     1    /1X,'#',20X,'DY = ',E13.6,' cm',/1X,'#',20X,
     1    'DZ = ',E13.6,' cm',/1X,'#')
        WRITE(9,9426)
 9426   FORMAT(1X,'#  columns 1 to 3: coordinates (X,Y,Z) of the bin ',
     1    'vertex (cm)',
     1    /1X,'#  4th column: density of x-ray emission (1/cm**3).',
     1    /1X,'#  5th column: statistical uncertainty (3 sigma).',/)
        DO I3=NDB(3),1,-1
          ZZ=DXL(3)+(I3-1.0D0)*BDOEV(3)
          DO I1=1,NDB(1)
            XX=DXL(1)+(I1-1.0D0)*BDOEV(1)
            DO I2=1,NDB(2)
              YY=DXL(2)+(I2-1.0D0)*BDOEV(2)
              YAV=DOEV(NEV,I1,I2,I3)
              YAV2=DOEV2(NEV,I1,I2,I3)
              YERR=3.0D0*SQRT(ABS(YAV2-YAV**2*DF))
              YAV=YAV*DF/VOXEL
              YERR=YERR*DF/VOXEL
              WRITE(9,9427) XX,YY,ZZ,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
            ENDDO
            WRITE(9,'(''  '')')
          ENDDO
          WRITE(9,'(''  '')')
        ENDDO
 9427   FORMAT(1X,1P,3E11.3,E14.6,E10.2)
        CLOSE(9)
C
C  ****  Spatial x-ray distributions at the central axes.
C
        IF(MOD(NDB(1),2).NE.0) THEN
          I1L=((NDB(1)+1)/2)-1
          I1U=((NDB(1)+1)/2)+1
        ELSE
          I1L=NDB(1)/2
          I1U=(NDB(1)/2)+1
        ENDIF
        IF(MOD(NDB(2),2).NE.0) THEN
          I2L=((NDB(2)+1)/2)-1
          I2U=((NDB(2)+1)/2)+1
        ELSE
          I2L=NDB(2)/2
          I2U=(NDB(2)/2)+1
        ENDIF
        IF(MOD(NDB(3),2).NE.0) THEN
          I3L=((NDB(3)+1)/2)-1
          I3U=((NDB(3)+1)/2)+1
        ELSE
          I3L=NDB(3)/2
          I3U=(NDB(3)/2)+1
        ENDIF
C
        OPEN(9,FILE='pe-map-'//LIT//'-x.dat')
        WRITE(9,9440)
 9440   FORMAT(
     1     1X,'#  Results from PENEPMA.',
     1    /1X,'#  Density of x rays along the central X axis',
     1    /1X,'#',A,/1X,'#  1st column: x (cm).',
     1    /1X,'#  2nd column: density of x-ray emission (1/cm**3).',
     1    /1X,'#  3rd column: statistical uncertainty (3 sigma).',/)
        DO I1=1,NDB(1)
          XYZ=DXL(1)+(I1-0.5D0)*BDOEV(1)
          NV=0
          YAV=0.0D0
          YAV2=0.0D0
          DO I2=I2L,I2U
            DO I3=I3L,I3U
              NV=NV+1
              YAV=YAV+DOEV(NEV,I1,I2,I3)
              YAV2=YAV2+DOEV2(NEV,I1,I2,I3)
            ENDDO
          ENDDO
          YERR=3.0D0*SQRT(ABS(YAV2-YAV**2*DF))
          YAV=YAV*DF/(NV*VOXEL)
          YERR=YERR*DF/(NV*VOXEL)
          WRITE(9,'(1X,1P,3E14.6)')
     1      XYZ,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
        ENDDO
        CLOSE(9)
C
        OPEN(9,FILE='pe-map-'//LIT//'-y.dat')
        WRITE(9,9450) BUFFER
 9450   FORMAT(
     1     1X,'#  Results from PENEPMA.',
     1    /1X,'#  Density of x rays along the central Y axis',
     1    /1X,'#',A,/1X,'#  1st column: y (cm).',
     1    /1X,'#  2nd column: density of x-ray emission (1/cm**3).',
     1    /1X,'#  3rd column: statistical uncertainty (3 sigma).',/)
        DO I2=1,NDB(2)
          XYZ=DXL(2)+(I2-0.5D0)*BDOEV(2)
          NV=0
          YAV=0.0D0
          YAV2=0.0D0
          DO I1=I1L,I1U
            DO I3=I3L,I3U
              NV=NV+1
              YAV=YAV+DOEV(NEV,I1,I2,I3)
              YAV2=YAV2+DOEV2(NEV,I1,I2,I3)
            ENDDO
          ENDDO
          YERR=3.0D0*SQRT(ABS(YAV2-YAV**2*DF))
          YAV=YAV*DF/(NV*VOXEL)
          YERR=YERR*DF/(NV*VOXEL)
          WRITE(9,'(1X,1P,3E14.6)')
     1      XYZ,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
        ENDDO
        CLOSE(9)
C
        OPEN(9,FILE='pe-map-'//LIT//'-z.dat')
        WRITE(9,9460) BUFFER
 9460   FORMAT(
     1     1X,'#  Results from PENEPMA.',
     1    /1X,'#  Density of x rays along the central Z axis',
     1    /1X,'#',A,/1X,'#  1st column: z (cm).',
     1    /1X,'#  2nd column: density of x-ray emission (1/cm**3).',
     1    /1X,'#  3rd column: statistical uncertainty (3 sigma).',/)
        DO I3=1,NDB(3)
          XYZ=DXL(3)+(I3-0.5D0)*BDOEV(3)
          NV=0
          YAV=0.0D0
          YAV2=0.0D0
          DO I1=I1L,I1U
            DO I2=I2L,I2U
              NV=NV+1
              YAV=YAV+DOEV(NEV,I1,I2,I3)
              YAV2=YAV2+DOEV2(NEV,I1,I2,I3)
            ENDDO
          ENDDO
          YERR=3.0D0*SQRT(ABS(YAV2-YAV**2*DF))
          YAV=YAV*DF/(NV*VOXEL)
          YERR=YERR*DF/(NV*VOXEL)
          WRITE(9,'(1X,1P,3E14.6)')
     1      XYZ,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
        ENDDO
        CLOSE(9)
C
        VOXEL=BDOEV(1)*BDOEV(3)
        OPEN(9,FILE='pe-map-'//LIT//'-xz.dat')
        WRITE(9,9470) BUFFER
 9470   FORMAT(
     1     1X,'#  Results from PENEPMA.',
     1  /1X,'#  Density of x rays on the XZ plane (integrated over Y)',
     1    /1X,'#',A,/1X,'#  1st column: x (cm).',
     1    /1X,'#  2nd column: z (cm).',
     1    /1X,'#  3rd column: density of x-ray emission (1/cm**2).',
     1    /1X,'#  4th column: statistical uncertainty (3 sigma).',/)
        DO I1=1,NDB(1)
          XX=DXL(1)+(I1-1.0D0)*BDOEV(1)
          DO I3=NDB(3),1,-1
            ZZ=DXL(3)+(I3-1.0D0)*BDOEV(3)
            YAV=0.0D0
            YAV2=0.0D0
            DO I2=1,NDB(2)
              YAV=YAV+DOEV(NEV,I1,I2,I3)
              YAV2=YAV2+DOEV2(NEV,I1,I2,I3)
            ENDDO
            YERR=3.0D0*SQRT(ABS(YAV2-YAV**2*DF))
            YAV=YAV*DF/VOXEL
            YERR=YERR*DF/VOXEL
            WRITE(9,'(1X,1P,2E11.3,E14.6,E10.2)')
     1        XX,ZZ,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
          ENDDO
          WRITE(9,'(''  '')')
        ENDDO
        CLOSE(9)
C
        VOXEL=BDOEV(2)*BDOEV(3)
        OPEN(9,FILE='pe-map-'//LIT//'-yz.dat')
        WRITE(9,9480) BUFFER
 9480   FORMAT(
     1     1X,'#  Results from PENEPMA.',
     1  /1X,'#  Density of x rays on the YZ plane (integrated over X)',
     1    /1X,'#',A,/1X,'#  1st column: y (cm).',
     1    /1X,'#  2nd column: z (cm).',
     1    /1X,'#  3rd column: density of x-ray emission (1/cm**2).',
     1    /1X,'#  4th column: statistical uncertainty (3 sigma).',/)
        DO I2=1,NDB(2)
          YY=DXL(2)+(I2-1.0D0)*BDOEV(2)
          DO I3=NDB(3),1,-1
            ZZ=DXL(3)+(I3-1.0D0)*BDOEV(3)
            YAV=0.0D0
            YAV2=0.0D0
            DO I1=1,NDB(1)
              YAV=YAV+DOEV(NEV,I1,I2,I3)
              YAV2=YAV2+DOEV2(NEV,I1,I2,I3)
            ENDDO
            YERR=3.0D0*SQRT(ABS(YAV2-YAV**2*DF))
            YAV=YAV*DF/VOXEL
            YERR=YERR*DF/VOXEL
            WRITE(9,'(1X,1P,2E11.3,E14.6,E10.2)')
     1        YY,ZZ,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
          ENDDO
          WRITE(9,'(''  '')')
        ENDDO
        CLOSE(9)
C
        VOXEL=BDOEV(1)*BDOEV(2)
        OPEN(9,FILE='pe-map-'//LIT//'-xy.dat')
        WRITE(9,9490)
 9490   FORMAT(
     1     1X,'#  Results from PENEPMA.',
     1  /1X,'#  Density of x rays on the XY plane (integrated over Z)',
     1    /1X,'#',A,/1X,'#  1st column: x (cm).',
     1    /1X,'#  2nd column: y (cm).',
     1    /1X,'#  3rd column: density of x-ray emission (1/cm**2).',
     1    /1X,'#  4th column: statistical uncertainty (3 sigma).',/)
        DO I1=1,NDB(1)
          XX=DXL(1)+(I1-1.0D0)*BDOEV(1)
          DO I2=1,NDB(2)
            YY=DXL(2)+(I2-1.0D0)*BDOEV(2)
            YAV=0.0D0
            YAV2=0.0D0
            DO I3=1,NDB(3)
              YAV=YAV+DOEV(NEV,I1,I2,I3)
              YAV2=YAV2+DOEV2(NEV,I1,I2,I3)
            ENDDO
            YERR=3.0D0*SQRT(ABS(YAV2-YAV**2*DF))
            YAV=YAV*DF/VOXEL
            YERR=YERR*DF/VOXEL
            WRITE(9,'(1X,1P,2E11.3,E14.6,E10.2)')
     1        XX,YY,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
          ENDDO
          WRITE(9,'(''  '')')
        ENDDO
        CLOSE(9)
        ENDDO
      ENDIF
C
C  ************  Intensities of characteristic lines.
C
      TOLE=1.0D35
      IF(NPTRAN.GT.0) THEN
        DO ID=1,NDEDEF
          WRITE(BUF2,'(I5)') 1000+ID
          SPCDIO='pe-intens-'//BUF2(4:5)//'.dat'
          OPEN(9,FILE=SPCDIO)
          WRITE(9,9510) ID
 9510 FORMAT(1X,'#  Results from PENEPMA. Output from photon ',
     1  'detector #',I3,/1X,'#')
          WRITE(9,9511) THETA1(ID)*RA2DE,THETA2(ID)*RA2DE,
     1      PHI1(ID)*RA2DE,PHI2(ID)*RA2DE
 9511 FORMAT(1X,'#  Angular intervals : theta_1 =',1P,E13.6,
     1  ',  theta_2 =',E13.6,/1X,'#',24X,'phi_1 =',E13.6,
     1  ',    phi_2 =',E13.6)
          WRITE(9,9512)
 9512 FORMAT(1X,'#'
     1  /1X,'#  Intensities of characteristic lines. ',
     1        'All in 1/(sr*particle).',
     1  /1X,'#    P = primary photons (from electron interactions);',
     1  /1X,'#    C = flourescence from characteristic x rays;',
     1  /1X,'#    B = flourescence from bremsstrahlung quanta;',
     1  /1X,'#   TF = C+B, total fluorescence;',
     1  /1X,'#  unc = statistical uncertainty (3 sigma).',
     1  /1X,'#',/1X,'# IZ S0 S1  E (eV)',6X,'P',12X,'unc',7X,'C',12X,
     1        'unc',7X,'B',12X,'unc',7X,'TF',11X,'unc',7X,'Intensity',
     1        4X,'unc')
C
          SANGLE=(PHI2(ID)-PHI1(ID))*(COS(THETA1(ID))-COS(THETA2(ID)))
          DO I=1,NPTRAN
            IZZ=IZS(I)
            IS1=IS1S(I)
            IS2=IS2S(I)
            ENERGY=ENERGS(I)
C
            YERRT=3.0D0*SQRT(ABS(PTIoT2(ID,IZZ,IS1,IS2)-
     1        PTIoT(ID,IZZ,IS1,IS2)**2*DF))*DF/SANGLE
            YAVT=PTIoT(ID,IZZ,IS1,IS2)*DF/SANGLE
C
            YERRP=3.0D0*SQRT(ABS(PTIoF2(ID,IZZ,IS1,IS2,1)-
     1        PTIoF(ID,IZZ,IS1,IS2,1)**2*DF))*DF/SANGLE
            YAVP=PTIoF(ID,IZZ,IS1,IS2,1)*DF/SANGLE
C
            YERRFC=3.0D0*SQRT(ABS(PTIoF2(ID,IZZ,IS1,IS2,2)-
     1        PTIoF(ID,IZZ,IS1,IS2,2)**2*DF))*DF/SANGLE
            YAVFC=PTIoF(ID,IZZ,IS1,IS2,2)*DF/SANGLE
C
            YERRFB=3.0D0*SQRT(ABS(PTIoF2(ID,IZZ,IS1,IS2,3)-
     1        PTIoF(ID,IZZ,IS1,IS2,3)**2*DF))*DF/SANGLE
            YAVFB=PTIoF(ID,IZZ,IS1,IS2,3)*DF/SANGLE
C
            YAVF=YAVFB+YAVFC
            YERRF=YERRFC+YERRFB
C
            IF(YAVT.GT.0.0D0) THEN
              WRITE(9,'(2X,I3,1X,A2,1X,A2,1P,E12.4,7(E14.6,E9.2))')
     1          IZZ,CS2(IS1),CS2(IS2),ENERGY,YAVP,YERRP,YAVFC,YERRFC,
     1          YAVFB,YERRFB,YAVF,YERRF,YAVT,YERRT
            IF(I.EQ.IENDTR.AND.ID.EQ.IENDD) TOLE=YERRT/MAX(YAVT,1.0D-35)
            ENDIF
          ENDDO
          CLOSE(9)
        ENDDO
C
C  ----  Probability of emission of characteristic photons.
C
        OPEN(9,FILE='pe-gen-ph.dat')
        WRITE(9,9610)
 9610 FORMAT(1X,'#  Results from PENEPMA.',
     1  /1X,'#  Probability of emission of characteristic photons. ',
     2        'All in 1/(sr*particle).',
     1  /1X,'#    P = primary photons (from electron interactions);',
     1  /1X,'#    C = flourescence from characteristic x rays;',
     1  /1X,'#    B = flourescence from bremsstrahlung quanta;',
     1  /1X,'#   TF = C+B, total fluorescence;',
     1  /1X,'#    T = P+C+B, total intensity;',
     1  /1X,'#  unc = statistical uncertainty (3 sigma).',
     1  /1X,'#',/1X,'# IZ S0 S1  E (eV)',6X,'P',12X,'unc',7X,'C',12X,
     1  'unc',7X,'B',12X,'unc',7X,'TF',11X,'unc',7X,'T',12X,'unc')
C
        SANGLE=TWOPI*2.0D0
        DO I=1,NPTRAN
          IZZ=IZS(I)
          IS1=IS1S(I)
          IS2=IS2S(I)
          ENERGY=ENERGS(I)
C
          YERRT=3.0D0*SQRT(ABS(PTIGT2(IZZ,IS1,IS2)-
     1      PTIGT(IZZ,IS1,IS2)**2*DF))*DF/SANGLE
          YAVT=PTIGT(IZZ,IS1,IS2)*DF/SANGLE
C
          YERRP=3.0D0*SQRT(ABS(PTIoG2(IZZ,IS1,IS2,1)-
     1      PTIoG(IZZ,IS1,IS2,1)**2*DF))*DF/SANGLE
          YAVP=PTIoG(IZZ,IS1,IS2,1)*DF/SANGLE
C
          YERRFC=3.0D0*SQRT(ABS(PTIoG2(IZZ,IS1,IS2,2)-
     1      PTIoG(IZZ,IS1,IS2,2)**2*DF))*DF/SANGLE
          YAVFC=PTIoG(IZZ,IS1,IS2,2)*DF/SANGLE
C
          YERRFB=3.0D0*SQRT(ABS(PTIoG2(IZZ,IS1,IS2,3)-
     1      PTIoG(IZZ,IS1,IS2,3)**2*DF))*DF/SANGLE
          YAVFB=PTIoG(IZZ,IS1,IS2,3)*DF/SANGLE
C
          YAVF=YAVFB+YAVFC
          YERRF=YERRFC+YERRFB
C
          IF(YAVT.GT.0.0D0) THEN
            WRITE(9,'(2X,I3,1X,A2,1X,A2,1P,E12.4,7(E14.6,E9.2))')
     1        IZZ,CS2(IS1),CS2(IS2),ENERGY,YAVP,YERRP,YAVFC,YERRFC,
     1        YAVFB,YERRFB,YAVF,YERRF,YAVT,YERRT
          ENDIF
        ENDDO
        CLOSE(9)
      ENDIF
C
C  ****  Probability of emission of bremsstrahlung photons.
C
      OPEN(9,FILE='pe-gen-bremss.dat')
      WRITE(9,9710)
 9710 FORMAT(
     1  1X,'#  Results from PENEPMA.',
     1 /1X,'#  Probability of emission of bremmstrahlung photons.',
     1 /1X,'#  1st column: E (eV).',
     1 /1X,'#  2nd and 3rd columns: probability density and STU',
     1         ' (1/(eV*sr*particle)).',/)
      SANGLE=TWOPI*2.0D0
      DO K=1,NBE
        XX=EMIN+(K-0.5D0)*BSE(2)
        YERR=3.0D0*SQRT(ABS(PDEBR2(K)-PDEBR(K)**2*DF))
        YAV=PDEBR(K)*DF/(BSE(2)*SANGLE)
        YERR=YERR*DF/(BSE(2)*SANGLE)
        IF(EABS(2,1).LT.EMIN+(K-1)*BSE(2)+1.0D0)
     1    WRITE(9,'(1X,1P,3E14.6)')
     1      XX,MAX(YAV,1.0D-35),MAX(YERR,1.0D-35)
      ENDDO
      CLOSE(9)
C
      WRITE(27,3030) ISEED1,ISEED2
 3030 FORMAT(/3X,'Last random seeds = ',I10,' , ',I10)
C
      IF(IENDTR.GT.0) THEN
        WRITE(27,3029) IENDL,IENDD,TOL,TOLE
 3029   FORMAT(/3X,'Reference line: ',I8,',  detector =',I3,',  toler',
     1    'ance =',1P,E10.3,/34X,' Relative uncertainty =',E10.3)
        IF(TOLE.LT.TOL) IRETRN=0
      ENDIF
C
      WRITE(27,'(/3X,72(''-''))')
      CLOSE(27)
C
C  ****  Continue if the DUMPTO option is active and IRETRN=1.
C
      IF(IRETRN.EQ.1) THEN
        WRITE(6,3040) SHN
 3040   FORMAT(2X,'Number of simulated showers =',1P,E14.7)
        CPUT0=CPUTIM()
        GO TO 101
      ELSE
        WRITE(6,3040) SHN
        WRITE(6,'(2X,''***  END  ***'')')
      ENDIF
C
      CLOSE(26)
      STOP
      END


C  *********************************************************************
C                       SUBROUTINE GCONE
C  *********************************************************************
      SUBROUTINE GCONE(UF,VF,WF)
C
C  This subroutine samples a random direction uniformly within a cone
C  with central axis in the direction (THETA,PHI) and aperture ALPHA.
C  Parameters are initialised by calling subroutine GCONE0.
C
      IMPLICIT DOUBLE PRECISION (A-H,O-Z), INTEGER*4 (I-N)
      PARAMETER (PI=3.1415926535897932D0, TWOPI=2.0D0*PI)
C  ****  Parameters for sampling directions within a cone.
      COMMON/CGCONE/CPCT,CPST,SPCT,SPST,SPHI,CPHI,STHE,CTHE,CAPER
C
      EXTERNAL RAND
C  ****  Define a direction relative to the z-axis.
      WT=CAPER+(1.0D0-CAPER)*RAND(1.0D0)
      DF=TWOPI*RAND(2.0D0)
      SUV=SQRT(1.0D0-WT*WT)
      UT=SUV*COS(DF)
      VT=SUV*SIN(DF)
C  **** Rotate to the beam axis direction.
      UF=CPCT*UT-SPHI*VT+CPST*WT
      VF=SPCT*UT+CPHI*VT+SPST*WT
      WF=-STHE*UT+CTHE*WT
C  ****  Ensure normalisation.
      DXY=UF*UF+VF*VF
      DXYZ=DXY+WF*WF
      IF(ABS(DXYZ-1.0D0).GT.1.0D-14) THEN
        FNORM=1.0D0/SQRT(DXYZ)
        UF=FNORM*UF
        VF=FNORM*VF
        WF=FNORM*WF
       ENDIF
      RETURN
      END
C  *********************************************************************
C                       SUBROUTINE GCONEP
C  *********************************************************************
      SUBROUTINE GCONEP(DX,DY,DZ)
C
C  This subroutine rotates the initial position of the primary particle
C  so that a circle in the X-Y plane centred at the origin thranforms
C  into a circle perpendicular to the direction (THETA,PHI) of the beam
C  axis. Parameters are initialised by calling subroutine GCONE0.
C
      IMPLICIT DOUBLE PRECISION (A-H,O-Z), INTEGER*4 (I-N)
      PARAMETER (PI=3.1415926535897932D0, TWOPI=2.0D0*PI)
C  ****  Parameters for sampling directions within a cone.
      COMMON/CGCONE/CPCT,CPST,SPCT,SPST,SPHI,CPHI,STHE,CTHE,CAPER
C  **** Rotate to the beam axis direction.
      XR=CPCT*DX-SPHI*DY+CPST*DZ
      YR=SPCT*DX+CPHI*DY+SPST*DZ
      ZR=-STHE*DX+CTHE*DZ
      DX=XR
      DY=YR
      DZ=ZR
      RETURN
      END
C  *********************************************************************
C                       SUBROUTINE GCONE0
C  *********************************************************************
      SUBROUTINE GCONE0(THETA,PHI,ALPHA)
C
C  This subroutine defines the parameters for sampling random directions
C  uniformly within a cone with axis in the direction (THETA,PHI) and
C  aperture ALPHA (in rad).
C
      IMPLICIT DOUBLE PRECISION (A-H,O-Z), INTEGER*4 (I-N)
C  ****  Parameters for sampling directions within a cone.
      COMMON/CGCONE/CPCT,CPST,SPCT,SPST,SPHI,CPHI,STHE,CTHE,CAPER
C
      CPCT=COS(PHI)*COS(THETA)
      CPST=COS(PHI)*SIN(THETA)
      SPCT=SIN(PHI)*COS(THETA)
      SPST=SIN(PHI)*SIN(THETA)
      SPHI=SIN(PHI)
      CPHI=COS(PHI)
      STHE=SIN(THETA)
      CTHE=COS(THETA)
      CAPER=COS(ALPHA)
      RETURN
      END
C  *********************************************************************
C                       SUBROUTINE N2CH10
C  *********************************************************************
      SUBROUTINE N2CH10(N,L,NDIG)
C
C  This subroutine writes a positive integer number N in a 10-character
C  string L. The number is written at the left, followed by unused blank
C  characters. NDIG is the number of decimal digits of N.
C
      IMPLICIT DOUBLE PRECISION (A-H,O-Z), INTEGER*4 (I-N)
      CHARACTER*10 L,LT
C
      ND=MAX(N,0)
      WRITE(LT,'(I10)') ND
      DO I=1,10
        IF(LT(I:I).NE.' ') THEN
          IT=I-1
          GO TO 1
        ENDIF
      ENDDO
      IT=9
    1 CONTINUE
      L=LT(IT+1:10)
      NDIG=10-IT
      RETURN
      END
C  *********************************************************************
C                       SUBROUTINE RDPSF
C  *********************************************************************
      SUBROUTINE RDPSF(IUNIT,PSFREC,KODE)
C
C  This subroutine reads the phase space file. When KODE=0, a valid
C  particle record has been read and copied into the character variable
C  PSFREC. KODE=-1 indicates that the program tried to read after the
C  end of the phase-space file. Blank lines and lines starting with the
C  pound sign (#) are considered as comments and ignored.
C
      IMPLICIT DOUBLE PRECISION (A-H,O-Z), INTEGER*4 (I-N)
      CHARACTER*200 PSFREC
C
      KODE=0
    1 CONTINUE
      READ(IUNIT,'(A200)',END=2,ERR=1) PSFREC
      READ(PSFREC,*,ERR=1,END=1) ITEST
      RETURN
    2 CONTINUE
      KODE=-1   ! End of file
      RETURN
      END
C  *********************************************************************
C                       SUBROUTINE FWORD
C  *********************************************************************
      SUBROUTINE FWORD(STRING,TAIL,WORD,LENGTH)
C
C  This subroutine extracts the First WORD (substring between enclosing
C  apostrophes) of the string STRING, if it contains one. LENGTH is the
C  length of the WORD, excluding the apostrophes. TAIL is the remainder
C  of STRING after removing the word and leading blanks, commas, and
C  apostrophes.
C
      IMPLICIT DOUBLE PRECISION (A-H,O-Z), INTEGER*4 (I-N)
      CHARACTER*(*) STRING,TAIL,WORD
      CHARACTER TMP*132
C
      WORD=' '
      LENGTH=0
      I1=INDEX(STRING,'''')
      IF(I1.EQ.0) RETURN
      TMP=STRING(I1+1:)
      I2=INDEX(TMP,'''')
      LENGTH=I2-1
      IF(LENGTH.LT.1) RETURN
      WORD=TMP(1:LENGTH)
      TAIL=TMP(LENGTH+1:)
C
C  ****  Remove leading blanks, commas and apostrophes.
C
    1 CONTINUE
      IF(TAIL(1:1).EQ.''''.OR.TAIL(1:1).EQ.' '.OR.TAIL(1:1).EQ.',') THEN
        TMP=TAIL(2:)
        TAIL=TMP
        GO TO 1
      ENDIF
C
      RETURN
      END
