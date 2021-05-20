#!/usr/bin/env bash

if [[ $1 == '-h' ]]
then
  host="-H $2"
  shift 2
fi

docker ${host} run -v $PWD:/uri-build -w /uri-build ocaml $*
