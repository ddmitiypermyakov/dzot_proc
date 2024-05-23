#!/bin/bash

# Получаем список всех PID процессов
pids=$(ls /proc | grep -E '^[0-9]+$')

# Проходимся по каждому PID
for pid in $pids; do
    # Проверяем, существует ли директория /proc/[PID]/fd
    if [ -d "/proc/$pid" ] && [ -e "/proc/$pid/fd" ]; then
        echo "PID: $pid"
        echo "Open Files:"

        # Получаем список файловых дескрипторов процесса
        fds=$(ls -l "/proc/$pid/fd" | grep -E '^l' | awk '{print $9}')

        # Выводим информацию о каждом открытом файле
        for fd in $fds; do
            file=$(readlink "/proc/$pid/fd/$fd")
            echo "  FD: $fd -> $file"
        done

        echo "------------------------"
    fi
done
