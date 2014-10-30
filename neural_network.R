# In this program, the computer will learn the model mapping the servers' status data to the temperature data.
# The machine learning approach is neural networks with multilayers.
# The package used in this program is Stuttgart Neural Network Simulator (SNNS) for R (RSNNS).

# install.packages("RSNNS")
library(RSNNS)

# Read the status data file into R.
rawdata <- read.table("C:\\Users\\S.Wang\\Documents\\GitHub\\Temperature_Monitoring\\status.txt", header = T)
# Get the useful columns.
data <- rawdata[,4:9]
# Randomrize the order of the data.
data = data[sample(1:nrow(data),length(1:nrow(data))),1:ncol(data)]

