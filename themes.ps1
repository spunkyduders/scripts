New-Module -scriptblock {
function Get-Themes{
$poshpath=$env:POSH_THEMES_PATH
$a=@(get-childitem $poshpath) 
for ($i=0;$i -le $a.count-1;$i++) 
{ 
  Write-Host "Theme $i :"$a[$i] 
  $cpath=Join-Path -path $poshpath -ChildPath $a[$i]
  $cmd=oh-my-posh.exe init powershell --config $cpath
  Invoke-Expression -Command $cmd 
  prompt
   
} 
}
} -name Themes
