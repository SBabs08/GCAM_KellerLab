# Global Change Analysis Model (GCAM) : Keller Lab Workflow  - In Progress
This repo provides the workflow to reporduce GCAM V6.0 output data and create figures and tables presented in  (link here). It includes documentation for
installating, running and debugging GCAM V6.0 on a Linux work environment, as well as post processing the GCAM output using rgcam.
For more information of this repo and its usage please conetat Sitara Baboolal (sitara.d.baboolal@dartmouth.edu)

##GCAM Model Overview
GCAM (developed by The Joint Global Change Research Institute (JGCRI)) is an open source model that represents the behavior of and complex interactions between five major systems – energy, water, land, climate, and the economy – at global and regional scales. The model simulates changes in these systems for decades into the future. It is a dynamic-recursive model with technology-rich representation of tthese 5 systems linked to a climate model that can be used to explor climate change mittigation policies including carbon taxes, carbon trading, regulations and accelerated deployment of energy technology. 

The GCAM model operates from 1990 to 2100 at 5 year intervals. It can be used to examine projections of future energy supply and demands and resuluting
greenhouse gas emissions, rediative forcing and climate effects of 16 greenhouse gases contingent on assumptions about future population, economy,
technology, and climate mitigation policy. The GCAM model scenarios and assumptions demonstrate a wide range of potential future energy, water, and land uses.

For more information about the GCAM model please visit https://github.com/JGCRI/gcam-core

### Additional Documentation

* [GCAM Documentation](http://jgcri.github.io/gcam-doc/)
* [Getting Started with GCAM](http://jgcri.github.io/gcam-doc/user-guide.html)
* [GCAM Community](http://www.globalchange.umd.edu/models/gcam/gcam-community/)
* [GCAM Videos and Tutorial Slides](https://gcims.pnnl.gov/community)

### Selected Publications

Calvin, K., Patel, P., Clarke, L., Asrar, G., Bond-Lamberty, B., Cui, R. Y., Di Vittorio, A., Dorheim, K., Edmonds, J., Hartin, C., Hejazi, M., Horowitz, R., Iyer, G., Kyle, P., Kim, S., Link, R., McJeon, H., Smith, S. J., Snyder, A., Waldhoff, S., and Wise, M.: GCAM v5.1: representing the linkages between energy, water, land, climate, and economic systems, Geosci. Model Dev., 12, 677–698, https://doi.org/10.5194/gmd-12-677-2019, 2019.

## USAGE
For the purpose of reproducibility, this repository contains references to the data, software and code used to process the GCAM output data and create figures and tables.

## Using the template
1.Example maps and tables processed from GCAM reference case (CO2 Emission by Region for 2025, 2050, 2075 and 2100) are located in the figures folder.  

2.GCAM query files used for ths example are located in the Output_data folder

3.Scripts, workflow for recreating results are located in the Workflow folder

4.Detailed installation and requierments documentation for the GCAM model is located in the Model_Info folder - in progress.



