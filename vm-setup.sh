# Install all dependencies to run fastchat on a (virtual) Ubuntu machine with an Nvidia graphiscs card 
curl https://pyenv.run | bash

echo '
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Restart your shell for the changes to take effect.

# Load pyenv-virtualenv automatically by adding
# the following to ~/.bashrc:

eval "$(pyenv virtualenv-init -)"
' >> $HOME/.bashrc 

curl -sSL https://install.python-poetry.org | python3 -

echo '
export PATH="$HOME/.local/bin:$PATH"
' >> $HOME/.bashrc

source $HOME/.bashrc

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-12-2

echo '
export PATH=/usr/local/cuda-12.2/bin${PATH:+:${PATH}}
' >> $HOME/.bashrc
