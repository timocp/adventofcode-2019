#! /bin/sh

year=2019
day=$1

if [ "$day" = "" ]; then
    day=$(TZ=US/Eastern date '+%d' | sed 's/^0//')
fi

if ! git diff --exit-code > /dev/null; then
    echo There are uncommitted changes 2>&1
    exit 1
elif [ -e input/day$day.txt ]; then
    echo Already have day $day 2>&1
    exit 1
fi

# download input (assumes w3m is already logged in)
url=https://adventofcode.com/$year/day/$day/input > input/day$day.txt
echo Fetching $url...
mkdir -p input
w3m $url > input/day$day.txt
file input/day$day.txt
