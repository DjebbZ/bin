#!/usr/bin/env fish

### Multicore temperature script for i3blocks.

# 4 cores temperatures
set full_text (sensors | grep Core | awk '{print substr($3, 2, length($3)-5)}' | tr '\n' ' ' | sed 's/ /°C /g')

# Package temperature
set short_text (sensors | grep 'Package id' | awk '{print substr($4, 2, length($4)-5)}' | tr '\n' ' ' | sed 's/ /°C  /g' | sed 's/  $//')

# max of 4 cores
set temps (echo $full_text | sed 's/°C//g' | sed 's/ /\n/g')

# consider 1st as max, and check others to avoid unecessary computations
set max $temps[1]

if test $temps[2] -ge $temps[1] -a $temps[2] -ge $temps[3] -a $temps[2] -ge $temps[4]
  set max $temps[2]
else if test $temps[3] -ge $temps[1] -a $temps[3] -ge $temps[2] -a $temps[3] -ge $temps[4]
  set max $temps[3]
else if test $temps[4] -ge $temps[1] -a $temps[4] -ge $temps[2] -a $temps[4] -ge $temps[3]
  set max $temps[4]
end

# color and icon depending on thresholds
set color "#00FF00" # temp < 45
set full_text " $full_text"
if test $max -gt 45 -a $max -lt 65
  set color "#FFD700"
  set full_text " $full_text"
else if test $max -ge 65
  set color "#FF0000"
  set full_text " $full_text"
end


### Output
echo $short_text
echo $short_text
echo $color
