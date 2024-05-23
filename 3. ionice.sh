#!/bin/bash

# Функция для выполнения процесса с ionice и замером времени выполнения
execute_process() {
    local ionice_value=$1
    local command=$2

    # Запускаем процесс с заданным значением ionice
    ionice -c 3 -n $ionice_value $command > output_$ionice_value.txt 2>&1

    # Выводим время выполнения процесса
    echo "Process with ionice $ionice_value completed in $(($(date +%s) - start_time)) seconds"
}

# Запускаем замер времени выполнения
start_time=$(date +%s)

# Запускаем два конкурирующих процесса с разными значениями ionice
execute_process 0 "dd if=/dev/zero of=output1.txt bs=1M count=1000"
execute_process 7 "dd if=/dev/zero of=output2.txt bs=1M count=1000"

# Выводим логи в консоль
echo "Output of process with ionice 0:"
cat output_0.txt
echo "------------------------"
echo "Output of process with ionice 7:"
cat output_7.txt
