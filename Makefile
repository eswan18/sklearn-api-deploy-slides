IMAGESIN=$(wildcard notebooks/images/*)
IMAGESOUT=$(patsubst notebooks/%,slides/%,$(IMAGESIN))
NBFILES=$(wildcard notebooks/*.ipynb)
HTMLFILES=$(patsubst notebooks/%.ipynb,slides/%.slides.html,$(NBFILES))
DIFFFILES=$(wildcard diffs/*.html)

.PHONY:
	images clean html index diffs

slides: html slides/styles.css

images: slides/images $(IMAGESOUT)

slides/styles.css: styles/styles.css
	cp styles/styles.css slides/

slides/images:
	mkdir -p slides/images

$(IMAGESOUT): slides/images/%: notebooks/images/%
	cp -a $< $@

html: images $(HTMLFILES) index diffs

$(HTMLFILES): slides/%.slides.html: notebooks/%.ipynb styles/custom-template.html.j2 
	bash scripts/generate_slides.sh $<

index: slides/index.html

diffs: slides/diffs

slides/diffs: $(DIFFFILES)
	cp -r diffs slides/
	
slides/index.html: styles/index.html
	cp styles/index.html slides/

clean:
	rm -rf slides/

