# Geographical Data with Python 
This block will be divided into two sections from 09:15-11:00 and 11:15-	13:15 on Wednesday the 9th of June.  

The focus will be on Geographical Data, with a basic understanding of python and jupyter notebook assumed.

This block will provide a solid base for understanding Geographical Data Analysis with Python, and will allow attendees to apply and develop the core concepts to their own work and/or research.

## Topics
* Basic understanding of Geographical Data, including vectors, rasters, .shp files and .tif files 
* Plotting simple geographical features 
* The use and differences between basic plot functions and those afforded in geopandas and matplotlib.pyplot 
* Deeper customisation of Geographical data, including labels, colour maps, re-sizing/re-positioning legends and adjusting extent/scale 
* Overlaying Geographical features for more complex analysis 
* Exporting plots 

## Installation
In this workshop, we are going to use the following packages, please run the following codes in your console if you have not installed before:
if you run into an error when trying installing **geopandas** do not worry we are going to see togeher how to do so via conda and the prompt of comand

```
%pip install git+git://github.com/geopandas/geopandas.git
%pip install matplotlib.pyplot
%pip install numpy
%pip install shapely.geometry

import geopandas as gpd
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from shapely.geometry import Point, Polygon
```

## Course Materials
In this repositary, you will find a  script (`Geographic_Data.ipynb`) and 2 folders one containing the **Data** and one for the **Output**. For your convenience, you can also download from the following link: https://github.com/DCS-training/CDCS-Summer-School/tree/main/Zipped-Files. The contents are identical.



## Autorship
This Block has been created and developped by Andrew McLean 
