# proxmox_vm_snapshot
Proxmox VM Snapshot Management Script
Description

Ce script Bash permet de gérer les snapshots des machines virtuelles (VM) sur un serveur Proxmox. Il offre les fonctionnalités suivantes :

    Créer un snapshot d'une VM
    Restaurer un snapshot d'une VM
    Supprimer un snapshot d'une VM

Prérequis

    Un serveur Proxmox avec les VMs configurées
    Accès SSH au serveur Proxmox
    Les droits nécessaires pour exécuter les commandes qm

Installation

    Clonez ce dépôt sur votre serveur Proxmox :

```bash
git clone https://github.com/SupRavII/proxmox_vm_snapshot.git
cd proxmox_vm_snapshot
```
Rendez le script exécutable :
```bash
chmod +x proxmox_vm_snapshot.sh
```
Utilisation

Exécutez le script et suivez les instructions affichées à l'écran :
```bash
./proxmox_vm_snapshot.sh
```
Vous verrez un menu avec les options suivantes :

    Create Snapshot : Permet de créer un snapshot d'une VM en fournissant l'ID de la VM et un nom de snapshot.
    Restore Snapshot : Permet de restaurer un snapshot existant d'une VM en fournissant l'ID de la VM et le nom du snapshot.
    Delete Snapshot : Permet de supprimer un snapshot existant d'une VM en fournissant l'ID de la VM et le nom du snapshot.
    Exit : Quitte le script.

Exemple de sortie
Création de snapshot
```bash
Proxmox VM Snapshot Management
1. Create Snapshot
2. Restore Snapshot
3. Delete Snapshot
4. Exit
Choose an option: 1
Enter VM ID: 112
Enter Snapshot Name: archlinux2024_snapshot
Snapshot 'archlinux2024_snapshot' for VM ID '112' created successfully.
```
Restauration de snapshot
```bash
Proxmox VM Snapshot Management
1. Create Snapshot
2. Restore Snapshot
3. Delete Snapshot
4. Exit
Choose an option: 2
Enter VM ID: 112
Available snapshots for VM ID '112':
archlinux2024_snapshot
Enter Snapshot Name to restore: archlinux2024_snapshot
Are you sure you want to restore snapshot 'archlinux2024_snapshot' for VM ID '112'? This will overwrite the current state of the VM. (yes/no): yes
Snapshot 'archlinux2024_snapshot' for VM ID '112' restored successfully.
```
Suppression de snapshot
```bash
Proxmox VM Snapshot Management
1. Create Snapshot
2. Restore Snapshot
3. Delete Snapshot
4. Exit
Choose an option: 3
Enter VM ID: 112
Available snapshots for VM ID '112':
archlinux2024_snapshot
Enter Snapshot Name to delete: archlinux2024_snapshot
Are you sure you want to delete snapshot 'archlinux2024_snapshot' for VM ID '112'? This action cannot be undone. (yes/no): yes
Snapshot 'archlinux2024_snapshot' for VM ID '112' deleted successfully.
```
Licence

Ce projet est sous licence MIT. Pour plus de détails, consultez le fichier LICENSE.
Contributions

Les contributions sont les bienvenues ! Veuillez ouvrir une issue pour discuter de ce que vous souhaitez changer ou ajouter. Vous pouvez aussi créer une pull request avec vos modifications.
