
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
#   - lollygagging
#   - being "tired"


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