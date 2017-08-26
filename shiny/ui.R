# This is the user interface

pageWithSidebar(

  headerPanel('allerID: Identifying allergens in free text using goldi.'),
  sidebarPanel(
	h2("Which allergens?"),
	p("Use the boxes below to select which allergens you're looking to avoid. You can select as many or as few as you want. Each comes from different sources, and these will be indicated in the output."),
	checkboxInput("milk", "Milk", FALSE),
checkboxInput("eggs", "Eggs", FALSE),
checkboxInput("nuts", "Nuts", FALSE),
checkboxInput("peanuts", "Peanuts", FALSE),
checkboxInput("vegan", "Vegan", TRUE),
	hr(),
	textAreaInput("ingredients", "Paste ingredients here, seperated by commas.", value = "Beats, Bears, Battlestar Galactica."),
	hr(),
	actionButton("ex", "Give me an example!"),
	hr(),
	helpText("Note: This information is by no means guarenteed to be correct and is only meant to help you make an informed decision about which products you choose to consume and use.")
  ),
  mainPanel(
	 tabsetPanel(
	tabPanel("Check for allergens", DT::dataTableOutput("table")),
	tabPanel("About this app", h3("A little more about the app"), p("Here I'm going to write a little bit more about this app"), h3("Contributing"), p("Here I'm going to write how to contribute"))
	)
	)
)
