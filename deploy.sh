docker build -t killer1987v/multi-client:latest -t killer1987v/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t killer1987v/multi-server:latest -t killer1987v/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t killer1987v/multi-worker:latest -t killer1987v/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push killer1987v/multi-client:latest
docker push killer1987v/multi-server:latest
docker push killer1987v/multi-worker:latest

docker push killer1987v/multi-client:$SHA
docker push killer1987v/multi-server:$SHA
docker push killer1987v/multi-worker:$SHA

kubectl apply -f K8s

kubectl set image Deployment/multi-client multi-client-container=multi-client:$SHA
kubectl set image Deployment/multi-server multi-server-container=multi-server:$SHA
kubectl set image Deployment/multi-worker multi-worker-container=multi-worker:$SHA