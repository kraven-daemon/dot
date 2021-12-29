#!/usr/bin/env sh

# unpacking some nerd font from the repo

target="${HOME}/.local/share/fonts"

mkdir -p "$target"

# add them here
sauce="SourceCodePro.zip"
monoki="Mononoki.zip"


baseurl="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/"

cd /tmp 2> /dev/null &&
for font in ${sauce} ${monoki}; do
	echo "Downloading ${font} ..."
	curl -L -O "${baseurl}${font}"
	unzip -tq "${font}" && unzip "${font}" -d "${target}"
done
	
