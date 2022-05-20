library(shiny)
library(shinyFiles)
library(fs)

# Define UI for application that uses shinyFiles for directory selection
ui <- fluidPage(
  
  fluidPage(
    # theme = bslib::bs_theme(version = 4),
    headerPanel(
      "Selections with shinyFiles",
      "shinyFiles example"
    ),
    sidebarLayout(
      sidebarPanel(
        shinyDirButton("directory", "Folder select", "Please select a folder"),
        tags$p(),
        tags$p("This button lets the user navigate the file system and select a\n
             folder. The absolute path of the selected folder is then sent\n
             back to the server. While only folders can be selected, it is\n
             possible to get an overview of the content beforehand. \n
             Furthermore it is permission aware and warns if a folder with \n
             missing write permissions is selected. Lastly it is possible to\n
             create folders on the fly")
        
      ),
      mainPanel(
        tags$h4("The output of a folder selection"),
        tags$p(HTML("When a folder is selected the position of the folder is sent to \n
                  the server and can be formatted with <code>parseDirPath()</code> to reflect a\n
                  standard path string as returned by e.g. <code>choose.dir()</code> on windows\n
                  systems.")),
        verbatimTextOutput("directorypath")
      )
    )
  )
)

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

# Run the application 
shinyApp(ui = ui, server = server)
