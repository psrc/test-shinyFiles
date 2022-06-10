fluidPage(
  theme = shinytheme("flatly"),
  navbarPage("UrbanSim QC Dashboard",
             tabPanel("One-Run",
                      sidebarPanel(width = 3,
                                   run_choice_ui('runChoice_one', 'Run Choice', 'Select Run', FALSE)
                      )
             ), # end tabPanel
             tabPanel("Multi-Run",
                      sidebarPanel(width = 3,
                                   run_choice_ui('runChoice_multi', 'Run Choices', 'Select Runs', TRUE)
                      ), # end sidebarPanel
                      mainPanel(width = 9)
             ) # end tabPanel
  ) # end navbarPage
) # end fluidPage

