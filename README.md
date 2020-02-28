# The Hybrid Line Hough Transform (Hybrid LHT) Implementation on FPGA (hybrid_lht).

This repository contains the dataset for the implementation of the Hybrid Line Hough Transform (Hybrid LHT) on Field Programmable Gate Array (FPGA).

The dataset for the Hybrid LHT FPGA implementation is provided as a set of Matlab and Simulink files for simulation and VHDL generation. Simulink models and M-files can be opened using MATLAB 2019b and the Synthesis and Implementation tool is Vivado 2019.1.

Simulink models that have already been tested for VHDL generation, synthesis, and implementation are provided. These models are parameterized using several different image resolutions and Hough parameters. Hardware resource utilization and timing analysis are provided by opening the associated Vivado project.

The primary simulation that tests the functionality of the Hybrid LHT is also provided. This simulation uses two candidate images, also found within this dataset, to test the ability of the Hybrid LHT.


## How to use this repository
Ensure that the following files and subfiles are added to the Matlab path.
* hybrid_lht/src/
* hybrid_lht/img/

## Implementation
Run implementation for either the Parallel LHT or Hybrid LHT by navigating to the respective model directory (hybrid_lht/models/...) and run the hdlcoder_test.m script. This will implement a design for all the given resolutions at the top of the file.

## Simulation
This work can be simulated by running the simulation_test.m file in the respectivel model directory (hybrid_lht/models/...). This script will iterate through each given resolution at the top of the screen and output a text file to indicate whether the test passed.
