# Wordclouds from *The Happy Prince and Other Tales*

Date: 2025-09-24
R version: >= 4.5.0

## Description
This project generates **interactive word clouds** for “The Happy Prince” by Oscar Wilde, downloaded from Project Gutenberg (public domain).
The script preprocesses the text, removes stopwords and filler words, counts word frequencies, and produces an **HTML wordcloud** with optional custom color palettes and shapes.

## Requirements
- **R**: version >= 4.3.1
- **R packages** (installed automatically if missing):
   - `wordcloud2` (v0.3)
   - `dplyr` (v1.1.2)
   - `stringr` (v1.5.0)
   - `tm` (v0.9-3)
   - `htmlwidgets` (v1.7)
   - `RColorBrewer` (v1.1-3)
> Tip: Run sessionInfo() inside the script to check exact R and package versions.

## How to Run
1. Download the R script `happy_prince_wordcloud.R`.
2. Open the R script in RStudio or R console.
3. Set your working directory at the top of the script: `setwd("your/folder/path")`
4. Run the script step by step or as a whole.  
   The script will:
- Download the text from Project Gutenberg
- Preprocess and clean the text
- Generate word frequency tables (`.csv`)
- Create interactive word clouds (`index.html`)
5. Open `index.html` in any web browser to explore the interactive wordcloud.

## Visual Guide
### 1. Full Wordcloud (All Words)    
Includes **all words after default stopword removal**.
- Size: 0.4 (adjustable)
- Gradient: **autumn palette**
> Frequent words are darker; less frequent words are lighter.

### 2. Filtered Wordcloud (Words > 5 Occurrences)  
Includes **only words appearing more than 5 times**, after removing common filler words.
- Size: 0.8 (for HTML display)
- Gradient: **autumn_balanced palette**
> Highlights the most meaningful words and provides a cleaner cloud.

### 3. Color Palettes  
- **Autumn palette**: for full-word wordclouds
   - Gradient from Deep Chestnut Brown → Pale Cream
- **Autumn Balanced palette**: for filtered-word wordclouds
   - Gradient from Deep Mahogany → Pale Wheat  
Colors can be modified in the script via `autumn` and `autumn_balanced`.

### 4. Optional Customizations  
- **Top N words**: Limit displayed words (uncomment `top_n` section)
- **Custom PNG shape**: Place PNG in working directory and uncomment `figPath`
- **Custom stopwords**: Add additional filler words to `custom_stop`
- **Wordcloud size**: Adjust `size` parameter for clarity on different mediums

### 5. Example Usage  
`# Generate filtered wordcloud
wc_filtered <- wordcloud2(freq_tbl_above_five, 
                          size = 0.8,
                          color = colorRampPalette(autumn_balanced)(nrow(freq_tbl_above_five)),
                          fontFamily = "Georgia",
                          backgroundColor = "white",
                          shape = "circle")`  
After running, open `index.html` to interact with the wordcloud.

## License  
Text: Project Gutenberg, public domain  
Code: CC0 1.0 License

