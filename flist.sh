#!/bin/bash
#
prefix=logexist
fext=tex


function usage {
    cat<<EOF>&2
Synopsis

  $0 

Description

  List today's files.


Synopsis

  $0  [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]

Description

  Absolute addressing reference, YYYYMMDD.


EOF
    return 1
}

#
#
if ! today=$(yyyymmdd) || [ ! -n "${today}" ]
then
    cat<<EOF>&2
$0 error running 'yyyymmdd' for today's date.
EOF
    exit 1
fi

#
#
ref=${today}

#
#
while [ -n "${1}" ]
do
    case "${1}" in

	[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])

	    ref="${1}"
	    ;;

	*)
	    usage
	    ;;
    esac
    shift
done

#
if flist=$(2>/dev/null ls ${prefix}-*.${fext} | sort -V | egrep -e "${ref}" ) && [ -n "${flist}" ]
then
    for file in ${flist}
    do
	echo ${file}
    done
else
    cat<<EOF>&2
$0 error listing files in '${ref}'.
EOF
    exit 1
fi

