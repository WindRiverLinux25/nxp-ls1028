#
# Copyright (C) 2025 Wind River Systems, Inc.
#
COMPATIBLE_MACHINE:nxp-ls1028 = "nxp-ls1028"
TARGET_SUPPORTED_KTYPES:nxp-ls1028 = "standard preempt-rt"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:nxp-ls1028 = " ${@bb.utils.contains('DISTRO_FEATURES', 'x11 wayland', \
								'file://nxp-ls1028-graphic-kernel-config.cfg', '', d)}"
