if [ -z $MINIO_S3_ENDPOINT ]
then
    echo "Enter the MINIO_S3_ENDPOINT: "
    read MINIO_S3_ENDPOINT
fi
mc alias set workshop $MINIO_S3_ENDPOINT admin crazytrain123!
# Dataset
mc mb workshop/data;
mc anonymous set download workshop/data;
# Shared fallback model registry
mc mb workshop/model-registry;
mc anonymous set download workshop/model-registry;
# Bounding boxes for the custom dataset
mc mb workshop/label-studio-sink;
mc anonymous set download workshop/label-studio-sink;
# User buckets and rbac
for i in {1..40};
do
    mc mb workshop/user$i;
    mc admin user add workshop user$i minio123;
    sed "s/USER_ID/user$i/g" policy.json > tmp.json;
    mc admin policy create workshop user$i tmp.json;
    mc admin policy attach workshop user$i --user user$i;
    mc anonymous set download workshop/user$i;
done;
