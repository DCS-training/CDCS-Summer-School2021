# Creating an Environment (geo_env) With Geopandas, Matplotlib and Jupyter Notebook 

conda create -n geo_env
conda activate geo_env
conda config --env --add channels conda-forge
conda config --env --set channel_priority strict

conda install python=3 geopandas
conda install python=3 matplotlib.pyplot
conda install python=3 shapely.geometry

python -m ipykernel install --name geo_env