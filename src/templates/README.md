# Templates
The purpose of this folder is to provide all templates for schematics sheets, PCBs, BOM, circuit snippets and reviews

## Circuit Snippets
[Badgerloop Altium Part II -- How to add a circuit snippet](https://www.youtube.com/watch?v=RExZlAXOayE&t=1s)

## Reviews
There are two templates associated with a review, the word document format and a powerpoint. The nominal workflow for a schematic or layout review are as follows:
1. The designer will output the following files and commit them to their working branch:
     * Schematic PDF
     * Board layout drawings, broken out layer by layer 
     * Gerbers, Drill Drawings
     * Pick and Place Files
     * BOM
     * Copy of the templates with the title < Project Name > _ Review _ < Rev > _ < Initial Date > copied into the podiv-altium/src folder
  
     * Note that there will be a template outputjob file that will take care of most of these outputs. 

2. The layout and/or schematic designer indicates that their board is ready for review by creating a new issue and assigning at least one peer reviewer or informing the electrical director they should assign a reviewer. 
3. Depending on the board complexity and timeline, we may want to have the board reviewed by a faculty member or one of our industry advisors. Work with the electrical director to arrange this. 
4. The reviewer will go through the review checklist. Note that the checklist is not exhaustive. Feel free to add rows and update the template. 
       * For short comments, quick calculations, design notes, etc., feel free to use the review word document. 
       * For more detailed comments or if screenshots are required, use the powerpoint format. Feel free to delete unused slides at the end of review. 
   
   Note that the slides will be listed as suggested reading for new PCB designers, as they will be a good record of mistakes we've made or almost made on our boards, in hopes that we won't do it again. 
5. The reviewer shall inform the designer of any changes required or suggested. We should also implement a way to indicate a change for the future revision, but not the current one. 
6. Any updates necessary should be made by the designer (nominally), but for some small changes it may be appropraite for changes to be made by the reviewer, just ensure that the RE knows and approves of the change.
7. Once a board is reviewed and okayed by all required parties, commenting on the git issue (or the designer / primary peer reviewer making a note of other's approval), output a final set of output files and add to the podiv-altium/pdf folder. It is critical that we have an exact copy of what we send to the board fabrication shop (and possibly assembly house) if we end up making future changes. 
8. Send files to the board shop. Work with them for any design for manufacturing (DFM) issues. 
9. Create a purchase order if necessary.
10. Wait 5-10 days and get your boards back.
11. Congratulations! You've just made a PCB with Badgerloop! 
