# Text Analysis with Python 

In this workshop, we will cover text data wrangling, text cleaning, visualisation, and preliminary analysis using Python. 

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

## Run the following code if you see warning message when importing gensim
pip install python-Levenshtein

## Run the foolowing code if you can't pip install wordcloud, you will need to have conda installed in the environment
conda install -c conda-forge wordcloud
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

## If you can't install any of the above-mentioned packages in your local environment, you can use ```google colab```

- Step 1: open Google Colab: https://colab.research.google.com/notebooks/

- Step 2: searching "DCS-training/CDCS-Summer-School" under the "GitHub" tab

- Step 3: select "Text-Analysis-Python/codes.ipynb" to open in Google Colab

- Step 4: importing the data and image folder 
    - a. click the "files" icon on the left column of your screen 
    - b. create an empty folder called "data" 
    - c. import the csv data file from the data folder downloaded from the current GitHub repo
    - d. make sure the data file is under the "data" folder on Google Colab
    - e. repeat the b-c-d steps to create a folder called "image" and upload 'snp.png' file from the image folder downloaded from the current repo. Make sure the image is saved under the 'image' folder

- Now, you are ready to run all the code cells on Google Colab!

## After course notes:

- We now added a function in lemmatisation to remove derivative words of nouns, for example, returning "minutes" to "minutes"

```
# Python NLTK provides WordNet Lemmatizer that uses the WordNet Database to lookup lemmas of words.
import nltk
from nltk.stem import WordNetLemmatizer
wordnet_lemmatizer = WordNetLemmatizer()

# We define a function to lookup lemmas of each word in the post, applying on verbs
def lemmatise_v(texts):
    return [[wordnet_lemmatizer.lemmatize(word, pos="v") for word in doc] for doc in texts]

# We define a function to lookup lemmas of each word in the post, applying on nouns
def lemmatise_n(texts):
    return [[wordnet_lemmatizer.lemmatize(word, pos="n") for word in doc] for doc in texts]

data_lemmatise_v = lemmatise_v(data_words_nostopwords)
data_lemmatise = lemmatise_n(data_lemmatise_v)
```

- We also added a cell under text analysis to let you export a csv file of results from different top-word measurements under the result folder

```
df_top_20_raw = pd.DataFrame(top_20_raw, columns=['word', 'top_20_raw'])
df_top_20 = pd.DataFrame(top_20, columns=['word', 'top_20'])
df_top_20 = df_top_20_raw.merge(df_top_20,on='word', how = 'outer').merge(tf_idf_20,on='word', how = 'outer')
df_top_20.to_csv("result/top_20_different_measurements.csv")
df_top_20
```

- For each of the visualisation, you can now save the plot in the result folder

```
import matplotlib.pyplot as plt
# import wordcloud 
from wordcloud import WordCloud, ImageColorGenerator
## Creating a wordcloud using top ranked 100 words (measured by TD-IDF) for the SNP corpora
fig, ax = plt.subplots(figsize=(10,10))
wc = WordCloud(background_color = 'white',
              width=800,height=600,
              max_words=2000).fit_words(words_tfidf[:100])
plt.imshow(wc)
plt.axis("off")
plt.savefig('result/snp_tf-idf.pdf')
plt.show()
```

## Autorship

This Block has been created and developped by Pu Yan, for Data and Text Analysis Summer School 

Pu Yan, Oxford Internet Institute, University of Oxford 

Email: <pu.yan@oii.ox.ac.uk> or <thuyanpu@gmail.com>

