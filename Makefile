VERSION_FILE := version.txt

setup init:
	pip install -r requirements/base.txt -r requirements/dev.txt
	pre-commit install

.PHONY: lint
lint: format

.PHONY: format
format:
	pre-commit run --all-files --show-diff-on-failure

.PHONY: get-version
get-version:
	cat $(VERSION_FILE)

.PHONY: update-version
update-version:
	echo "v`date +"%y.%m.%d"`" > $(VERSION_FILE)

.PHONY: changelog-draft
changelog-draft: update-version $(VERSION_FILE)
	towncrier --draft --name "Docker registry frontend" --version `cat version.txt`

.PHONY: changelog
changelog: update-version $(VERSION_FILE)
	towncrier --name "Docker registry frontend" --version `cat version.txt` --yes
