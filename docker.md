# DOCKER

## Delete unsused images

```bash
docker system prune
```

## Delete all images

```bash
docker system prune -a
```

## Images folder

```bash
/var/lib/docker/overlay2
```

## Launch

### Install and launch image

```bash
sudo docker run it -rm -p 12345:80 -d wordpress
```

* -d: detach (background)
* -rm: delete container when stopped
* -it: interactive mode

### List all containers

```bash
sudo docker ps -a
```

### Start / Stop / rm

```bash
sudo docker start [id]
sudo docker stop [id]
sudo docker rm [id]
```

## Docker compose

### Update
```bash
docker-compose pull
docker-compose up -d --remove-orphans
docker image prune
```

## Synology

### Update

1. Go to Registry and download new image (mostly the “latest” version)
2. Go to Container, select the container you need to update and stop it
3. From Actions menu select “Clear/Reset”
4. Start the container again