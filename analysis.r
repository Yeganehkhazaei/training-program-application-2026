# ---------------------------------------------------------

# Melbourne Bioinformatics Training Program

# This exercise to assess your familiarity with R and git. Please follow
# the instructions on the README page and link to your repo in your application.
# If you do not link to your repo, your application will be automatically denied.

# Leave all code you used in this R script with comments as appropriate.
# Let us know if you have any questions!


# You can use the resources available on our training website for help:
# Intro to R: https://mbite.org/intro-to-r
# Version Control with Git: https://mbite.org/intro-to-git/

# ----------------------------------------------------------

# Load libraries -------------------
# You may use base R or tidyverse for this exercise

library(tidyverse)
library(readr)

# Load data here ----------------------
# Load each file with a meaningful variable name.
data <- read_csv("data/GSE60450_GeneLevel_Normalized(CPM.and.TMM)_data.csv")
meta_data <- read_csv("data/GSE60450_filtered_metadata.csv")


# Inspect the data -------------------------

# What are the dimensions of each data set? (How many rows/columns in each?)
# Keep the code here for each file.
# What are the dimensions of each data set?


## Expression data
dim(data)
# or nrow(), ncol()
#answer: [1] 23735 rows    14 columns

## Metadata
dim(meta_data)
#answer: [1] 12 rows 4 columns

# Prepare/combine the data for plotting ------------------------
# How can you combine this data into one data.frame?

# Convert expression matrix to long format
data_long <- data %>%
  pivot_longer(
    cols = starts_with("GSM"),
    names_to = "sample",
    values_to = "expression"
  )

# Merge with metadata
combined_df <- data_long %>%
  left_join(meta_data, by = c("sample" = "...1"))

# Check results
dim(combined_df)
head(combined_df)



# Plot the data --------------------------
## Plot the expression by cell type
## Can use boxplot() or geom_boxplot() in ggplot2

library(ggplot2)

ggplot(combined_df, aes(x = immunophenotype, y = expression)) + # we can do y with log too due to skewedness.
  geom_boxplot() +
  labs(
    title = "Gene Expression by Cell Type",
    x = "Cell Type (Immunophenotype)",
    y = "Expression"
  ) +
  theme_bw()
## Save the plot
ggsave("results/expression_by_celltype.png", width = 8, height = 6)
### Show code for saving the plot with ggsave() or a similar function
