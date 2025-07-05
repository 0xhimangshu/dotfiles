##################

#!/bin/bash

grep "CPU_SCALING_GOVERNOR_ON_AC=performance" /etc/tlp.conf &> /dev/null && echo "Perf" && exit
grep "CPU_SCALING_GOVERNOR_ON_AC=schedutil" /etc/tlp.conf &> /dev/null && echo "Balanced" && exit
grep "CPU_SCALING_GOVERNOR_ON_AC=powersave" /etc/tlp.conf &> /dev/null && echo "Save" && exit
echo "?"
