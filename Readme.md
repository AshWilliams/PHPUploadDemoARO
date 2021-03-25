
## Creación del Cluster de ARO (Azure RedHat Openshift)

```
#Creamos una VNET
az network vnet create --resource-group RG-ARO --name aro-vnet --address-prefixes 10.0.0.0/22

#Creamos una subnet para los nodos del control plane(master nodes)
az network vnet subnet create --resource-group RG-ARO --vnet-name aro-vnet --name master-subnet --address-prefixes 10.0.0.0/23 --service-endpoints Microsoft.ContainerRegistry

#Creamos una subnet para los nodos workers
az network vnet subnet create --resource-group RG-ARO --vnet-name aro-vnet --name worker-subnet --address-prefixes 10.0.2.0/23 --service-endpoints Microsoft.ContainerRegistry

#Deshabilitamos la politica de link privado para poder acceder a la consola de aro desde la internet
az network vnet subnet update --name master-subnet --resource-group RG-ARO --vnet-name aro-vnet --disable-private-link-service-network-policies true
```

Creamos una cuenta en https://cloud.redhat.com/openshift/install/azure/aro-provisioned damos click a `Download pull secret`, tal como aparece en la imagen

![foto1](images/foto1.png)

Luego desde la misma carpeta donde bajamos el `pull secret`, abrimos un terminal y ejecutamos en comando de creación del cluster.

```
#Creamos nuestro cluster con la configuración por defecto
az aro create -g RG-ARO -n "ARO-CLUSTER-DEMO" --vnet aro-vnet --master-subnet master-subnet --worker-subnet worker-subnet --worker-count 3 --pull-secret @pull-secret.txt
```

El comando tomará unos 30-40 minutos en desplegar el cluster. Una vez desplegado nos va a mostrar un json, donde nos podemos fijar en la siguiente información:

*`apiserverProfile` contiene la `API URL` necesaria para ingresar al cluster, por medio de `oc`

*`consoleProfile` contiene la `URL` para la consola de aro.

El comando construirá un cluster con 3 masters y 3 workers. Los nodos master tendrán un vm-size `D8s_v3` mientras los workers, un vm-size `D4s_v3`desplegados en 3 distintas `Availability Zones` dentro de la región elegida. Estos tamaños de máquinas virtuales y nos número de workers, se pueden modificar, por medio de los parámetros `–master-vm-size` y `–worker-vm-size`.

Para obtener las credenciales de ingreso a la consola, ejecutamos el siguiente comando:
```
az aro list-credentials -n "ARO-CLUSTER-DEMO" --resource-group RG-ARO
```