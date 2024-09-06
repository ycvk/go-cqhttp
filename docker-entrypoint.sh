#!/bin/sh

USER=abc

echo "---Setup Timezone to ${TZ}---"
echo "${TZ}" > /etc/timezone
echo "---Checking if UID: ${UID} matches user---"
usermod -o -u ${UID} ${USER}
echo "---Checking if GID: ${GID} matches user---"
groupmod -o -g ${GID} ${USER} > /dev/null 2>&1 ||:
usermod -g ${GID} ${USER}
echo "---Setting umask to ${UMASK}---"
umask ${UMASK}

echo "---Taking ownership of data...---"
chown -R ${UID}:${GID} /app /data
chmod +x /app/cqhttp

echo "Starting..."
if [ -n "$1" ]; then
    su-exec ${USER} sh -c "echo $1 | /app/cqhttp"
else
    su-exec ${USER} /app/cqhttp
fi