# Define server logic required
server <- function(input, output, session) {
  
  rund <- "/media/aws-prod-file01modeldata/vision2050/opusgit/urbansim_data/data/psrc_parcel/runs"
  # rund2 <- "/media/aws-prod-file01modeldata2/vision2050/opusgit/urbansim_data/data/psrc_parcel/runs"
  # rund <- 'L:/vision2050/opusgit/urbansim_data/data/psrc_parcel/runs' # When running locally
  
  volumes <- c(Home = rund, "R Installation" = R.home(), getVolumes()())
  # volumes <- c(Home = fs::path_home(), "R Installation" = R.home(), getVolumes()())
  # by setting `allowDirCreate = FALSE` a user will not be able to create a new directory
  shinyDirChoose(input, "directory", roots = volumes, session = session, restrictions = system.file(package = "base"), allowDirCreate = FALSE)
  
  ## print to console to see how the value of the shinyFiles 
  ## button changes after clicking and selection
  
  observe({
    cat("\ninput$directory value:\n\n")
    print(input$directory)
  })
  
  output$directorypath <- renderPrint({
    if (is.integer(input$directory)) {
      cat("No directory has been selected (shinyDirChoose)")
    } else {
      parseDirPath(volumes, input$directory)
    }
  })
  
  # -------------------------------------------------------
  
  r <- reactiveValues(runs = c())
  
  observeEvent(input$directory, {
    dir.path <- parseDirPath(volumes, input$directory)
    run.name <- str_extract(dir.path, "(?<=/)run_.*$")
    names(dir.path) <- run.name
    r$runs <- c(r$runs, dir.path)
  })
  
  output$widget <- renderUI({
    if(length(r$runs > 0)) {
      selectInput('allRuns',
                  label = 'Run Choices',
                  selected = r$runs,
                  choices = r$runs,
                  multiple = TRUE)
    } else {
      selectInput('allRuns',
                  label = 'Run Choices',
                  selected = NULL,
                  choices = NULL,
                  multiple = TRUE)
    }
  })
}