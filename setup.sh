#!/bin/bash

set -eu

. /etc/os-release
curl -fsSL https://mechatrax-kiyonaga.github.io/setup/${ID}-${VERSION_ID}.sh | bash
