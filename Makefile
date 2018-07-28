
SRC=$(shell find . -type f -name '*.org')

.PHONY: all
# emacs adds its own caching
all:
	mkdir -p export
	emacs --batch -l build/publish.el

.PHONY: clean
clean:
	rm -rf export
