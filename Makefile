# Makefile for CivicTech.ca GitHub Pages Migration Evaluation

JEKYLL=bundle exec jekyll
SCRIPTS_DIR=./_scripts

prepare:
	build install
	generate

# Start Jekyll server
serve:
	prepate
	$(JEKYLL) serve

# Start Jekyll server with incremental regeneration
serve-incremental:
	prepare
	$(JEKYLL) serve --incremental

# Generate category and tag data
generate-data:
	$(SCRIPTS_DIR)/generate_category_data.sh
	$(SCRIPTS_DIR)/generate_tag_data.sh

# Generate category and tag pages
generate-pages:
	$(SCRIPTS_DIR)/generate_category_pages.sh
	$(SCRIPTS_DIR)/generate_tag_pages.sh

generate-thumbnails:
	$(SCRIPTS_DIR)/thumbnail_sizes.sh

# Generate all content
generate: generate-data generate-pages generate-thumbnails

# Update Git submodules
update:
	git submodule update --remote --merge

# Clean Jekyll output
clean:
	rm -rf _site .jekyll-metadata

.PHONY: all clone bundle serve serve-incremental generate-data generate-pages generate update-submodules clean
