# Minecraft to Kubernetes

Deploy a Minecraft Java Edition server to Kubernetes.

## Prepare

- kubernetes environment
- loadbalancer

The easy way is to use `microk8s`. https://microk8s.io/

If you can use `snap` (If your OS is Ubuntu)

```
$ snap install microk8s --classic
$ sudo microk8s enable dns 
$ sudo microk8s enable metallb
```

To use MicroK8s with your existing kubectl:

```
sudo microk8s kubectl config view --raw > $HOME/.kube/config
```

## Deploy Minecraft

Create a persistentVolume
> Note: `option/persistentVolume.yaml` will create a persistent volume for `hostPath`. If you are using this in a multi-node environment, you should consider using `nfs`.
> 
> Also, in GKE, this operation is not necessary because the persistent volume is automatically created by dynamic provisioning.

```
$ kubectl apply -f option/persistentVolume.yaml
```

create StatefulSet & ConfigMap & Service

```
$ kubectl apply -k base
```

check External-IP

```
$ kubectl get svc minecraft
NAME        TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)           AGE
minecraft   LoadBalancer   10.152.183.139   192.168.1.150   25565:32219/TCP   10m
```

Access External-IP Address in minecraft client.

Enjoy !

## delete 

delete StatefulSet & ConfigMap & Service

```
$ kubectl delete -k base
```

delete persistentVolumeClaim

```
$ kubectl delete pvc -l app=minecraft
```

delete persistent volume(If you have created a persistent volume manually)

```
$ kubectl delete -f option/persistentVolume.yaml
```

## Use RamDisk

Minecraft server runs faster with RamDisk

The manifest to use ramdisk is in `overlays/ramdisk`

if you want use ramdisk, apply Manufest

> Caution: There is a risk of data loss!

```
$ kubectl apply -k overlays/ramdisk/
```
