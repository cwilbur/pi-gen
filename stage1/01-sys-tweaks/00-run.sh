#!/bin/bash -e

install -d ${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d
install -m 644 files/noclear.conf ${ROOTFS_DIR}/etc/systemd/system/getty@tty1.service.d/noclear.conf
install -m 744 files/policy-rc.d ${ROOTFS_DIR}/usr/sbin/policy-rc.d #TODO: Necessary in systemd?
install -v -m 644 files/fstab ${ROOTFS_DIR}/etc/fstab

# if we have something in NEW_UID use that instead of 'pi'
# if we have something in NEW_GECOS use that instead of ''
# if we have something in NEW_PWD use that instead of 'raspberry'
# if we have something in NEW_ROOT_PWD use that instead of 'root'

on_chroot << EOF
if ! id -u ${NEW_UID:-pi} >/dev/null 2>&1; then
	adduser --disabled-password --gecos "${NEW_GECOS:-}" "${NEW_UID:-pi}"
fi
echo "${NEW_UID:-pi}:${NEW_PWD:-raspberry}" | chpasswd
echo "root:${NEW_ROOT_PWD:-root}" | chpasswd
EOF


