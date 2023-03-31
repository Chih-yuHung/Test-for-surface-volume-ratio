# Introduction
This repository provides the **Ottawa** results in "Perspectives on peak liquid manure temperature with implications for methane emissions" in Journal of Environmental Quality, authored by Chih-Yu Hung, Efe Kemal Koc, Brian Grant, Ward Smith, and Andrew VanderZaag. The DOI will be provided when it is available.


# Data
Input data include **daily env input_RH.csv**, which has daily air temperature, precipitation, wind speed, solar radiation, and RH, and **Initial M temp.csv**, which has assumed initial manure temperature.
Output data are the simulation results that can be directly used to create figure 2A in the manuscript. The data include *result50%_Ottawa.rda*, *result100%_Ottawa.rda*, and *result150%_Ottawa.rda*, which are 50%, 100% and 150% wind speed respectively. The data can be read with ***load*** in R. 

## 0.REsults output.R
This script organize the data and create Figure 2.  
Lines 1-112 read the simulation data and merge into the three rda files. If you want to check the data in Figure 2, you can start with the rda files, instead of the csv files. The rest of code here created the Figure. 

## 1. Major.R
This script created multiple variables, i.e. the diameters of storage, to create multiple SV ratio. The script called **2. Marco.R** to run the simulation. You can try different reduction factor for the diameter.

## 2. Marco.R
This script is the major script for simulation. People who want to see how to run the simulation can read the script here. The script ***source*** some scripts to run other calculations, which include **constant.R** (for constant used in the simulation), **Manure volume.R** (to calculate daily manure volume), **Solar radiation and soil temper.R** (to calculate heat transfers), **hourly temp.R** (to obtain hourly temperature data)



