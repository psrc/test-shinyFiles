
fluidPage(
  headerPanel(
    "Selections with shinyFiles",
    "shinyFiles example"
  ),
  mainPanel(
    shinyDirButton("directory", "Folder select", "Please select a folder"),
    verbatimTextOutput("directorypath"),
    uiOutput('widget')
  )
)

