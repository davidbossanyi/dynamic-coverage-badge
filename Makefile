.DEFAULT_GOAL := show-help
current_directory := ${CURDIR}

.PHONY: show-help
# See <https://gist.github.com/klmr/575726c7e05d8780505a> for explanation.
## This help screen
show-help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)";echo;sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## //;td" -e"s/:.*//;G;s/\\n## /---/;s/\\n/ /g;p;}" ${MAKEFILE_LIST}|LC_ALL='C' sort -f|awk -F --- -v n=$$(tput cols) -v i=29 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"%s%*s%s ",a,-i,$$1,z;m=split($$2,w," ");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;printf"\n%*s ",-i," ";}printf"%s ",w[j];}printf"\n";}'

.PHONY: test
## Run all tests
test: test-unit test-integration

.PHONY: test-unit
## Run unit tests
test-unit:
	poetry run pytest -m "not integration" --cov=.

.PHONY: test-integration
## Run integration tests
test-integration:
	poetry run pytest -m "integration" --cov=. --cov-append

.PHONY: lint
## Lint the project (and fix)
lint:
	poetry run pre-commit run --all-files

.PHONY: init
## Initialize the project
init:
	poetry install && poetry run pre-commit install

.PHONY: coverage
## View the test coverage report
coverage:
	coverage html && python -m webbrowser -t $(current_directory)/htmlcov/index.html
