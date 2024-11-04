# AMBA3-APB
This project features an implementation of the AMBA3 Advanced Peripheral Bus (APB) protocol, which is designed for connecting low-bandwidth peripherals in a system-on-chip (SoC). The APB protocol simplifies communication by using a single-cycle bus interface for read and write operations, minimizing complexity and power consumption compared to high-performance buses. APB is commonly used for accessing register-based peripherals in embedded systems, making it ideal for low-power applications.

The implementation includes a SystemVerilog-based testbench (non-UVM) and has been tested with a basic sequence of one write followed by one read transaction. Simulation and synthesis were performed on Vivado 2024.1. Feedback and suggestions are welcome!
