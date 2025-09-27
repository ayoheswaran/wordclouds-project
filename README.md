# Wordclouds Project Hub

This repository contains **interactive wordclouds** using **R** and `wordcloud2` from various literary works in Tamil and English, including gift works for a friend, shared favorite books, and a public domain classic.

---

## 📚 Books Included

| Folder Name      | Description              | Notes |
|----------------------|-------------------------|-------|
| `golden-sunset`      | Poetry Book 1 (Tamil)  | Gift HTML only; original text (from Anthiyil Thikalvathu by V.N.Surya) not uploaded. Inspired by shades-of-blue theme. |
| `tiny-cockroach`     | Poetry Book 2 (Tamil)  | Gift HTML only; original text (from Karapanium by V.N.Surya) not uploaded. Inspired by forest-moss theme. |
| `peacock-blue`       | Fiction Book (Tamil)| Shared favorite book HTML only; original text (from Vanmurasu 4: Neelam by Jeyamohan) not uploaded. Inspired by peacock-feather theme. |
| `the-lullaby`        | A passage (Tamil)      | A favorite passage HTML only; original text (from Venmurasu 26: Muthalavin by Jeyamohan) not uploaded. Inspired by shades-of-sea theme. |
| `little-prince`  | Fiction Book (English) | Shared favorite book HTML only; original text (from The Little Prince by Antoine de Saint-Exupéry) not uploaded. Inspired by autumn-sunset theme. |
| `happy-prince`   | The Happy Prince       | Public domain book by Oscar Wilde. Full code + HTML included for educational purposes. |

---
## 🌥️ About Word Clouds

A word cloud is a simple visualization that shows the most frequent words in a text. Larger, darker words appear more often in the text, while smaller, lighter ones are less common. Word clouds don’t replace deep analysis, but they are a gentle entry point into Exploratory Data Analysis (EDA). They give you an instant “feel” for the text — its mood, repeated ideas, and rhythm — before you move on to structured methods like keyword extraction, co-occurrence networks, or topic modeling.

---
## 🌱 My Learning Note

- This project is part of my **learning-NLP journey**. While exploring the pipeline — Problem Definition → Data Collection → Preprocessing → Exploratory Data Analysis → Feature Engineering → Model Building → Evaluation → Deployment — I became fascinated by the role of **word clouds** in Exploratory Data Analysis (EDA).
- A word cloud doesn’t always need to conclude something. Sometimes it’s like standing on a beach and watching the sea — you don’t demand a message from every wave; you just let the rhythm wash over you. 🌊
- In the **Tamil word clouds**, I could do only limited preprocessing, so all the words from the text simply appear together as a cloud. For **The Little Prince**, I excluded stopwords and filtered mainly for nouns and verbs.
- Please check the `happy-prince` folder to follow my progress as I continue learning.  

*Thank you for sharing this little learning-journey with me.* 🌿


## 🔍 How to View

1. Open [index.html](index.html) in a browser **or** visit via GitHub Pages:https://ayoheswaran.github.io/wordclouds-project/
2. Click on the tabs to view the wordcloud for each book.  
3. Hover over words in the wordcloud to see frequency counts.

---

## 🛡 Licensing & Ethics

- This project is intended for **educational and personal exploration** of literature.
- The HTML wordclouds and R code are licensed under CC0-1.0.
- The original texts of poetry and fiction themselves are copyrighted and not included.

- **Gift books** (`golden-sunset`, `tiny-cockroach`) and **Shared favorite books and text** (`little-prince`, `peacock-blue`, `the-lullaby`): HTML only, **no original text uploaded**. Intended for personal viewing by the recipient.  
- **Public domain book** (`happy-prince`): © Oscar Wilde, 1888, Public Domain, from 
<a href="https://www.gutenberg.org/files/902/902-0.txt" target="_blank">Project Gutenberg</a>,
R Code, HTML, and sample images included. You are free to use/adapt for educational purposes. [Happy Prince Wordclouds](happy-prince/) 
- Original authors are acknowledged.

---

## 📂 Repository Structure
<pre>```
wordclouds-project/
│
├─ index.html                <-- main page linking all wordclouds
├─ README.md                 <-- project description + ethics
├─ robots.txt                <-- prevents search engine indexing
│
├─ golden-sunset/            <-- Poetry Book 1: "Anthiyil Thikalvathu" by V.N.Surya
│   └─ index.html            <-- HTML only
│
├─ happy-prince/             <-- Public domain book
│   ├─ images 
│   │   ├─ wordcloud_all.png
│   │   └─ wordcloud_filtered.png
│   └─ index.html            <-- interactive wordcloud
│   └─ README.md            
│   └─ sessionInfo.txt 
│   └─ happy_prince_wordcloud.r 
│    
│
├─ little-prince/            <-- Shared favorite book: "The Little Prince" by Antoine de Saint-Exupéry
│   └─ index.html            <-- HTML only
│
├─ peacock-blue/             <-- Shared favorite book: "Neelam – Vanmurasu 4" by Jeyamohan
│   └─ index.html            <-- HTML only
│
├─ the-lullaby/              <-- Passage from "Muthalavin – Venmurasu 26" by Jeyamohan
│   └─ index.html            <-- HTML only
│
└─ tiny-cockroach/           <-- Poetry Book 2: "Karapanium" by V.N.Surya
    └─ index.html            <-- HTML only
```</pre>

---

## 🙏 Acknowledgements 

- Jeyamohan, for *Venmurasu* and all his words.
- Antoine de Saint-Exupéry, for *The Little Prince*.
- Oscar Wilde, for The *Happy Prince and Other Tales*.  
- V.N.Surya, for his Poems.  
- ChatGPT, for technical guidance on R scripting, Markdown formatting, and wordcloud visualization.

✨ Created with ♡ | Personal and ethical sharing only | [View source on GitHub](https://github.com/yourusername/wordclouds-project)



  

