# Simple model using the top 6 predictors according to the correlation matrix
# Analysis done on original data

model1 <- lm(totalActualVal ~ TotalFinishedSF + mainfloorSF + nbrFullBaths + nbrBedRoom + carStorageSF + PCT_WHITE, data=train.tr)

summary(model1)

library(car)
vif(model1)

mean((predict(object=model1,newdata=train.te) - train.te$totalActualVal)^2)

# MSE 41499923372
