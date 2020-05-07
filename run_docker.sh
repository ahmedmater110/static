#!/usr/bin/env bash

docker build --tag=myapp .

docker image ls

docker run -p 80:80 myapp
