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
k = 3
m = 5 # Number of desired LOs.

# Read the status data file into R.
rawdata <- read.table("C:\\Users\\S.Wang\\Documents\\GitHub\\Temperature_Monitoring\\status.txt", header = T)
# Get the useful columns.
data <- rawdata[,4:11]
# Be sure to normalize data
for(i in 1:8) data[,i] = (data[,i]-mean(data[,i]))/(max(data[,i])-min(data[,i]))
# Calculate the LOFs for each record.
lof <- lofactor(data,k)
result.data <- cbind(rawdata, lof)

# Get the most suspectable five records.
lof.sort <- sort(lof, decreasing = T, index.return = T)
print(result.data[lof.sort[[2]][1:m],])