# PVE Backup extractor
Proxmox uses its own backup format which is not suitable for import into QEMU/KVM as it is not supported. This Docker Container unpacks this format and converts the disk images to qcow2 images. The unpacked files are stored in the same volume as the packed archive.

## Usage
1. Replace the following variables, in the [docker-compose.yml](./docker-compose.yml):
	| Variable | Description | Example |
	|----------|-------------|---------|
	| <filename_backup> | Filename of your backup | vzdump-qemu-42-2020_04_14-00_12_00.vma.lzo |
	| <path_to_directory> | Path to directory | /home/testuser/backups |
2. Execute the follwing command in your shell:
```shell
docker-compose up
```