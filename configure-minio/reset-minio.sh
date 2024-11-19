if [ -z $MINIO_S3_ENDPOINT ]
then
    echo "Enter the MINIO_S3_ENDPOINT: "
    read MINIO_S3_ENDPOINT
fi
mc alias set workshop $MINIO_S3_ENDPOINT admin crazytrain123!
for bucket in data model-registry label-studio-sink user{1..40};
do
    mc rb --force workshop/$bucket;
    mc admin policy detach workshop $bucket --user $bucket;
    mc admin policy rm workshop $bucket;    
done;