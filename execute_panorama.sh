if [[ $# -ne 2 ]]; then
    printf "ERROR: Need two arguments.\n"
    printf "\tUsage: $0 <input_folder> <output_folder>\n"
    exit 1
fi

make -B
mkdir -p $2
mkdir -p $2/logs

obj_files=`find $1 -type f | grep ".obj"`

split=`echo "${obj_files[@]}"|xargs -n80`

for s in $split; do
  echo "split: ${s}"
done

# for file in $obj_files; do
#     echo $file
#     file_name=`echo $file | awk 'BEGIN{FS="/"} {print $NF}' | awk 'BEGIN{FS="."} {print $1}'`
#     echo $file_name
#     mkdir -p $2/$file_name/
#     bin/panorama_extended $file_name $file $2/$file_name/ $2/$file_name/ &> $2/logs/${file_name}.log
# done

# poweroff