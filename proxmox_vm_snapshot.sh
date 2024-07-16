#!/bin/bash
# Script to manage snapshots of Proxmox VMs

# Function to display usage
usage() {
  echo "Usage: $0"
}

# Function to create a snapshot
create_snapshot() {
  qm list
  echo -n "Enter VM ID: "
  read VMID
  if [ -z "$VMID" ]; then
    echo "Error: VM ID cannot be empty."
    return
  fi
  VM_STATUS=$(qm status $VMID | awk '{print $2}')
  if [ "$VM_STATUS" != "running" ]; then
    echo "Error: VM ID '$VMID' is not running. Start the VM before taking a snapshot."
    return
  fi
  echo -n "Enter Snapshot Name: "
  read SNAPNAME
  if [ -z "$SNAPNAME" ]; then
    echo "Error: Snapshot name cannot be empty."
    return
  fi
  qm snapshot $VMID $SNAPNAME --description "Snapshot created on $(date)" --vmstate true
  if [ $? -eq 0 ]; then
    echo "Snapshot '$SNAPNAME' for VM ID '$VMID' created successfully."
  else
    echo "Error: Failed to create snapshot."
  fi
}

# Function to restore a snapshot
restore_snapshot() {
  qm list
  echo -n "Enter VM ID: "
  read VMID
  if [ -z "$VMID" ]; then
    echo "Error: VM ID cannot be empty."
    return
  fi
  echo "Available snapshots for VM ID '$VMID':"
  qm listsnapshot $VMID
  echo -n "Enter Snapshot Name to restore: "
  read SNAPNAME
  if [ -z "$SNAPNAME" ]; then
    echo "Error: Snapshot name cannot be empty."
    return
  fi
  echo -n "Are you sure you want to restore snapshot '$SNAPNAME' for VM ID '$VMID'? This will overwrite the current state of the VM. (yes/no): "
  read CONFIRM
  if [ "$CONFIRM" != "yes" ]; then
    echo "Restoration cancelled."
    return
  fi
  qm rollback $VMID $SNAPNAME
  if [ $? -eq 0 ]; then
    echo "Snapshot '$SNAPNAME' for VM ID '$VMID' restored successfully."
  else
    echo "Error: Failed to restore snapshot."
  fi
}

# Function to delete a snapshot
delete_snapshot() {
  qm list
  echo -n "Enter VM ID: "
  read VMID
  if [ -z "$VMID" ]; then
    echo "Error: VM ID cannot be empty."
    return
  fi
  echo "Available snapshots for VM ID '$VMID':"
  qm listsnapshot $VMID
  echo -n "Enter Snapshot Name to delete: "
  read SNAPNAME
  if [ -z "$SNAPNAME" ]; then
    echo "Error: Snapshot name cannot be empty."
    return
  fi
  echo -n "Are you sure you want to delete snapshot '$SNAPNAME' for VM ID '$VMID'? This action cannot be undone. (yes/no): "
  read CONFIRM
  if [ "$CONFIRM" != "yes" ]; then
    echo "Deletion cancelled."
    return
  fi
  qm delsnapshot $VMID $SNAPNAME
  if [ $? -eq 0 ]; then
    echo "Snapshot '$SNAPNAME' for VM ID '$VMID' deleted successfully."
  else
    echo "Error: Failed to delete snapshot."
  fi
}

# Main menu
while true; do
  echo "Proxmox VM Snapshot Management"
  echo "1. Create Snapshot"
  echo "2. Restore Snapshot"
  echo "3. Delete Snapshot"
  echo "4. Exit"
  echo -n "Choose an option: "
  read OPTION
  case $OPTION in
    1) create_snapshot ;;
    2) restore_snapshot ;;
    3) delete_snapshot ;;
    4) exit 0 ;;
    *) echo "Invalid option. Please choose a valid option." ;;
  esac
done
