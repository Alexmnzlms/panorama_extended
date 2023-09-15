#!/bin/bash

source_folder=$1
output_folder=$2

if [ "$#" -ne 2 ]; then
    echo "Wrong number of params"
    echo "./execute_panorama source_folder output_folder"
    exit
fi

num_processes=14
num_jobs=0

start=$(date +%s)
for folder in $source_folder/*; do
    case_number=`echo $folder | awk -F "/" '{print $2}'`
    # echo $case_number

    for file in $source_folder/$case_number/*; do
        file_name=`echo $file | awk -F "/" '{print $3}'`
        laterality=`echo $file_name | awk -F "_" '{print $2}'`
        echo $file_name
        output=$output_folder/$case_number\_$laterality/
        if [[ ! -d $output ]]; then
            mkdir -p $output
            bin/panorama_extended $case_number\_$laterality $file $output $output > logs/$file_name.log &
            num_jobs=$((num_jobs+1))
        else
            echo "Skipping folder $output"
        fi
    done

    if [[ $num_jobs -ge $num_processes ]]; then
        echo "Reached $num_jobs processes. Waitng..."
        wait
        end=$(date +%s)
        echo "Elapsed Time: $(($end-$start)) seconds"
        num_jobs=0
    fi

done

wait

poweroff