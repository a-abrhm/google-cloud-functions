steps:
  - name: 'gcr.io/cloud-builders/git'
    id: detect-changes
    entrypoint: 'bash'
    args:
      - '-c'
      - |
        echo "Detecting changes in Node.js and Python subdirectories..."
        CHANGED_FILES=$(git diff --name-only HEAD^ HEAD -- "cloud_functions")
        # Extract unique directories
        echo "$CHANGED_FILES" | \
          awk -F/ '{print $1"/"$2"/"$3"}' | \
          sort -u > $HOME/changed_dirs.txt
        # Display the result for debugging purposes
        cat $HOME/changed_dirs.txt

  - name: 'gcr.io/cloud-builders/gcloud'
    id: deploy-functions
    entrypoint: 'bash'
    args:
      - '-c'
      - |
        echo "Deploying functions..."
        while IFS= read -r dir; do
          # Check if the directory contains 'nodejs' and deploy if it does
          if [[ "$dir" == *nodejs* ]]; then
            echo "Deploying Node.js function in $dir"
            gcloud run deploy "$(basename "$dir")" --source="$dir" --region=YOUR_REGION --allow-unauthenticated
          # Check if the directory contains 'python' and deploy if it does
          elif [[ "$dir" == *python* ]]; then
            echo "Deploying Python function in $dir"
            gcloud run deploy "$(basename "$dir")" --source="$dir" --region=YOUR_REGION --allow-unauthenticated
          fi
        done < $HOME/changed_dirs.txt
