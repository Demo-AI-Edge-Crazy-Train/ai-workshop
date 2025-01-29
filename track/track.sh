if [ -z $MINIO_S3_ENDPOINT ]
then
    echo "Enter the MINIO_S3_ENDPOINT: "
    read MINIO_S3_ENDPOINT
fi
mc alias set workshop $MINIO_S3_ENDPOINT admin crazytrain123!
echo '' > /tmp/results-all.csv

for USER_ID in user{1..40}
do
    mc get workshop/$USER_ID/results.csv /tmp/results-$USER_ID.csv
    if [[ -f /tmp/results-$USER_ID.csv ]]
    then
        mAP50=$(cat /tmp/results-${USER_ID}.csv | awk -F, 'END { print $7 }' | xargs)
        echo "$USER_ID,$mAP50" >> /tmp/results-all.csv
    else
        echo "$USER_ID,0" >> /tmp/results-all.csv
    fi
done
cat /tmp/results-all.csv