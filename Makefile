#
# These two variables must be defined before including cpress.mak
#
HEADER_FILE := header.md
CPRESS_DIR := ./

# Include cpress.mak
include $(CPRESS_DIR)cpress.mak

all: lorem_ipsum.html

