#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
text2<-read.csv("StudentsPerformance.csv") # source link for the dataset: https://www.kaggle.com/spscientist/students-performance-in-exams
gender<-read.csv("gender.csv") #used python to filter the data
test<-read.csv("test.csv") #used python to filter the data
gender_test<-read.csv("gender_test.csv") #used python to filter the data
library(ggplot2)
library(treemap)
library(RColorBrewer)
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$tree1<-renderPlot({
        colx<-as.numeric(input$score1)
        if(colx==3){
            x3<-"Math Score"
        }else if(colx==2){
            x3<-"Reading Score"
        }else if(colx==4){
            x3<-"Writing Score"
        }
        barplot(height =c(gender_test[1,colx],gender_test[2,colx]),names=c("male","female"),col=input$barcolor,main=input$input3,
                ylim=c(0,100),density=input$density2,angle=c(input$dg,input$dg),ylab="Score",xlab=x3)
    })
    output$pie1<-renderPlot({
        if(input$piedata==1){
            if(input$piecolor==1){
                y2<-c("red","yellow")
            }else if(input$piecolor==2){
                y2<-c("blue","green")
            }
            pie(c(gender[,1],gender[,2]),labels = c("female","male"),col=y2,edges = input$edges,density = input$density1,border = input$bordercolor1,cex=input$piesize)
        }else{
            if(input$piecolor==1){
                y2<-c("red","yellow")
            }else if(input$piecolor==2){
                y2<-c("blue","green")
            }
            pie(c(test[,1],test[,2]),labels = c("Taken","None"),col=y2,edges = input$edges,density = input$density1,border = input$bordercolor1,cex=input$piesize)
        }
    })
    output$gp<-renderPlot({
        if(input$var1==1){
            y1<-c("blue","yellow","red","green")
        }else if(input$var1==2){
            y1<-c("#999999", "#E69F00", "#56B4E9", "#009E73",
                  "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
        }
        colx<-as.numeric(input$x1)
        coly<-as.numeric(input$y1)
        shape1<-as.numeric(input$shape)
        if(colx==6){
            x2<-"Math Score"
        }else if(colx==7){
            x2<-"Reading Score"
        }else if(colx==8){
            x2<-"Writing Score"
        }
        if(coly==6){
            y2<-"Math Score"
        }else if(coly==7){
            y2<-"Reading Score"
        }else if(coly==8){
            y2<-"Writing Score"
        }
        plot(text2[,colx],text2[,coly],col=y1,xlab=x2,ylab=y2,main=input$input1,pch=shape1,cex=input$dotsize)
    })
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        colm<-as.numeric(input$var)
        x    <- text2[, colm]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        # draw the histogram with the specified number of bins
        if(colm==6){
            y<-"Math Score"
        }else if(colm==7){
            y<-"Reading Score"
        }else if(colm==8){
            y<-"Writing Score"
        }
        hist(x, breaks = bins, col = input$color, border = input$bordercolor,main =input$input2,xlab = y )
    })

})
