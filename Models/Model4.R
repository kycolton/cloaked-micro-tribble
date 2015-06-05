# Simple model using the top 6 predictors according to the correlation matrix
# Analysis done on original data

# deed-recode
train$deed_simple <- as.character(train$deed)
train$deed_simple[-which(train$deed_type %in% c('WD','SJ','SW','RD'))] <- 'Other'
train$deed_simple <- as.factor(train$deed_simple)

model4 <- lm(totalActualVal ~ TotalFinishedSF + mainfloorSF + nbrFullBaths + nbrBedRoom + carStorageSF + PCT_WHITE + designCodeDscr + range + nbrThreeQtrBaths + nbrHalfBaths + carStorageTypeDscr + deed_simple + township + TotalFinishedSF:township + carStorageSF:township + pct_own + bsmtSF + ConstCodeDscr + qualityCodeDscr + designCodeDscr:nbrBedRoom, data=train)

summary(model4)

# deed-recode test
test$deed_simple <- as.character(test$deed)
test$deed_simple[-which(test$deed_type %in% c('WD','SJ','SW','RD'))] <- 'Other'
test$deed_simple <- as.factor(test$deed_simple)

mod4 <- predict(model4, test)
mod4 <- as.data.frame(cbind(1:10000,mod4))
names(mod4) <- c('id','totalActualVal')
head(mod4)
write.csv(mod4,file='mod4.csv',row.names=F)
