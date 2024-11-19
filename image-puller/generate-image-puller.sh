# Read the file line by line
images=""
while IFS= read -r line; do
    # Generate a random unique name
    random_name=$(uuidgen | cut -c1-8) # Use the first 8 characters of a UUID for uniqueness
    # Print the unique name followed by the line content
    images+="$random_name=$line;"
done < images.txt

cat > image-puller.yaml<< EOF
kind: Namespace
apiVersion: v1
metadata:
  name: ai-image-puller
---
kind: KubernetesImagePuller
apiVersion: che.eclipse.org/v1alpha1
metadata:
  name: ai-image-puller
  namespace:  ai-image-puller
spec:
  daemonsetName: ai-image-puller
  images: "$images"
EOF