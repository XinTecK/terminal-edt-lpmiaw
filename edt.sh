#!/bin/bash

# Init config array
typeset -A config
config=(
  [username]=""
)

# Init variables
ostype=$(echo $OSTYPE)
class_date=""
class_start_time=""
class_end_time=""
class_summary=""

load_config () {
  while read line
  do
    varname=$(echo "$line" | cut -d '=' -f 1)
    config[$varname]=$(echo "$line" | cut -d '=' -f 2-)
  done < $HOME/.edt-lpmiaw/config
}

init () {
  # Check if config directory exists
  if ! [ -d $HOME/.edt-lpmiaw ]
  then
    mkdir $HOME/.edt-lpmiaw
  fi
  # Check if config file exists
  if [ -e $HOME/.edt-lpmiaw/config ]
  then
    load_config
    load_edt
  else
    read -p "Entrez votre identifiant: " config[username]
    echo "username=${config[username]}" >> $HOME/.edt-lpmiaw/config
    load_edt
  fi
}

load_edt () {

  url="http://apps.univ-lr.fr/apps/sp/wa/ics?login=${config[username]}"

  # Set next week dates variables
  current_day_date=$(date +"%Y%m%d")
  if [[ "$ostype" =~ darwin* ]] # gdate for Mac, date for Linux => --date flag compatibility
  then
    next_1_day_date=$(gdate --date="1 day" +"%Y%m%d")
    next_2_day_date=$(gdate --date="2 day" +"%Y%m%d")
    next_3_day_date=$(gdate --date="3 day" +"%Y%m%d")
    next_4_day_date=$(gdate --date="4 day" +"%Y%m%d")
    next_5_day_date=$(gdate --date="5 day" +"%Y%m%d")
    next_6_day_date=$(gdate --date="6 day" +"%Y%m%d")
  else
    next_1_day_date=$(date --date="1 day" +"%Y%m%d")
    next_2_day_date=$(date --date="2 day" +"%Y%m%d")
    next_3_day_date=$(date --date="3 day" +"%Y%m%d")
    next_4_day_date=$(date --date="4 day" +"%Y%m%d")
    next_5_day_date=$(date --date="5 day" +"%Y%m%d")
    next_6_day_date=$(date --date="6 day" +"%Y%m%d")
  fi

  # Get edt file
  wget -qO - $url > $HOME/.edt-lpmiaw/edt

  # Display next week classes
  load_day $next_6_day_date
  load_day $next_5_day_date
  load_day $next_4_day_date
  load_day $next_3_day_date
  load_day $next_2_day_date
  load_day $next_1_day_date
  load_day $current_day_date
  
  rm $HOME/.edt-lpmiaw/edt
}

# [Parameter] day_date => string (ex: "20191110T093500")
load_day () {
  day_date=$1
  index=0
  
  day_date_with_slash=$(echo ${day_date:6:2} / ${day_date:4:2} / ${day_date:0:4})
  echo "------------------"
  echo "| $day_date_with_slash |"
  echo "------------------"

  # Foreach tasks for the specific day
  grep -A 2 "DTSTART;TZID=Europe/Paris:${day_date}" $HOME/.edt-lpmiaw/edt | while read -r line; do
    if [ "$line" != "--" ]
    then
      if [ $index == 0 ] # Class start time => DTSTART
      then
        index=$((index+1))
        initial_date=$(echo "$line" | rev | cut -d ':' -f 1 | rev) # Get date in format like "20191110T093500"
        class_start_time=$(echo ${initial_date:9:2}:${initial_date:11:2}:${initial_date:13:2})
      elif [ $index == 1 ] # Class end time => DTEND
      then
        index=$((index+1))
        initial_date=$(echo "$line" | rev | cut -d ':' -f 1 | rev) # Get date in format like "20191110T093500"
        class_end_time=$(echo ${initial_date:9:2}:${initial_date:11:2}:${initial_date:13:2})
      elif [ $index == 2 ] # Class summary => SUMMARY
      then
        index=0
        class_summary=$(echo -e "$line" | cut -d ':' -f 2-)
        # Display class
        echo "     -----------------------"
        echo "     | ${class_start_time} - ${class_end_time} |"
        echo "     -----------------------"
        echo "         |"
        echo "         -->" ${class_summary}
      fi
    fi
  done
}

init
