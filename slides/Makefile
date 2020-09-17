# To use this make sure first line of main .Rnw file is \documentclass only
# this makefile will create 2 new .Rnw files, and then compile to pdf
# one for slides and one for handout. from the slides directory
# usage: make filename="001-introduction" path="001-introduction"


all: handout slides

.PHONY: html pdf clean

clean: 
	rm *.aux *.blg *.out *.bbl *.log

# Create the two header files

handout: 
	echo "\documentclass[10pt,handout]{beamer}" > $(path)/$(filename)\_handout.Rnw
	awk 'NR>1' $(path)/$(filename).Rnw >> $(path)/$(filename)\_handout.Rnw 	
	Rscript -e "knitr::knit2pdf(input = '$(path)/$(filename)_handout.Rnw', output = '$(path)/$(filename)_handout.tex', compiler = 'xelatex')"
	#pdfunite $(OUTPUT)_handout.pdf PoissonAndExtraPoissonVariation_handout.pdf $(OUTPUT)_handout_JH.pdf
  
slides:
	echo "\documentclass[10pt]{beamer}" > $(path)/$(filename)\_slides.Rnw
	awk 'NR>1' $(path)/$(filename).Rnw >> $(path)/$(filename)\_slides.Rnw 	
	Rscript -e "knitr::knit2pdf(input = '$(path)/$(filename)_slides.Rnw', output = '$(path)/$(filename)_slides.tex', compiler = 'xelatex')"
	#pdfunite $(OUTPUT)_slides.pdf PoissonAndExtraPoissonVariation.pdf $(OUTPUT)_slides_JH.pdf
