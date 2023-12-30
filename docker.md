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
```
/var/lib/docker/overlay2
```

## Launch
###Install and launch image
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