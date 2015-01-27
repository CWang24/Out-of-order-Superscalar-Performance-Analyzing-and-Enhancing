# Out-of-order Superscalar Performance Analyzing and Enhancing
This is the projects of EE557. It's combined of two parts actually, the first part is designed to familirize us with the tools and the structure.

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


