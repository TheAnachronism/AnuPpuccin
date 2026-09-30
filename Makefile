BUN ?= bun
SASS ?= $(BUN) x --bun sass
SASSFLAGS := --no-source-map --no-charset

.PHONY: build
build: ## Build CSS
	$(SASS) src/base.scss theme.css $(SASSFLAGS)

.PHONY: snippets
snippets: ## Build CSS for snippets
	$(SASS) $(SASSFLAGS) \
		snippets/src/custom-background.scss:snippets/custom-background.css \
		snippets/src/custom-rainbow-colors.scss:snippets/custom-rainbow-colors.css \
		snippets/src/extended-colorschemes.scss:snippets/extended-colorschemes.css \
		snippets/src/floating-search-bar.scss:snippets/floating-search-bar.css \
		snippets/src/floating-status-bar.scss:snippets/floating-status-bar.css \
		snippets/src/its-frontmatter.scss:snippets/its-frontmatter.css \
		snippets/src/minimal-cards.scss:snippets/minimal-cards.css \
		snippets/src/notion-cards.scss:snippets/notion-cards.css

.PHONY: help
help: ## Display help
	@awk -F ':|##' '/^[^\t].+?:.*?##/ {printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF}' $(MAKEFILE_LIST) | sort
