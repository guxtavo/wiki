#include <stdio.h>

/* Performance Debugger Library - pdl
 *
 * "Utilization, Starvation and Errors" and "Workload Characterization" Methods Debugger 

   use-wc-md

program prototype

use-wc-md performs automated performance investigation based on two methodologies created by Brendan Greg:

  - Utilization, starvation and errors methodology (USE)
  - Workload characterization methodology

By using "needles", use-wc-md can collect the necessary data to create a report 

  usage: use-wc-md [--help]

  use-wc-md - USE and WC methods debugger
  use-wc-md - triggering needles to investigate performance
  -u 
     generate utilization points
  -s 
     generate starvation points
  -e
    generate errors poins
  -w 
    generate workload characterzation
  -p <PID>
     call strace -c on a process, to get system call stats 
  -t 
     run perf stat for needle_interval

 DESCRIPTION
        This command gathers performance data to be investigated. It uses the µ
        Concept of needles from OpenQA. 
*/

needle_interval

needle_proc_stat

needle_perf
needle_strace_culprit_process

trigger_types proc/stat, perf
trigger_proc_running
trigger_proc_blocked
trigger_context switches
trigger_cpu_utilization
trigger_memory - how much memory you are moving
trigger_

trigger_to_start_debugger
  bool manual
  

utilization_points
starvation_points
errors_points

output_writer

start_debugger



main
