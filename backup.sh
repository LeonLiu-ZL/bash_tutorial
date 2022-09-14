#!/bin/bash
# This bash script is used to backup the directories in the programming folder. Multiple input folders can be used with -i file1 -i file2 ...
# In default, the backup file is stored in /Users/zhaoliangliu/programming/backup folder
# unless it is specified by the -o parameter

while getopts "i:o:" opt; do
  case $opt in
    i) input+=($OPTARG);;
    o) output=($OPTARG);;
  esac
done
shift $((OPTIND -1))


function backup {
  if [ ! -d "/Users/$(whoami)/programming/$1" ]; then
    echo "Requested $1 input directory doesn't exist."
  	exit 1
  else
  	input_path=/Users/$(whoami)/programming/$1
  	echo "The input backup directory: $input_path"
  fi
  # Check output argument
  if [ -z $2 ]; then
  	output_path=/Users/$(whoami)/programming/backup/"$1"_$(date +%Y-%m-%d_%H%M%S).tar.gz
    echo "The backup file path: $output_path"
  else
  	if [ ! -d "/Users/$(whoami)/programming/$2" ];then
  		echo "Requested destination directory $2 doesn't exist."
  		exit 1
  	fi
  	output_path=/Users/$(whoami)/programming/"$2"/"$1"_$(date +%Y-%m-%d_%H%M%S).tar.gz
  	echo "The backup file path: $output_path"
  fi

  # The function total_files reports a total number of files for a given directory

  function total_files {
  	find $1 -type f | wc -l
  }

  function total_directories {
  	find $1 -type d | wc -l
  }

  function total_archived_directories {
  	tar -tzf $1 | grep /$ | wc -l
  }

  function total_archived_files {
  	tar -tzf $1 | grep -v /$ | wc -l
  }

    tar --disable-copyfile -czf $output_path $input_path 2> /dev/null

    src_files=$(total_files $input_path)
    src_directories=$(total_directories $input_path)

    arch_files=$(total_archived_files $output_path)
    arch_directories=$(total_archived_directories $output_path)

    echo "Files to be included: $src_files"
    echo "Directories to be included: $src_directories"
    echo "Files archived: $arch_files"
    echo "Directories archived: $arch_directories"

    if [ $src_files -eq $arch_files ]; then
    	echo "Back up of $input completed!"
    	echo "Details about the output backup file:"
    	ls -l $output_path
    else
    	echo "Backup of $input_path failed"
    fi
}
# Check input argument

if [ ${#input[@]} -eq 0 ]; then
  echo "Input backup directories are required. Use -i to pass."
else
  for directory in ${input[@]}; do
    echo "- $directory"
  	backup $directory $output
  done
fi
