# PowerShell

I ran this via [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell), which should be pre-installed on most windows systems, and can now be installed on some linux systems too.

Note that first you'll need to allow powershell to execute unsigned scripts by doing something like this in powershell `Set-ExecutionPolicy unrestricted`. Note that this will let you execute any powershell scripts. Don't execute scripts you dont trust.

```
> powershell -Command ./script.ps1
```