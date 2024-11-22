#!/bin/bash

# Default values
num_instances=1
start_port=11435
interval=5

# Function to display usage
usage() {
    echo "Usage: $0 [--num-instances <number>] [--start_port <port>] [--interval <seconds>]"
    exit 1
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --num-instances)
        num_instances="$2"
        shift # past argument
        shift # past value
        ;;
        --start_port)
        start_port="$2"
        shift
        shift
        ;;
        --interval)
        interval="$2"
        shift
        shift
        ;;
        *)
        echo "Unknown option: $1"
        usage
        ;;
    esac
done

# Validate arguments
if ! [[ "$num_instances" =~ ^[0-9]+$ ]] || ! [[ "$start_port" =~ ^[0-9]+$ ]] || ! [[ "$interval" =~ ^[0-9]+$ ]]; then
    echo "Error: Arguments must be numeric."
    usage
fi

echo "Starting $num_instances Ollama instances starting from port $start_port..."

declare -A pid_port_map

# Start instances
for ((i=0; i<num_instances; i++)); do
    port=$((start_port + i))
    echo "Launching instance on port $port..."
    OLLAMA_HOST=0.0.0.0:$port ollama serve &
    pid=$!
    pid_port_map[$pid]=$port
done

echo "All instances have been started."

# Monitoring loop
while true; do
    clear
    echo "Monitoring Ollama instances (refresh every $interval seconds):"
    echo "PID       Port      Status"
    echo "-------------------------------"
    for pid in "${!pid_port_map[@]}"; do
        if kill -0 $pid 2>/dev/null; then
            status="Running"
        else
            status="Not running"
        fi
        printf "%-9s %-9s %s\n" "$pid" "${pid_port_map[$pid]}" "$status"
    done
    sleep $interval
done
