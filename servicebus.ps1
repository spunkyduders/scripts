$rand=RANDOM
$gname='sbtest'
$location='southindia'
$namespace='sbtest'+$rand
$queue='empque'
$topic='emptopic'
$qpolicy='manageempq'
$tpolicy='manageempt'


az group create -n $gname -l $location -o json| ConvertFrom-Json

az servicebus namespace create -g $gname -n $namespace -l $location `
 --sku standard -o  json| ConvertFrom-Json

az servicebus queue create -g $gname -n $queue --namespace-name $namespace `
-o  json| ConvertFrom-Json

az servicebus queue authorization-rule create --resource-group $gname `
--namespace-name $namespace --queue-name $queue --name $qpolicy --rights Manage Send Listen

az servicebus topic create -g $gname -n $topic --namespace-name $namespace `
-o  json| ConvertFrom-Json

az servicebus topic authorization-rule create --resource-group $gname `
--namespace-name $namespace --topic-name $topic --name $tpolicy --rights Manage Send Listen



#az servicebus queue authorization-rule keys list --resource-group $gname `
# --namespace-name $namespace --queue-name $queue --name $qpolicy -o json|ConvertFrom-Json

#az group delete -n $gname -y

