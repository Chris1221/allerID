function(input, output, session) {
	library(goldi)

	ingredients <- reactive({
		input$ingredients
	}) 
}
