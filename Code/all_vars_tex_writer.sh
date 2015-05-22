#!/bin/bash
#
# Run first
# write.table(names(train),row.names=F,file='names.csv',quote=F,sep='\n',col.names=F)
#

echo "\documentclass[10pt,letterpaper]{article}
\usepackage[utf8]{inputenc}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage[left=2cm,right=2cm,top=2cm,bottom=2cm]{geometry}
\title{Stat 101C Final}
\author{Kyle Colton}
\usepackage{Sweave}
\begin{document}
\maketitle"

echo "<<echo=F>>=
train <- read.csv('train.csv',header=T)
@"
vars=$(cat names.csv)
for name in $(cat names.csv | tail -n 93)
do
    echo "\section{$name}"
    echo "<<fig=T>>="
    echo "plot(totalActualVal ~ $name,data=train)"
    echo "summary(lm(totalActualVal ~ poly($name,3),data=train))"
    echo "@"
done
echo "\end{document}"
