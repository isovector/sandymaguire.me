wcst:
	stack install
	wcst

test:
	stack install
	rm -r _live/we-can-solve-this || return 0
	wcst clean
	wcst build
	mv _site _live/we-can-solve-this

deploy:
	# @./scripts/cron.sh
	@./scripts/deploy.sh

publish:
	@./scripts/publish.sh

newpost:
	@./scripts/newpost.sh

clippings:
	flip -ub site/clippings/*

book-reviews:
	gr -k OeZYlIV1M4a6ouACnYuSg show read 14945161

.PHONY: deploy test newpost clippings book-reviews

