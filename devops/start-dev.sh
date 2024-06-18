#!/bin/bash
docker_compose="docker-compose"

if docker compose version &>/dev/null; then
    docker_compose="docker compose"
elif ! docker-compose version &>/dev/null; then
    echo "Neither 'docker compose' nor 'docker-compose' commands are available."
    exit 1
fi

$docker_compose -p accommodatio-stage -f compose.dev.yaml down
$docker_compose -p accommodatio-stage -f compose.dev.yaml build --no-cache
$docker_compose -p accommodatio-stage -f compose.dev.yaml up
