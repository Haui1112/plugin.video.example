#!/bin/bash

set -e

RELEASEFOLDER="./RELEASE/plugin.video.pt"
mkdir -p ${RELEASEFOLDER}

for filename in ./*; do
  copybool=0
  while read b; do
  if [ ${filename##*/} = ${b} ]; then copybool=1; fi
#  echo ${b}
  done <./.buildignore
  if [ ${copybool} = 0 ]; then
    if [[ -f ${filename} ]]; then 
      cp ${filename} ${RELEASEFOLDER}
    elif [[ -d ${filename} ]]; then 
      cp -r ${filename} ${RELEASEFOLDER}
    else
      echo "${filename} not valid"
    fi
  fi
done

cd RELEASE
#tar -czvf plugin.video.pt.zip ./plugin.video.pt/
ZIPFILE=plugin.video.pt.zip
if [[ -f ./${ZIPFILE} ]]; then rm ./${ZIPFILE}; fi
zip -r ${ZIPFILE} ./plugin.video.pt/
if [[ -f ~/Downloads/${ZIPFILE} ]]; then rm ~/Downloads/${ZIPFILE}; fi
cp ./plugin.video.pt.zip ~/Downloads/
echo "done"
