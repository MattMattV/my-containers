GREEN='\033[0;32m'
RESET='\033[0;0m'

echo "${GREEN}CLEANING${RESET}"
docker-compose stop
docker-compose rm -f


echo "${GREEN}rm old binaries${RESET}"
rm load-balancer/load-balancer
#rm middleware/middleware

echo "${GREEN}Compiling load-balancer${RESET}"
go build -ldflags "-linkmode external -extldflags -static" -o /home/mvion/dockerData/load-balancer/load-balancer /home/mvion/goWorkspace/src/github.com/Mistermatt007/load-balancer/load-balancer.go
echo "${GREEN}done${RESET}"
#echo "${GREEN}Compiling middleware${RESET}"
#go build -ldflags "-linkmode external -extldflags -static" -o /home/mvion/dockerData/middleware/middleware /home/mvion/goWorkspace/src/github.com/Mistermatt007/middleware/middleware.go
#echo "${GREEN}done${RESET}"


echo "${GREEN}Building load-balancer${RESET}"
sudo docker build -t load-balancer load-balancer/
#echo "${GREEN}Building middleware${RESET}"
#sudo docker build -t middleware middleware/

echo "${GREEN}Booting up !${RESET}"
docker-compose up -d
