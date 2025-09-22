# -------------------------------
# Happy Prince Wordcloud Generator 
# -------------------------------

getwd()
#setwd("pathname for the working directory") #set the desired working directory

# Install required packages if not installed
packages <- c("wordcloud2", "dplyr", "stringr","tm", "htmlwidgets", "RColorBrewer")
installed <- rownames(installed.packages())
for(p in packages) if(!(p %in% installed)) install.packages(p)

library(wordcloud2)
library(dplyr)
library(stringr)
library(tm)
library(htmlwidgets)
library(RColorBrewer)

# Download the text
url <- "https://www.gutenberg.org/files/902/902-0.txt"
text <- readLines(url, warn = FALSE, encoding = "UTF-8")

# Remove Gutenberg header/footer
start_line <- grep("\\*\\*\\* START OF THE PROJECT GUTENBERG EBOOK", text)
end_line   <- grep("\\*\\*\\* END OF THE PROJECT GUTENBERG EBOOK", text)
story_lines <- text[(start_line + 1):(end_line - 1)]

# Remove front matter / title pages / pictures / uppercase headings
story_lines <- story_lines[!grepl("^[A-Z\\s\\*\\[\\]]+$", story_lines)]
story_lines <- story_lines[story_lines != ""]  # remove empty lines

# Combine lines into a single text
text_clean <- paste(story_lines, collapse = " ")

# Preprocess text
words <- text_clean %>%
  tolower() %>%
  str_replace_all("[^a-z\\s]", " ") %>%   # Remove punctuation, numbers, smart quotes
  str_split("\\s+") %>%
  unlist() %>%
  str_trim()

# Remove empty strings and stopwords
words <- words[words != ""]
words <- words[!words %in% stopwords("en")]

# Count frequencies
freq_tbl <- as.data.frame(table(words), stringsAsFactors = FALSE)
colnames(freq_tbl) <- c("word", "freq")

# Remove common filler words
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

# Remove single-letter artifacts
freq_tbl <- freq_tbl[nchar(freq_tbl$word) > 1, ]

# Arrange words by frequency (descending)
freq_tbl <- freq_tbl %>% arrange(desc(freq))
dim(freq_tbl)

# Filter by frequency
freq_tbl <- freq_tbl[freq_tbl$freq > 5, ]
dim(freq_tbl)
head(freq_tbl)
tail(freq_tbl)

# Keep only top N words for cleaner cloud
# top_n <- 200
# freq_tbl <- freq_tbl[1:min(top_n, nrow(freq_tbl)), ]

# Save frequency table
write.csv(freq_tbl, "happy_prince_word_frequencies.csv", row.names = FALSE, fileEncoding = "UTF-8")


# Use your custom palette
autumn_balanced <- c(
  "#6B2E1F",  # Deep Mahogany (anchor dark)
  "#A23E2C",  # Brick Red
  "#C97B4C",  # Burnt Sienna
  "#E68A00",  # Autumn Orange
  "#FFB347",  # Harvest Gold
  "#F6D186",  # Soft Amber
  "#FFF2CC"   # Pale Wheat (light highlight)
)

# Create gradient from light -> dark using happy_prince palette
# Gradient: light for rare words, dark for high-frequency
colors <- colorRampPalette(autumn_balanced)(nrow(freq_tbl))

# Optional: use a custom shape
#figPath <- "bird.png"   # place PNG in working directory

# Generate interactive wordcloud
wc <- wordcloud2(freq_tbl, 
                 size = 0.8,
                 color = colors,
                 fontFamily = "Georgia",
                 backgroundColor = "white",
                 shape = "circle"
                 #, figPath = figPath   #uncomment if using custom shape
)

# Save as HTML 
html_file <- "index.html"
saveWidget(wc, html_file, selfcontained = TRUE)

