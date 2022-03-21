VERSION_FILE := version.txt

setup init:
	pip install -r requirements/base.txt -r requirements/dev.txt

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