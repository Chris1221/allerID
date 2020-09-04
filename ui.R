# This is the user interface

pageWithSidebar(

  headerPanel('Find allergens in lists of ingredients'),
  sidebarPanel(
	#img(src='logo.png', align = "left", width=500 ),
	img(src = 'logo.png', width = 200, align = "center"),
	h3("Which allergens?"),
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
  textOutput("n"),
  hr(),
	helpText("Note: This information is by no means guarenteed to be correct and is only meant to help you make an informed decision about which products you choose to consume and use.")
  ),
  mainPanel(
	 tabsetPanel(
	tabPanel("Check for allergens", DT::dataTableOutput("table")),
	tabPanel("About this app",
	         h3("A little more about the app"),
	            p("This is a very quick attempt to remedy some issues that I've personally been having reading cosmetics labels. Currently I've only implimented the ability to find common allergens from databases of ingredients, however there is no reason that it cannot be extended to include any niche ingredients that you would want to avoid. Please take the results with a grain of salt, and let me know if something is not working."),
	         h4("Data Sources"), 
	            p("The 'terms' or allergens implimented here are all to be found in the data directory as plain text lists. Please feel free to add or subtract as you see fit. If you do put some work into it, please consider submitting your additions as a pull request as detailed below. If you would like to add a different set of ingredients, simply add a new 'checkboxInput' level in ui.R with the name of the file as the first input and it should work the same way as the others."),
	         h3("Contributing"),
	            p("If you wish to make a suggestion or contribution, by all means, please do. Fork the github repository and edit whatever you would like, and submit the changes as a pull request. If you do not want to change something, and rather just would like to let me know that something isn't working out, then raise an issue. The code here is pretty basic, and mostly relies on my goldi package, so any changes will mostly concern the list of terms, or allergens, to find in the ingredient lists. Suggestions for improving goldi are also welcome, however please do make them in the appropriate repository."))
	)
	)
)
