# This is the user interface

pageWithSidebar(

  headerPanel('Tool to identify non-vegan ingredients in cosmetics.'),
  sidebarPanel(
	textInput("ingredients", "Paste ingredients here, seperated by commas.", value = "peanut")
  ),
  mainPanel(
	DT::dataTableOutput("table")
	)
)
