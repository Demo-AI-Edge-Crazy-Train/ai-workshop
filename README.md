# Workshop setup

## Steps

1. Deploy the operators and their CRs. GPU operator is deployed and configured for time slicing.
```
oc apply -f operators
# Wait for the operator installation to complete
oc apply -f operators-instances
```

2. Configure RHOAI
```
oc apply -f rhoai-setup
# Reload dashboard
oc -n redhat-ods-applications rollout restart deploy/rhods-dashboard
```

3. Deploy a shared base model
```
oc apply -f base-model
```

4. Deploy Minio
```
oc apply -k deploy-minio
```

5. Deploy the user projects
```
cd namespaces-setup.sh
chmod +x setup.sh
./setup.sh
cd ..
```

6. Configure minio
```
cd configure-minio
chmod +x create-buckets-users-policies.sh populate-bucket.sh
./create-buckets-users-policies.sh
./populate-bucket.sh
cd ..
```

7. Setup the image puller to speed up image pulling. You can use the script inside the folder to generate a new one from a list of images.
```
oc apply -f image-puller/image-puller.yaml
```