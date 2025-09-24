# -------------------------------
# Happy Prince Wordcloud Generator 
# -------------------------------

# Date: 2025-09-24
# R version: 4.5.0
# Description: Generates interactive word clouds for "The Happy Prince" text 
#              from Project Gutenberg. Includes preprocessing, stopword removal,
#              frequency filtering, and optional custom color palettes.
# Note: Requires internet connection to download the text.

# -------------------------------
# 1. Set Working Directory
# -------------------------------
getwd() # check current working directory
# Replace with your folder path (absolute or relative)
setwd("folderpath") 
getwd()

# -------------------------------
# 2. Install and Load Required Packages
# -------------------------------
packages <- c("wordcloud2", "dplyr", "stringr", "tm", "htmlwidgets", "RColorBrewer")
installed <- rownames(installed.packages())
for(p in packages) if(!(p %in% installed)) install.packages(p)

library(wordcloud2)
library(dplyr)
library(stringr)
library(tm)
library(htmlwidgets)
library(RColorBrewer)

# Optional: check package versions
sessionInfo()  # prints R version + loaded package versions

# -------------------------------
# 3. Download Text
# -------------------------------
# Text downloaded from Project Gutenberg (public domain)
# https://www.gutenberg.org/files/902/902-0.txt
url <- "https://www.gutenberg.org/files/902/902-0.txt" 
text <- readLines(url, warn = FALSE, encoding = "UTF-8")

# -------------------------------
# 4. Remove Gutenberg header/footer
# -------------------------------
start_line <- grep("\\*\\*\\* START OF THE PROJECT GUTENBERG EBOOK", text)
end_line   <- grep("\\*\\*\\* END OF THE PROJECT GUTENBERG EBOOK", text)
story_lines <- text[(start_line + 1):(end_line - 1)]

# -------------------------------
# 5. Remove front matter / title pages / uppercase headings
# -------------------------------
story_lines <- story_lines[!grepl("^[A-Z\\s\\*\\[\\]]+$", story_lines)]
story_lines <- story_lines[story_lines != ""]  # remove empty lines

# -------------------------------
# 6. Combine lines into single text
# -------------------------------
text_clean <- paste(story_lines, collapse = " ")

# -------------------------------
# 7. Preprocess text
# -------------------------------
words <- text_clean %>%
  tolower() %>%
  str_replace_all("[^a-z\\s]", " ") %>%   # Remove punctuation, numbers, smart quotes
  str_split("\\s+") %>%
  unlist() %>%
  str_trim()

# -------------------------------
# 8. Remove empty strings and stopwords
# -------------------------------
# Default English stopwords from 'tm' package
# Reference: https://cran.r-project.org/web/packages/tm/refman/tm.html#stopwords
words <- words[words != ""]
words <- words[!words %in% stopwords("en")]
# optional: view default stopwords
stopwords("en")

# -------------------------------
# 9. Count word frequencies
# -------------------------------
freq_tbl <- as.data.frame(table(words), stringsAsFactors = FALSE)
colnames(freq_tbl) <- c("word", "freq")

# Remove single-letter artifacts
freq_tbl <- freq_tbl[nchar(freq_tbl$word) > 1, ]

# Arrange words by frequency (descending)
freq_tbl <- freq_tbl %>% arrange(desc(freq))
dim(freq_tbl) # rows x columns

# Optional: save full frequency table and inspect
write.csv(freq_tbl, "happy_prince_word_frequencies_all.csv", 
          row.names = FALSE, fileEncoding = "UTF-8")

# -------------------------------
# 10. Remove common filler words
# -------------------------------
custom_stop <- c(
  "said", "little", "will", "one", "now", "oh", "yes", "upon", "cried",
  "like", "quite", "came", "answered", "good", "away", "never", "always", 
  "going", "really", "must", "see", "shall", "well", "went", "go", "long",
  "know", "looked", "much", "think", "indeed", "made", "come", "don", 
  "time", "head", "can", "thing", "things", "began", "fact", "say", 
  "every", "just", "look", "put", "better", "everybody", "get", "heard", 
  "may", "next", "talk", "true", "asked", "let", "still", "sure", "take", 
  "tell", "want", "best"
)

