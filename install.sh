#!/bin/bash

sudo apt-get update

sudo apt-get install -y git build-essential libssl-dev

# Install Docker
# https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# https://docs.docker.com/engine/install/linux-postinstall/
sudo groupadd docker

sudo usermod -aG docker $USER

newgrp docker

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

pyenv install 3.10
pyenv install 3.11

pyenv global 3.11

curl -sSL https://install.python-poetry.org | python3 -

# Install Nvm and Nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

source ~/.bashrc

# Intall current Nodejs LTS version
nvm install 18

# Install Yarn
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

# Install Postman
sudo snap install postman


