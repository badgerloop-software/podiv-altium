# Power PCB BOM Changes
* Replace R8 with 0402 316K 1% Ohm resistor 
  * Adjust the 3.3V feedback resistor to output 3.3V instead of 5V
  * Yes, this does cause the "POS5V" net to output 3.3V and "POS3V3" to output 5V. This was the only way to spin the processor board in a couple of hours rather than a couple of days. 
* DNP U4
  * Individual Board sensing not going to be used, as overall information will come from ideal diode PCB
