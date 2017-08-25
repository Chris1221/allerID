library(goldi)
library(data.table)
library(magrittr)
library(tm)

function(input, output, session) {

		allergyTDM <- reactive({
			
			raw_go <- readLines("../data/init.txt")

			if( input$milk ) {
				#raw_go <- c(raw_go, readLines("data/milk.txt"))
			} else if( as.factor( input$vegan ) ) {
				raw_go <- c(raw_go, readLines("../data/not_vegan.txt"))
			}
				
			raw_go <- iconv(raw_go,"WINDOWS-1252","UTF-8") #this might not be a silver bullet, check the encoding
			raw_go <- raw_go[which(raw_go!="")]

			raw_go <- unlist(strsplit(raw_go, ","))
			doc.vec <- VectorSource(raw_go)
			doc.corpus <- Corpus(doc.vec)
			raw.corpus <- doc.corpus # for use later	
			doc.corpus <- tm_map(doc.corpus, content_transformer(tolower))
			doc.corpus <- tm_map(doc.corpus, content_transformer(replaceExpressions))
			doc.corpus <- tm_map(doc.corpus, removePunctuation)
			doc.corpus <- tm_map(doc.corpus, removeNumbers)
			doc.corpus <- tm_map(doc.corpus, removeWords, stopwords("english"))
			doc.corpus <- tm_map(doc.corpus, stemDocument)
			doc.corpus <- tm_map(doc.corpus, stripWhitespace)

			TermDocumentMatrix(doc.corpus) %>% as.matrix() %>%
				as.data.frame ->
				TDM.go.df
			
			sub <- gsub(" ", "_", x = raw_go)
			sub <- gsub("-", "_", x = sub)

			colnames(TDM.go.df) <- sub

			TDM.go.df
	})
	
	justString <- reactive(unlist(strsplit(input$ingredients, ", ")))

	out <- reactive({
		goldi::goldi(
		doc = justString(),
		#terms = c("peanut", "tallow"),
		term_tdm = allergyTDM(),
		lims = c(0,1,2,3),
		output = "../output.txt",
		log = "../log.txt",
		object = TRUE,
		reader = "local") %>%
	as.data.frame -> goldi_output

	# Process this to get the source
	# 	This is pretty damn messy
	
	goldi_output$Source <- NA

	for( i in 1:nrow(goldi_output) ){
		if(goldi_output[i, 1] %in% readLines("../data/not_vegan.txt") ) goldi_output[i, "Source"] <- "https://www.peta.org/living/other/animal-ingredients-list/"

		if(goldi_output[i, 1] %in% readLines("../data/init.txt") ) goldi_output[i, "Source"] <- "Jim Halpert"


	}
	goldi_output
	})
	
	output$table <- DT::renderDataTable({
		DT::datatable( 
			out()
			)
	}, escape = F)
}
