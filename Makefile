DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR= ==================================================
LESS_FILES = static/less/less-variables.less \
			 static/less/third-party-bootstrap.less \
			 static/less/third-party-font-awesome.less \
			 static/less/base-elements.less \
			 static/less/buttons.less \
			 static/less/layout.less \
			 static/less/responsive-800.less \
			 static/less/responsive-600.less
THIRD_PARTY = static/lib/underscore.js \
		static/lib/json2.js \
		static/lib/jquery.js \
		static/lib/backbone.js \
		static/lib/d3.js \
		static/lib/bootstrap-transition.js \
		static/lib/bootstrap-tooltip.js \
		static/lib/bootstrap-popover.js \
		static/lib/bootstrap-modal.js \
		static/lib/jquery-ui.min.js
less: 
	@echo "\n${HR}"
	@echo "Combining Less Files"
	cat $(LESS_FILES) > static/less/all.less
	@echo "${CHECK} Done"
	@echo "\n${HR}"
	@echo "Compiling CSS"
	@./node_modules/less/bin/lessc static/less/all.less static/css/style-all.css
	@rm static/less/all.less
	@echo "Running Less compiler... ${CHECK} Done"

build:
	@echo "\n${HR}"
	@echo "Running JSHint"
	@echo "${HR}\n"
	@jshint static/script/*[^min].js --config static/script/.jshintrc
	@echo "Running JSHint on javascript...	${CHECK} Done"
	@echo "Compiling Lucid Scripts"
	@cat static/script/namespace.js static/script/facet.js static/script/facet-objects.js static/script/app.js static/script/data-item.js static/script/facet-objects.js static/script/bread-crumb.js static/script/main.js > static/script/build/lucid.js
	@echo "Running uglify"
	@uglifyjs -nc static/script/build/lucid.js > static/script/build/lucid.min.js
	@cat static/script/build/copyright.js | cat - static/script/build/lucid.min.js > temp && mv temp static/script/build/lucid.min.js
	@rm static/script/build/lucid.js
	@echo "Compiling and minifying javascript...	${CHECK} Done"
	@echo "\n${HR}"
	@echo "Files successfully built at ${DATE}."
	@echo "Files: static/css/bootstrap.all.css, static/script/build/lucid.min.js, static/script/libs/all3rd.min.js"
	@echo "${HR}\n"

third:
	@echo "Compiling Third Party JS"
	@cat $(THIRD_PARTY) > static/lib/all3rdjs.js
	@uglifyjs -nc static/lib/all3rdjs.js > static/lib/all3rdjs.min.js
	@rm static/lib/all3rdjs.js

watch:
	echo "Watching less files..."; \
	watchr -e "watch('static/css/.*\.less') { system 'make' }"

watchjs:
	echo "Watching js files..."; \
	watchr -e "watch('static/script/.*\.js') { system 'make' }"
