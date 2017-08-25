library(goldi)
library(data.table)
library(magrittr)
library(tm)

function(input, output, session) {
	
		nonveganTDM <- {
			
		raw_go <- readLines("../data/not_vegan.txt")	
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
	}

	justString <- reactive(unlist(strsplit(input$ingredients, ", ")))

	out <- reactive({
		goldi::goldi(
		doc = justString(),
		#terms = c("peanut", "tallow"),
		term_tdm = nonveganTDM,
		lims = c(0,1,2,3),
		output = "../output.txt",
		log = "../log.txt",
		object = TRUE,
		reader = "local") %>%
	as.data.frame

	})
	
	output$table <- DT::renderDataTable({
		DT::datatable( 
			out()
		)
	})
}
