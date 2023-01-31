#!/bin/bash

 
FILE_NAME=`basename $0`
memsize=$2
function usage()
{
echo "Usage:$FILE_NAME consume memory_size|release -----the value of memory_size like 100M 2G and etc"
echo "Example: $FILE_NAME consume 1G"
echo "         $FILE_NAME release"
}
function consume()
{
if [ -d  /tmp/memory ];then
    echo "/tmp/memory already exists"
else
    mkdir /tmp/memory
fi
mount -t tmpfs -o size=$1 tmpfs /tmp/memory   
dd if=/dev/zero of=/tmp/memory/block
 
}
 
function release()
{
rm /tmp/memory/block;ret=$?
if [ $ret != 0 ]; then
    echo "remove memory data failed"
    return $ret
fi
 
umount /tmp/memory;ret=$?
if [ $ret != 0 ]; then
    echo "umount memory filedir failed"
    return $ret
fi
 
rmdir /tmp/memory;ret=$?
if [ $ret != 0 ]; then
    echo "remove memory filedir failed"
    return $ret
fi
 
}
 
function main()
{
case "$1" in
    consume) consume $memsize;;
    release) release;;
          *) usage;exit 1;;
esac
}
 
main $*
