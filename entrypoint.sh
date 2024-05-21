#!/bin/bash

set -e

rm -f /horror_burn/tmp/pids/server.pid

exec "$@"
