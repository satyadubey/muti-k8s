docker build -t satya27aug/multi-client:latest -t satya27aug/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t satya27aug/multi-server:latest -t satya27aug/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t satya27aug/multi-worker:latest -t satya27aug/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push satya27aug/multi-client:latest
docker push satya27aug/multi-server:latest
docker push satya27aug/multi-worker:latest

docker push satya27aug/multi-client:$SHA
docker push satya27aug/multi-server:$SHA
docker push satya27aug/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=satya27aug/multi-server:$SHA
kubectl set image deployments/client-deployment client=satya27aug/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=satya27aug/multi-worker:$SHA