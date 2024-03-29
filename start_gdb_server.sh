#!/usr/bin/env bash

function print_usage() {
  RED='\033[0;31m'
  BLUE='\033[0;34m'
  BOLD='\033[1m'
  NONE='\033[0m'

  echo -e "\n${RED}Usage${NONE}:
  .${BOLD}/start_gdb_server.sh${NONE} MODULE_NAME PORT_NUMBER"

  echo -e "${RED}MODULE_NAME${NONE}:
  ${BLUE}agvctrl${NONE}: debug the agvctrl module.
  ${BLUE}agvstate${NONE}: debug the agvstate module.
  ${BLUE}transfer${NONE}: debug the transfer module.
  ..., and so on."

  echo -e "${RED}PORT_NUMBER${NONE}:
  ${NONE}a port number, such as '9999'."
}

if [ $# -lt 2 ];then
    print_usage
    exit 1
fi

# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# source "${DIR}/apollo_base.sh"

MODULE_NAME=$1
PORT_NUM=$2
shift 2

# If there is a gdbserver process running, stop it first.
GDBSERVER_NUMS=$(pgrep -c -x "gdbserver")
if [ ${GDBSERVER_NUMS} -ne 0 ]; then
  sudo pkill -f "gdbserver"
fi

# Because the "grep ${MODULE_NAME}" always generates a process with the name of
# "${MODULE_NAME}", I added another grep to remove grep itself from the output.
# The following command got a wrong result and I can't find the reason.
#PROCESS_ID=$(ps -eo pid,command | grep "${MODULE_NAME}" | grep -v "grep" | awk '{print $1}')
# This one is OK.
PROCESS_ID=$(pgrep -o -x "${MODULE_NAME}")
#echo ${PROCESS_ID}

# If the moudle is not started, start it first.
if [ -z ${PROCESS_ID} ]; then
  #echo "The '${MODULE_NAME}' module is not started, please start it in the dreamview first. "
  #exit 1

  # run function from apollo_base.sh
  # run command_name module_name
  ./${MODULE_NAME} &

  PROCESS_ID=$(pgrep -o -x "${MODULE_NAME}")
fi

gdbserver :${PORT_NUM} --attach ${PROCESS_ID}