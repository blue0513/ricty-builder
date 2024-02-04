.PHONY: clean download build install
.PHONY: check force-clean

clean:
	mkdir -p dist
	cd dist && rm -f *Ricty*.ttf

force-clean:
	rm -rf dist

download: clean
	# ricty scripts
	cd dist && wget https://rictyfonts.github.io/files/ricty_generator.sh && chmod +x ricty_generator.sh
	cd dist && wget https://rictyfonts.github.io/files/os2version_reviser.sh && chmod +x os2version_reviser.sh
	# migu-1m
	cd dist && wget "https://github.com/itouhiro/mixfont-mplus-ipa/releases/download/v2020.0307/migu-1m-20200307.zip" --timeout 120
	cd dist && unzip migu-1m-20200307.zip
	# font-forge
	brew install fontforge
	# inconsolata
	@echo "Please access & download zip: https://fonts.google.com/download?family=Inconsolata"
	@echo "Then: cd dist && unzip Inconsolata.zip"

build: clean
	cd dist && ./ricty_generator.sh -n "Ao" -d "07DZlrz*+-=<>~" auto
	cd dist && ./os2version_reviser.sh *Ricty*.ttf

install:
	cp dist/RictyAoDiscord*.ttf $(HOME)/Library/Fonts/

check:
	fc-list : family | grep -i ricty
