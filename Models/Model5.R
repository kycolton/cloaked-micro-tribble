# Simple model using the top 6 predictors according to the correlation matrix
# Analysis done on original data

train <- read.csv('git/Data/train.csv')
test <- read.csv('git/Data/test.csv')

# deed-recode
train$deed_simple <- as.character(train$deed_type)
train$deed_simple[-which(train$deed_type %in% c('WD','SJ','SW'))] <- 'Other'
train$deed_simple <- as.factor(train$deed_simple)

# Design Code recode
train$dCD_simple <- as.character(train$designCodeDscr)
train$dCD_simple[-which(train$designCodeDscr %in% names(tail(sort(table(train$designCodeDscr)),5)))] <- 'Other'
train$dCD_simple <- as.factor(train$dCD_simple)

# Car Storage recode
train$cST_simple <- as.character(train$carStorageTypeDscr)
train$cST_simple[which(train$carStorageTypeDscr %in% names(head(sort(table(train$carStorageTypeDscr)),3)))] <- 'Other'
train$cST_simple <- as.factor(train$cST_simple)

model5 <- lm(totalActualVal ~ TotalFinishedSF + mainfloorSF + nbrFullBaths + nbrBedRoom + carStorageSF + PCT_WHITE + dCD_simple + range + nbrThreeQtrBaths + nbrHalfBaths + cST_simple + deed_simple + township + TotalFinishedSF:township + carStorageSF:township + pct_own + bsmtSF +  dCD_simple:nbrBedRoom, data=train)
# ConstCodeDscr + qualityCodeDscr +

# Remove leverage points
lev <- which(hatvalues(model5) > 2*mean(hatvalues(model5)))

model5 <- lm(totalActualVal ~ TotalFinishedSF + mainfloorSF + nbrFullBaths + nbrBedRoom + carStorageSF + PCT_WHITE + dCD_simple + range + nbrThreeQtrBaths + nbrHalfBaths + carStorageTypeDscr + deed_simple + township + TotalFinishedSF:township + carStorageSF:township + pct_own + bsmtSF + dCD_simple:nbrBedRoom, data=train[-lev,])

#summary(model5)

# deed-recode test
test$deed_simple <- as.character(test$deed)
test$deed_simple[-which(test$deed_type %in% c('WD','SJ','SW'))] <- 'Other'
test$deed_simple <- as.factor(test$deed_simple)

# Design Code recode
test$dCD_simple <- as.character(test$designCodeDscr)
test$dCD_simple[-which(test$designCodeDscr %in% names(tail(sort(table(test$designCodeDscr)),5)))] <- 'Other'
test$dCD_simple <- as.factor(test$dCD_simple)


# Car Storage recode
test$cST_simple <- as.character(test$carStorageTypeDscr)
test$cST_simple[which(test$carStorageTypeDscr %in% names(head(sort(table(test$carStorageTypeDscr)),3)))] <- 'Other'
test$cST_simple <- as.factor(test$cST_simple)

mod5 <- predict(model5, test)
mod5 <- as.data.frame(cbind(1:10000,mod5))
names(mod5) <- c('id','totalActualVal')
head(mod5)
write.csv(mod5,file='mod5.csv',row.names=F)

