docker build -t spiderbezno/multi-client:latest -t spiderbezno/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t spiderbezno/multi-server:latest -t spiderbezno/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t spiderbezno/multi-worker:latest -t spiderbezno/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push spiderbezno/multi-client:latest
docker push spiderbezno/multi-server:latest
docker push spiderbezno/multi-worker:latest

docker push spiderbezno/multi-client:$SHA
docker push spiderbezno/multi-server:$SHA
docker push spiderbezno/multi-worker:$SHA

kubectl apply -f k8s
kubectl set images deployments/server-deployment server=spiderbezno/multi-server:$SHA
kubectl set images deployments/client-deployment client=spiderbezno/multi-client:$SHA
kubectl set images deployments/worker-deployment worker=spiderbezno/multi-worker:$SHA