PROJECT=datepicker
SRC=index.js
CSS=node_modules/popover-component/node_modules/component-tip/tip.css \
	node_modules/code42day-calendar/lib/calendar.css \
	datepicker.css

all: check compile

check: lint

compile: build/build.js build/build.css

build:
	mkdir -p $@

build/build.css: $(CSS) | node_modules build
	cat $^ > $@

build/build.js: $(SRC) | node_modules build
	browserify --require ./index.js:$(PROJECT) --outfile $@

.DELETE_ON_ERROR: build/build.js

$(CSS): | node_modules

node_modules: package.json
	npm install

lint:
	jshint $(SRC)

clean:
	rm -fr build node_modules

.PHONY: clean lint check all compile
