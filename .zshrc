
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

source ~/zsh-git-prompt/zshrc.sh

PROMPT='%B%m%~%b$(git_super_status) %# '

ssh-add ~/.ssh/dagudelo

plugins=(git ssh-agent)
# SSH

sshify() {
  cat ~/.ssh/dagudelo.pub | ssh $1 'cat >> ~/.ssh/authorized_keys'
}
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
gm() {
	git commit -m $1
}
# checkout
gk() {
	git checkout $1
}
# checkout new one
gb(){
	git checkout -b da-$1
}

gr(){
	git branch -m $1 $2
}

gp(){
	git push origin $(_git_branch_name)
}

# Vendor
# ==============================================================================
# get the name of the branch we are on
_git_repo_name() { 
    gittopdir=$(git rev-parse --git-dir 2> /dev/null)
    if [[ "foo$gittopdir" == "foo.git" ]]; then
        echo `basename $(pwd)`
    elif [[ "foo$gittopdir" != "foo" ]]; then
        echo `dirname $gittopdir | xargs basename`
    fi
}
_git_branch_name() {    
    git branch 2>/dev/null | awk '/^\*/ { print $2 }'
}    
 _git_is_dirty() { 
   git diff --quiet 2> /dev/null || echo '*'
}

# frequently used Git operations
# ==============================================================================
# Checkout and pull with master.
gmaster() {
	git checkout master
	git pull origin master
}

# Create a new branch, and sync with master. Stash any changes and 
# clean
gnew() {
	git checkout master
	git pull origin master
	git checkout -b $1
}

#cleans shit. Careful
gclean() {
	git checkout -- .
	git clean -df
}

#undo changes.
gundo() {
	git checkout -- .
}
# WIP
gpushall() {
	if $(_git_branch_name) == 'master'; then
		echo 'Fuck off, no master pushes'
		return -1
	else
		git add --all
		git commit -m $1
		git push origin _git_branch_name
	fi
}

branches() {
	git branch -l | grep da-
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

# go to fleshbot
fleshbot() {
	cd ~/Projects/SK/Projects/fleshbot-rails
}
# ==============================================================================
# Personal things
rubofuck() {
	pronto run
}


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

sslstart(){
	thin start -p 3001 --ssl --ssl-key-file ~/.ssl/server.key --ssl-cert-file ~/.ssl/server.crt
}