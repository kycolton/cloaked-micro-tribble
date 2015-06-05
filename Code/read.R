# Reads data, looks at correlations with the response variable (totalActualVal)

# Seed for reproducablility
set.seed(17328)

train <- read.csv('train.csv',header=T,stringsAsFactors=F)
test <- read.csv('test.csv',header=T,stringsAsFactors=F)

# Split training into training / test
t.index <- which(runif(nrow(train)) > .5)
train.tr <- train[t.index,]
train.te <- train[-t.index,]

# pairs[,-which(sapply(train,class)=='character')]

#~ I don't think R likes how many variables there are
# pairs(train[,sapply(train, function(x) is.numeric(x))])
#~ Error in plot.new() : figure margins too large

# Sort the correlations with the response variable
sort((cor(train[,sapply(train, function(x) is.numeric(x))])[,3])^2)

# Massive corrplot...
library(corrplot)
tr.cor <- cor(train[,sapply(train, function(x) is.numeric(x))])
corrplot(tr.cor,method='ellipse')

