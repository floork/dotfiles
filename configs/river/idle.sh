#!/bin/env bash

LOCK_CMD="swaylock"
DPMS_OFF_CMD="wlopm --off '*'"
DPMS_ON_CMD="wlopm --on '*'"

# times
LOCK_TIME=300
DPMS_TIME=350

# color
LOCK_COLOR=000000

swayidle -w \
    timeout "$LOCK_TIME" "$LOCK_CMD -f -c $LOCK_COLOR" \
    timeout "$DPMS_TIME" "$DPMS_OFF_CMD" \
    resume "$DPMS_ON_CMD" \
    before-sleep "$LOCK_CMD -f -c $LOCK_COLOR"
