#!/bin/sh
clear
minikube start --driver=virtualbox --extra-config=apiserver.service-node-port-range=1-35000

eval $(minikube docker-env)

export MINIKUBE_IP=`minikube ip`
echo $MINIKUBE_IP > srcs/nginx/srcs/ip
echo $MINIKUBE_IP > srcs/ftps/srcs/ip
echo $MINIKUBE_IP > srcs/mysql/srcs/ip
echo $MINIKUBE_IP > srcs/phpmyadmin/srcs/ip
echo $MINIKUBE_IP > srcs/wordpress/srcs/ip
echo $MINIKUBE_IP > srcs/telegraf/srcs/ip
echo $MINIKUBE_IP > srcs/influxdb/srcs/ip
echo $MINIKUBE_IP > srcs/grafana/srcs/ip

minikube addons enable metrics-server
minikube addons enable dashboard

docker build -t nginx srcs/nginx/ --quiet
docker build -t ftps srcs/ftps/ --quiet
docker build -t mysql srcs/mysql/ --quiet
docker build -t phpmyadmin srcs/phpmyadmin/ --quiet
docker build -t wordpress srcs/wordpress/ --quiet
docker build -t influxdb srcs/influxdb/ --quiet
docker build -t telegraf srcs/telegraf/ --quiet
docker build -t grafana srcs/grafana/ --quiet

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metallb.yaml
kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/ftps.yaml
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/phpmyadmin.yaml
kubectl apply -f srcs/wordpress.yaml
kubectl apply -f srcs/influxdb.yaml
kubectl apply -f srcs/telegraf.yaml
kubectl apply -f srcs/grafana.yaml

rm -f srcs/nginx/srcs/ip
rm -f srcs/ftps/srcs/ip
rm -f srcs/mysql/srcs/ip
rm -f srcs/phpmyadmin/srcs/ip
rm -f srcs/wordpress/srcs/ip
rm -f srcs/influxdb/srcs/ip
rm -f srcs/telegraf/srcs/ip
rm -f srcs/grafana/srcs/ip

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

sleep 15
clear
minikube service list

echo "ssh:"
echo "ssh -p 30022 admin@$(minikube ip)"
echo "ftp:"
echo "open ftp://jan:jan@$(minikube ip)"
