# cpress - Main cpress makefile. Include this in your project-specific projects
#

PDF_OPTS := --page-width 5.5in --page-height 8.5in --margin-top 0.25in --margin-bottom 0.25in --margin-left 0.25in --margin-right 0.25in --load-error-handling ignore
EPUB_OPTS := --no-default-epub-cover --base-font-size 12 --keep-ligatures --margin-top 10.0 --margin-bottom 10.0 --margin-left 10.0 --margin-right 10.0 
NOVELMDCSS_FILE ?= $(CPRESS_DIR)novel-style.mdcss
EPUBMDCSS_FILE  ?= $(CPRESS_DIR)epub-style.mdcss

lorem_ipsum.html: lorem_ipsum.md

#
# Handy command to generate base64 encoded version of a png
#
$(CPRESS_DIR)images/%.base64: $(CPRESS_DIR)%.png $(CPRESS_DIR)cpress.mak
	base64 $< | sed -e "s/.\{76\}/&~/g"  | tr '~' '\n' | tr -d ' ' > $@
	#base64 $< $@

%.html: %.md $(HEADER_FILE) $(NOVELMDCSS_FILE) $(CPRESS_DIR)cpress.mak
	cat $(HEADER_FILE) > tmp
	cat $(NOVELMDCSS_FILE) >> tmp
	cat $< >> tmp
	multimarkdown -o $@ tmp
	rm -f tmp

%.pdf: %.html $(CPRESS_DIR)cpress.mak
	wkhtmltopdf $(PDF_OPTS) $< $@

$(CPRESS_DIR)%.mdcss: $(CPRESS_DIR)css/%.css $(CPRESS_DIR)cpress.mak
	echo HTML Header: \<style type=\"text/css\" media=\"all\" \> > tmp.mdcss
	cat $< >> tmp.mdcss
	echo \</style\> >> tmp.mdcss
	cat tmp.mdcss | tr -d '\n' > $@
	echo >> $@
	rm -f tmp.mdcss


%.epub:  %.md $(HEADER_FILE) $(EPUBMDCSS_FILE) $(CPRESS_DIR)cpress.mak
	cat $(HEADER_FILE) > tmp
	cat $(EPUBMDCSS_FILE) >> tmp
	cat $< >> tmp
	multimarkdown -o tmp.html tmp
	rm -f tmp
	ebook-convert tmp.html $@ $(EPUB_OPTS)
	rm -f tmp.html

clean:
	rm -f *.pdf
	rm -f *.html
	rm -f $(CPRESS_DIR)*.mdcss
	rm -f *.epub
	rm -f $(CPRESS_DIR)*.base64
	rm -f $(CPRESS_DIR)images/*.base64
