# Ollama Server Scaler Script

## Overview

The `ollama_server_scaler.sh` script allows you to launch multiple Ollama server instances simultaneously, each on a unique port. This is useful for scaling services, load balancing, or testing multiple configurations in parallel.

## Prerequisites

- **Bash Shell**: The script is written for bash; ensure you have bash installed.
- **Ollama Installed**: Make sure the `ollama` command-line tool is installed and accessible in your system's `PATH`.
- **Network Ports**: Ensure the range of ports you plan to use is available and not blocked by your firewall or used by other applications.

## Installation

1.  **Download the Script**: Save the script content into a file named `ollama_server_scaler.sh`.

2.  **Make the Script Executable**: `chmod +x ollama_server_scaler.sh`

## Usage

Run the script using the following syntax:

bash

Copy code

`./ollama_server_scaler.sh --num-instances <number_of_instances> --start_port <starting_port_number>`

- `--num-instances`: (Optional) The number of Ollama instances to launch. Defaults to `1` if not specified.
- `--start_port`: (Optional) The starting port number for the first instance. Defaults to `11435` if not specified.

### Example

To launch 8 Ollama instances starting from port `11435`:

`./ollama_server_scaler.sh --num-instances 8 --start_port 11435`

This will start instances on ports `11435`, `11436`, `11437`, ..., `11442`.

## Script Explanation

The script performs the following steps:

1.  **Argument Parsing**: It reads the command-line arguments to determine the number of instances and the starting port.

2.  **Validation**: It checks if the provided arguments are numeric and displays usage information if they are not.

3.  **Launching Instances**: It starts the specified number of Ollama server instances in the background, each bound to a unique port.

## Tips

- **Port Range**: Ensure that the range of ports (`start_port` to `start_port + num_instances - 1`) is available.

- **Background Processes**: The script launches the servers in the background. They will continue to run until you terminate them or log out (unless they are managed by a process supervisor).

- **Logs**: If you need to capture logs from each instance, consider redirecting output to log files within the script.

## Troubleshooting

- **Command Not Found**: If you receive a `command not found` error for `ollama`, ensure it is installed and your `PATH` variable includes the directory containing `ollama`.

- **Permission Denied**: If you encounter permission issues, check the execution permissions of the script and ensure you have the necessary rights to bind to the specified ports.

- **Port Already in Use**: If an instance fails to start due to the port being in use, verify that no other service is running on that port.

## Contact

For questions or support, please contact the script maintainer or refer to the Ollama documentation.

## License

This script is released under the MIT License.
