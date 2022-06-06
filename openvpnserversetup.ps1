$gname='win11'
$image='BizTalk-Server'
$location='southindia'
$urn='MicrosoftBizTalkServer:BizTalk-Server:2020-Standard:1.0.2' 
$adminuname='raj'
$adminpwd='Raj@MDPR12345'
$publicipsku='Standard'
$portstoopen='1194,943'
$vmname='win11'

az group create -n $gname -l $location -o json| convertfrom-json 


az vm create -n $vmname --image $urn --admin-username $adminuname `
 --admin-password $adminpwd  -g $gname `
 --public-ip-sku $publicipsku -o json |convertfrom-json

 #az vm open-port -g $gname -n $vmname --port 3389 --priority 100 -o json |convertfrom-json

 #az vm open-port -g $gname -n secureports --port $portstoopen --priority 100 -o json |convertfrom-json

 #az vm deallocate -g $gname -n $vmname 