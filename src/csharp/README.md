# C#

I ran this using [Visual Studio 2019](https://visualstudio.microsoft.com/downloads/) (Community Edition). It should run fine in non-windows environments too as it is configured for .NET Core 3.1. I'm using the [Newtonsoft.JSON](https://www.newtonsoft.com/json) NuGet package, as that's the classic way of dealing with json in C#. If you open the project in visual studio and hit run it'll likely setup and build everything for you and run just fine.

If you'd rather run it from command line, you can build it and then run it with this:
```
> dotnet SimpleScript.dll
```