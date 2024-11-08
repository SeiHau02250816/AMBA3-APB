# AMBA3-APB
This project features an implementation of the AMBA3 Advanced Peripheral Bus (APB) protocol, which is designed for connecting low-bandwidth peripherals in a system-on-chip (SoC). The APB protocol simplifies communication by using a single-cycle bus interface for read and write operations, minimizing complexity and power consumption compared to high-performance buses. APB is commonly used for accessing register-based peripherals in embedded systems, making it ideal for low-power applications.

The implementation includes a SystemVerilog-based testbench (non-UVM) and has been tested with a basic sequence of one write followed by one read transaction. Simulation and synthesis were performed on Vivado 2024.1. Feedback and suggestions are welcome!


### Coverage report:
![image](https://github.com/user-attachments/assets/730d2ff6-c5d8-4fde-a463-1aba6f2cf8b0)

![image](https://github.com/user-attachments/assets/516e592e-ef3a-4706-8a77-d5d0c7f52733)
