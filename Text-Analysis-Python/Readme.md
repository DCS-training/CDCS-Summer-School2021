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

## Autorship

This Block has been created and developped by Pu Yan, for Data and Text Analysis Summer School 

Pu Yan, Oxford Internet Institute, University of Oxford 

Email: <pu.yan@oii.ox.ac.uk> or <thuyanpu@gmail.com>

