
function PrintInfo([string] $msg)  { 
	[Console]::ForegroundColor = 'yellow'
	[Console]::Write("] ")
	[Console]::ResetColor()
	[Console]::WriteLine($msg)
}

# get the directory of this script
$scriptDir = $PSScriptRoot

# go to the root directory of this folder
$rootDir = Split-Path -Parent (Split-Path -Parent $scriptDir)

# get the data directory
$dataDir = Join-Path -Path $rootDir "data"

# get all files in directory
$files = Get-ChildItem -Path $dataDir
$files = $files | ? { -not $_.PSIsContainer }

# filter for only json files
$files = $files | ? { $_.Extension -eq ".json" }

# list all json files in the directory by full path name, then filename, then ext
PrintInfo "JSON files:"
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

$data = $text | ConvertFrom-Json

$petNames = $data.pets | % { $_.name }

PrintInfo "Pet Names:"
$petNames

# sort by age
$pets = $data.pets | Sort-Object { [datetime]::ParseExact($_.born, "MMM yyyy", $null) } -Descending

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

