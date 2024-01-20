SHELL := /bin/bash

.SILENT: test up stop pull update rebuild remove
.PHONY: test up stop pull update rebuild remove
# .RECIPEPREFIX +=
# .RECIPEPREFIX := $(.RECIPEPREFIX)

help:
	@grep -E '^[1-9a-zA-Z_-]+:.*?## .*$$|(^#--)' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m %-24s\033[0m %s\n", $$1, $$2}' \
	| sed -e 's/\[32m #-- /[33m/'

# ####

#--
#--  PHP Server - commands

up: ## Run container
	docker compose up -d
	echo
	echo
	echo -e "\033[32m▎ \033[0m URL:  \033[32mhttp://localhost:22222\033[0m"

stop: ## Stop container
	docker compose stop

down: ## Remove contanier
	docker compose stop
	docker compose rm -f
	docker compose down --remove-orphans

build: ## Edit Dockerfile and rebuild container
	docker compose watch