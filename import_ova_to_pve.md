# Import OVA to Proxmox

1. Extract OVA file in Proxmox Server  


```bash
tar xvf mrRobot.ova
```

2. Import VM Settings to Proxmox  


```
qm importovf 605 ./mrRobot.ovf local --format qcow2
```

3. Remove existing disk from VM

4. Import VM Disk (VMDK) to Virtual Machine (VM)  


```
qm importdisk 605 mrRobot.vmdk local -format qcow2
```

5. Add disk to VM

6. Add Virtual Network Interface