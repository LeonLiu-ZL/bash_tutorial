#!/bin/bash

for file in $(ls); do
	echo $file has $(cat $file | wc -l) lines
done
