BIN_DIRECTORY=/opt/local/sbin/exim-4.91/bin
CONFIGURE_FILE=/opt/local/etc/exim/exim.conf
HEADERS_CHARSET="ISO-8859-1"
FIXED_NEVER_USERS=root
HAVE_IPV6=no
HAVE_ICONV=yes
SYSLOG_LOG_PID=yes
EXICYCLOG_MAX=10
COMPRESS_SUFFIX=gz

EXIM_USER=exim
EXIM_GROUP=exim

ROUTER_ACCEPT=yes
ROUTER_DNSLOOKUP=yes
ROUTER_IPLITERAL=yes
ROUTER_MANUALROUTE=yes
ROUTER_QUERYPROGRAM=yes
ROUTER_REDIRECT=yes

TRANSPORT_APPENDFILE=yes
TRANSPORT_AUTOREPLY=no
TRANSPORT_PIPE=yes
TRANSPORT_SMTP=yes

SUPPORT_MBX=no
SUPPORT_MAILDIR=no
SUPPORT_MAILSTORE=no
SUPPORT_TLS=yes

LOOKUP_CDB=no
LOOKUP_DBM=yes
LOOKUP_DNSDB=yes
LOOKUP_LSEARCH=yes
LOOKUP_DSEARCH=no
LOOKUP_NIS=no
LOOKUP_PASSWD=yes

EXIM_MONITOR=eximon.bin
EXIM_PERL=perl.o

AUTH_CRAM_MD5=yes
AUTH_PLAINTEXT=yes
AUTH_SPA=yes

SYSTEM_ALIASES_FILE=/opt/local/etc/exim/aliases
SPOOL_DIRECTORY=/var/spool/exim
PID_FILE_PATH=/var/run/exim.pid
LOG_FILE_PATH=/var/log/exim/%slog

TMPDIR="/tmp"
ZCAT_COMMAND=/usr/bin/zcat
COMPRESS_COMMAND=/usr/bin/gzip

PCRE_CONFIG=/opt/local/sbin/pcre/bin/pcre-config
PCRE_LIBS=-lpcre -L/opt/local/sbin/pcre/lib
TLS_LIBS=-L/opt/local/sbin/openssl/lib -lssl -lcrypto
TLS_INCLUDE=-I/opt/local/sbin/openssl/include
INCLUDE=-I/opt/local/sbin/pcre/include -I/opt/local/sbin/db/include
DBMLIB=-L/opt/local/sbin/db/lib -ldb

CFLAGS += -I/opt/local/sbin/openssl/include
LDFLAGS += -L/opt/local/sbin/openssl/lib -lssl -lcrypto
