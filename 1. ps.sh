#!/bin/bash

# Получаем список всех PID процессов
pids=$(ls /proc | grep -E '^[0-9]+$')

# Проходимся по каждому PID
for pid in $pids; do
    # Проверяем, существует ли директория /proc/[PID]/status
    if [ -d "/proc/$pid" ] && [ -e "/proc/$pid/status" ]; then
        # Читаем содержимое файла /proc/[PID]/status
        status=$(cat "/proc/$pid/status")

        # Извлекаем необходимую информацию из содержимого файла
        name=$(grep -E '^Name:' <<< "$status" | awk '{print $2}')
        state=$(grep -E '^State:' <<< "$status" | awk '{print $2}')
        ppid=$(grep -E '^PPid:' <<< "$status" | awk '{print $2}')
        threads=$(grep -E '^Threads:' <<< "$status" | awk '{print $2}')

        # Выводим информацию о процессе
        echo "PID: $pid"
        echo "Name: $name"
        echo "State: $state"
        echo "PPID: $ppid"
        echo "Threads: $threads"
        echo "------------------------"
    fi
done
