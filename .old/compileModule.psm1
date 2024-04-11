# Define-SlashFunction
function Define-SlashFunction {
	param (
		[string]$Name,
		[string]$Args,
		[scriptblock]$TranslateTo
	)

	$SlashFunctions = Get-Variable -Name "SlashFunctions" -Scope Global -ErrorAction SilentlyContinue
	if (-not $SlashFunctions) {
		$SlashFunctions = @{}
	}

	$SlashFunctions[$Name] = @{
		Name = $Name
		Args = $Args
		TranslateTo = $TranslateTo
	}

	Set-Variable -Name "SlashFunctions" -Value $SlashFunctions -Scope Global
}

# Get-SlashFunction
function Get-SlashFunction {
	param (
		[string]$Name
	)

	$SlashFunctions = Get-Variable -Name "SlashFunctions" -Scope Global -ErrorAction SilentlyContinue
	if ($SlashFunctions -and $SlashFunctions.ContainsKey($Name)) {
		return $SlashFunctions[$Name]
	} else {
		return $null
	}
}

# Remove-SlashFunction
function Remove-SlashFunction {
	param (
		[string]$Name
	)

	$SlashFunctions = Get-Variable -Name "SlashFunctions" -Scope Global -ErrorAction SilentlyContinue
	if ($SlashFunctions -and $SlashFunctions.ContainsKey($Name)) {
		$SlashFunctions.Remove($Name)
		Set-Variable -Name "SlashFunctions" -Value $SlashFunctions -Scope Global
	}
}

# Invoke-SlashFunction
function Invoke-SlashFunction {
	param (
		[string]$Name,
		[object[]]$Arguments
	)

	$FunctionInfo = Get-SlashFunction -Name $Name
	if ($FunctionInfo -ne $null) {
		& $FunctionInfo.TranslateTo @Arguments
	} else {
		Write-Host "Error: SlashCode function '$Name' not found."
	}
}

# Import-SlashFunctions
function Import-SlashFunctions {
	param (
		[string]$FilePath
	)

	$functions = Import-Csv -Path $FilePath
	foreach ($function in $functions) {
		# Convert translation string to script block
		$translateTo = [scriptblock]::Create($function.TranslateTo)
		Define-SlashFunction -Name $function.Name -Args $function.Args -TranslateTo $translateTo
	}
}

# Export-SlashFunctions
function Export-SlashFunctions {
	param (
		[string]$FilePath
	)

	$SlashFunctions = Get-Variable -Name "SlashFunctions" -Scope Global -ErrorAction SilentlyContinue
	if ($SlashFunctions) {
		$SlashFunctions.Values | Export-Csv -Path $FilePath -NoTypeInformation
	}
}
