#!/bin/sh

if [ "${1}" != "zip" ]; then
	echo "$0: we can only scan zip files";
	exit 0
fi

UNZIP=/usr/bin/unzip
OS=`uname`

P=/var/spool/exim/scan/${2}
Z=${3}

cd "${P}"

if [ ! -s $Z ]; then
	exit 0;
fi

if [ "${OS}" = "FreeBSD" ]; then
	if [ $( ${UNZIP} -l "${Z}" | \
		tail -n +4 | \
		egrep -i '[.](bat|btm|cmd|com|cpl|dat|dll|exe|lnk|msi|pif|prf|reg|scr|vb|vbs|url|jar)$' | \
		wc -l ) -gt 0 ]
	then
		exit 1
	fi
else
	if [ $( ${UNZIP} -l "${Z}" | \
		tail -n +4 | head -n -2 | \
		egrep -i '[.](bat|btm|cmd|com|cpl|dat|dll|exe|lnk|msi|pif|prf|reg|scr|vb|vbs|url|jar)$' | \
		wc -l ) -gt 0 ]
	then
		exit 1
	fi
fi

exit 0
