#!/bin/bash

#color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Default

#Refresh Interval in Seconds (Set to 300 = 5 minutes, 600 = 10 minutes)
INTERVAL=300

#Top 10 CPU and Memory Consuming Applications
top_apps() {
  echo -e "${YELLOW}Top 10 CPU and Memory Consuming Applications:${NC}"
  ps aux | sort -nrk 3 | head -n 10
}

#Network Monitoring
network_monitor() {
  echo -e "${YELLOW}Network Monitoring:${NC}"
  echo "Concurrent Connections: $(ss -s | grep -i estab | awk '{print $4}')"
  echo "Total Packet Drops: $(cat /proc/net/netstat | grep -m1 TcpExt | awk '{print $14}')"

  IFACE=$(ip route get 1 | awk '{print $5; exit}')
  RX=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
  TX=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
  echo "Interface: $IFACE"
  echo "In: $((RX / 1024 / 1024)) MB, Out: $((TX / 1024 / 1024)) MB"
}

#Disk Usage
disk_usage() {
  echo -e "${YELLOW}Disk Usage:${NC}"
  df -h | awk 'NR==1 || $5+0 > 80 {print}'
}

#System Load and CPU Breakdown
system_load() {
  echo -e "${YELLOW}System Load and CPU Breakdown:${NC}"
  uptime
  echo "CPU Usage:"
  mpstat 1 1 | grep "all" | awk '{print "User: " $4 "%, System: " $6 "%, Idle: " $13 "%"}'
}

#Memory and Swap Usage 
memory_usage() {
  echo -e "${YELLOW}Memory and Swap Usage:${NC}"
  free -h
}

#Process Monitoring
process_monitor() {
  echo -e "${YELLOW}Process Monitoring:${NC}"
  echo "Active Processes: $(ps aux | wc -l)"
  echo "Top 5 Processes by CPU and Memory:"
  ps aux | sort -nrk 3 | head -n 6
}

#Essential Services Monitoring 
service_monitor() {
  echo -e "${YELLOW}Essential Services Monitoring:${NC}"
  for service in sshd apache2 nginx iptables; do
    if systemctl list-units --type=service | grep -q "$service"; then
      systemctl is-active --quiet $service && \
        echo "$service: ${GREEN}Active${NC}" || \
        echo "$service: ${RED}Inactive${NC}"
    else
      echo "$service: ${YELLOW}Not installed${NC}"
    fi
  done
}
show_all() {
  clear
  top_apps
  echo
  network_monitor
  echo
  disk_usage
  echo
  system_load
  echo
  memory_usage
  echo
  process_monitor
  echo
  service_monitor
}
case $1 in
  -cpu) top_apps ;;
  -network) network_monitor ;;
  -disk) disk_usage ;;
  -load) system_load ;;
  -memory) memory_usage ;;
  -process) process_monitor ;;
  -services) service_monitor ;;
  -all | "") 
    while true; do
      show_all
      sleep $INTERVAL
      clear
    done
    ;;
esac
