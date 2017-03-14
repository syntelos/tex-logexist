#!/bin/bash

function usage {
  cat<<EOF
Synopsis

  $0 [0-9]* 

Description

  Review a number of documents producing a temp file of query
  responses.  The argument is a date pattern, e.g. "201701".

EOF
  exit 1
}

2>/dev/null rm /tmp/review.* 

log=/tmp/review.$$

re=2017
case "${1}" in
[0-9]*)
  re="${1}"
  ;;
[a-z-]*)
  re="${1}"
  ;;
*)
  usage
  ;;
esac


if flist=$(2>/dev/null ls *${re}*.tex ) && [ -n "${flist}" ]
then
 for src in ${flist}
 do
   less ${src}
   read -p "delete? [yN] " -n 1 r_del
   case "${r_del}" in
   [yY])
     echo "D ${src}" >> ${log}
     echo # (read -n 1)
     ;;
   [nN])
     echo "X ${src}" >> ${log}
     echo # (read -n 1)
     ;;
   *)
     echo "X ${src}" >> ${log}
     ;;
   esac

 done
 exit 0
else
 cat<<EOF>&2
$0 error, empty list of files from 'ls *${re}*.tex'.
EOF
 exit 1
fi
