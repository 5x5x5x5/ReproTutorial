#!/bin/sh

# Build and serve locally the website
#
# Run from the top of the repository

my_dir="$(dirname "$0")"

"$my_dir/generate.sh"

echo
echo "Serving website..."
if test running_in_docker; then
  dexy serve || exit 1
else
  docker run --rm -P -v $PWD:/home/reproducible reproducible/dexy dexy serve
  test $? || exit 1
fi
echo "Serving website... [ok]"

