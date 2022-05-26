fluidPage(
  theme = shinytheme("flatly"),
  navbarPage("UrbanSim QC Dashboard",
             tabPanel("One-Run"
             ), # end tabPanel
             tabPanel("Multi-Run",
                      sidebarPanel(width = 3,
                                   # splitLayout(#style = "display: flex;",
                                   # uiOutput('widget'),
                                   selectInput('allRuns',
                                               label = 'Runs',
                                               selected = NULL,
                                               choices = NULL,
                                               multiple = TRUE,
                                               width = '100%'),
                                   shinyDirButton(id = "directory", 
                                                  label = 'Select Runs',
                                                  icon = icon("fa-solid fa-folder"),
                                                  title = "Please select a folder",
                                                  # style = "margin-left: .5rem; height: 4rem"
                                                  )
                                   
                                   # ) #end div
                      ), # end sidebarPanel
                      mainPanel(width = 9)
             ) # end tabPanel
  ) # end navbarPage
  
)

