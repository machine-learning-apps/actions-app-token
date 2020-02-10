#!/bin/bash

echo $INPUT_APP_PEM | base64 -d > pem.txt
python /app/token_getter.py
