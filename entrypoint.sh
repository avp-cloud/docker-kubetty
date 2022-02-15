#!/usr/bin/env bash

TITLE="${TITLE:-KubeTTY}"
/gotty -a "0.0.0.0" -p "8080" --reconnect --permit-arguments --title-format "$TITLE" -w "/bin/bash"