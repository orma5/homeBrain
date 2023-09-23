#!/bin/sh
set -x
echo "-----------------------------------"
echo "Shutting down docker containers"
docker-compose --env-file /home/master/homeBrain/.env -f /home/master/homeBrain/common.yml -p common down
docker-compose --env-file /home/master/homeBrain/.env -f /home/master/homeBrain/smarthome.yml -p smarthome down
echo "-----------------------------------"
echo "Shut down complete"
echo "-----------------------------------"
echo "Pulling latest images"
docker images --format "{{.Repository}}:{{.Tag}}" | grep :latest | xargs -L1 docker pull
echo "-----------------------------------"
echo "Images updated"
echo "-----------------------------------"
echo "Starting containers"
docker-compose --env-file /home/master/homeBrain/.env -f /home/master/homeBrain/common.yml -p common up -d
docker-compose --env-file /home/master/homeBrain/.env -f /home/master/homeBrain/smarthome.yml -p smarthome up -d
echo "-----------------------------------"
echo "update complete, remove unused images"
docker image prune -f
echo "DONE!"
