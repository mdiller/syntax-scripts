# Syntax Scripts

The idea of this is to cover a whole bunch of basic syntaxes for several languages so that its all in one place and easy to look up if i want to know how to do a regex replace for each item in a list in any language for example. Also could be nice for people to look at potentially when learning new languages, and will likely help me learn new languages as I could just make it a task to add a new language to this list! This will probably mainly focus on "scripting" languages that dont require a lot of extra files/projects to be around in order to run them, but we'll see where it goes.

# A THOUGHT I'VE JUST HAD

Maybe instead of just an example script thing that doesnt really have a purpose, we give this script a job and a purpose, and each language has to do the same job/purpose. Could be interesting

# todo
- add more languages
- add more stuff to the script
- add a thing to test that theyre all the same

# Stuff to Cover
- func to print log info (use ] syntax)
  - maybe do a thing so you can pass in regular args
- func to do some regex operation on a string?
- strings
  - string templating
  - other string formatting stuff?
  - escaping quotes and newlines
  - check equality, do lowercase, startswith
  - regex?
    - replace
    - match finding
    - groups replacing
    - custom groups replace function
- lists/arrays
  - creation,addingstuff
  - foreach
  - for index,item
  - filter,map,etc, lambda functions
  - joining,splitting
- dictionaries
  - creating
  - list all keys
  - list all values
  - for loop?
  - maybe combine this with the json stuff
- os file structure navigation
  - get directory of currently running script
  - navigate to the /data directory
  - list files in dir
  - path join
  - abs path
  - check if exists
  - splitting path (ext, filename, dir)
- json
  - read file
  - convert to json object
  - edit
  - print pretty
  - print compressed
  - convert back
  - write file
- inspect objects
  - enumerate property names on object
  - print type of object
  - reflection to get object name
- rest api requests
- asyncio stuff
- regex tools
- including other files?
- accepting commandline input?
- run console commands
- comment documentation?
- set/get clipboard?
- exiting early + red console logging
- exception stack trace printing etc
- datetime stuff
- a readme file in the language dir that explains when to use it, where to get it, how to run it, what package manager to use, etc.
- other scripts to include:
  - minimal.ps1: shows the basic barebones you need for a script
  - domath.ps1: you give it args and it shows parsing command line shit in a super minimal way. could also show comment documentation example for something like this
  - draw.ps1: loads an image, does turtle drawing stuff, saves the image
  - use-libraries.ps1: shows how to import other files and import libraries etc
  - asyncio.ps1: shows how to do async/await stuff in most basic way possible

# Languages to Start With
- python
- powershell
- bash
- nodejs
- html/browser js
- c?
- C#