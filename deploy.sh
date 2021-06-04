docker build -t ogandoe/multi-client:latest -t ogandoe/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ogandoe/multi-server:latest -t ogandoe/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ogandoe/multi-worker:latest -t ogandoe/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ogandoe/multi-client:latest
docker push ogandoe/multi-server:latest
docker push ogandoe/multi-worker:latest

docker push ogandoe/multi-client:$SHA
docker push ogandoe/multi-server:$SHA
docker push ogandoe/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ogandoe/multi-server:$SHA
kubectl set image deployments/client-deployment server=ogandoe/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ogandoe/multi-worker:$SHA