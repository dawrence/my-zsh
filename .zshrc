
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

source ~/zsh-git-prompt/zshrc.sh

PROMPT='%B%m%~%b$(git_super_status) %# '

# git functions
# ==============================================================================
# status
gs() {
	git status
}

# add --all
ga() {
	git add --all
}

# commit
gcm() {
	git commit -m $1
}
# checkout
gch() {
	git checkout $1
}
# checkout new one
gchb(){
	git checkout -b $1
}

# frequently used Git operations
# ==============================================================================
# Checkout and pull with master. Stash any changes
gmaster() {
	git stash
	git checkout master
	git pull origin master
}

# Create a new branch, and sync with master. Stash any changes and 
# clean
gnew () {
	git stash
	git checkout master
	git pull origin master
	git checkout -b $1
}

#cleans shit. Careful
gclean () {
	git checkout -- .
	git clean -df
}

# Read Access
# ==============================================================================
sk() {
	cd ~/Projects/SK/Projects/
}

# go to mrskin
mrskin() {
	cd ~/Projects/SK/Projects/mr-skin-rails
}
# go to naked news
nn() {
	cd ~/Projects/SK/Projects/naked-news
}

# go to mrman
mrman() {
	cd ~/Projects/SK/Projects/mr-man-app
}
# ==============================================================================
# Personal things

personal() {
	cd ~/Projects/Personal
}

myzsh() {
	cd ~/Projects/Personal/my-zsh/
}

#reload zsh
reload() {
	. ~/.zshrc
}
