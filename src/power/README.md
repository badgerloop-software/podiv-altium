# Point of Load (POL) Power Supplies
## Getting Started
1. Watch the introductory [video](https://www.youtube.com/watch?v=o5OQcIHKOF0)
2. Download [Altium](www.altium.com) if you haven't already done so
3. Download [LTPowerCAD](http://www.analog.com/en/design-center/ltpowercad.html)
4. Download [Mathcad Express](https://www.ptc.com/en/products/mathcad-express-free-download/install)
5. Read some background information 
   * [Good Start](https://electronicsforu.com/resources/learn-electronics/smps-basics-switched-mode-power-supply)
   * [More Advanced](https://www.onsemi.com/pub/Collateral/SMPSRM-D.PDF)
6. Review the LTC8642S [datasheet](http://www.analog.com/media/en/technical-documentation/data-sheets/lt8642s.pdf)

## Board Power Tree

![Power Tree](https://github.com/badgerloop-software/podiv-altium/blob/master/pdf/LV-Modules-PowerTree.png "Power Tree")

## Random Design Notes

* Use X7R for most capacitors, as these have better ratings over temperature. Note that this limits the range of nominal values you have access to per a given package size, but actual capacitance may be better over the range. 
   * Use C0G or NP0 Caps for compensation components if possible
* Feedback resistors should be 0.1% tolerance and Cff/Cfb should be X7R or NP0.
* Record all calculations in the mathcad files. Every component needs a justification.
* Estimating ESR and ESL is difficult. 
   * AVX published this [paper](https://www.avx.com/docs/techinfo/CeramicCapacitors/parasitc.pdf) for average ESL for package sizes. 
   * Depending on the manufacturer, ESR may be found on the component datasheet (Tayido Yuden) on a part specific search (TDK), Web app (Murata). It helps to do a search directly from the manufacturer's website. 
   * If you can't find data, you should probably use a different cap. If you really need to for some reason, you could copy characteristics from a similar component, but that's error prone.
* Capacitance changes with 
   * Temperature
   * Operating Frequency
   * DC Bias
   * Manufacturing tolerance
Be sure to account for all of these losses! Nominal capacitance doesn't really mean anything. Yes, you multilpy all of these losses together 
   * Example: 90% (temp losses)* 95% (Operating frequency) * 60% (DC Bias) * 80% (Manufacturing tolerance) = 41% of the datasheet capacitance value. That's like expecting 4.7uF and getting 2uF.
* Frequency Response simulations like those provided with LTPowerCAD can vary greatly if you put the incorrect inputs in for values like ESR and ESL. 
* Separate tantalum and ceramic capacitors for bulk and ceramic in PowerCAD. ESR is very different between the two and does not add like regular parallel resistance. 

## Testing Power Supplies

There are a number of design verification tests and measurements that should be performed for switch-mode-power-supplies or LDOs to ensure their operation in corner cases and over the lifetime of the product. This document will be updated with sample scope captures. 

Note that it is good practice to perform each test at min/max/nominal load cases, min/max/nominal input voltage, (min/max/nominal temperature is nice too but not required for our application)

### Steady-State Output Voltage Ripple
Measuring the peak-to-peak ripple current (on the order of 5mV/div on a scope). Looking for ESL spikes on the output as well. 

### Transient Response
How does a supply respond to a (near) instantaneous load. When current is drawn from the supply, the output voltage should drop, and then recover to the original output voltage minus load line losses. When the load is removed, the opposite should occur. You should be looking for a "critically damped", or single half-wave sinusoid, response as "ringing", or a fully sinusoidal wave with decreasing amplitude, indicates an unstable supply.
#### Testing Transient Response
Testing a transient response can be done in a number of ways. The most basic version is to manually connect and disconnect a power resistor to the output. 

Alternatively, more advanced forms of this test involve a device like an Intel [mini-slammer](https://designintools.intel.com/25A_Mini_Slammer_p/q6uj9a00ms25.htm_) or similar programmable load. Basically, you apply a waveform to the mini-slammer, which alters the effective load resistnace on the supply. This is an effective way to power on and power off a load at a regular frequency. Operation of a mini-slammer also requires an [Analog Discovery](https://store.digilentinc.com/analog-discovery-2-100msps-usb-oscilloscope-logic-analyzer-and-variable-power-supply/) or other wavegenerator and a mini-slammer [control board](https://designintools.intel.com/Mini_Slammer_Control_Board_p/q6uj9a00mscb.htm_)

Your oscilloscope should be set to NORMAL mode and trigger on your current-corresponding waveform. Scope captures should include Vin, Vout and load current. 
#### What do we get out of testing transient response? 
Testing the transient response of a supply gets you the following:
1. Evaluates stability of the supply (ringing present)
2. Measuring the deviation in output voltage from the norm. Some processors and FPGAs have 5% or even 3% output voltage tolerances.
3. Confidence that your supply will work when loads power on, relays engage, or there is some change in load.

### Vin / Enable / Vout / PGood Characteristics
Most power supplies that we are working with have a number of inputs and outputs that depend on one another. For example, for the LTC8640S supply topology, to have the normal operating output voltage, VIn must be above the Vin_min value listed in the datasheet, but the LTC8641S is in shutdown when the EN pin is low and active when the pin is high. According to the datasheet, When the LT8642S’s output voltage is within the ±8% window of the regulation point, the output voltage is considered good and the open-drain PG pin goes high impedance and is typically pulled high with an external resistor. We want to verify these signals do not glitch and characterize the delay between actions to ensure that we are not violating the minimum time thresholds in the datasheet. 

For these tests, set the oscilloscope to measure the following signals: Vin, EN, PGood, Output
#### Vin high with EN rising
Part A:
1. Hold Vin at the minimum operating voltage
2. Slowly increase the voltage on the ENABLE pin until the supply enables. Record this a EN_MIN
Part B:
1. Set your bench power supply to the expected operating minimum enable voltage
2. Enable the supply
3. The scope should be triggered ont he rising PGOOD channel.
4. Inspect the supply for any glitching of signals
5. Using the vertical cursors, measure the time between EN @ EN_MIN and the output reaching the steady state value and PGOOD going high. 
6. Repeat while the output is connected to a load.

#### Vin rising with EN high
Repeat the previous test except VIn will rise and EN will be held high

### Frequency Response Analysis
This guide will cover the basics of Frequency Response, but will focus on the practical aspects of frequency response. For more theory, check out these links
* [AN-1889 How to Measure the Loop Transfer Function of Power Supplies](http://www.ti.com/lit/an/snva364a/snva364a.pdf)
* [Ridley Engineering](http://www.ridleyengineering.com/design-center-ridley-engineering/)

According to Dr. Ridley, 
    "Loop gain is an essential measurement on all switching power supplies since it will provide information of stability, closed-loop performance, long-term ruggedness of the control, and a sensitive measure of many parts involved in the power supply construction."
This [article](http://www.ridleyengineering.com/design-center-ridley-engineering/41-frequency-response/104-026-frequency-response-measurement-part-4-loop-measurements.html) describes the industry standard technique for measuring loop response. Note that for the supplies we are working with the PWM controller and Switching Power Supply are integrated into the same IC. 

We are trying to measure the loop-gain and phase of the feedback system for the power supply. We purposely inject noise into the system at increasing frequency (Channel A) and measure the output (Channel B or R) and compare. R/A plots the gain and phase of the system. In short, we are trying to ensure that both gain and phase will not equal zero at the same time, which leads to an unstable transfer function. There are certain critical aspects of the system:
* Gain 0 dB crossover frequency: Where does the gain cross zero? Are there multilpe crossovers? This is also known as the "Bandwidth" of the supply. Rule of thumb is about 1/20th the switching frequency
* Phase Margin: What is the phase doing when gain is at zero? Depending on the application, anywhere from 30 degrees of margin (cheap toys) to > 70 degrees (helicopters, medical instruments) is required. For the pod, 50-60 degrees is the target. 
* Gain Margin: What is the gain doing when phase crosses zero? Rule of thumb, this should be less than -10 dB
It should be noted that these are just three points on an entire spectrum. Understanding different types of compensation networks and their gain and phase curves is a more advanced skill, but is still worthwhile. This [article](http://www.ridleyengineering.com/design-center-ridley-engineering/41-frequency-response/140-077-interpreting-loop-gain-measurements.html) goes into more detail. 

#### Why so much margin? 
Well, you think you're ok with 30 degrees of PM and -5dB of GM. But then it's a little chilly out one day and your iPhone stops working. Or it's a hot day in LA and we're getting in the tube and our boards turn off randomly. Or we've been using the supply for so long our caps start to lose some of their nominal value. Or 100 other things could change in the real world application of the circuit. Having sufficient margins allows for these changes. 

#### Why should we do this? 
More from Dr. Ridley:
   "The aerospace design world is probably the most rigorous in making complete sets of bode plots for input impedance, output impedance, audiosusceptibility, and loop gain. Outside of the aerospace world, it is less common to make this full set of measurements. Most experienced designers will make a loop gain measurement since they find that it is a very sensitive measure of just about everything in the power stage and the feedback path. **If some component is the wrong value, or something is built wrong, the loop gain is very likely to show that there is a problem.**"

#### How to perform the test
For now, I will just link to Dr. Ridley's explaination of the test. [AN_026](http://www.ridleyengineering.com/design-center-ridley-engineering/41-frequency-response/104-026-frequency-response-measurement-part-4-loop-measurements.html)
