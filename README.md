# Out-of-order Superscalar Performance Analyzing and Enhancing
This is the projects of EE557. It has two parts actually, the first part is designed to let us be familiar with the tools and the structure. The second part is using what we learnt in part1 boost the perfomance of this superscalar to the most.

Improve the performance of the baseline processor with limited resources (area, transistor count), by iteratively looking for an optimal design choice for all the micro-architectural blocks like adjusting branch and cache configuration. Exploring the design space using simulations. Individual project. 
Wrote Perl script to automatically modify and read result of Excel based Estimator and online webpage based estimate tool (Cacti).
Wrote Perl script to automatically modify the configuration file and test with four benchmarks on UNIX system and parse the test results log files for performance calculating.

The Cacti 5.3 simulator is available on the net at http://quid.hpl.hp.com:9081/cacti/

The SimpleScalar simulator has been installed on the ITS machines (aludra.usc.edu or nunki.usc.edu).

We will be using two SPEC CPU2000 (http://www.spec.org/cpu2000/) benchmarks i.e. gzip for integer
benchmark and equake for floating point benchmark. 

limit all our simulations to only 75 million instructions. We will fast-forward through first 300 million
instructions. 

-max:inst 75000000
-fastfwd 300000000
#### Project Environment
###### a.SimpleScalar Simulator and Benchmarks
SimpleScalar (http://www.simplescalar.com) is a suite of several simulators, which simulate the machine
at different levels of detail. We will use sim-outorder, the most detailed one. It can simulate, cycle by
cycle, a superscalar processor with dynamic scheduling, branch prediction, speculative execution, caches,
etc. 
benchmarks:gzip(executables), equake (executables), input.graphic (gzip input file) and equake.in (equake input files). 

###### b. Cacti Simulator
Cacti is a model based tool which estimates cache access time, cycle time, leakage and dynamic power
for an SRAM based memory. We will use the most recent version of Cacti, which is 5.3. It is interactive
and web based. 
http://quid.hpl.hp.com:9081/cacti/

###### c. Transistor Count and On-chip Real Estate Estimator
The hardware complexity estimation tool can estimate the transistor count and chip space based on the
SimpleScalar configuration parameters. The tool is implemented as an MS Excel spreadsheet,
“realEstimator.xls” 

###### d. Simulator (sim-outorder) Configuration









