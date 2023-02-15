# Global Change Analysis Model (GCAM): Keller Lab Workflow  - In Progress
This repo provides the workflow to reproduce GCAM V6.0 output data and create figures and tables presented in (link here). It includes documentation for
installing, executing and debugging the GCAM V6.0 model on a Linux work environment, as well as post processing the GCAM output using the rgcam toolbox.
For more information of this repo and its usage please contact Sitara Baboolal (sitara.d.baboolal@dartmouth.edu)

## GCAM Model Overview
GCAM (developed by the Joint Global Change Research Institute (JGCRI)) is an open source model that represents the behavior of and complex interactions between five major systems – energy, water, land, climate, and the economy – at global and regional scales. The model simulates changes in these systems for decades into the future. It is a dynamic-recursive model with technology-rich representation of these 5 systems linked to a climate model that can be used to explore climate change mitigation policies including carbon taxes, carbon trading, regulations and accelerated deployment of energy technology. 

The GCAM model operates from 1990 to 2100 at 5 year intervals. It can be used to examine projections of future energy supply and demands and resulting
greenhouse gas emissions, radiative forcing and climate effects of 16 greenhouse gases contingent on assumptions about future population, economy,
technology, and climate mitigation policy. GCAM models scenarios and assumptions to demonstrate a wide range of potential future climates, energy, water, and land uses and economies.

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

### Model_info
1. Documentation for installing GCAM V6.0 on a Linux environment

2. Installation zip, and additional supporting Install files needed to compile GCAM

3. Tutorials for running and debugging GCAM reference case

### WorkFlow
1. Example maps and tables processed from GCAM reference case (CO2 Emission by Region for 2025, 2050, 2075 and 2100).  

2. GCAM query files used for this example 

3. Scripts for extracting parameters form raw GCAM data, 

4. Workflow for recreating results
![image](https://user-images.githubusercontent.com/107976299/219106919-b5226e0a-61c2-4808-8404-48e97da5b259.png)





