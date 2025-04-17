#!/bin/sh

# Displays the current time and calendar

# Centers provided text horizontally
centerh() {
  length="${#1}"
  printf "%$(((columns+length)/2))s\n" "$1"
}

# Returns a value denoting whether the calendar should be hidden, or fully or
# partially displayed.
#
# Uses the dimensions of the terminal alongwith whether figlet(1) is used to
# display the time to determine the returned value.
#
# 0 => hidden, 1 => 3 months, 2 => 12 months, 3 => 1 month
is_cal_hidden() {
  if [ "$rows" -lt 11 ] || [ "$columns" -lt 25 ]; then
    return 0
  fi
  if [ "$columns" -lt 75 ]; then
    return 3
  fi
  if [ "$figlet_time" ]; then
    [ "$rows" -gt 38 ] && return 2
    return 1
  else
    [ "$rows" -gt 35 ] && return 2
    return 1
  fi
}

# Uses value from is_cal_hidden to display an appropriate calendar.
disp_cal() {
  case "$(is_cal_hidden; echo $?)" in
    0) return ;;
    1) echo; cal -3w ;;
    2) cal -yw | tail -n +2 ;;
    3) echo; cal -w ;;
  esac
}

# Displays the time, using figlet(1) if available.
#
# Uses the dimensions of the terminal alongwith the return value of
# is_cal_hidden to determine the size of the text to avoid any cut-off
disp_time() {
  curr_time="$(date '+%I:%M:%S')"
  if [ "$figlet_time" ]; then
    case "$(is_cal_hidden; echo $?)" in
      0)
        if [ "$rows" -gt 9 ]; then
          figlet -tcW -f big "$curr_time"
        elif [ "$rows" -gt 7 ]; then
          figlet -tcW -f standard "$curr_time"
        elif [ "$rows" -gt 5 ]; then
          figlet -tcW -f small "$curr_time"
        elif [ "$rows" -gt 3 ]; then
          figlet -tcW -f digital "$curr_time"
        else
          centerh "$curr_time"
        fi ;;
      1|3)
        if [ "$rows" -gt 17 ]; then
          figlet -tcW -f big "$curr_time"
        elif [ "$rows" -gt 15 ]; then
          figlet -tcW -f standard "$curr_time"
        elif [ "$rows" -gt 12 ]; then
          figlet -tcW -f digital "$curr_time"
        else
          centerh "$curr_time"
        fi ;;
      2)
        if [ "$rows" -gt 45 ]; then
          figlet -tcW -f big "$curr_time"
        elif [ "$rows" -gt 40 ]; then
          figlet -tcW -f standard "$curr_time"
        else
          figlet -tcW -f small "$curr_time"
        fi ;;
    esac
  else
    centerh "$curr_time"
  fi
}

# The main sequence of displaying the time and calendar
run() {
  # Get the dimensions of the terminal
  columns="$(tput cols)"
  rows="$(tput lines)"
  # Set a flag if figlet(1) should be used to display time and the terminal is
  # wide enough
  command -v figlet > /dev/null 2>&1 && [ "$columns" -gt 60 ] && figlet_time="Y"
  # Display the time
  disp_time
  # Display the date
  centerh "$(date '+%A, %d %B, %Y')"
  # Display the calendar
  disp_cal | while IFS= read -r line; do
    centerh "$line"
  done
}

run
