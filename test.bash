#!/usr/bin/env bash

docker run -v $PWD:/uri-build -w /uri-build ocaml $*
