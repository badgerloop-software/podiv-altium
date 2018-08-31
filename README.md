# podiv-altium
Altium repository for podiv.

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
7. Go to DXP -> My Account
8. Click Use to claim a license. If you are not using a valid license, you will be able to view files in Altium Designer but you will not be able to make edits.
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
