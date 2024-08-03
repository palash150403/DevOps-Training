# day7
## Project-1

### 1. Setup Minikube and Git Repository

Start Minikube:
```
minikube start
```

-   Create a new directory for your project:
```
mkdir nodejs-k8s-project
cd nodejs-k8s-project
```
-   Initialize Git repository:
```
git init
```

-   Create a .gitignore file:
```
node_modules/
.env
```

-   Add and commit initial changes:
```
git add .
git commit -m "Initial commit"
```
### 2. Develop a Node.js Application
-   Create the Node.js App
-   Initialize the Node.js project:
```
npm init -y
```
-   Install necessary packages:
```
npm install express body-parser
```

-   Create app.js:
```
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

Update package.json to include a start script:

"scripts": {
  "start": "node app.js"
}
```

-   Commit the Node.js Application
Add and commit changes:
```
git add .
git commit -m "Add Node.js application code"
```
![alt text](img/image-2.png)
### 3. Create Dockerfile and Docker Compose
-   Create a Dockerfile

```
# Use official Node.js image
FROM node:18

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port on which the app runs
EXPOSE 3000

# Command to run the application
CMD [ "npm", "start" ]
```

-   Create a .dockerignore file:
```
node_modules
.npm
```
-   Add docker-compose.yml:
```
version: '3'
services:
  app:
    build: .
    ports:
      - "3000:3000"
```
-   Add and commit changes:
```
git add Dockerfile docker-compose.yml
git commit -m "Add Dockerfile and Docker Compose configuration"
```
![alt text](img/image-3.png)
### 4. Build and Push Docker Image
-   Build the Docker image:
```
docker build -t nodejs-app:latest .
```

-   Push Docker Image to Docker Hub
```
docker tag nodejs-app:latest palash150403/nodejs-app:latest
docker push your-palash150403/nodejs-app:latest
```

-   Add and commit changes:
```
git add .
git commit -m "Build and push Docker image"
```
![alt text](img/image-4.png)
### 5. Create Kubernetes Configurations
-   Create kubernetes/deployment.yaml:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-app-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nodejs-app
  template:
    metadata:
      labels:
        app: nodejs-app
    spec:
      containers:
      - name: nodejs-app
        image: your-dockerhub-username/nodejs-app:latest
        ports:
        - containerPort: 3000
        env:
        - name: PORT
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: PORT
        - name: NODE_ENV
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: NODE_ENV
```
-   Create kubernetes/configmap.yaml:
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  PORT: "3000"

Create kubernetes/secret.yaml:

apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  NODE_ENV: cHJvZHVjdGlvbmFs # Base64 encoded value for "production"
```
-   Add and commit Kubernetes configurations:
```
git add kubernetes/
git commit -m "Add Kubernetes deployment, configmap, and secret"
```
![alt text](img/image-5.png)

-   Apply Kubernetes Configurations
Apply the ConfigMap and Secret:
```
kubectl apply -f kubernetes/configmap.yaml
kubectl apply -f kubernetes/secret.yaml
```

-   Apply the Deployment:
```
kubectl apply -f kubernetes/deployment.yaml
```
![alt text](img/image-6.png)

-   Create kubernetes/hpa.yaml:
```
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: nodejs-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nodejs-app-deployment
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
```
-   Apply the HPA:
```
kubectl apply -f kubernetes/hpa.yaml
```
![alt text](img/image-7.png)
-   Create Vertical Pod Autoscaler
Create kubernetes/vpa.yaml:
```
apiVersion: autoscaling.k8s.io/v1beta2
kind: VerticalPodAutoscaler
metadata:
  name: nodejs-app-vpa
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nodejs-app-deployment
  updatePolicy:
    updateMode: "Auto"
```
-   Apply the VPA:
```
kubectl apply -f kubernetes/vpa.yaml
```

-   Check the Status of Pods, Services, and HPA
-   Verify the Pods:
```
kubectl get pods
```

-   Verify the Services:
```
kubectl get svc
```

-   Verify the HPA:
```
kubectl get hpa
```
![alt text](img/image-8.png)

-   Access the Application
Expose the Service:
```
kubectl expose deployment nodejs-app-deployment --type=NodePort --name=nodejs-app-service
``` 
-   Get the Minikube IP and Service Port:
```
minikube service nodejs-app-service –url
```
![alt text](img/image-9.png)
-   Access the Application in your browser using the URL obtained from the previous command.
![alt text](img/image-10.png)

-   Create and switch to a new branch:
```
git checkout -b feature/new-feature
```
Make changes and commit:
```
git add .
git commit -m "Add new feature"
```

-   Push the branch to the remote repository:
```
git push origin feature/new-feature
```

-   Rebase Feature Branch on Main Branch
Switch to the main branch and pull the latest changes:
```
git checkout main
git pull origin main
```

-   Rebase the feature branch:
```
git checkout feature/new-feature
git rebase main
```
-   Resolve conflicts if any, and continue the rebase:
```
git add .
git rebase --continue
```

-   Push the rebased feature branch:
```
git push origin feature/new-feature --force
```
-   Final Commit and Cleanup
Merge feature branch to main:
```
git checkout main
git merge feature/new-feature
```
-   Push the changes to the main branch:
```
git push origin main
```

## Project 02 Deploy a Node.js application to Kubernetes with advanced usage of ConfigMaps and Secrets. 

