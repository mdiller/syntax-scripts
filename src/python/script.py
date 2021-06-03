import os
import json
import datetime

def PrintInfo(msg):
	print(f"] {msg}")

# get the directory of this script
scriptDir = os.path.dirname(os.path.realpath(__file__))

# go to the root directory of this folder
rootDir = os.path.dirname((os.path.dirname(scriptDir)))

# get the data directory
dataDir = os.path.join(rootDir, "data")

# get all files in directory
files = os.listdir(dataDir)
files = [f for f in files if os.path.isfile(os.path.join(dataDir, f))]

# filter for only json files
files = list(filter(lambda f: f.endswith(".json"), files))

# list all json files in the directory by full path name, then filename, then ext
PrintInfo("JSON files:")
for file in files:
	fullPath = os.path.join(dataDir, file)
	if not os.path.exists(fullPath):
		# check if file exists, if it doesnt, just exit (shouldn't ever happen)
		exit(1)

	name, extension = os.path.splitext(file)
	print(fullPath)
	print(os.path.dirname(fullPath))
	print(file)
	print(name)
	print(extension)

# use the first json file
filename = os.path.join(dataDir, files[0])

with open(filename, "r") as f:
	text = f.read()

data = json.loads(text)

petNames = list(map(lambda p: p["name"], data["pets"]))

PrintInfo("Pet Names:")
for name in petNames:
	print(name)

# sort by age
pets = sorted(data["pets"], key=lambda p: datetime.datetime.strptime(p["born"], "%b %Y"), reverse=True)

PrintInfo("Pet Information")
for i in range(len(pets)):
	pet = pets[i]

	now = datetime.datetime.now()
	birthday = datetime.datetime.strptime(pet["born"], "%b %Y")
	age = (now - birthday).days / 365

	info = f"{pet['name']} [{pet['type']}] is {age:.2f} years old"
	print(info)

