# Docker compose on Debian 11 ARM

## DOCKER

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

## PIP3

```bash
sudo apt update
sudo apt -y upgrade
sudo apt update
sudo apt install python3-venv python3-pip
```

## DOCKER-COMPOSE

```bash
pip3 install docker-compose
```

## WORDPRESS

```bash
mkdir my_wordpress
cd my_wordpress
```

### docker-compose.yml

```yml
version: "3.9"
    
services:
  db:
    image: mariadb:latest
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: my_root_password
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: my_wordpress_password
    
  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    volumes:
      - wordpress_data:/var/www/html
    ports:
      - "8000:80"
    restart: always
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: my_wordpress_password
volumes:
  db_data: {}
  wordpress_data: {}
```

## LAUNCH

```bash
docker-compose up -d
```

## DELETE

```bash
docker-compose down --volumes
```

## MYSQL / MARIADB

On ARM, using MySQL in docker-compose.yml (`image: mysql:latest`) results in the following error:  
`ERROR: no matching manifest for linux/arm64/v8 in the manifest list entries`  
This is because there is no arm64 version of MySQL.  
Instead, use mariadb: `image: mariadb:latest`