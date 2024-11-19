if [ -z $MINIO_S3_ENDPOINT ]
then
    echo "Enter the MINIO_S3_ENDPOINT: "
    read MINIO_S3_ENDPOINT
fi
mc alias set workshop $MINIO_S3_ENDPOINT admin crazytrain123!
mc cp --recursive datasets/traffic-sign-lego workshop/data
mc cp datasets/validation-dataset.tar.gz workshop/data
mc cp --recursive models/default workshop/model-registry
mc cp --recursive models/lego workshop/model-registry
# Labels contains placeholder for domain name
# Create a tmp folder with customization and upload
rm -rf custom-labels
cp -r labels custom-labels
grep -rlZ MINIO_S3_ENDPOINT custom-labels | xargs -0 sed -i "s@MINIO_S3_ENDPOINT@$MINIO_S3_ENDPOINT@g"
mc cp --recursive custom-labels/* workshop/label-studio-sink
