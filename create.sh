#!/bin/bash

prefix=logexist
subtitle=''
yyyymmdd=$(yyyymmdd)
index=0

function usage {
    cat<<EOF>&2
Synopsis

  $0 

Description

  Create new file "{prefix}-{yyyymmdd}-{x}.tex", for x = {0,...,N}.


Synopsis

  $0 %p'prefix'

Description

  Create new file "{prefix}-{yyyymmdd}-{x}.tex".


Synopsis

  $0 %s'subtitle'

Description

  Create new file "{prefix}-{yyyymmdd}-{x}-{subtitle}.tex".


EOF
}

#
while [ -n "${1}" ]
do
    case "${1}" in

	%p*)
	    prefix=$(echo "${1}" | sed 's^%p^^')
	    ;;

	%s*)
	    subtitle=$(echo "${1}" | sed 's^%s^^')
	    ;;

	*)
	    usage
	    exit 1
	    ;;
    esac
    shift
done

#
file=${prefix}-${yyyymmdd}-${index}.tex

while [ -f ${file} ]
do
    index=$(( ${index} + 1 ))
    file=${prefix}-${yyyymmdd}-${index}.tex
done

#
if [ -n "${subtitle}" ]
then
    file=${prefix}-${yyyymmdd}-${index}-${subtitle}.tex
fi

#
cat<<EOF>${file}
\input preamble



\bye
EOF

echo ${file}

git add ${file}

emacs ${file} &
