# Badgerloop Libraries

## How to add a part video:
https://youtu.be/r89xm_44ldI

## Schematics Requirements:
1. Correct library (capacitor, resistor, connector...)
2. Descriptive and searchable Design ID?
3. Link to component on digikey?
4. Default designator set?
5. 100 Mil Snap Grid? 
6. Pin Maps are correct
7. Are pins grouped in a logical way? 
8. Does the part symbol make sense for the specific part? 
9. Is your part linked to a PCB Footprint?
10. Is your part linked to a 3D Model? 

## PCB Footprint Requirements:
1. Are you following the datasheet's recommended PCB footprint guidelines? 
2. Does your silkscreen make sense? Is it descriptive, but still small? 
3. Do you have enough clearance between adjacent pads, vias, PTH, etc.
4. Are you following the datasheet's recommended PCB footprint guidelines?
5. Do your pads have enough room to solder onto? 
6. Check your layers, are you working primarily on the top side? 
7. Did you check your real-world component dimensions with calipers?
8. What is your snap grid? 

## Temporary Libraries:
While doing a design you may want to move pin locations, adjust sizes, clean up silkscreen, etc. and it’s cumbersome to switch back and forth between the libraries branch and your project branch, doing a PR, getting it merged and rebased. This leads to not doing it and ignoring the structure set up. 



Temporary Library files can be used for a particular branch while actively fine tuning library components. When you are at a decent pause point, you should commit your changes, save the library locally to your machine, then switch to the primary libraries branch. Once here, copy and paste your changes into the main libraries, go through the checklists, and make  PR. Once you are merged into master, go back to your project branch, rebase, and update your component links all at once. Once we have a solid library of verified parts this will be less necessary.