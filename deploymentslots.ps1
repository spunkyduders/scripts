﻿
function slot{
param(
$webappname,
$location,
$gname,
$name,
$user,
$pwd,
$sitename,
$stagekey)


#****************************
az webapp deployment slot create --name $sitename --resource-group $gname --slot staging

az webapp config appsettings set --name $sitename --resource-group $gname --slot staging --settings DEPLOYMENT_BRANCH=master

$stageurl=$(az webapp deployment source config-local-git --name $sitename --resource-group $gname --slot staging --query url --output tsv)

git commit -a -m "upgraded to V1"

#az group delete --name $gname -y
}