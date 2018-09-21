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
