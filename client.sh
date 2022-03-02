#! /bin/sh

url=$1
baseurl=$1
selected=true
while [[ $selected ]]
do
  selected=`cat Test-TD.json \
    # | fx 'x => { const {links = [], ...content} = x; return [JSON.stringify(content), ...links].join("\n"); }' \
    | fx findNestedHrefs \
    | fzf --select-1 --sync --reverse --preview 'echo {} | fx . 2>/dev/null || echo {}'`
  echo $selected | fx . 2> /dev/null && break;
  url=$baseurl$selected
done
echo $url
