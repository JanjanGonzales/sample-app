
#!/bin/bash

# ===============================
# Sample App Jenkins-Friendly Script
# ===============================

# Set variables
APP_NAME="sampleapp"
CONTAINER_NAME="samplerunning"
PORT=5050
TEMP_DIR="tempdir"

# Remove old container if it exists
docker rm -f $CONTAINER_NAME 2>/dev/null || true

# Create temporary directories
mkdir -p $TEMP_DIR/templates
mkdir -p $TEMP_DIR/static

# Copy files
cp sample_app.py $TEMP_DIR/
cp -r templates/* $TEMP_DIR/templates/
cp -r static/* $TEMP_DIR/static/

# Create Dockerfile
cat <<EOL > $TEMP_DIR/Dockerfile
FROM python
RUN pip install --no-cache-dir --disable-pip-version-check --progress-bar off flask
COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/
EXPOSE $PORT
CMD ["python", "/home/myapp/sample_app.py"]
EOL

# Build and run Docker container
cd $TEMP_DIR
docker build -t $APP_NAME .
docker run --rm -d -p $PORT:$PORT --name $CONTAINER_NAME $APP_NAME
docker ps -a
