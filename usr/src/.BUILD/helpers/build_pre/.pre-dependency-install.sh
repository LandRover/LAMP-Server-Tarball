#!/bin/bash

[ "$0" = "${BASH_SOURCE}" ] && echo "FILE CAN ONLY BE SOURCED, DIRECT EXECUTION IS NOT ALLOWED!" && exit 0;

# Unpacks source packages at /usr/src
# file is loaded via SOURCE and must NOT BE executed directly.

check_dependencies() {
  local any_dependency_missing=true

  # Check each dependency
  for DEP in "${DEPENDENCIES[@]}"; do
    if [ ! -f "$BIN_DIR/$DEP" ]; then
      echo "Error: Dependency '$DEP' not found in $BIN_DIR.";
    else
      echo "$DEP found in $BIN_DIR";
      any_dependency_missing=false
    fi
  done

  # Exit with status 1 if any dependency is missing
  if [ "$any_dependency_missing" = true ]; then
    exit 1
  fi
}

check_dependencies
