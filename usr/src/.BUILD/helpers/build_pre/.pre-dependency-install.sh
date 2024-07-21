#!/bin/bash

[ "$0" = "${BASH_SOURCE}" ] && echo "FILE CAN ONLY BE SOURCED, DIRECT EXECUTION IS NOT ALLOWED!" && exit 0;

# Unpacks source packages at /usr/src
# file is loaded via SOURCE and must NOT BE executed directly.

any_dependencies_found=false;

# Check each dependency
for DEP in "${DEPENDENCIES[@]}"; do
  if [ ! -d "${BIN_DIR}/${DEP}" ]; then
    echo "Error: Dependency '${DEP}' not found in ${BIN_DIR}.";
    any_dependencies_found=true;
  fi
done

# Exit with status 1 if any dependency is missing
if [ "${any_dependencies_found}" = true ]; then
  exit 1
fi
