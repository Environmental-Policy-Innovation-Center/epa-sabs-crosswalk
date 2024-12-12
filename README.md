![](www/epic-logo-transparent.png)

# EPIC's Service Area Boundaries & Census Data Crosswalk
This repository maintains the code and data for crosswalking census data to EPA's water utility boundaries. Crosswalking is done using a mix of population weighted interpolation and block-parcel crosswalks (see methodology for more information). Using the functions in this repository and a template spreadsheet to hold census varaibles, it's possible to crosswalk any collection of census variables to water utility service area boundaries. 

Link to [census variables](https://docs.google.com/spreadsheets/d/1UvFjxOm1Q06ZEDXr98Pt0uvLFabsGA8IT8eEJrQN9pg/edit?gid=0#gid=0) used for our crosswalk.

Link to [methodology](https://docs.google.com/document/d/1va2Iq2oJxnqiwgNHD4bWpXKxdWbq-TYoYkosj1oz_JU/edit?tab=t.0) for TX analysis. Full methodology coming soon. 


The project's pipeline includes:

-   epa-sabs-crosswalk-refactored.Rmd: contains code to crosswalk EPA's SABs to census variables. This code also pulls in summary SDWIS violations, EJScreen's drinking water metric, and HUCs. 

-   functions/: contains crosswalk functions. These functions are sourced into the R markdown file above. 

-   comparison-analysis/: contains original comparison of EPA's and EPIC's SABs from June 2024 