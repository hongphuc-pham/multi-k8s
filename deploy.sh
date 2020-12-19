docker build -t phhogphuc/multi-client:latest -t phhogphuc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t phhogphuc/multi-server:latest -t phhogphuc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t phhogphuc/multi-worker:latest -t phhogphuc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push phhogphuc/multi-client:latest
docker push phhogphuc/multi-server:latest
docker push phhogphuc/multi-worker:latest

docker push phhogphuc/multi-client:$SHA
docker push phhogphuc/multi-server:$SHA
docker push phhogphuc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=phhogphuc/multi-client:$SHA
kubectl set image deployments/server-deployment server=phhogphuc/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=phhogphuc/multi-worker:$SHA