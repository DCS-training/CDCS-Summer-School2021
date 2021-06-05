# Text Analysis with Python 

In this workshop, we will cover text cleaning, visualisation, and preliminary analysis using Python. 

## Topics

0. Introduction
    
1. Text cleaning and pre-processing

    1.1 Importing text data & summary of text 
    
    1.2 Removal of punctuations
    
    1.3 Tokenisation
    
    1.4 Case normalisation
    
    1.5 Stopwords removal
    
    1.6 Stemming and Lemmatisation
    
    1.7 Advanced: Part-of-Speech tagging; named entities in spaCy

2. Text analysis and visualisation

    2.1 Word counts (pre- and post-processing)
    
    2.2 Word frequency
    
    2.3 TF-IDF: table and visualisation
    
3. Beyond quantification? Toolkit for qualitative research:


## Installation

In this workshop, we are going to use the following packages, please run the following codes in your terminals before the course. 

You will need to install ```pip``` in your local envrionment before the installation. 

Here's a documentation on installing pip: <https://pip.pypa.io/en/stable/installing/>

```
pip install pandas
pip install numpy
pip install --user -U nltk
pip install -U pip setuptools wheel
pip install -U spacy
pip install --upgrade gensim
python -m spacy download en_core_web_sm
pip install pillow
pip install wordcloud
```

## Course Materials

```slides.ipynb``` has both the codes and outputs from running the code cells mentioned in the lecture

```slides.html``` is a jupyter-generated slides for you (for future references)

```codes.ipynb``` has all the codes mentioned in the lecture but contains no outputs, please use this jupyter notebook file to run codes during the course.

Please find the dataset saved in the **data** folder, and related readings in the **reading** folder

## Useful resources

- Books:
    
    - Bengfort, B., Bilbro, R., & Ojeda, T. (2018). Applied text analysis with Python : Enabling language-aware data products with machine learning. Beijing: O'Reilly
    
    - Vanderplas, J. (2017). Python data science handbook : Essential tools for working with data. Beijing: O'Reilly
    
- Online resources:
    
    - A list of NLP courses around the world, curated by ACL (the Association for Computational Linguistics): https://aclweb.org/aclwiki/List_of_NLP/CL_courses 
    
    - An introduction to Natural Language Processing (NLP): https://port.sas.ac.uk/mod/book/view.php?id=583&chapterid=445 
    
    - Introduction to NLP & Data Science: https://www.youtube.com/watch?v=5BVebXXb2o4

## Autorship

This Block has been created and developped by Pu Yan, for Data and Text Analysis Summer School 

Pu Yan, Oxford Internet Institute, University of Oxford 

Email: <pu.yan@oii.ox.ac.uk> or <thuyanpu@gmail.com>


## If you can't install any of the above-mentioned packages in your local environment, you can use ```google colab```

- Step 1: open Google Colab: https://colab.research.google.com/notebooks/

- Step 2: searching "DCS-training/CDCS-Summer-School" under the "GitHub" tab

- Step 3: select "Text-Analysis-Python/codes.ipynb" to open in Google Colab

- Step 4: importing the data and image folder 
    - click the "files" icon on the left column of your screen 
    - create an empty folder called "data" 
    - import the csv data file from the data folder downloaded from the current GitHub repo
    - Make sure the data fiel is under the "data" folder on Google Colab
