#!/bin/bash
bckp_dir=/tmp/backups/

if [ "$#" -ne 2 ];
	then
        echo "WRONG numbers of arguments!" 1>&2
        exit 1
fi

if ! [ -d "$1" ];
        then
        echo "First parametr must be a directory" 1>&2
        exit 1
fi


if ! [[ "$2" =~ ^[0-9]*$ ]];
	then
        echo "Second parametr must be a number" 1>&2
	exit 1
fi

[ -d "$bckp_dir" ] || mkdir $bckp_dir

name=$(echo "$1" | sed 's/\//-/g' | sed 's/\-$//g' | sed 's/^.//g')
#echo $name

#bckp_num=$(find $bckp_dir -name "$name*" | wc -l)

file=${name}.$(date '+%Y-%m-%d-%H%M%S').tar.gz

tar --create --gzip --file="$bckp_dir$file" "$1" 2> /dev/null

rm -f $(find "$bckp_dir" -name "$name*" -type f -printf "%Ts\t$bckp_dir%P\n" | sort -n | head -n -"$2"| cut -f 2- )

		
