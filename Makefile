.PHONY: hadolint docker-build docker-run docker-push ci

BINARY = wisecow
VERSION ?= 1.0.0

hadolint:
	hadolint Dockerfile

docker-build:
	docker build -t nsahil992/wisecow:$(VERSION) .

docker-run:
	docker run -p 4499:4499 nsahil992/wisecow:$(VERSION)

docker-push:
	docker push nsahil992/wisecow:$(VERSION)

ci: hadolint docker-build docker-push