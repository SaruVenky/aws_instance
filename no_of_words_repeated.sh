#!/bin/bash

x=$1
s=$2

grep -o "$s" <<< "$x" | wc -l

echo "$x" | grep -o "$s" | wc -l 
