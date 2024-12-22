# Install pwncat-cs on Kali with python >= 3.12

```bash
sudo apt update
sudo apt install build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl git libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y
sudo apt install python3 python3-pip -y
```

```bash
curl https://pyenv.run | bash
```

```bash
cat <<'EOF' >> ~/.bashrc
export PATH="${HOME}/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF
source ~/.bashrc
```

```bash
pyenv install 3.11.0
```

```bash
pyenv virtualenv 3.11.0 pwncat-cs
```

```bash
pyenv activate pwncat-cs
```

```bash
pip install pwncat-cs
```