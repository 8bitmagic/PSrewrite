
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
$varList = Get-ChildItem *.* -Recurse | Select-Object FullName 


<#---vars---#>
$cName = "BCMSD"
$webServer = "web12.icescape.com"
$iceServer = "bcmsdtest.icescape.com"
$switchID = "11001"
$imrPort = "9500"
$netTcpPort = "10000"
$sRPort= "9600"
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


for($i = 0; $i -lt $varList.Count; $i++)
{
   $item1 =  $varList[$i].FullName
   #Write-Host $item1
   #$FCV = Get-Content -Path $item1 
   
   switch ($item1){

   {$item1 -like '*iceIMR*'} { 
   Write-Host "IMR!!!"
   $FileContentVariable = Get-Content -Path $item1 | ForEach-Object {
   #$_.replace("https://localhost:8301/iceIMRService", "https://$($webServer):$($imrPort)/iceIMRService").replace("net.tcp://localhost:8401/iceIMRService", "net.tcp://$($webServer):$($netTcpPort)/iceIMRService").replace("<add key=""iceIMRService.SwitchId"" value=""11001""/>", "<add key=""iceIMRService.SwitchId"" value=""$($switchID)""/>").replace("<add key=""iceIMRService.icePassword"" value=""PASSWORD""/>", "<add key=""iceIMRService.icePassword"" value=""288""/>").replace("<add key=""iceIMRService.iceAddress"" value=""ice.domain.com""/>", "<add key=""iceIMRService.iceAddress"" value=""$($iceServer)""/>")  
   
    $_.replace("https://localhost:8301/iceIMRService", "https://$($webServer):$($imrPort)/iceIMRService").replace("net.tcp://localhost:8401/iceIMRService", "net.tcp://$($webServer):$($netTcpPort)/iceIMRService").replace("<add key=""iceIMRService.SwitchId"" value=""11001""/>", "<add key=""iceIMRService.SwitchId"" value=""$($switchID)""/>").replace("<add key=""iceIMRService.icePassword"" value=""PASSWORD""/>", "<add key=""iceIMRService.icePassword"" value=""288""/>").replace("<add key=""iceIMRService.iceAddress"" value=""ice.domain.com""/>", "<add key=""iceIMRService.iceAddress"" value=""$($iceServer)""/>").replace("<add key=""iceIMRService.EmailAlertSMTPServer"" value=""email.domain.com""/>", "<add key=""iceIMRService.EmailAlertSMTPServer"" value=""10.258.258.25""/>").replace("<add key=""iceIMRService.iceDBConnectionString"" value=""Data Source=""$($sqlServer)"";Initial Catalog=iceSwitch11001;Persist Security Info=True;User Id=sa;Password=PASSWORD""/>","<add key=""iceIMRService.iceDBConnectionString"" value=""Data Source=""$($sqlServer)"";Initial Catalog=""$($iceDB)"";Persist Security Info=True;User Id=sa;Password=288""/>").replace("<add key=""iceIMRService.iceMailDBConnectionString"" value=""Data Source=localhost;Initial Catalog=iceMail;Persist Security Info=True;User Id=sa;Password=PASSWORD""/>","<add key=""iceIMRService.iceMailDBConnectionString"" value=""Data Source=$($sqlServer);Initial Catalog=$($iceDB)Mail;Persist Security Info=True;User Id=sa;Password=288""/>")


   }
   $FileContentVariable | Out-File -FilePath $item1
   #Write-Host $FileContentVariable
   
   <#
   $FileContentVariable = $FileContentVariable -replace ("https://localhost:8301/iceIMRService", "https://$($webServer):$($imrPort)/iceIMRService")
   $FileContentVariable = $FileContentVariable -replace ("net.tcp://localhost:8401/iceIMRService", "net.tcp://$($webServer):$($netTcpPort)/iceIMRService")
   $FileContentVariable = $FileContentVariable -replace ("<add key=""iceIMRService.SwitchId"" value=""11001""/>", "<add key=""iceIMRService.SwitchId"" value=""$($switchID)""/>")
  
   $FileContentVariable | Out-File -FilePath $item1
   #>
  }

  <#

   {$item1 -like '*install*'} {Write-Host "install!"   }
   {$item1 -like '*RecordingManager*'} {Write-Host "RecordingManager!"   }
   {$item1 -like '*UcmaRec*'} {Write-Host "UCMA!"   }
   {$item1 -like '*.js*'} {Write-Host "js!"   }
   {$item1 -like '*web*'} {Write-Host "web!"   }
   #>
   }

}

