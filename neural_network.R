# In this program, the computer will learn the model mapping the servers' status data to the temperature data.
# The machine learning approach is neural networks with multilayers.
# The package used in this program is Stuttgart Neural Network Simulator (SNNS) for R (RSNNS).

# install.packages("RSNNS")
library(RSNNS)

# Read the status data file into R.
rawdata <- read.table("C:\\Users\\S.Wang\\Documents\\GitHub\\Temperature_Monitoring\\status.txt")
# Get the useful columns.
data <- rawdata[,4:11]
# In order to do the classification, it needs to obtain dicrete output values.
data[,8] <- round(data[,8])
# Randomize the order of the data.
data = data[sample(1:nrow(data),length(1:nrow(data))),1:ncol(data)]
# Specify input values and outputs with class labels.
dataInputs = data[,1:7]
dataTargets = decodeClassLabels(data[,8])
# Split data into training and testing with a fixed ratio.
data = splitForTrainingAndTest(dataInputs, dataTargets, ratio=0.15)
# Normalize input data.
data = normTrainingAndTestSet(data)

# Use mpl fuction to obtain the model.
model = mlp(data$inputsTrain, data$targetsTrain, size=5, learnFunc="Quickprop", learnFuncParams=c(0.1, 2.0, 0.0001, 0.1),maxit=100, inputsTest=data$inputsTest, targetsTest=data$targetsTest) 
# Make predictions.
predictions = predict(model, data$inputsTest)

# Calculate the accuracy of the model.
accuracy = sum(encodeClassLabels(predictions) == encodeClassLabels(data$targetsTest))/ncol(data$targetsTest)
print(accuracy)