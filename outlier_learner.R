# In this program, the computer will learn the local outliers (LOs) within the data obtained.
# The basic theory we use is the one named local outlier factor (LOF) proposed by Breunig et al.
# "LOF: Identifying Density-Based Local Outliers":  http://dl.acm.org/citation.cfm?id=335388
# For convinience, we will use the function completed in the book entitled "Data Mining with R".
# Therefore, we need to install the package named "DMwR".
# Note: In Mac or Linux, one may use the package named "Rlof", which performs better in multicores.

install.packages("DMwR") # Omit when completed.
library(DMwR)

# The function is lofactor(data, k), where k is the number of neighbours (refer to the paper).
# For a complete understanding of the function, please refer to the book or just use "??lofactor" command.


