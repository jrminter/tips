RMDFILE=automater

all: $(RMDFILE).html

$(RMDFILE).html :
	Rscript -e "require(knitr); require(markdown); knit('$(RMDFILE).rmd', '$(RMDFILE).md'); markdownToHTML('$(RMDFILE).md', '$(RMDFILE).html', options=c('use_xhtml', 'base64_images'))"

clean :
	rm -rf *.md
