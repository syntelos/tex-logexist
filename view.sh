#!/bin/bash

file_pdf=$(./file.sh $* pdf)

file_png=$(./file.sh $* png)


if [ -f "${file_pdf}" ]
then
    evince ${file_pdf}  

else
    cat<<EOF>&2
$0: file "${file_pdf}" not found.
EOF

    if [ -f "${file_png}" ]
    then
	eog ${file_png}  &
    else
	cat<<EOF>&2
$0: file "${file_png}" not found.
EOF
	exit 1
    fi

fi

exit 0
