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
