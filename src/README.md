# Pod IV Multi-board PCB Project
The general approached for PCBs for Pod IV is to divide the workload into two types of boards-- processor boards and IO (Input/Output) boards. One processor board and one IO board will make up a module. The primary benefit to this approach is that the more complicated power and microcontroller circuitry can be done one time on the processor board, while module specific IO can be created to fit the specific module needs. 

## Module Notes:
+ Standard [connector](https://www.avnet.com/shop/emea/products/samtec/et60t-00-00-04-l-rt1-gp-3074457345629068722/") and pinout for each module allows for IO modules to be connected to any processor board safely
+ The blade connectors will be able to transfer the required current for up to 20 solenoids.
+ Must verify that signals routed over the longer leads are routed properly
+ Direct board <--> harness connection to eliminate module-box level wiring
+ I2C IO expanders used regularly as the standard interface between processor and IO boards. SPI and UART connections also routed to the connector but a NC (no connect) is acceptable.
+ 3D printed module boxes to fit the box to the boards, have holes pre-drilled

## Processor Board Notes:
+ 24V Input --> 5V, 3.3V outputs with reverse polarity protection, hold-up, surge stopper
+ Board mount processor with a QFN32 package utilized

## Module Board Notes:
+ Good project for beginners after you have completed the training board. 
+ Propoposed board ideas:
   + Navigation -- Accelerometer, Retroreflective sensor, distance sensor, wheel encoder
   + Pressure Vessel / Precharge PCB -- Pressure vessel monitoring and high voltage pre-charge circuit
   + Wireless communications -- replacement for the network access panel (NAP)
   + Braking -- IO for solenoids, pressure sensors
   + Low Voltage battery monitoring -- Battery management system for the low voltage system
   + Control Panel Display board -- Provide visual feedback for the system, useful for debugging. 
