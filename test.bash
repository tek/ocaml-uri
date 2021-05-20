#!/usr/bin/env bash

if [[ -n $1 ]]
then
  host="-H $1"
  shift 1
fi

docker ${host} run -v /uri-build:$PWD -w /uri-build ocaml $*
