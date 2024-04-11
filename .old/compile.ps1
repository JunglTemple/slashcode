Import-Module .\compileModule.psm1

Import-SlashFunctions -FilePath ".\functions.csv"
Parse-SlashFile -FilePath ".\main.slash"