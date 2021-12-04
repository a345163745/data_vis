#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
shinyUI(pageWithSidebar(
    titlePanel("Student Exam Performance"),
    sidebarPanel(
        
        
        conditionalPanel(condition="input.tabselected==1",sliderInput("bins",
                                                                      "Number of bins for bar graph:",
                                                                      min = 1,
                                                                      max = 100,
                                                                      value = 50),
                         selectInput("color","select your bar color",c("red","green","yellow")),
                         selectInput("bordercolor","select your border color:",c("blue","white","black")),
                         selectInput("var","Select data for histogram:",choices = c("Math Score"=6,"Reading Score"=7,"Writing Score"=8)),
                         textInput("input2","enter title for histogram",value = "histogram")),
        conditionalPanel(condition="input.tabselected==2",
                         selectInput("var1","select color for scatterplot:",choices = c("Palette 1"=1,"Palette 2"=2)),
                         selectInput("x1","pick for x variable:",choices = c("Math Score"=6,"Reading Score"=7,"Writing Score"=8)),
                         selectInput("y1","pick for y variable:",choices = c("Math Score"=6,"Reading Score"=7,"Writing Score"=8)),
                         selectInput("shape","pick for scatterplot dot shape:",choices = c("Trangle"=2,"Star"=11,"Circle"=1,"Square"=15)),
                         sliderInput("dotsize","dot size for scatterplot",min=0,max=10,value=1),
                         textInput("input1","enter title for scatter plot",value = "scatter plot"),
                         
        ),
        
        conditionalPanel(condition="input.tabselected==3",selectInput("piedata","pick data for pie chart:",choices = c("Student's Gender"=1,"Preparation Course Status"=2)),
                         selectInput("piecolor","select color for Pie chart:",choices = c("red,yellow"=1,"blue,green"=2)),
                         sliderInput("edges","adjust edge shape for pie chart",min=0,max=50,value=50),
                         sliderInput("density1","adjust density for pie chart",min=0,max=100,value=50),
                         selectInput("bordercolor1","select your border color for pie chart:",c("brown","purple","black")),
                         sliderInput("piesize","font size for pie chart",min=1,max=5,value=1)),
        conditionalPanel(condition="input.tabselected==4",
                         textInput("input3","enter title for bar plot",value = "bar plot"),
                         sliderInput("density2","adjust density for bar chart",min=0,max=120,value=10),
                         sliderInput("dg","adjust bar texture degree for bar chart",min=0,max=360,value=10),
                         selectInput("barcolor","select your bar color",c("red","green","yellow","blue")),
                         selectInput("score1","pick Subject score for bar-plot :",choices = c("Math Score"=3,"Reading Score"=2,"Writing Score"=4)))
        
    ),
    mainPanel(
        tabsetPanel(
            tabPanel("Histogram", value=1,plotOutput("distPlot")),
            tabPanel("Scatter Plot", value=2, plotOutput("gp")),
            tabPanel("Pie Chart", value=3, plotOutput("pie1")),
            tabPanel("Bar Chart",value=4, plotOutput("tree1")),
            id = "tabselected"
        )
    )
))
