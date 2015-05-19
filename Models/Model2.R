# Simple model using the top 6 predictors according to the correlation matrix
# Analysis done on original data

model2 <- lm(totalActualVal ~ TotalFinishedSF + mainfloorSF + nbrFullBaths + nbrBedRoom + carStorageSF + PCT_WHITE + designCodeDscr + range + nbrThreeQtrBaths + nbrHalfBaths + carStorageTypeDscr + ConstCodeDscr, data=train)

summary(model2)

mod2 <- predict(model2, test)
mod2 <- as.data.frame(cbind(1:10000,mod2))
names(mod2) <- c('id','totalActualVal')
head(mod2)
write.csv(mod2,file='mod2.csv',row.names=F)

# MSE 41499923372
