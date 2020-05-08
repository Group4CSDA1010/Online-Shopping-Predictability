#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(dplyr)
library(reshape2)
library(ggplot2)
library(Hmisc)
library(corrplot)
library(mice)
library(VIM)
library(sqldf)
library(pROC)
library(caret)
library(tidyverse)
library(lubridate)
library(tidyr)
library(tseries)
library(corrplot)
library(rpart)
library(rpart.plot)
library(randomForest)
library(viridis)
library(hrbrthemes)
library(plyr)
library(cluster)
library (factoextra)
library(fpc)
library (gmodels); library (MASS)
library(profvis)




#setwd("C:/Users/afawzi/OneDrive - The Massey Centre for Women/York CS - Big Data/CSDA1010-022-O-W20S3/Final Project_SHOPPERS/Final_/FINAL_01")

#setwd("C:/Users/AbdulsalamFawzi/OneDrive - The Massey Centre for Women/York CS - Big Data/CSDA1010-022-O-W20S3/Final #Project_SHOPPERS/Final_")
DF1 <- read.csv("online_shoppers_intention.csv")
DF2 <- DF1[c(1:10,12:18)]
VisitorType <- factor(DF2$VisitorType)
DF2$VisitorType <- as.numeric(VisitorType)
DF2$Weekend=ifelse(DF2$Weekend=="TRUE",1,0)
DF2$Revenue=ifelse(DF2$Revenue=="TRUE",1,0)
Scaled_DF_1 = as.data.frame(scale(DF2[1:17]))
# Create Training Data
input_ones <- DF2[which(DF2$Revenue == 1), ]  # all 1's

input_zeros <- DF2[which(DF2$Revenue == 0), ]  # all 0's

set.seed(100)  # for repeatability of samples
input_ones_training_rows <- sample(1:nrow(input_ones), 0.7*nrow(input_ones))  # 1's for training
input_zeros_training_rows_half <- sample(1:nrow(input_zeros), 0.35*nrow(input_ones))  # 0's for training. Pick as many 0's as 1's
training_ones <- input_ones[input_ones_training_rows, ]  
training_zeros_Half <- input_zeros[input_zeros_training_rows_half, ]
trainingData_Half <- rbind(training_ones, training_zeros_Half)  # row bind the 1's and 0's 

# Create Test Data
test_ones <- input_ones[-input_ones_training_rows, ]
test_zeros_Half <- input_zeros[-input_zeros_training_rows_half, ]
testData_Half <- rbind(test_ones, test_zeros_Half)  # row bind the 1's and 0's 
#random Forest
library(randomForest)
fitRF2 <- randomForest(
  Revenue ~ ., method="anova",
  data=trainingData_Half[1:17], importance=TRUE, ntree=100)
varImpPlot(fitRF2, main="")
PredictionRF2 <- predict(fitRF2, testData_Half)
df3_2 = data.frame(as.factor(testData_Half$Revenue), PredictionRF2)
colnames(df3_2) <- c("Test","Prediction")
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$plotgraph1 <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2]
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    set.seed(1240)
    clusters <- kmeans(DF2[, 1:17],input$bins , nstart = 25)
    library(cluster)
    Cneters_1 = data.frame(clusters$centers)
    plotcluster(DF2[1:17], clusters$cluster)
    #clusplot(DF2, clusters$cluster, color=TRUE, shade=TRUE,
             #labels=2, lines=0,main='Kmean Clusters for the original Data')
    
  })
  output$plt1stats1 <- renderPrint({
    clusters <- kmeans(DF2[, 1:17],input$bins , nstart = 25)
    data.frame(clusters$centers)
  })
  output$plotgraph2 <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2]
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    set.seed(1240)
    clusters_1 <- kmeans(Scaled_DF_1[, 1:17],input$bins , nstart = 25)
    plotcluster(Scaled_DF_1[1:17], clusters_1$cluster)
    
    #fviz_cluster(clusters_1, data = Scaled_DF_1[1:17],ellipse=TRUE,main='Kmean Clusters for the Scaled Data')
    
    
    })
  output$plt1stats2 <- renderPrint({
    clusters_1 <- kmeans(Scaled_DF_1[, 1:17],input$bins , nstart = 25)
    data.frame(clusters_1$centers)
  })
  
  output$plotgraph3 <- renderPlot({varImpPlot(fitRF2, main="")
})
  output$plotgraph4 <- renderPlot({
  cor.matrix <- cor(DF2, method = "pearson", use = "complete.obs")
  corrplot(cor.matrix)
})
  output$str <- renderText({
    library(stargazer)
    stargazer(DF1,type = 'html');
    
    
    
  })
  output$VTYPE <- renderTable({
  table(DF1$VisitorType)
  
  })
  
  output$REV <- renderTable({
    table(DF1$Revenue)
    
  })
  
  output$ro <- renderTable({
    nrow(DF1)
    
  })
  output$col <- renderTable({
    ncol(DF1)
    
  })
})
