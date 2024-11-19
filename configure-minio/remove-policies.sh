if [ -z $MINIO_S3_ENDPOINT ]
then
    echo "Enter the MINIO_S3_ENDPOINT: "
    read MINIO_S3_ENDPOINT
fi
for i in {1..40};
do
    mc admin policy detach workshop user$i --user user$i;
    mc admin policy rm workshop user$1;
done;
