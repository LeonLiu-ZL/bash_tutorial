#!/bin/bash
while getopts n:a:g: flag; do
  case "${flag}" in
    n) name=${OPTARG};;
    a) age=${OPTARG};;
    g) gender=${OPTARG};;
  esac
done

echo "Name: $name";
echo "Age: $age";
echo "Gender:$gender";