-   Create a new directory for our project and initialize Git:
```
mkdir nodejs-advanced-k8s-project
cd nodejs-advanced-k8s-project
git init
```


-   Create the initial Node.js application and Docker-related files:
```
npm init -y
npm install express redis body-parser
```

-   app.js
```
const express = require('express');
const bodyParser = require('body-parser');
const redis = require('redis');
const app = express();
const PORT = process.env.PORT || 3000;

// Connect to Redis
const redisClient = redis.createClient({
  url: `redis://${process.env.REDIS_HOST}:${process.env.REDIS_PORT}`
});
redisClient.on('error', (err) => console.error('Redis Client Error', err));

app.use(bodyParser.json());

app.get('/', async (req, res) => {
  const visits = await redisClient.get('visits');
  if (visits) {
    await redisClient.set('visits', parseInt(visits) + 1);
  } else {
    await redisClient.set('visits', 1);
  }
  res.send(`Hello, World! You are visitor number ${visits || 1}`);
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
```

-   Dockerfile
```
FROM node:18

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]

.dockerignore

node_modules
.npm
```

-   Build and push Docker image:
```
   docker build -t palash150403/nodejs-advanced-app:latest .
   docker push 150403/nodejs-advanced-app:latest
```
-   Apply Kubernetes configurations:
```
kubectl apply -f kubernetes/
```
-   Access the application:
```
minikube service nodejs-advanced-app-service --url
```
-   Create `kubernetes/deployment.yaml` to deploy the Node.js application with Redis dependency:
```
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-advanced-app-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nodejs-advanced-app
  template:
    metadata:
      labels:
        app: nodejs-advanced-app
    spec:
      containers:
      - name: nodejs-advanced-app
        image: your-dockerhub-username/nodejs-advanced-app:latest
        ports:
        - containerPort: 3000
        env:
        - name: PORT
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: PORT
        - name: REDIS_HOST
          valueFrom:
            configMapKeyRef:
              name: redis-config
              key: REDIS_HOST
        - name: REDIS_PORT
          valueFrom:
            configMapKeyRef:
              name: redis-config
              key: REDIS_PORT
        - name: NODE_ENV
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: NODE_ENV
      - name: redis
        image: redis:latest
        ports:
        - containerPort: 6379
```
-   Create kubernetes/configmap.yaml to manage application and Redis configurations:
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  PORT: "3000"

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: redis-config
data:
  REDIS_HOST: "redis"
  REDIS_PORT: "6379"
```

-   Create kubernetes/secret.yaml to manage sensitive environment variables:
```
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  NODE_ENV: cHJvZHVjdGlvbg== # Base64 encoded value for "production"
```

-   Create kubernetes/service.yaml to expose the Node.js application:
```
apiVersion: v1
kind: Service
metadata:
  name: nodejs-advanced-app-service
spec:
  selector:
    app: nodejs-advanced-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
  type: LoadBalancer
```

-   Create kubernetes/hpa.yaml to manage autoscaling:
```
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: nodejs-advanced-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nodejs-advanced-app-deployment
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 70
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 30
      selectPolicy: Max
      policies:
      - type: Pods
        value: 2
        periodSeconds: 30
      - type: Resource
        resource: cpu
        value: 2
        periodSeconds: 30
    scaleDown:
      stabilizationWindowSeconds: 30
      selectPolicy: Min
      policies:
      - type: Pods
        value: 1
        periodSeconds: 30
      - type: Resource
        resource: memory
        value: 1
        periodSeconds: 30
```
-   Create kubernetes/vpa.yaml to manage vertical scaling:
```
apiVersion: autoscaling.k8s.io/v1beta2
kind: VerticalPodAutoscaler
metadata:
  name: nodejs-advanced-app-vpa
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nodejs-advanced-app-deployment
  updatePolicy:
    updateMode: "Auto"
```

-   Add a Redis deployment configuration to kubernetes/redis-deployment.yaml:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: redis:latest
        ports:
        - containerPort: 6379
```

-   Add Redis service configuration to kubernetes/redis-service.yaml:
```
apiVersion: v1
kind: Service
metadata:
  name: redis-service
spec:
  selector:
    app: redis
  ports:
  - protocol: TCP
    port: 6379
    targetPort: 6379
  type: ClusterIP
```

-   Apply all configurations to your Minikube cluster:
```
kubectl apply -f kubernetes/redis-deployment.yaml
kubectl apply -f kubernetes/redis-service.yaml
kubectl apply -f kubernetes/configmap.yaml
kubectl apply -f kubernetes/secret.yaml
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/hpa.yaml
kubectl apply -f kubernetes/vpa.yaml
```
![alt text](<img/Screenshot from 2024-08-01 14-31-34.png>)
-   Check the status of your deployments and services:
```
kubectl get all
```
-   Access the application via Minikube:
```
minikube service nodejs-advanced-app-service --url
```

-   Simulate load on the application to test the HPA:
```
kubectl run -i --tty --rm load-generator --image=busybox --restart=Never -- /bin/sh
```
-   Inside the pod, run the following command to generate load
```
while true; do wget -q -O- http://nodejs-advanced-app-service; done
```
-   Observe the HPA behavior:
```
kubectl get hpa
```
![alt text](<img/Screenshot from 2024-08-01 14-34-42.png>)

-   Watch the scaling events and verify that the application scales up and down based on the policies you configured.






