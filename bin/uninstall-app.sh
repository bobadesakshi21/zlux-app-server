#!/bin/sh
# This program and the accompanying materials are
# made available under the terms of the Eclipse Public License v2.0 which accompanies
# this distribution, and is available at https://www.eclipse.org/legal/epl-v20.html
# 
# SPDX-License-Identifier: EPL-2.0
# 
# Copyright Contributors to the Zowe Project.
if [ $# -eq 0 ]
  then
  echo "Usage: $0 AppID|AppPath [PluginsDir]"
  exit 1
fi

export _CEE_RUNOPTS="FILETAG(AUTOCVT,AUTOTAG) POSIX(ON)"
export _EDC_ADD_ERRNO2=1                        # show details on error
unset ENV             # just in case, as it can cause unexpected output

dir=$(cd `dirname $0` && pwd)

if [ -d "$1" ]; then
  arg_path="true"
  app_path=$(cd "$1"; pwd)  
else
  arg_path="false"
  app_id="$1"
fi

if [ $# -gt 1 ]
then
  plugin_dir=$2
  mkdir -p $plugin_dir
  shift
fi
shift

if [ -z "$plugin_dir" ]; then
  if [ -e "${INSTANCE_DIR}/workspace/app-server/serverConfig/server.json" ]; then
    config_path="${INSTANCE_DIR}/workspace/app-server/serverConfig/server.json"
  elif [ -e "${HOME}/.zowe/workspace/app-server/serverConfig/server.json" ]; then
    config_path="${HOME}/.zowe/workspace/app-server/serverConfig/server.json"
  elif [ -e "../deploy/instance/ZLUX/serverConfig/zluxserver.json" ]; then
    echo "WARNING: Using old configuration present in ${dir}/../deploy\n\
This configuration should be migrated for use with future versions. See documentation for more information.\n"
    config_path="../deploy/instance/ZLUX/serverConfig/zluxserver.json"
  else
    echo "Error: could not find plugin directory"
    exit 1
  fi
  plugin_dir=`grep "pluginsDir" "${config_path}" |  sed -e 's/"//g' | sed -e 's/.*: *//g' | sed -e 's/,.*//g'`
fi


if [ "$arg_path" == "true" ]; then
  id=`grep "identifier" ${app_path}/pluginDefinition.json |  sed -e 's/"//g' | sed -e 's/.*: *//g' | sed -e 's/,.*//g'`

  if [ -n "${id}" ]; then
    echo "Found plugin=${id}"
    app_id=$id
    echo "Ended with rc=$?"
  else
    echo "Error: could not find plugin id for path=${app_path}"
    exit 1
  fi
fi

if [ -n "${plugin_dir}" ]; then
  rm "${plugin_dir}/${app_id}.json"
else
  echo "Could not find plugins directory"
  exit 1
fi

