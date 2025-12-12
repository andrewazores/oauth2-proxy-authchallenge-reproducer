#!/usr/bin/env bash

DIR="$(dirname "$(readlink -f "$0")")"

export OAUTH2_PROXY_HTPASSWD_FILE="${DIR}/htpasswd"
export OAUTH2_PROXY_COOKIE_SECRET="__24_BYTE_COOKIE_SECRET_"

if [ ! -f "${DIR}/oauth2-proxy" ]; then
    curl --location --output "${DIR}/oauth2-proxy.tar.gz" "https://github.com/oauth2-proxy/oauth2-proxy/releases/download/v${OAUTH2_PROXY_VERSION:-7.12.0}/oauth2-proxy-v${OAUTH2_PROXY_VERSION:-7.12.0}.${OS:-linux}-${ARCH:-amd64}.tar.gz"
    tar xvf "${DIR}/oauth2-proxy.tar.gz"
    rm -f "${DIR}/oauth2-proxy.tar.gz"
    mv "${DIR}/oauth2-proxy-v${OAUTH2_PROXY_VERSION:-7.12.0}.${OS:-linux}-${ARCH:-amd64}/oauth2-proxy" "oauth2-proxy"
    rm -r "${DIR}/oauth2-proxy-v${OAUTH2_PROXY_VERSION:-7.12.0}.${OS:-linux}-${ARCH:-amd64}/"
    chmod +x "${DIR}/oauth2-proxy"
fi

pid=0
function cleanup() {
    if [ "${pid}" -gt 1 ]; then
        kill "${pid}"
    fi
}
trap cleanup EXIT

"${DIR}/oauth2-proxy" --alpha-config="${DIR}/config.yml" &
pid=$!

sleep 3

curl -vv --fail http://localhost:8080
