

```
az network vnet create --resource-group RG-ARO --name aro-vnet --address-prefixes 10.0.0.0/22

az network vnet subnet create --resource-group RG-ARO --vnet-name aro-vnet --name master-subnet --address-prefixes 10.0.0.0/23 --service-endpoints Microsoft.ContainerRegistry

az network vnet subnet create --resource-group RG-ARO --vnet-name aro-vnet --name worker-subnet --address-prefixes 10.0.2.0/23 --service-endpoints Microsoft.ContainerRegistry

az network vnet subnet update --name master-subnet --resource-group RG-ARO --vnet-name aro-vnet --disable-private-link-service-network-policies true


az aro create -g RG-ARO -n "ARO-CLUSTER-DEMO" --vnet aro-vnet --master-subnet master-subnet --worker-subnet worker-subnet --worker-count 3 --pull-secret @pull-secret.txt
```

`apiserverProfile` contains the API URL necessary to log in to the cluster
`consoleProfile` contains the URL for the WEB UI.


The command will deploy a cluster with 3 masters and 3 workers. The Masters will be D8s_v3 while the workers D4s_v3 machines deployed into three different Availability Zones within a Region. If these default sizes are not fitting for the purpose they can be parameterized within the create command with the –master-vm-size and –worker-vm-size parameters.
```
az aro list-credentials -n "ARO-CLUSTER-DEMO" --resource-group RG-ARO
```