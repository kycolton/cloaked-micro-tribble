# Simple model using the top 6 predictors according to the correlation matrix
# Analysis done on original data

# deed-recode
train$deed_simple <- as.character(train$deed)
train$deed_simple[-which(train$deed_type %in% c('WD','SJ','SW','RD'))] <- 'Other'
train$deed_simple <- as.factor(train$deed_simple)

vars <- c(4,9,8,13:32,34:40,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72:85,87,89,91,92,95:97,99)

tic <- proc.time()
model4 <- lm(totalActualVal ~ . + poly(taxArea,3) + poly(bsmtSF,3) + poly(carStorageSF,3) + poly(nbrBedRoom,3) + poly(mainfloorSF,3) + poly(TotalFinishedSF,3) + poly(PCT_WHITE,3) + poly(MED_AGE,3) + poly(PCT_OWN,3) + township:qualityCodeDscr + township:carStorageTypeDscr + township:mainfloorSF + township:nbrFullBaths + township:TotalFinishedSF + township:PCT_WHITE + township:MED_AGE + township:PCT_OWN + range:designCodeDscr + range:qualityCodeDscr + range:carStorageTypeDscr + range:nbrBedRoom + range:mainfloorSF + range:nbrFullBaths + range:nbrThreeQtrBaths + range:PCT_OWN + range:MED_AGE + range:PCT_WHITE + range:deed_simple + taxArea:designCodeDscr + taxArea:qualityCodeDscr + taxArea:carStorageTypeDscr + taxArea:nbrBedRoom + taxArea:nbrThreeQtrBaths + taxArea:nbrFullBaths + taxArea:TotalFinishedSF + taxArea:PCT_WHITE + taxArea:MED_AGE + designCodeDscr:bsmtSF + designCodeDscr:nbrHalfBaths + designCodeDscr:PCT_WHITE + designCodeDscr:PCT_OWN + designCodeDscr:deed_simple + qualityCodeDscr:bsmtSF + qualityCodeDscr:carStorageSF + qualityCodeDscr:carStorageTypeDscr + qualityCodeDscr:nbrBedRoom + qualityCodeDscr:mainfloorSF + qualityCodeDscr:nbrThreeQtrBaths + qualityCodeDscr:nbrFullBaths + qualityCodeDscr:nbrHalfBaths + qualityCodeDscr:TotalFinishedSF + qualityCodeDscr:MED_AGE + qualityCodeDscr:PCT_OWN + qualityCodeDscr:deed_simple + bsmtSF:TotalFinishedSF + bsmtSF:nbrFullBaths + carStorageSF:mainfloorSF + carStorageSF:nbrBedRoom + carStorageSF:carStorageTypeDscr + carStorageSF:nbrThreeQtrBaths + nbrBedRoom:nbrThreeQtrBaths + mainfloorSF:nbrThreeQtrBaths + mainfloorSF:nbrFullBaths + mainfloorSF:nbrHalfBaths + mainfloorSF:TotalFinishedSF + mainfloorSF:MED_AGE + mainfloorSF:PCT_OWN + nbrThreeQtrBaths:PCT_WHITE + nbrThreeQtrBaths:TotalFinishedSF + nbrThreeQtrBaths:MED_AGE + nbrFullBaths:PCT_WHITE + nbrFullBaths:MED_AGE + nbrFullBaths:TotalFinishedSF + PCT_WHITE:deed_simple
, data=train)
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
mod4$totalActualVal <- abs(mod4$totalActualVal)
write.csv(mod4,file='mod4_4.csv',row.names=F)
