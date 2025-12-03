#!/bin/bash

# create temporary directories
mkdir -p tempdir/templates
mkdir -p tempdir/static

# copy files
cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.


echo "FROM python" >> tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY  sample_app.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile        # changed from 8080 to 5050
echo "CMD python /home/myapp/sample_app.py" >> tempdir/Dockerfile

# create Dockerfile with fixed pip install
cat <<EOL > tempdir/Dockerfile
FROM python
RUN pip install --no-cache-dir --disable-pip-version-check --progress-bar off flask
COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/
EXPOSE 5050
CMD ["python", "/home/myapp/sample_app.py"]
EOL
 Changed port from 8080 to 5050.

# build and run Docker container
cd tempdir
docker build -t sampleapp .

docker run -t -d -p 5050:5050 --name samplerunning sampleapp   # changed port mapping to 5050
docker ps -a

docker run -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a

 Changed port from 8080 to 5050.
