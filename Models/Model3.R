# Simple model using the top 6 predictors according to the correlation matrix
# Analysis done on original data

# deed-recode
train$deed_simple <- as.character(train$deed)
train$deed_simple[-which(train$deed_type %in% c('WD','SJ','SW','RD'))] <- 'Other'
train$deed_simple <- as.factor(train$deed_simple)

model3 <- lm(totalActualVal ~ TotalFinishedSF + mainfloorSF + nbrFullBaths + nbrBedRoom + carStorageSF + PCT_WHITE + designCodeDscr + range + nbrThreeQtrBaths + nbrHalfBaths + carStorageTypeDscr + deed_simple + township + TotalFinishedSF:township + carStorageSF:township + pct_own, data=train)

summary(model3)

# deed-recode test
test$deed_simple <- as.character(test$deed)
test$deed_simple[-which(test$deed_type %in% c('WD','SJ','SW','RD'))] <- 'Other'
test$deed_simple <- as.factor(test$deed_simple)

mod3 <- predict(model3, test)
mod3 <- as.data.frame(cbind(1:10000,mod3))
names(mod3) <- c('id','totalActualVal')
head(mod3)
write.csv(mod3,file='mod3.csv',row.names=F)
