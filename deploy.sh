docker build -t dorairajsanjay/multi-client:latest -t dorairajsanjay/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dorairajsanjay/multi-server:latest -t dorairajsanjay/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dorairajsanjay/multi-worker:latest -t dorairajsanjay/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dorairajsanjay/multi-client:latest
docker push dorairajsanjay/multi-client:$SHA 
docker push dorairajsanjay/multi-server:latest
docker push dorairajsanjay/multi-server:$SHA 
docker push dorairajsanjay/multi-worker:latest
docker push dorairajsanjay/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=dorairajsanjay/multi-server:$SHA
kubectl set image deployments/client-deployment client=dorairajsajay/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dorairajsanjay/multi-worker:$SHA