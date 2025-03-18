# Import OVA to Proxmox

1. Extract OVA file in Proxmox Server  

```bash
tar xvf vmfile.ova
```

2. Import VM Settings to Proxmox  

```
qm importovf 605 ./vmfile.ovf local --format qcow2
```

3. Remove existing disk from VM

4. Import VM Disk (VMDK) to Virtual Machine (VM)  

```
qm importdisk 605 vmfile.vmdk local -format qcow2
```

5. Add disk to VM (double click on it)

6. Add Virtual Network Interface

7. Add snapshot RESET
