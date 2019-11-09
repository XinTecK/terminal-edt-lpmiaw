#!/bin/bash

# Init config array
typeset -A config
config=(
  [username]=""
)

load_config () {
  while read line
  do
    varname=$(echo "$line" | cut -d '=' -f 1)
    config[$varname]=$(echo "$line" | cut -d '=' -f 2-)
  done < .config
}

init () {
  if [ -e .config ]
  then
    load_config
  else
    read -p "Entrez votre identifiant: " config[username]
    echo "username=${config[username]}" >> .config
  fi
}

init
