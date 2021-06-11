using Newtonsoft.Json.Linq;
using System;
using System.IO;
using System.Linq;

namespace SimpleScript
{
    class Program
	{
		public static void PrintInfo(string msg)
		{
			Console.WriteLine($"] { msg}");
		}

        public static int Main(string[] args)
        {
			// get the directory of this script
			var scriptDir = new DirectoryInfo(AppContext.BaseDirectory);

			// go to the root directory of this folder (we have to go up 5 times because we're several subfolders under bin)
			var rootDir = scriptDir.Parent.Parent.Parent.Parent.Parent;

			// get the data directory
			var dataDir = Path.Join(rootDir.FullName, "data");

			// get all files in directory
			var files = Directory.GetFiles(dataDir);

			// filter for only json files
			files = files.Where(f => f.EndsWith(".json")).ToArray();

			// list all json files in the directory by full path name, then filename, then ext
			PrintInfo("JSON files:");
			foreach (var fullPath in files)
			{
				var fileInfo = new FileInfo(fullPath);
				if (!fileInfo.Exists) {
					// check if file exists, if it doesnt, just exit(shouldn't ever happen)
					return 1;
				}

				Console.WriteLine(fileInfo.FullName);
				Console.WriteLine(fileInfo.DirectoryName);
				Console.WriteLine(fileInfo.Name);
				Console.WriteLine(fileInfo.Name.Replace(fileInfo.Extension, ""));
				Console.WriteLine(fileInfo.Extension);
			}

			// use the first json file
			var filename = files.First();

			var text = File.ReadAllText(filename);

			var data = JObject.Parse(text);

			var petNames = data["pets"].Select(p => p.Value<string>("name"));

			PrintInfo("Pet Names:");
			Console.WriteLine(string.Join(", ", petNames));

			// sort by age
			var pets = data["pets"].ToList();
			pets = pets
				.OrderBy(pet => DateTime.Parse(pet.Value<string>("born")))
				.Reverse()
				.ToList();

			PrintInfo("Pet Information");
			for (var i = 0; i < pets.Count; i++)
			{
				var pet = pets[i];

				var now = DateTime.Now;
				var birthday = DateTime.Parse(pet.Value<string>("born"));
				var age = (now - birthday).TotalDays / 365;

				var info = $"{pet["name"]} [{pet["type"]}] is {age:0.##} years old";
				Console.WriteLine(info);
			}

			return 0;
        }
    }
}
