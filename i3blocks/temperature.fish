#!/usr/bin/env fish

### Temperature script for i3blocks.
### The one shipped with i3blocks retrieves the wrong temperature.

# Package temperature
set value (sensors | grep 'Package id' | awk '{print substr($4, 2, 2)}')

# color and icon depending on thresholds
set color "#00FF00" # temp < 45
if test $value -gt 45 -a $value -lt 65
  set color "#FFD700"
else if test $value -ge 65
  set color "#FF0000"
end

set full_text (string join " " "" $value "°C")

### Output
echo $full_text   # i3bar's full_text
echo $full_text   # i3bar's short_textr
echo $color       # i3bar's color
