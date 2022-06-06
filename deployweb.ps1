$rand=RANDOM
$webappname='mywebapp'+ $rand
$location='southindia'
$gname='deployweb'+$rand
$name='myweb'+$rand
$user='rsbtest'
$pwd='Raj@MDPR1'
$sitename='rsbtest'+$rand
$prodkey='prod'+$rand
$stagekey='stage'+$rand




Write-Host 'creating resource group....'.ToUpper()
Write-Host '=================================='

az group create --location $location --name $gname -o json |ConvertFrom-Json

Write-Host 'resource group created.'.ToUpper()
Write-Host '=================================='
Write-Host 'creating app service plan....'.ToUpper()

az appservice plan create --name $name --resource-group $gname --sku S1 -o json|ConvertFrom-Json

Write-Host 'app service plan created'.ToUpper()
Write-Host '=================================='
Write-Host 'creating web app....'.ToUpper()

az webapp create --name $sitename --resource-group $gname --plan $name -o json|ConvertFrom-Json

Write-Host 'web app created'.ToUpper()
Write-Host '=================================='
Write-Host 'setting deployment branch to main....'.ToUpper()

az webapp config appsettings set --name $sitename --resource-group $gname `
 --settings DEPLOYMENT_BRANCH=main -o json|ConvertFrom-Json

Write-Host 'setting deployment credentials....'.ToUpper()
Write-Host '=================================='
az webapp deployment user set --user-name $user --password $pwd -o json|ConvertFrom-Json

Write-Host 'retrieving git url....'.ToUpper()
Write-Host '=================================='
$giturl=$(az webapp deployment source config-local-git `
 --name $sitename --resource-group $gname --query url --output tsv)

 $giturl

Write-Host '=================================='
Write-Host 'Setting remote git....'.ToUpper()
git remote add $prodkey $giturl

Write-Host '=================================='
Write-Host 'pushing content to remote git....'.ToUpper()
git push $prodkey 

$prodweb= 'http://'+$sitename+'.azurewebsites.net'

start $prodweb


. D:\PROJECTS\simple-feed-reader\slots.ps1
slot -webappname $webappname,-location $location,-gname $gname,-name $name,-user $user,-pwd $pwd,-sitename $sitename,-stagekey $stagekey
