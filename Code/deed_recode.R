table(train$deed)
train$deed_simple <- as.character(train$deed)
train$deed_simple[-which(train$deed_type %in% c('WD','SJ','SW','RD'))] <- 'Other'
table(train$deed_simple)
summary(lm(train$totalActualVal ~ train$deed_simple))
