const path = require("path");
const fs = require("fs");

function printInfo(msg) {
	console.log(`] ${msg}`)
}

// get the directory of this script
var scriptDir = __dirname;

// go to the root directory of this folder
var rootDir = path.dirname(path.dirname(scriptDir));

// get the data directory
var dataDir = path.join(rootDir, "data");

// get all files in directory
var files = fs.readdirSync(dataDir);
files = files.filter(f => !fs.lstatSync(path.join(dataDir, f)).isDirectory());

// filter for only json files
files = files.filter(f => f.endsWith(".json"));

// list all json files in the directory by full path name, then filename, then ext
printInfo("JSON files:");
files.forEach(file => {
	var fullPath = path.join(dataDir, file);
	if (!fs.existsSync(fullPath)) {
		// check if file exists, if it doesnt, just exit(shouldn't ever happen)
		process.exit(1);
	}

	var splitted = file.split(".");
	console.log(fullPath);
	console.log(path.dirname(fullPath));
	console.log(file);
	console.log(splitted[0]);
	console.log("." + splitted[1]);
});

// use the first json file
var filename = path.join(dataDir, files[0]);

var text = fs.readFileSync(filename, "utf8");

var data = JSON.parse(text);

var petNames = data.pets.map(p => p.name);

printInfo("Pet Names:");
console.log(petNames.join(", "));

// sort by age
var pets = data.pets;
pets.sort((a, b) => Date.parse(b.born) - Date.parse(a.born));

printInfo("Pet Information");
for (var i = 0; i < pets.length; i++) {
	var pet = pets[i];

	var now = Date.now();
	var birthday = Date.parse(pet.born);
	var age = (now - birthday) / (1000 * 3600 * 24) / 365;
	age = age.toFixed(2);

	var info = `${pet.name} [${pet.type}] is ${age} years old`;
	console.log(info);
}

