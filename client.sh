#! /bin/sh

url=$1
selected=true
while [[ $selected ]]
do
  selected=`curl -Ls $url \
    | fx 'x => { const {_links = [], ...content} = x; return [JSON.stringify(content), ..._links].join("\n"); }' \
    | fzf --select-1 --sync --reverse --preview 'echo {} | fx . 2>/dev/null || echo {}'`
  echo $selected | fx . 2> /dev/null && break;
  url=$selected
done
echo $url
