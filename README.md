# Out-of-order Superscalar Performance Analyzing and Enhancing
This is the final project of EE557. It has two parts actually, the first part is designed to let us be familiar with the tools and the structure. The second part is using what we learnt in part1 to <b>improve the perfomance of this superscalar to the most with limited resources (area, transistor count).</b><br />
The tools are webpage based and Excel based. I need to modify the settings, calculate the value, fill in the file and simulate again and again. The procedure is quite tedious, time-consuming and error-prone if doing manually. <br />
So I wrote [a perl script](https://github.com/CWang24/Out-of-order-Superscalar-Performance-Analyzing-and-Enhancing/blob/master/cw557.pl) and do the iterations with it. The flowchart below basically summerizes this perl script. <br />
(Start from "Setting Info" in the top right corner following the solid blue arrow to the left)
![image] (https://dl.dropboxusercontent.com/s/4t86k91wq204xr7/pic3.png?dl=0)
#### Tools involved
###### a.SimpleScalar Simulator and Benchmarks
[SimpleScalar](http://www.simplescalar.com) is a suite of several simulators, which simulate the machine
at different levels of detail. It is intalled on the server with all the benchmarks.
###### b. Cacti Simulator
[Cacti](http://quid.hpl.hp.com:9081/cacti/) is a model based tool which estimates cache access time, cycle time, leakage and dynamic power for an SRAM based memory. It is web based. 
###### c. Transistor Count and On-chip Real Estate Estimator
The hardware complexity estimation tool can estimate the transistor count and chip space based on the SimpleScalar configuration parameters. The tool is implemented as an MS Excel spreadsheet, “realEstimator.xls”.


#### Summerize

I iterated many times and left two directions of design, one was sacrifice clock period for more execution units, the other one was using less execution units for a small clock period. I adjusted other parameters to achieve the highest MIPS in both design flows. The best for the first design was 3420, while the second design achieved 3438. So I chose the second design as my final design.

With <b>clock cycle=0.46ns(2.17GHz), the MIPS of the final design reaches 3438</b>, while using 220251031 transistors and 19.9mm^2 area. And this was the top3 design in that semester. This page is just an introduction, for detailed report please contact me via caowang34@gmail.com.









