#!/bin/bash

tmpf=/tmp/test.png

if img=$(./file.sh png) &&[ -n "${img}" ]
then
    echo "+ convert ${img} -crop 591x838+801+56 -scale 800x1134+0+0 ${tmpf}"

    if convert ${img} -crop 591x838+801+56 -scale 800x1134+0+0 ${tmpf}
    then
	echo "+ cp ${tmpf} ${img}"
	if cp ${tmpf} ${img}
	then
	    echo "+ rm -f ${tmpf}"

	    rm -f ${tmpf} 

	    echo "OK ${img}"

	    exit 0
	else
	    cat<<EOF>&2
$0 error: Failed to "copy".
EOF
	    exit 1
	fi
    else
	cat<<EOF>&2
$0 error: Failed to "convert".
EOF
	exit 1
    fi
else
  cat<<EOF>&2
$0 error: Source image not found.  Empty result from './file.sh png'.
EOF
  exit 1
fi

