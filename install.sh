#!/bin/bash

sudo apt-get update

sudo apt-get install -y git build-essential libssl-dev

# Install Docker
# https://docs.docker.com/engine/install/ubuntu/#installation-methods

sudo apt-get install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

# Download and install latest docker package

curl 'https://desktop.docker.com/linux/main/amd64/docker-desktop-4.12.0-amd64.deb' --output /tmp/docker-desktop-4.12.0-amd64.deb

sudo apt install -y /tmp/docker-desktop-4.12.0-amd64.deb 

systemctl --user enable docker-desktop


# Intall Pyenv, Python 3.XX & Poetry
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment

sudo apt-get install -y make zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev


curl https://pyenv.run | bash

# Add pyenv init scripts to .bashrc

echo 'export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"' >> ~/.bashrc 

echo 'export PATH="/home/asanka/.local/bin:$PATH"'>> ~/.bashrc

source ~/.bashrc

pyenv install 3.10.7

pyenv global 3.10.7

sudo apt-get install -y python-is-python3

curl -sSL https://install.python-poetry.org | python3 -

# Install Nvm and Nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

source ~/.bashrc

# Intall current Nodejs LTS version
nvm install 16

npm install --global yarn

# Install golang 
curl -L https://go.dev/dl/go1.19.4.linux-amd64.tar.gz --output /tmp/go1.19.4.linux-amd64.tar.gz 

tar -C /usr/local -xzf /tmp/go1.19.4.linux-amd64.tar.gz

echo 'export PATH=$PATH:/usr/local/go/bin'>> ~/.bashrc


# Install Postgres and create default user
sudo apt install -y postgresql postgresql-contrib

sudo systemctl start postgresql.service

sudo -u postgres createuser "$USER" --superuser

# Remove no longer required packages 
sudo apt autoremove -y
