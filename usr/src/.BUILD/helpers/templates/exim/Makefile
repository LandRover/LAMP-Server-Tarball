BIN_DIRECTORY=/opt/local/sbin/exim-4.98/bin
CONFIGURE_FILE=/opt/local/etc/exim/exim.conf
HEADERS_CHARSET="ISO-8859-1"
FIXED_NEVER_USERS=root
HAVE_IPV6=yes
HAVE_ICONV=no
SYSLOG_LOG_PID=yes
EXICYCLOG_MAX=10

EXIM_USER=mail
EXIM_GROUP=mail

ROUTER_ACCEPT=yes
ROUTER_DNSLOOKUP=yes
ROUTER_IPLITERAL=yes
ROUTER_MANUALROUTE=yes
ROUTER_QUERYPROGRAM=yes
ROUTER_REDIRECT=yes

TRANSPORT_LMTP=yes
TRANSPORT_APPENDFILE=yes
TRANSPORT_AUTOREPLY=no
TRANSPORT_SMTP=yes
TRANSPORT_PIPE=yes

SUPPORT_MOVE_FROZEN_MESSAGES=yes
SUPPORT_MBX=yes
SUPPORT_MAILDIR=yes
SUPPORT_MAILSTORE=yes
SUPPORT_TLS=yes
SUPPORT_SPF=yes
SUPPORT_SRS=yes
SUPPORT_DMARC=yes
DMARC_TLD_FILE=/usr/share/publicsuffix/effective_tld_names.dat
DMARC_API=100400

USE_GDBM=yes
LOOKUP_CDB=no
LOOKUP_DBM=no
LOOKUP_DNSDB=yes
LOOKUP_LSEARCH=yes
LOOKUP_DSEARCH=yes
# LOOKUP_NIS=yes
LOOKUP_PASSWD=yes

EXIM_PERL=perl.o
EXIM_MONITOR=eximon.bin

AUTH_SPA=yes
AUTH_DOVECOT=yes
#AUTH_CYRUS_SASL=no
AUTH_CRAM_MD5=yes
AUTH_PLAINTEXT=yes

WITH_CONTENT_SCAN=yes
WITH_OLD_DEMIME=yes

SYSTEM_ALIASES_FILE=/opt/local/etc/exim/aliases
SPOOL_DIRECTORY=/var/spool/exim
PID_FILE_PATH=/var/run/exim.pid
LOG_FILE_PATH=syslog:/var/log/exim/%slog

LOG_DIRECTORY_MODE=0755
LOG_MODE=0644

TMPDIR="/tmp"
ZCAT_COMMAND=/usr/bin/zcat
COMPRESS_COMMAND=/usr/bin/gzip
COMPRESS_SUFFIX=gz

DBMLIB=-L/opt/local/sbin/gdbm/lib -lgdbm

PCRE_CONFIG=/opt/local/sbin/pcre2/bin/pcre2-config
PCRE_LIBS=-lpcre2-8 -L/opt/local/sbin/pcre2/lib

CFLAGS += -DSPF -I/opt/local/sbin/opendmarc/include -I/opt/local/sbin/libspf2/include -I/opt/local/sbin/libsrs_alt/include -I/opt/local/sbin/pcre2/include -I/opt/local/sbin/gdbm/include
LDFLAGS += -L/opt/local/sbin/opendmarc/lib -L/opt/local/sbin/libspf2/lib -L/opt/local/sbin/libsrs_alt/lib -lspf2 -lopendmarc -lsrs_alt -fstack-protector-strong

USE_OPENSSL=yes
USE_OPENSSL_PC=openssl
TLS_LIBS=-L/opt/local/sbin/openssl/lib64 -lssl -lcrypto
TLS_INCLUDE=-I/opt/local/sbin/openssl/include

#USE_GNUTLS=no
#USE_GNUTLS_PC=gnutls
#TLS_LIBS=-L/opt/local/sbin/gnu/lib -lgnutls -ltasn1 -lgcrypt
#TLS_INCLUDE=-I/opt/local/sbin/gnu/include
