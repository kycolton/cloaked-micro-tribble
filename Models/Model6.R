# Library Required
library(randomForest)

# Read the training data
train <- read.csv('Data/train.csv',header=T)
test <- read.csv('Data/test.csv',header=T)

# variables to be used (taken from mod4)
vars <- c(4,31,27,29,25,23,48,16,9,28,30,24,99,8,89,21,18,17)

# Recode Deed_type in training data
train$deed_simple <- as.character(train$deed_type)
train$deed_simple[-which(train$deed_type %in% c('WD','SJ','SW','RD'))] <- 'Other'
train$deed_simple <- as.factor(train$deed_simple)

# Recode Deed_type in test data
test$deed_simple <- as.character(test$deed_type)
test$deed_simple[-which(test$deed_type %in% c('WD','SJ','SW','RD'))] <- 'Other'
test$deed_simple <- as.factor(test$deed_simple)

# Set seed
set.seed(53924)

# Model
deforestation <- randomForest(totalActualVal~.,data=train[,vars],importance=T,ntree=200,nodesize=5)

# Need to reset levels that aren't represented in test, otherwise the model gets angry
levels(test$ConstCodeDscr) <- levels(train$ConstCodeDscr)
levels(test$qualityCodeDscr) <- levels(train$qualityCodeDscr)

# Predict
mod6 <- predict(deforestation,test)
mod6 <- as.data.frame(cbind(1:10000,mod6))
names(mod6) <- c('id','totalActualVal')
write.csv(mod6,file='mod6.csv',row.names=F)
