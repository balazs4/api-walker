#! /bin/sh

baseurl=$1
selected=true
url=${baseurl:-http://localhost:3000}/

while [[ $selected ]]
do
  selected=`curl -Ls $url | fx findNestedHrefs | fzf --select-1 --reverse --preview 'echo {} | fx . 2>/dev/null || echo {}'`
  echo $selected | fx . 2> /dev/null && break;
  url=$baseurl$selected
done
echo $url
