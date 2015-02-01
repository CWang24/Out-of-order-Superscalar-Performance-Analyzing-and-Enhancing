# Out-of-order Superscalar Performance Analyzing and Enhancing
This is the final project of EE557. It has two parts actually, the first part is designed to let us be familiar with the tools and the structure. The second part is using what we learnt in part1 to improve the perfomance of this superscalar to the most with limited resources (area, transistor count).<br />
I need to modify the settings, calculate the value, fill in the file and simulate. Again and again, the procedure is quite tedious, time-consuming and error-prone if doing manually. <br />
So I wrote [a perl script](https://github.com/CWang24/Out-of-order-Superscalar-Performance-Analyzing-and-Enhancing/blob/master/cw557.pl) and do the iterations with it. The flowchart below basically summerizes this perl script. <br />
(Start from "Setting Info" in the top right corner following the solid blue arrow to the left)
![image] (https://dl.dropboxusercontent.com/s/4t86k91wq204xr7/pic3.png?dl=0)
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










