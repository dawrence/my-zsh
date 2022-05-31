source ~/zsh-git-prompt/zshrc.sh
source /Users/dj/.dokta_functions

eval "$(rbenv init -)"

export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
export PATH="/usr/local/Cellar/mongodb-community@4.2/4.2.8/bin:$PATH"
PROMPT='%B%m%~%b$(git_super_status) %# '

ssh-add ~/.ssh/dagudelo
ssh-add ~/.ssh/dj

alias dcd='docker-compose -f dcd.yml'
alias dcp='docker-compose run web'
alias dct='docker-compose -f dct.yml'
alias rake='noglob rake'

alias dev-cluster="kubectl config use-context arn:aws:eks:us-west-2:794844780483:cluster/inspire"
alias stage-cluster="kubectl config use-context arn:aws:sts::543886297237:cluster/inspire"
alias prod-cluster="kubectl config use-context arn:aws:eks:us-west-2:266151418910:cluster/inspire"

export TGLN_API_DB_NAME=OAS
export TGLN_API_DB_HOST=localhost
export TGLN_API_ALLOCATION_SERVICE_ENDPOINT=http://localhost:8000
export TGLN_API_UPLOAD_STORE=S3
export TGLN_API_S3_ACCESS_ID=minio
export TGLN_API_S3_SECRET_ACCESS_KEY=minio123
export TGLN_API_S3_REGION=1
export TGLN_API_S3_ENDPOINT=http://localhost:9000/
export TGLN_API_S3_BUCKET_NAME=uploads
# Variables needed for the docker compose file.
export OAS_DOCKER_COMPOSE_IDIOM_VERSION=v0.1.0
export OAS_DOCKER_COMPOSE_ALLOCATION_VERSION=v10.10.1
export OAS_DOCKER_COMPOSE_DATABASE_NAME=OASv820
export OAS_DOCKER_COMPOSE_HOST_IP=192.168.2.51
export MINIO_DATA_DIR=/home/sunspar/minio_data
# SSRS Integration
export TGLN_API_REPORTING_SERVICE_HOST='http://52.233.17.129/ReportServer?'
export TGLN_API_REPORTING_SERVICE_AUTH_ACCOUNT='cmVwb3J0dmlld2VyOmRnM1RFemk2aEJCN0NBdA=='
export TGLN_API_ALLOCATION_SERVICE_ENDPOINT=http://localhost:8000
# export OAS_DOCKER_COMPOSE_HOST_IP=192.168.0.18
# export OAS_DOCKER_COMPOSE_DATABASE_NAME=OAS
# export OAS_MONGODB_URL="mongodb://admin:admin@hostmachine/${OAS_DOCKER_COMPOSE_DATABASE_NAME}?authSource=admin"

# QA  TEST
export OAS_DOCKER_COMPOSE_HOST_IP=138.197.130.179
export OAS_DOCKER_COMPOSE_DATABASE_NAME=tgln_qa_production
export OAS_MONGODB_URL="mongodb+srv://oats_qa_production:AZQ8LcC2cgUAZN3WvYNWvOibMu5HgwRRsVcmNsq415We8W8pPySEKmPzYQo5JN2@tgln-oats-dev.sw9w6.mongodb.net/oats_qa_production"

# UAT ALLOCATION TEST
# export OAS_DOCKER_COMPOSE_HOST_IP=138.197.130.179
# export OAS_DOCKER_COMPOSE_DATABASE_NAME=oats_allocationtest_production
# export OAS_MONGODB_URL="mongodb+srv://oats_allocationtest_api:tZXtBwpGfiG0ZNuA1bLhvBR4A62OPJ7JkoV3YDHhwLMfJd6S7Gax0TbG9lrooGz@oats-allocationtest.sw9w6.mongodb.net/oats_allocationtest_production?retryWrites=false&w=majority&authSource=admin"


#SHORE commands

shore_allocation_service(){
  source docker-compose.env && docker-compose up
}

shore_server() {
  bundle exec rails s -p 5000
}

shore_console(){
  bundle exec rails c
}

shore_spec(){
  bundle exec rspec $1
}

shore_suite(){
  bundle exec rspec spec
}

# DOCKER

docker_stop_all(){
  docker stop $(docker ps -a -q)
}

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

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

gu(){
  git pull origin $(_git_branch_name)
}

gp(){
	git push origin $(_git_branch_name)
}

gpf(){
  git push -f origin $(_git_branch_name)
}

## huntclub deployments
##

hc_deploy_staging(){
  git pull huntclub-staging main && git push huntclub-staging develop:main
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

# Checkout and pull with main because master is racist (wtf).
gmain() {
  git checkout main
  git pull origin main
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

# ==============================================================================
# Personal things
rubofuck() {
	pronto run
}

killemall(){
  lsof -t -i tcp:5000 | xargs kill
  lsof -t -i tcp:8982 | xargs kill
  lsof -t -i tcp:6379 | xargs kill
}

# kube_rake api-utility-management migration:MIGRATION
function kube_rake () {
  if [ -z "$2" ]
  then
    echo "Missing service name"
    return
  fi
  PODS=$(kubectl get pods | grep $1)
  POD=${PODS%% *}
  echo "kubectl exec -it $POD /src/bin/rake $2"
  kubectl exec -it $POD /src/bin/rake $2
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dj/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dj/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dj/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dj/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
