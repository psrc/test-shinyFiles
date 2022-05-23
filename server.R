# Define server logic required
server <- function(input, output, session) {
  
  # rund <- "/media/aws-prod-file01modeldata/vision2050/opusgit/urbansim_data/data/psrc_parcel/runs"
  # rund2 <- "/media/aws-prod-file01modeldata2/vision2050/opusgit/urbansim_data/data/psrc_parcel/runs"
  
  volumes <- c(Home = 'L:/vision2050/opusgit/urbansim_data/data/psrc_parcel/runs', "R Installation" = R.home(), getVolumes()())
  # volumes <- c(Home = fs::path_home(), "R Installation" = R.home(), getVolumes()())
  # by setting `allowDirCreate = FALSE` a user will not be able to create a new directory
  shinyDirChoose(input, "directory", roots = volumes, session = session, restrictions = system.file(package = "base"), allowDirCreate = FALSE)
  
  # shinyFileChoose(input, "file", roots = volumes, session = session)
  # shinyFileSave(input, "save", roots = volumes, session = session, restrictions = system.file(package = "base"))
  
  ## print to console to see how the value of the shinyFiles 
  ## button changes after clicking and selection
  
  observe({
    cat("\ninput$directory value:\n\n")
    print(input$directory)
  })
  
  ## print to browser
  output$filepaths <- renderPrint({
    if (is.integer(input$file)) {
      cat("No files have been selected (shinyFileChoose)")
    } else {
      parseFilePaths(volumes, input$file)
    }
  })
  
  output$directorypath <- renderPrint({
    if (is.integer(input$directory)) {
      cat("No directory has been selected (shinyDirChoose)")
    } else {
      parseDirPath(volumes, input$directory)
    }
  })
  
}