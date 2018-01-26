wcst:
	stack install
	wcst clean
	wcst watch

test:
	stack install
	rm -r _live/we-can-solve-this || return 0
	wcst clean
	wcst build
	mv _site _live/we-can-solve-this

deploy:
	@./scripts/deploy.sh

publish:
	@./scripts/publish.sh

newpost:
	@./scripts/newpost.sh

clippings:
	flip -ub site/clippings/*

.PHONY: deploy test newpost clippings

