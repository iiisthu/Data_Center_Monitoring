# In this program, the computer will learn the model mapping the servers' status data to the temperature data.
# The machine learning approach is neural networks with multilayers.
# The package used in this program is Stuttgart Neural Network Simulator (SNNS) for R (RSNNS).

# install.packages("RSNNS")
library(RSNNS)

# Read the status data file into R.
rawdata <- read.table("/home/swang/Documents/ServerTemperature/81.txt")
# Get the useful columns.
data <- rawdata[,4:15]
# In order to do the classification, it needs to obtain dicrete output values.
data[,12] <- round(data[,12]*2)/2
# Randomize the order of the data.
data = data[sample(1:nrow(data),length(1:nrow(data))),1:ncol(data)]
# Specify input values and outputs with class labels.
dataInputs = data[,1:11]
dataTargets = decodeClassLabels(data[,12])

# Constructing coordinating data.
coordinate.data <- data.frame(data[,12],encodeClassLabels(dataTargets))
coordinate.data <- coordinate.data[!duplicated(coordinate.data),]

# Split data into training and testing with a fixed ratio.
data = splitForTrainingAndTest(dataInputs, dataTargets, ratio=0.15)
# Normalize input data.
data = normTrainingAndTestSet(data)

# Use mpl fuction to obtain the model. learnFuncParams=c(0.0001, 2.0, 2),
model = mlp(data$inputsTrain, data$targetsTrain, size=c(3), learnFunc="Std_Backpropagation", maxit=10000, inputsTest=data$inputsTest, targetsTest=data$targetsTest) 
# Make predictions.
predictions = predict(model, data$inputsTest)
predictions.explict <- rep(0, length = nrow(predictions))
test.explict <- rep(0, length = nrow(predictions))
for(i in 1:nrow(predictions)){
  predictions.explict[i] <- coordinate.data[coordinate.data[, 2] == encodeClassLabels(predictions)[i], ][1, 1]
  # Get back the true value of the test inputs.
  test.explict[i] <- coordinate.data[coordinate.data[, 2] == encodeClassLabels(data$targetsTest)[i], ][1, 1]
} 

# Calculate the accuracy of the model.
accuracy = sum(encodeClassLabels(predictions) == encodeClassLabels(data$targetsTest))/nrow(data$targetsTest)
print(accuracy)
# print(cbind(data$inputsTest, test.explict, predictions.explict))