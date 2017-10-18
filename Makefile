.PHONY: all

all: launch

launch: shiny/ui.R shiny/server.R
	Rscript -e "shiny::runApp('shiny')"
