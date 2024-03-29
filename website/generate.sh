#!/bin/sh

# Build the website
#
# Run from the top of the repository

running_in_docker() {
  awk -F/ '$2 == "docker"' /proc/self/cgroup | read
}

generate_website() {
  echo
  echo "Generating website..."
  if test running_in_docker; then
	  dexy setup
	  dexy || exit 1
  else
	  docker run --rm -v $PWD:/home/repro reproducible/dexy dexy setup
	  docker run --rm -v $PWD:/home/repro reproducible/dexy dexy
	  test $? || exit 1
  fi
  echo "Generating website... [ok]"
}

generate_website
