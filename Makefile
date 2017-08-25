.PHONY: all

all: launch

launch: shiny/ui.R shiny/server.R
	Rscript-devel -e "shiny::runApp('shiny')"
