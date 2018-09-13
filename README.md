# podiv-altium
Altium repository for podiv. This project is set up to provide all documentation, design and data validation required for the Badgerloop Pod 4 PCBs.

## Prerequisites
Altium only works on Windows. See  [Altium System Requirements](https://www.altium.com/documentation/18.0/display/ADES/Altium+Designer+-+((System+Requirements))") for more information. An internet connection is required to connect to the license server and dual monitors are nice to ahve. Microsoft Excel is required for BOM generation.

## Installation
1. Create an [Altium Live](https://live.altium.com/#Join") and contact Ethan Link, Ryan Castle or Vaughn Kottler to be added to the Badgerloop Team AltiumLive Account and the Badgerloop [Github](https://github.com/badgerloop-software"). You may continue to step to step 8 without requiring an active license.
2. Download the latest version of [Altium Designer](https://www.altium.com/products/downloads") 
3.  Install Altium. Default file paths will work.
4. Insall [Git Bash](https://gitforwindows.org/") Git Bash (or whatever BASH emulation tool you are comfortable with)
5. Open Git Bash
6. Type the following commands into the command prompt window:
   + cd Documents
   + mkdir git_repos
   + cd git_repos
   + git clone https://github.com/badgerloop-software/podiv-altium.git
   + git checkout -b <your-username_training>
   + Open Altium and sign in. You are now on a training branch that you will complete your first getting started project on if you are new to Altium. 
7. Go to User Silhouette (Top Right Corner) -> License Management. Then Click Sign In and enter your username and password associated with Altium Live and accept the warning. It's also a good idea to check Sign me in when I start Altium Designer if you'd like to save a little time.
8. Click Use to claim a license. If you are not using a valid license, you will be able to view files in Altium Designer but you will not be able to make edits. Ensure that you are choosing an Altium Designer License and not our PDN License. That's something else. 
9. Go to Setting -> Data Management -> Design Reposotories and enter the following information:
   + Name: pod4
   + Default Checkout Path C:\Users\ < your username >\Documents\git_repos\podiv-altium
   + Method: https
   + Server: github.com
   + Server Port: Default
   + Repository Subfolder: /badgerloop-software/podiv-altium
   + Username: < your github username >
   + Password: < your github password > 
10. You are now ready to use Altium. See [Training](#training) for more details on how to get started. 

## Training
View the [Badgerloop Altium Presentation](https://uwmadison.box.com/s/2sdt8kfaeyde04sg8edn62u7vtrdsiyx") for a getting started project. You can work locally for this project. Git-specific training will be posted at a later date. 

## General Tips
+ Do not try to use Altium's built in check-out/commit tools. Instead, use Git from the terminal to perform git operations. This prevents a lot of conflicts. Learning how to use the command line is a really good thing to learn how to do as it's used in industry all over.
+ To save, CTRL + S does not work all of the time. Instead, right click on the file you want to save and hit "save". Also, note that if a schematic document is edited, saving the entire project will only save the project structure, not the actual schematic file you have changed. 
+ Multiple libraries are used in part to reduce the number of conflicts between branches. It's important that you are regularly commiting and pushing your changes when multilpe users are working. Conflicts are possible to solve, but are somewhat challenging to do so. 
+ Note that multilpe projects can reference the same libraries. Be careful if you are editing a component that has already been placed in another project, as even minor changes like pad size can have major unintended results. 

## Contributing
There are several ways to contribute to the repo. Check open issues to see what needs active work. Talk to the Avionics Lead or the Electrical Director about where your skill level can be most used.
+ Library components:
   + Schematic: Schematic libraries consist of the symbols used in schematics, as well as their pinoutsand link PCB and 3D components
   + PCB: PCB libraries consist of the footprints, pinouts and links to schematic symbols and 3D components. Footprints are the arrangement of pads and/or plated through-holes to physically attach and electrically connect a component to a printed circuit board. A silkscreen, keepout zone, and mechanical connections may also be added to a footprint
   + 3D Library: Each PCB footprint can be associated with a 3D STEP model and viewed in 3D mode of the PCB viewer. This is not required, but useful for exporting to the main pod MCAD as well as for enclosure design. 
+ Schematics:
   + Break out your datasheets! This is where the rubber meets the road of electrical engineering. Schematic design is where the highest level electrical engineering occurs, connecting different discrete components like resistors, capacitors, inductors and diodes to integrated circuits (ICs), connectors, hardware, etc. 
   + Schematic review: Look through an existing schematic and fill out the (still TODO) Schematic Review checklist. We want to catch issues as early as possible and correct before the board goes to layout or even worse, fabrication! 
+ PCBs:
   + I like to think of PCB layout as running through a maze several dozen times, where you control how the walls are constructed, there more more walls as you go along, and things can move as you go. PCB design is a learned skill, so the best thing to do is practice!
   + PCB review: Similar to schematic review, we want to find PCB layout issues before we send out to fabrication. Something as simple as a component flipped around can cause a boards unusable! 

## Directory Structure
TODO

## Authors
TODO

## Acknowledgements
+ Dave Jones of the EEVBlog, as we'd have no idea what we were doing with his videos.
