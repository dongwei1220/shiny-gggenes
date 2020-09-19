#/bin/bash

# build the image
docker build -t gggenes .

# run the container
docker run --rm -p 3838:3838 gggenes
