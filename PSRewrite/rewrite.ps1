
<#--adding init values--#>
function Set-OrAddIniValue
{
    Param(
        [string]$FilePath,
        [hashtable]$keyValueList
    )

    $content = Get-Content $FilePath

    $keyValueList.GetEnumerator() | ForEach-Object {
        if ($content -match "^$($_.Key)=")
        {
            $content= $content -replace "^$($_.Key)=(.*)", "$($_.Key)=$($_.Value)"
        }
        else
        {
            $content += "$($_.Key)=$($_.Value)"
        }
    }

    $content | Set-Content $FilePath
}

<#--makes customer filedirecotry--#>
function createDirectory($cName){
    New-Variable -Name dir1 -Value "C:\Users\WCHAN\Desktop\PSRewrite\$cName" -Scope Global
    New-Item -Path $dir1 -ItemType Directory -Force
    cp -Force -Recurse C:\Users\WCHAN\Desktop\PSRewrite\clean\* $dir1
    
    
}


<#---cleanfiles #>
$list = @()
$list += "\web\iceconfig.js"
$list +=  "\web\Web.config"
$list += "\packager\install.ini"
$list += "\recorder\iceRecordingManager.exe.config"
$list += "\recorder\iceUCMARecorder.exe.config"
$list += "\imr\iceIMRHostService.exe.config"


<#---vars---#>
$cName = "BCMSD"
$webServer = "web12.icescape.com"
$switchID = "11001"
$sqlServer = "ctdvmsql01.ctd.local"
$switchDB = "ctdvmice01Switch"+$switchID
$sqlUser = "sa"
$sqlPwd = "ctt^sql^288"

<#-- readhost--#>
<#
Set-OrAddIniValue -FilePath "C:\Users\WCHAN\Desktop\PSRewrite\install.ini"  -keyValueList @{
    Server = "testserver.icescape.com"
    Port = "20702"
    SwitchID = "$switchID"
    GlobalConfigLocation = "https://"+$webServer+"/"+$cName+"/iceBARConfig/iceBARWebService.asmx"

}

Set-OrAddIniValue -FilePath "C:\Users\WCHAN\Desktop\PSRewrite\install.ini"  -keyValueList @{
    Server = "testserver.icescape.com"
    Port = "20702"
    SwitchID = "$switchID"
    GlobalConfigLocation = "https://"+$webServer+"/"+$cName+"/iceBARConfig/iceBARWebService.asmx"

}

# Load the file
$FileContentVariable = Get-Content -Path .\textfile.txt

# Replace the value for "Setting1" with "This is my new setting" - note the use of tick marks (`) for escaping quotes
$FileContentVariable = $FileContentVariable -replace ("Setting1=`"This is a placeholder`"", "Setting1=`"This is my new setting`"")

# Replace the value for "Setting2" with "Here is an iguana" but use a regular expression for the search this time.
$FileContentVariable = $FileContentVariable -replace ("Setting2=.+", "Setting2=`"Here is an iguana`"")

# Export the new variable to a new text file (or to the old file if you're updating a config file)
$FileContentVariable | Out-File -FilePath .\textfile_updated.txt




#>

$fList = @()
<#--actions--#>
createDirectory($cName) --quiet

<#
for($i = 0; $i -lt $list.Count; $i++)
{
   $fList += $dir1 + $list[$i]
   foreach
}#>