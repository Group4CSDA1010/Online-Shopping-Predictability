#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
# Define UI for application that draws a histogram

shinyUI(fluidPage(theme = "bootstrap.css",

    # Application title
    headerPanel(
      h1("Online Shopping Predictability",
         style = "font-weight: 500;text-align: center; color: #4d3a7d;background-color: coral")),
    h2("CSDA1010 Basic Methods of Data Analytics - Winter 2020 Section III",style = "font-weight: 200;text-align: center; color: #8e83d3;"),
    #h3("Group 4 Final Project",style = "font-weight: 200;text-align: center; color: #8e83d4;"),
    h4("Completed By:",style = "font-weight: 200;text-align: center; color: #6e60c4;"),
    h1("JINPING BAI , ", "KRISHNA KIRUBA, " ,"LEOLEIN PAOPCHI, ","PAUL FLEMMING, ", " and Sam Fawzi",style = "font-weight: 300;text-align: center; color: #47399e;background-color: coral"),
    

    #titlePanel("Shoppers Data Analysis / Kmean Clusters plot"),
    tabsetPanel(
      tabPanel("Introduction",
               h2("Introduction",style = "font-weight: 500;text-align: center; color: #4d3a7d;background-color: coral"),
      h3("Retail ecommerce sales, globally, have increased from 1.3 trillion US dollars in 2014 to 2.8 trillion US dollars in 2018 and are projected to be 4.9 trillion US dollars in 2021 (Orendorff, 2019).   Total global retail sales during the same period were 22.5 trillion US dollars in 2014, 24 trillion US dollars in 2018 and are projected to be 27.25 trillion US dollars in 2021 (MarketingCharts, 2015) (Lipsman, 2019).  In 2014, retail ecommerce sales accounted for 5.8% of total retail sales and by 2021 are projected to be 18% of total retail sales.  This increase will provide online retailers, new and existing, opportunities in new and emerging markets.  Existing online retailers will need to understand the buying patterns of existing customers as well as understand why customers purchase or decide not to purchase online.
The team assembled for this project has been tasked with two tasks.  The first is understanding why an online shopper follows through with a purchase and the second task is to create a profile of an online shopper who makes a purchase. 
The participants of the team involved in this study are Sam Fawzi, Jinping Bai, Krishna Kiruba, Leolein Paouchi, and Paul Flemming.  The team brings together a wide variety of experience from the fields of business, finance, logistics, engineering and IT.  This combined experience enables the team to analyze the project from different perspectives.
",style = "font-family: Arial, Helvetica, sans-serif;font-size: 25px;letter-spacing: 2px;word-spacing: 2px;color: #000000;font-weight: normal;
text-decoration: none;font-style: normal;font-variant: normal;text-transform: none;"),
      h2("Background",style = "font-weight: 500;text-align: center; color: #4d3a7d;background-color: coral"),
      h3("The dataset (Online Shoppers Purchasing Intention Dataset Data Set) that has been provided for this study are statistics describing the web pages visited previously, the length of time browsing the web pages and various other metrics measured by Google Analytics.  The data consists of data collected over a one-year period.  Although the data provides a variety of features, there are issues with some of the features.  Most issues will not affect the outcome of the modelling but a better insight into the data would be available if some of the issues are resolved.",style = "font-family: Arial, Helvetica, sans-serif;font-size: 25px;letter-spacing: 2px;word-spacing: 2px;color: #000000;font-weight: normal;
text-decoration: none;font-style: normal;font-variant: normal;text-transform: none;"),
      h2("Objective",style = "font-weight: 500;text-align: center; color: #4d3a7d;background-color: coral"),
      h3("One of objectives of this study is to develop an algorithm for predicting the probability of an online shopper making a purchase.  The second objective of the study is to create a profile of the typical online shopper who makes a purchase.  This process will include looking at the variables and deciding if they are required in the modelling process.  Looking for outliers in the data.  Checking for missing data.  Checking the independence of the variables to each other. A variety of models will initially be tested in determining the best way to develop the desired algorithm. The models for the first objective will include classification modelling and the second objective will include clustering models",style = "font-family: Arial, Helvetica, sans-serif;font-size: 25px;letter-spacing: 2px;word-spacing: 2px;color: #000000;font-weight: normal;
text-decoration: none;font-style: normal;font-variant: normal;text-transform: none;"),
      ),
      tabPanel("Data Understanding",
               br(),
               br(),
               br(),
               fluidRow("Dataset Rows (Observations)",style = "font-weight: 500;text-align: left; color: #4d3a7d;background-color: coral"),
               fluidRow(htmlOutput("ro")),
               br(),
               fluidRow("Dataset columns (Features) (Observations)",style = "font-weight: 500;text-align: left; color: #4d3a7d;background-color: coral"),
               fluidRow(htmlOutput("col")),
               br(),
               fluidRow("Dataset Stats",style = "font-weight: 500;text-align: left; color: #4d3a7d;background-color: coral"),
               fluidRow(htmlOutput("str")),
               br(),
               fluidRow("Visitors Type Frequency",style = "font-weight: 500;text-align: left; color: #4d3a7d;background-color: coral"),
               fluidRow(tableOutput("VTYPE")),
               br(),
               fluidRow("Revenue Frequency",style = "font-weight: 500;text-align: left; color: #4d3a7d;background-color: coral"),
               fluidRow(tableOutput("REV")),
               
               ),
      tabPanel("Data correlation", h2("Our Data Correlation plot "),
               plotOutput(outputId="plotgraph4", width="600px",height="600px")),
      tabPanel("k-means clustering",
             sidebarPanel(
             h6("Select the number of clusters you want to see "),
             sliderInput("bins","Number of Clusters:",min = 1,max = 15,value = 1),
             h6("we've found that The optimal number of clusters is 4")),
             mainPanel(    
        # Show a plot of the generated distribution
            #("Visulisation of clusters",
                fluidRow(
                plotOutput(outputId="plotgraph1", width="600px",height="600px"),
                verbatimTextOutput(outputId="plt1stats1")),
                fluidRow(
                h2("Let's look at the scaled dataset Model "),
                plotOutput(outputId="plotgraph2", width="600px",height="600px"),
                verbatimTextOutput(outputId="plt1stats2")))),
             tabPanel("Random Forest", h2("Our Random Forest model "),
                      plotOutput(outputId="plotgraph3", width="600px",height="600px"))
            )))
            
            
    
    
    


