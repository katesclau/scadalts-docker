# scadalts-docker #
Docker image creation kit

## How to build ##
1. clone this repo
  `git clone https://github.com/katesclau/scadalts-docker.git`

1. add mysql-connector-java-LATEST-bin.jar to the folder
  https://dev.mysql.com/downloads/connector/j/

1. build . -t <USER>/scadalts-dev

## How to run ##
`docker run -it -e DOCKER_HOST_IP=127.0.0.1 -p 8080:8080 katesclau/scadalts-dev /tmp/start.sh`

check http://localhost:8080/ScadaBR (old UI) & http://localhost:8080/ScadaLTS (New UI, WIP)

__initial login => admin:admin__

## Is this on Docker Hub? ##
Yes - pull with
`docker pull katesclau/scadalts-dev`

## Visit ScadaLTS project ##
https://github.com/SCADA-LTS & www.scada-lts.org

Tagged image versions are released on katesclau/scadalts-dev:VERSION after a release on
https://github.com/SCADA-LTS/Scada-LTS/releases