freq_tbl <- freq_tbl[!freq_tbl$word %in% custom_stop, ]
dim(freq_tbl)


# -------------------------------
# 11. Filter by frequency
# -------------------------------
# Keep only words that appear more than 5 times
freq_tbl_above_five <- freq_tbl[freq_tbl$freq > 5, ]
dim(freq_tbl_above_five)
head(freq_tbl_above_five)
tail(freq_tbl_above_five)

# Keep only top N words for cleaner cloud
# top_n <- 200
# freq_tbl_top_n <- freq_tbl[1:min(top_n, nrow(freq_tbl)), ]

# Optional: save filtered frequency table
write.csv(freq_tbl_above_five, "happy_prince_word_frequencies_filtered.csv", row.names = FALSE, fileEncoding = "UTF-8")

# -------------------------------
# 12. Custom color palettes
# -------------------------------
autumn <- c(
  "#7F5539",  # Deep Chestnut Brown (anchor)
  "#9C6644",  # Warm Cinnamon
  "#B08968",  # Muted Caramel
  "#E6CCB2",  # Pale Sand
  "#F5E6CA"   # Soft Cream (light)
)

autumn_balanced <- c(
  "#6B2E1F",  # Deep Mahogany (anchor dark)
  "#A23E2C",  # Brick Red
  "#C97B4C",  # Burnt Sienna
  "#E68A00",  # Autumn Orange
  "#FFB347",  # Harvest Gold
  "#F6D186",  # Soft Amber
  "#FFF2CC"   # Pale Wheat (light highlight)
)

# Generate gradients: light for high-frequency, dark for rare words 
colors1 <- colorRampPalette(autumn)(nrow(freq_tbl)) # all words
colors2 <- colorRampPalette(autumn_balanced)(nrow(freq_tbl_above_five)) # filtered

# -------------------------------
# 13. Generate interactive wordclouds
# -------------------------------
# Optional: use a custom shape
#figPath <- "bird.png"   # place PNG in working directory

# Wordcloud for all words
wc_all <- wordcloud2(freq_tbl, 
                          size = 0.4, # may need adjustment depending on number of words
                          color = colors1,
                          fontFamily = "Georgia",
                          backgroundColor = "white",
                          shape = "circle"
                          #, figPath = figPath   #uncomment if using custom shape
)
wc_all

# Wordcloud for filtered words
wc_filtered <- wordcloud2(freq_tbl_above_five, 
                 size = 0.8, # increased size for HTML display clarity
                 color = colors2,
                 fontFamily = "Georgia",
                 backgroundColor = "white",
                 shape = "circle"
                 #, figPath = figPath   #uncomment if using custom shape
)
wc_filtered

# -------------------------------
# 14. Save filtered wordcloud as HTML
# -------------------------------
html_file <- "index.html"
saveWidget(wc_filtered, html_file, selfcontained = TRUE) # Generates standalone HTML file with interactive cloud

# -------------------------------
# 15. Optional: Save session info as text file
# -------------------------------
# Save a trimmed session info (without locale/system details)
sink("sessionInfo.txt")

# Add timestamp
cat("Session Info generated on:", as.character(Sys.Date()), "\n\n")

# Capture session info
si <- sessionInfo()

# Print only the useful parts
cat("R version:", si$R.version$version.string, "\n")
cat("Platform:", si$platform, "\n\n")

cat("Attached base packages:\n")
print(si$basePkgs)

cat("\nOther attached packages:\n")
print(sapply(si$otherPkgs, function(x) paste0(x$Package, "_", x$Version)))

cat("\nLoaded via a namespace (and not attached):\n")
print(sapply(si$loadedOnly, function(x) paste0(x$Package, "_", x$Version)))

sink()


