# Simple model using the top 6 predictors according to the correlation matrix
# Analysis done on original data

# deed-recode
train$deed_simple <- as.character(train$deed)
train$deed_simple[-which(train$deed_type %in% c('WD','SJ','SW','RD'))] <- 'Other'
train$deed_simple <- as.factor(train$deed_simple)

vars <- c(4,8:9,13,16:18,21,23:25,27:31,48,71,89,99)

tic <- proc.time()
model4 <- lm(totalActualVal ~ . + .:., data=train[,vars])
toc <- proc.time()
toc - tic
gc()

summary(model4)

# deed-recode test
test$deed_simple <- as.character(test$deed)
test$deed_simple[-which(test$deed_type %in% c('WD','SJ','SW','RD'))] <- 'Other'
test$deed_simple <- as.factor(test$deed_simple)

mod4 <- predict(model4, test)
mod4 <- as.data.frame(cbind(1:10000,mod4))
names(mod4) <- c('id','totalActualVal')
head(mod4)
write.csv(mod4,file='mod42.csv',row.names=F)
