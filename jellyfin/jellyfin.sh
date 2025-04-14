#! /bin/bash

echo "----------------------------------------------------------"
echo "Current folder is JellyFin! Your Movie Server starting up"
echo " Run \"start_server\" to start server"
echo " Run \"stop_server\" to stop server"
echo "----------------------------------------------------------"



function start_server()
{
    if [ -f docker-compose.yml ]; then
        docker compose -f docker-compose.yml up -d 
    fi
}

function stop_server()
{
    if [ -f docker-compose.yml ]; then
        docker compose -f docker-compose.yml down
    fi
}