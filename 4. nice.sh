#!/bin/bash

# Функция для выполнения процесса с nice и замером времени выполнения
execute_process() {
    local nice_value=$1
    local command=$2

    # Запускаем процесс с заданным значением nice
    nice -n $nice_value $command > output_$nice_value.txt 2>&1

    # Выводим время выполнения процесса
    echo "Process with nice $nice_value completed in $(($(date +%s) - start_time)) seconds"
}

# Запускаем замер времени выполнения
start_time=$(date +%s)

# Запускаем два конкурирующих процесса с разными значениями nice
execute_process 0 "yes > /dev/null"
execute_process 10 "yes > /dev/null"

# Выводим логи в консоль
echo "Output of process with nice 0:"
cat output_0.txt
echo "------------------------"
echo "Output of process with nice 10:"
cat output_10.txt
