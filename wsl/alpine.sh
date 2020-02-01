#!/usr/bin/env bash

docker run --rm -v /$PWD:/workdir k4zuki/pandocker-alpine:2.8 $@
