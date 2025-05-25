#!/bin/bash

#set -x #debug mode

echo "----------------------------------"
echo "Disk space Details:"
echo "----------------------------------"
df -h
echo "----------------------------------"
echo "Memory Details:"
echo "----------------------------------"
free -g
echo "----------------------------------"
echo "Number of processors:"
echo "----------------------------------"
nproc
echo "----------------------------------"
echo "processors Details:"
echo "----------------------------------"
ps -ef | grep "amazon" | awk '{print $1,$2}'
echo "----------------------------------"
