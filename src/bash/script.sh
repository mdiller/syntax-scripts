
printInfo()  { 
	msg="$*"
	echo "] $msg"
}

# get the directory of this script
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# go to the root directory of this folder
rootDir="$(dirname "$(dirname "$scriptDir")")"

# get the data directory
dataDir="$rootDir/data"

# get all json files in directory
files=( $(ls $dataDir | grep ".json") )

# bash array support is a bit limited. Heres a helpful link
# https://opensource.com/article/18/5/you-dont-know-bash-intro-bash-arrays


# list all json files in the directory by full path name, then filename, then ext
printInfo "JSON files:"
for file in ${files[@]}
do
	fullPath="$dataDir/$file"
	if [ ! -f "$fullPath" ]
	then
		# check if file exists, if it doesnt, just exit (shouldn't ever happen)
		exit 1
	fi

	echo $fullPath
	echo $(dirname "$fullPath")
	echo $file

	# parameter expansion documented here: 
	# http://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
	echo "${file%.*}"
	echo ".${file#*.}"
done

# use the first json file
filename="$dataDir/${files[0]}"

text=$(<"$filename")

# sed is usually just like sed 's/pattern/replacement/g' but we gotta do extra to deal with newlines
petNames=$(echo $text | jq '.pets[].name' -r | sed ':a; N; $!ba; s/\n/,/g')

printInfo "Pet Names:"
echo $petNames

readarray -t pets < <(echo $text | jq '.pets[]' -c)

# sort by age
readarray -t pets < <(
for str in "${pets[@]}"; do
	born="$(echo $str | jq '.born' -r)"
	timestamp="$(date -d "01 $born" +%s)"
	printf '%d\t%s\n' "$timestamp" "$str"
done | sort -k 1,1nr -k 2 | cut -f 2- )

printInfo "Pet Information"
for (( i=0; i<${#pets[@]}; i++ ))
do
	pet=${pets[$i]}

	now=$(date +%s)
	born="$(echo $pet | jq '.born' -r)"
	birthday="$(date -d "01 $born" +%s)"
	age=$(awk "BEGIN {print ($now - $birthday) / ( 3600.0 * 24.0 ) / 365.0}")
	age=$(printf "%.2f" $age)

	name="$(echo $pet | jq '.name' -r)"
	type="$(echo $pet | jq '.type' -r)"

	info="$name [$type] is $age years old"
	echo $info
done
