#!/bin/sh

sudo cgroupfs-mount
sudo usermod -aG docker $USER
sudo service docker start
