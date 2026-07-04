#!/bin/bash
set -e

source shell/custom-packages.sh

make image \
  PROFILE="generic" \
  PACKAGES="$CUSTOM_PACKAGES"
