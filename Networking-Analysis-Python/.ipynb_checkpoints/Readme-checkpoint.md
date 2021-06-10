# Social Network Analysis with Python 
In this workshop, we will cover key concepts in social network analysis, and will introduce basic steps for constructing, visualising, and analysing social networks

## Topics

0. Introduction

    0.1 Defining networks
    
    0.2 Social network examples
    
1. Understanding networks: Key network concepts 

2. Nework 101: Data management
    
    2.1 Tookit for SNA in Python
    
    2.2 Basic network generation in NetworkX
    
    2.3 Importing real-world SNA datase
    
    2.4 Importing large-scale social network data

3. Visualising networks
    
    3.1 Option 1: the NetworkX method
    
    3.2 Option 2: ploting interactive networks using pyvis

4. Measuring networks: Centrality

    4.1 Degree centrality
    
    4.2 Betweenness centrality 
    
    4.3 Eigenvector centrality


5. Identifying subgroups: Community detection 

    5.1 Connected components
    
    5.2 Modularity
    
    5.3 Cliques
   
6. Conclusion

## Installation
In this workshop, we are going to use the following packages, please run the following codes (run each line per time) in your terminal if you have not installed the module before:

```
pip install pandas
pip install networkx
pip install matplotlib
pip install pyvis
```

## Course Materials

Please use ```slides.ipynb``` to see the lecture content, as well as outputs from sample codes

Please use ```codes.ipynb``` to run codes in your local environment

Use ```slides.html``` to see the slides for the lecture 

 For your convenience, you can also download from the following link: https://github.com/DCS-training/CDCS-Summer-School/tree/main/Zipped-Files. The contents are identical.


## Useful resources
- Books:

    - Leguina, Adrian. (2016). Analysing social networks. International Journal Of Research & Method In Education: IJRME, 39(4), Pp446-447. 
    
    - M., K., Mohan, A., & Srinivasa, K. (2018). Practical social network analysis with Python (Computer communications and networks). Cham, Switzerland.
    
    - Al-Taie, M., & Kadry, S. (2017). Python for graph and network analysis (Advanced information and knowledge processing). Cham, Switzerland.
    
    
- Online resources:
    
    - Exploring and Analyzing Network Data with Python: https://programminghistorian.org/en/lessons/exploring-and-analyzing-network-data-with-python
    
    - Introduction to Social Network Analysis using Gephi: https://towardsdatascience.com/how-to-get-started-with-social-network-analysis-6d527685d374 


## If you can't install any of the above-mentioned packages in your local environment, you can use ```google colab```

- Step 1: open Google Colab: https://colab.research.google.com/notebooks/

- Step 2: searching "DCS-training/CDCS-Summer-School" under the "GitHub" tab

- Step 3: select "Networking-Analysis-Python/codes.ipynb" to open in Google Colab

- Step 4: importing the data and image folder 
    - a. click the "files" icon on the left column of your screen 
    - b. create an empty folder called "data" 
    - c. import the csv data file from the data folder downloaded from the current GitHub repo
    - d. make sure the data file is under the "data" folder on Google Colab
    - e. create a folder called "result" for saving all the visualisation outputs

- Now, you are ready to run all the code cells on Google Colab!
    

## Autorship

This Block has been created and developped by Pu Yan, for Data and Text Analysis Summer School 

Pu Yan, Oxford Internet Institute, University of Oxford 

Email: <pu.yan@oii.ox.ac.uk> or <thuyanpu@gmail.com>

