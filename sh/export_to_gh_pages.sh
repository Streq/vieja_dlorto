#!/bin/bash
green=`tput setaf 2`
reset=`tput sgr0`
print_message(){
	echo "${green}$1${reset}"
}

print_message "exporting HTML5"
godot --export "HTML5" --quiet

print_message "stashing changes"
git add .
git stash
git checkout gh-pages || exit "$?"

print_message "running git rm -rf on directory (to avoid merge conflicts)"
git rm -rf .

print_message "recovering .gitignore"
git checkout HEAD -- .gitignore

print_message "applying stash"
git stash pop

print_message "committing changes"
git commit -m"release"
git push
git checkout main