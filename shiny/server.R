library(goldi)
library(data.table)

function(input, output, session) {
	
	ingredients <- reactive({
		input$ingredients
	}) 

	output$table <- reactive({

		goldi::goldi(
			doc = "data/not_vegan.txt",
			terms = ingredients,
			output = "/dev/null",
			log = "/dev/null",
			object = TRUE) %>%
		as.data.table


	})
}
