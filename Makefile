clean:
	find . -name "*.pyc" -type f -delete
	find . -name "tags" -type f -delete

update:
	git pull
	git submodule update --init
