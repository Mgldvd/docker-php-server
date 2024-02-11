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
	@compose_files=("compose.yml" "docker-compose.yml" "compose.yaml" "docker-compose.yaml"); \
	for file in "$${compose_files[@]}"; do \
		if [ -f "$$file" ]; then \
			file_content=$$(< "$$file"); \
			break; \
		fi; \
	done; \
	if [ -z "$$file_content" ]; then \
		echo "Error: No compose file found"; \
		exit 1; \
	fi; \
	ports=$$(awk '/ports:/{getline; print $$2}' <<< "$$file_content"); \
	IFS=: read -r port1 port2 <<< "$$ports" || { echo "Error: Invalid port format"; exit 1; }; \
	echo; \
	echo -e "\033[32m▎ \033[0m URL:  \033[32mhttp://localhost:$$port1\033[0m"

stop: ## Stop container
	docker compose stop

down: ## Remove contanier
	docker compose stop
	docker compose rm -f
	docker compose down --remove-orphans

build: ## Edit Dockerfile and rebuild container
	docker compose watch


url:
	@compose_files=("compose.yml" "docker-compose.yml" "compose.yaml" "docker-compose.yaml"); \
	for file in "$${compose_files[@]}"; do \
		if [ -f "$$file" ]; then \
			file_content=$$(< "$$file"); \
			break; \
		fi; \
	done; \
	if [ -z "$$file_content" ]; then \
		echo "Error: No compose file found"; \
		exit 1; \
	fi; \
	ports=$$(awk '/ports:/{getline; print $$2}' <<< "$$file_content"); \
	IFS=: read -r port1 port2 <<< "$$ports" || { echo "Error: Invalid port format"; exit 1; }; \
	echo; \
	echo -e "\033[32m▎ \033[0m URL:  \033[32mhttp://localhost:$$port1\033[0m"

