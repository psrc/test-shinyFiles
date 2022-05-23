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
