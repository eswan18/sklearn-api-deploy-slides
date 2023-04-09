IMAGESIN=$(wildcard notebooks/images/*)
IMAGESOUT=$(patsubst notebooks/%,slides/%,$(IMAGESIN))
NBFILES=$(wildcard notebooks/*.ipynb)
HTMLFILES=$(patsubst notebooks/%.ipynb,slides/%.slides.html,$(NBFILES))

slides: html css

images: slides/images $(IMAGESOUT)

css: styles.css
	cp styles.css slides/

slides/images:
	mkdir -p slides/images

$(IMAGESOUT): slides/images/%: notebooks/images/%
	cp -a $< $@

html: images $(HTMLFILES) custom-template.html.j2 slides/index.html

$(HTMLFILES): slides/%.slides.html: notebooks/%.ipynb
	bash scripts/generate_slides.sh $<

slides/index.html:
	cp index.html slides/

clean:
	rm -rf slides/
