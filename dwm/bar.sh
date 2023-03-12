#!/bin/env bash

# vim:set ft=sh
# 参考 https://github.com/joestandring/dwm-bar
IDENTIFIER="unicode"
SEP1=" | "
SEP2=""

# datetime {{{
get_datetime() {
    local datetime="$(date "+%Y年%m月%d日 周%a %H:%M")"
    # local icon="DAT"
    # local icon="📆"

    echo $datetime
}
# }}}
# memory {{{
get_memory() {
    # local icon="MEM"
    # local icon="💻"

    [ "$LC_MESSAGES" == "en_US.UTF-8" ] && key="Mem" || key="内存"

    local free_output=$(free -h | grep $key)
    local used=$(echo $free_output | awk '{print $3}')
    local buffer=$(echo $free_output | awk '{print $6}')
    local total=$(echo $free_output | awk '{print $2}')
    echo "$key $used/$buffer/$total"
}

# }}}
# cpu{{{
get_cpu() {
    local icon="CPU"
    local cpu=$(top -bn1 | grep Cpu)
    local user=$(echo $cpu | awk '{print $2}')
    local sys=$(echo $cpu | awk '{print $4}')
    echo "$icon $user% $sys%"
}
# }}}
# storage {{{
get_storage() {
    local main=$(df -h / | tail -n 1 | awk '{print $4}')

    echo "$main"
}
# }}}
# alsa {{{
get_alsa() {
    local switch=$(amixer sget Master | tail -n1 | sed -r "s/.*\[(.*)\]/\1/")
    local vol=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    local icon="VOL"

    if [ "$IDENTIFIER" == "unicode" ]; then
        if [ "$switch" == off ] || [ "$vol" -eq 0 ]; then
            echo "🔇"
        elif [ "$vol" -gt 0 ] && [ "$vol" -le 33 ]; then
            echo "🔈$vol%"
        elif [ "$vol" -gt 33 ] && [ "$vol" -le 50 ]; then
            echo "🔉$vol%"
        else
            echo "🔊$vol%"
        fi
    elif [ "$switch" == "off" ]; then
        echo "MUTE"
    else
        echo "$icon $vol%"
    fi
}
# }}}
# battery {{{
get_battery() {
    local charge=$(cat /sys/class/power_supply/BAT0/capacity)
    local switch=$(cat /sys/class/power_supply/BAT0/status)
    local icon="BAT"

    if [ "$IDENTIFIER" == "unicode" ]; then
        [ "$switch" == "Charging" ] && icon="🔌" || icon="🔋"
    fi
    echo "$icon$charge%"
}
# }}}

bar=""
bar="$bar$(get_datetime)$SEP2"
bar="$bar$SEP1$(get_memory)$SEP2"
bar="$bar$SEP1$(get_cpu)$SEP2"
# bar="$bar$SEP1$(get_storage)$SEP2"
bar="$bar$SEP1$(get_alsa)$SEP2"
bar="$bar$SEP1$(get_battery)$SEP2"

xsetroot -name "$bar"
