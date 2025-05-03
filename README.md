**Monitoring System Resources for a Proxy Server

#Explanation:
- *top_apps*:  Displays the top 10 processes consuming the most CPU and memory.
- *network_monitor: Shows the number of concurrent connections, packet drops, and network traffic.
- *disk_usage: Displays disk usage and highlights partitions using more than 80% of the space.
- *system_load: Shows the current system load and a breakdown of CPU usage.
- *memory_usage: Displays total, used, and free memory, including swap usage.
- *process_monitor: Shows the number of active processes and top 5 processes by CPU and memory usage.
- *service_monitor: Monitors essential services like sshd, nginx, apache2, and iptables.

# Usage:
 -Given the script execute permissions using "chmod +x mv.sh" before running it.
 
- Runned the script with the -all switch to view the entire dashboard:
  bash
  ./mv.sh

- We can also call individual fuction by using:
    -./mv.sh -cpu        #for top 10 CPU and Memory consuming applications.
    -./mv.sh -network    #for network monitor, concurrent connection and packet drops.
    -mv.sh -disk         #for display mounted partitians
    ./mv.sh -load        #for current load and CPU breakdown of system.
    ./mv.sh -memory      #for display total,used and free memory also swap usage.
    ./mv.sh -process     #for display all active processes and top 5 processes of system.
    ./mv.sh -services    #for essential services like sshd apache2 etc. check status of services.


  #INTERVAL
    - By using interval this can clear the existing data and update it by new one at specific time.
    - we can add time as per our requirement
    - eg: 30 sec, 300 sec= 5 min , 600 = 10 min..
  


 
