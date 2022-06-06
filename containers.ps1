
$gname='container'
$location='southindia'
$container='test'
$image ='ghost'
$port='2368'


az group create -n $gname -l $location


az container create --name $container --image $image  --port $port -g $gname `
--ip-address public 

$ip=az container list --query "[?contains(name, 'test')].[ipAddress.ip]" --output tsv

$url ='http://'+$ip+':'+$port

start $url


#az group delete -n container -y