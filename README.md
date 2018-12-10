### A `shiny` server to identify various allergens from free text using `goldi`. 

This tool was written to help people find potential allergens in food and cosmetic labels, especially those ingredients that may be obscure and/or difficult to remember.  We compare the ingredients provided in several databases using a method implimented in [`goldi`](https://github.com/chris1221/goldi). Full details on the `goldi` implimentation are provided in relevant literature, however in brief `goldi` compares each ingredient (which may be several words long) to the relevant database using techniques borrowed from natural language processing and determines if there is enough evidence to match the terms. If the terms are matched, `allerID` returns the relevant entry and reports it back to you!

To run the application, first use `git` to clone (download) it to a memorable location:

```sh
git clone git@github.com:Chris1221/shiny_vegan.git
```

Then, start `R`, and navigate to the same directory:

```R
setwd("shiny_vegan")
```

Install `goldi` and `shiny` (and maybe other dependencies), and launch away!

```R
install.packages("goldi")
install.packages("shiny")

shiny::runApp("shiny")
```

Contributions are very much welcome, please see the relevant section in the app. If something breaks, please copy paste the `log.txt` provided by `goldi` as it will give me more information as to what happenned. 


