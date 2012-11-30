# cpress - Main cpress makefile. Include this in your project-specific projects
#

PDF_OPTS := --page-width 5.5in --page-height 8.5in --margin-top 0.25in --margin-bottom 0.25in --margin-left 0.25in --margin-right 0.25in --load-error-handling ignore
EPUB_OPTS := --no-default-epub-cover --base-font-size 12 --keep-ligatures --margin-top 10.0 --margin-bottom 10.0 --margin-left 10.0 --margin-right 10.0 
NOVELMDCSS_FILE := $(CPRESS_DIR)novel-style.mdcss
EPUBMDCSS_FILE  := $(CPRESS_DIR)epub-style.mdcss

lorem_ipsum.html: lorem_ipsum.md

%.base64: $(CPRESS_DIR)%.png $(CPRESS_DIR)cpress.mak
	base64 $< | sed -e "s/.\{76\}/&~/g"  | tr '~' '\n' | tr -d ' ' > $@
	#base64 $< $@

%.html: %.md $(HEADER_FILE) $(NOVELMDCSS_FILE)
	cat $(HEADER_FILE) > tmp
	cat $(NOVELMDCSS_FILE) >> tmp
	cat $< >> tmp
	multimarkdown -o $@ tmp
	rm -f tmp

%.pdf: %.html
	wkhtmltopdf $(PDF_OPTS) $< $@

$(CPRESS_DIR)%.mdcss: $(CPRESS_DIR)css/%.css
	echo HTML Header: \<style type=\"text/css\" media=\"all\" \> > $@
	cat $< | tr -d '\n' >> $@
	echo \</style\> >> $@

%.epub: %.html
	   ebook-convert $< $@ $(EPUB_OPTS)


clean:
	rm -f *.pdf
	rm -f *.html
	rm -f $(CPRESS_DIR)*.mdcss
	rm -f *.epub
	rm -f $(CPRESS_DIR)*.base64
