cpress
======

A set of makefiles and scripts to build html, pdf, and epub files from Markdown source.

## Prerequisites ##

Right now, cpress has only been tested on a Mac, running Lion.  You also need a few programs installed and running in your PATH before using cpress.

* Multimarkdown - http://fletcherpenney.net/multimarkdown/
* wkhtmltopdf - http://code.google.com/p/wkhtmltopdf/
* Calibre - http://calibre-ebook.com/

## Usage ##

To test that things are working, clone this repo and run make. This Should make the lorem_ipsum.html sample.

To use cpress in your  own projects, create your own makefile and use this template:

```
HEADER_FILE := header.md
CPRESS_DIR := ../cpress/

all: test.html

include $(CPRESS_DIR)cpress.mak
```

You need to create a header.md which has some directives such as author, title, etc. Set the location of this via `HEADER_FILE`. There is a sample file you can use as a template. You also need to define the relative path to the cpress.mak install from your Makfile via  `CPRESS_DIR `
