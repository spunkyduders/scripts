
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

$stageurl=$(az webapp deployment source config-local-git --name $sitename --resource-group $gname --slot staging --query url --output tsv)#make changes to the code

git commit -a -m "upgraded to V1"git remote add $stagekey $stageurlgit push $stagekey master#swap the slotsaz webapp deployment slot swap --name $sitename --resource-group $gname --slot staging$stageweb= 'http://'+$sitename+'-staging.azurewebsites.net'start $stageweb#clean the reources

#az group delete --name $gname -y
}