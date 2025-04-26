#! /usr/bin/bash


CPU_TEMP=$(cut -c 1,2 < /sys/class/hwmon/hwmon4/temp1_input)
GPU_TEMP=$(cut -c 1,2< /sys/class/hwmon/hwmon4/temp2_input)
FAN_1=$(cat /sys/class/hwmon/hwmon4/fan1_input)
FAN_2=$(cat /sys/class/hwmon/hwmon4/fan2_input)

echo "CPU:""$CPU_TEMP"" GPU:""$GPU_TEMP" "FANS:""$FAN_1"/"$FAN_2"
