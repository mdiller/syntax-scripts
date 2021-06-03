
function PrintInfo([string] $msg)  { 
	[Console]::ForegroundColor = 'yellow'
	[Console]::Write("] ")
	[Console]::ResetColor()
	[Console]::Error.WriteLine($msg)
}

#
# SECTION 1: STRINGS
# 

PrintInfo "SECTION 1: STRINGS"

$name = "Bob"
$lastName = "Bobson"

$name
# PRINTS: Bob

"The name is $lastName, $name $lastName"
# PRINTS: The name is Bobson, Bob Bobson

"I said, my name is $($name.ToUpper())!"
# PRINTS: I said, my name is BOB!

PrintInfo "escaping"
$thingsBobHates = "There are 2 things I hate:`n- lollygagging`n- being `"tired`""
$thingsBobHates
# PRINTS:
# There are 2 things I hate:
#	- lollygagging
#	- being "tired"


PrintInfo "multi-line string"
# this would print the same thing
$thingsBobHates2 = @"
There are 2 things I hate:
- lollygagging
- being "tired"
"@


PrintInfo "string list splitting/joining"
$sentance = @( "An", "example", "sentance", "goes", "something", "like", "this" ) -join " "

$sentance
# PRINTS: An example sentance goes something like this

$sentance -split " "
# PRINTS: 
# An
# example
# sentance
# goes
# something
# like
# this

PrintInfo "regex"
# this is some sloppy regex for a word that ends in s.
$pattern = "(?<=\s)([^\s])([^\s]+s)(?= |$)"

$sentance -replace $pattern,"banana"
# PRINTS: An example sentance banana something like banana

$match = [regex]::Match($sentance, $pattern)

if ($match.Success) {
	$match.groups[0].Value
	# PRINTS: goes

	$match.groups[1].Value
	# PRINTS: g

	$match.groups[2].Value
	# PRINTS: oes
}


#
# SECTION 2: LISTS
# 

PrintInfo "SECTION 2: LISTS"

$numbers = @( 7, 123, 555 )

$numbers += 12345

PrintInfo "enumerating"
foreach ($item in $numbers) {
	$item
}
for ($i = 0; $i -lt $numbers.Length; $i++) {
	$numbers[$i]
}
$numbers
# (ALL OF THE ABOVE) PRINT:
# 7
# 123
# 555
# 12345

PrintInfo "filtering"
$numbers | ? { $_ -gt 200 }
# PRINTS:
# 555
# 12345

PrintInfo "mapping"
$numbers | % { $_ + 200 }
# map
# 207
# 323
# 755
# 12545


#
# SECTION 3: FILE SYSTEM
# 

PrintInfo "SECTION 3: FILE SYSTEM"

# get the directory of this script
$scriptDir = $PSScriptRoot

# go to the root directory of this folder
$rootDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)

# get the data directory
$dataDir = Join-Path -Path $rootDir "data"

# get all files in directory
$files = Get-ChildItem -Path $dataDir
$files = $files | ? { -not $_.PSIsContainer }

# filter for only json files
$files = $files | ? { $_.Extension -eq ".json" }

# list all json files in the directory by full path name, then filename, then ext
PrintInfo "json files:"
foreach ($file in $files) {
	if (-not (Test-Path -Path $file.FullName)) {
		# check if file exists, if it doesnt, just exit (shouldn't ever happen)
		exit 1
	}

	# $file is a FileInfo object (if you start witha path use Get-Item to turn it into FileInfo or DirectoryInfo)
	$file.FullName
	$file.Directory.FullName
	$file.Name
	$file.BaseName
	$file.Extension
}


# use the first json file
$filename = $files[0].FullName

$text = Get-Content -Path $filename

$json = $text | ConvertFrom-Json

$petNames = $json.pets | % { $_.name }

PrintInfo "Pet Names:"
$petNames

# sort by age
$pets = $json.pets | Sort-Object { [datetime]::ParseExact($_.born, "MMM yyyy", $null) } -Descending

PrintInfo "Pet Information"
for ($i = 0; $i -lt $pets.Length; $i++) {
	$pet = $pets[$i]

	$now = Get-Date
	$birthday = [datetime]::ParseExact($pet.born, "MMM yyyy", $null)
	$age = ($now - $birthday).TotalDays / 365
	$age = "{0:n2}" -f $age

	$info = "$($pet.name) [$($pet.type)] is $age years old"
	$info
}

