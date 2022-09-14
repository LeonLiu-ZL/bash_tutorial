#!/bin/bash

# In default, this bash script is used to backup the directories in the programming folder. Multiple directories can be used as input.
# The backup file is stored in /Users/zhaoliangliu/programming/backup folder

function backup {
# Check input argument
  if [ -z $1 ]; then
    echo "Missing paramerter: backup folder"
  	exit 1
  else
  	if [ ! -d "/Users/$(whoami)/programming/$1" ];then
  		echo "Requested $1 user home directory doesn't exist."
  		exit 1
  	fi
  	input=/Users/$(whoami)/programming/$1
  	echo "The backup folder: $input"
  fi

  output=/Users/$(whoami)/programming/backup/"$1"_$(date +%Y-%m-%d_%H%M%S).tar.gz


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

  tar --disable-copyfile -czf $output $input 2> /dev/null

  src_files=$(total_files $input)
  src_directories=$(total_directories $input)

  arch_files=$(total_archived_files $output)
  arch_directories=$(total_archived_directories $output)

  echo "Files to be included: $src_files"
  echo "Directories to be included: $src_directories"
  echo "Files archived: $arch_files"
  echo "Directories archived: $arch_directories"

  if [ $src_files -eq $arch_files ]; then
  	echo "Back up of $input completed!"
  	echo "Details about the output backup file:"
  	ls -l $output
  else
  	echo "Backup of $input failed"
  fi
}

for directory in $*; do
	backup $directory
done
