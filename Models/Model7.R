# Library Required
library(randomForest)

# Read the training data
train <- read.csv('Data/train.csv',header=T)
test <- read.csv('Data/test.csv',header=T)

# variables to be used (taken from mod4)
vars <- c(4,9,8,13:32,34:40,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72:85,87,89,91,92,95:97)

# Set seed
set.seed(53924)

# Model
tic <- proc.time()
deforestation <- randomForest(totalActualVal~.,data=train[,vars],importance=T,ntree=200,nodesize=5)
tock <- proc.time()
tock - tic

for(i in vars)
{
  if(is.factor(test[,i]))
  {
    print(names(test)[i])
    levels(test[,i]) <- levels(train[,i])
  }
}

# Need to reset levels that aren't represented in test, otherwise the model gets angry
#levels(test$ConstCodeDscr) <- levels(train$ConstCodeDscr)
#(test$qualityCodeDscr) <- levels(train$qualityCodeDscr)

# Predict
mod7 <- predict(deforestation,test[,vars])
mod7 <- as.data.frame(cbind(1:10000,mod7))
names(mod7) <- c('id','totalActualVal')
write.csv(mod7,file='mod7.csv',row.names=F)
